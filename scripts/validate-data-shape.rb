#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'yaml'

ROOT = File.expand_path('..', __dir__)
DATA_ROOT = File.join(ROOT, '_data', 'years')
PAGE_BODY_FILES = %w[
  home cfp submission program venue registration keynote shortcourse events special_issue
].freeze
REQUIRED_PAGE_KEYS = {
  'home' => %w[title lead overview objectives topics],
  'cfp' => %w[description],
  'submission' => %w[sections],
  'program' => %w[intro],
  'venue' => %w[sections],
  'registration' => %w[title body],
  'keynote' => %w[talks],
  'shortcourse' => %w[title description logistics],
  'events' => %w[items],
  'special_issue' => %w[description submission]
}.freeze
ALLOWED_PAGE_KEYS = {
  'home' => %w[title lead overview objectives topics artifacts previous_events show_contact show_important_dates show_news show_sponsors],
  'cfp' => %w[description special_issue contact submission sections dates],
  'submission' => %w[nav_hidden sections show_contact show_important_dates],
  'program' => %w[nav_hidden intro social_events schedule links show_contact],
  'venue' => %w[nav_hidden intro sections],
  'registration' => %w[nav_hidden title body visa],
  'keynote' => %w[nav_hidden talks],
  'shortcourse' => %w[nav_hidden title description topics additional_topics logistics show_contact],
  'events' => %w[nav_hidden items],
  'special_issue' => %w[nav_hidden title description editors submission dates show_contact]
}.freeze
NAV_PAGE_FILES = {
  'home' => 'index.md',
  'cfp' => 'cfp.md',
  'submission' => 'submission.md',
  'program' => 'program.md',
  'venue' => 'venue.md',
  'registration' => 'registration.md',
  'keynote' => 'keynote.md',
  'shortcourse' => 'shortcourse.md',
  'events' => 'events.md',
  'special_issue' => 'special-issue.md'
}.freeze
FORBIDDEN_HTML = /<(div|table|tr|td|th|style|script|iframe|center|i)\b|<!--/i
GENERIC_PAGE_KEYS = %w[blocks columns class type].freeze
COMMITTEE_MEMBER_KEYS = %w[name org homepage role].freeze
COMMITTEE_GROUP_KEYS = %w[
  organizing_committee program_chair steering_committee
  technical_program_chair technical_program_committee webmaster
].freeze
IMPORTANT_DATE_KEYS = %w[date text timezone].freeze
NEWS_KEYS = %w[date text].freeze
SPONSOR_KEYS = %w[name logo_path].freeze
KEYNOTE_TALK_KEYS = %w[label title speaker affiliation homepage abstract materials].freeze
KEYNOTE_TALK_REQUIRED_KEYS = %w[label title speaker abstract].freeze
KEYNOTE_MATERIAL_KEYS = %w[label url].freeze
SCHEDULE_DAY_KEYS = %w[key label].freeze
SCHEDULE_ROW_RESERVED_KEYS = %w[time all].freeze
SCHEDULE_CELL_ALLOWED = {
  'meta' => %w[kind text],
  'keynote' => %w[kind number chair speaker title],
  'talk' => %w[kind speaker title],
  'event' => %w[kind label chair note],
  'schedule' => %w[kind items]
}.freeze
SCHEDULE_CELL_REQUIRED = {
  'meta' => %w[text],
  'keynote' => %w[speaker title],
  'talk' => %w[speaker title],
  'event' => %w[label],
  'schedule' => %w[items]
}.freeze

def local_asset_exists?(path)
  path.to_s.start_with?('/assets/') && File.exist?(File.join(ROOT, path.delete_prefix('/')))
end

def inspect_value(value, path, key_path, errors)
  case value
  when Hash
    value.each do |key, nested|
      inspect_value(nested, path, [key_path, key].compact.join('.'), errors)
    end
  when Array
    value.each_with_index do |nested, index|
      inspect_value(nested, path, "#{key_path}[#{index}]", errors)
    end
  when String
    return unless value.match?(FORBIDDEN_HTML)

    errors << "#{path}:#{key_path}: contains layout/script HTML; move markup to an include"
  end
end

def inspect_generic_page_keys(value, path, key_path, errors)
  case value
  when Hash
    value.each do |key, nested|
      nested_key_path = [key_path, key].compact.join('.')
      if GENERIC_PAGE_KEYS.include?(key.to_s)
        errors << "#{path}:#{nested_key_path}: generic render/layout key is not allowed in page data"
      end
      inspect_generic_page_keys(nested, path, nested_key_path, errors)
    end
  when Array
    value.each_with_index do |nested, index|
      inspect_generic_page_keys(nested, path, "#{key_path}[#{index}]", errors)
    end
  when String
    return unless value.include?('{:')

    errors << "#{path}:#{key_path}: Kramdown inline attributes are layout data; move styling to includes"
  end
end

def inspect_record_list(data, path, allowed_keys, errors, required_keys: [], extra: nil)
  unless data.is_a?(Array)
    errors << "#{path}: must be a list"
    return
  end

  data.each_with_index do |record, index|
    unless record.is_a?(Hash)
      errors << "#{path}[#{index}]: must be a mapping"
      next
    end

    record.keys.each do |key|
      next if allowed_keys.include?(key.to_s)

      errors << "#{path}[#{index}].#{key}: unknown key"
    end

    required_keys.each do |required_key|
      next if record.key?(required_key)

      errors << "#{path}[#{index}].#{required_key}: missing required key"
    end

    extra&.call(record, index)
  end
end

def date_like?(value)
  value.is_a?(Date) || value.is_a?(Time) || value == 'TBA'
end

def inspect_important_dates_shape(data, path, errors)
  inspect_record_list(
    data, path, IMPORTANT_DATE_KEYS, errors,
    required_keys: %w[date text],
    extra: lambda do |record, index|
      date = record['date']
      next if date_like?(date)

      errors << "#{path}[#{index}].date: must be an ISO YYYY-MM-DD date or the literal string TBA (got #{date.inspect})"
    end
  )
end

def inspect_news_shape(data, path, errors)
  inspect_record_list(
    data, path, NEWS_KEYS, errors,
    required_keys: %w[text],
    extra: lambda do |record, index|
      date = record['date']
      next if date.nil? || date_like?(date)

      errors << "#{path}[#{index}].date: must be an ISO YYYY-MM-DD date, TBA, or empty (got #{date.inspect})"
    end
  )
end

def inspect_sponsors_shape(data, path, errors)
  inspect_record_list(data, path, SPONSOR_KEYS, errors, required_keys: %w[name logo_path])
end

def inspect_keynote_shape(data, path, errors)
  talks = data['talks']
  unless talks.is_a?(Array)
    errors << "#{path}:talks: must be an array"
    return
  end

  talks.each_with_index do |talk, index|
    talk_path = "#{path}:talks[#{index}]"
    unless talk.is_a?(Hash)
      errors << "#{talk_path}: must be a mapping"
      next
    end

    talk.keys.each do |key|
      next if KEYNOTE_TALK_KEYS.include?(key.to_s)

      errors << "#{talk_path}.#{key}: unknown talk key"
    end

    KEYNOTE_TALK_REQUIRED_KEYS.each do |required_key|
      errors << "#{talk_path}.#{required_key}: missing required key" unless talk[required_key].is_a?(String)
    end

    materials = talk['materials']
    next if materials.nil?

    inspect_record_list(
      materials, "#{talk_path}.materials",
      KEYNOTE_MATERIAL_KEYS, errors,
      required_keys: %w[label url]
    )
  end
end

def inspect_schedule_cell(cell, path, errors)
  return if cell.nil? || cell == ''

  unless cell.is_a?(Hash)
    errors << "#{path}: cell must be a mapping with a kind: field, or empty"
    return
  end

  kind = cell['kind'].to_s
  unless SCHEDULE_CELL_ALLOWED.key?(kind)
    allowed = SCHEDULE_CELL_ALLOWED.keys.join(', ')
    errors << "#{path}.kind: unknown cell kind #{cell['kind'].inspect} (allowed: #{allowed})"
    return
  end

  allowed = SCHEDULE_CELL_ALLOWED[kind]
  cell.each_key do |key|
    next if allowed.include?(key.to_s)

    errors << "#{path}.#{key}: unknown key for cell kind #{kind}"
  end

  SCHEDULE_CELL_REQUIRED[kind].each do |required_key|
    errors << "#{path}.#{required_key}: missing required key for cell kind #{kind}" unless cell.key?(required_key)
  end

  if kind == 'schedule'
    items = cell['items']
    unless items.is_a?(Array) && !items.empty? && items.all? { |i| i.is_a?(String) }
      errors << "#{path}.items: must be a non-empty array of strings"
    end
  end
end

def inspect_timetable_schedule(schedule, path, errors)
  days = schedule['days']
  unless days.is_a?(Array) && !days.empty?
    errors << "#{path}:schedule.days: timetable schedules require a non-empty days array"
    return
  end

  day_keys = []
  days.each_with_index do |day, index|
    unless day.is_a?(Hash) && day['key'].is_a?(String) && day['label'].is_a?(String)
      errors << "#{path}:schedule.days[#{index}]: each day requires string key and label"
      next
    end

    day.each_key do |key|
      next if SCHEDULE_DAY_KEYS.include?(key.to_s)

      errors << "#{path}:schedule.days[#{index}].#{key}: unknown day key"
    end
    day_keys << day['key']
  end

  rows = schedule['rows']
  unless rows.is_a?(Array)
    errors << "#{path}:schedule.rows: must be an array"
    return
  end

  allowed_row_keys = SCHEDULE_ROW_RESERVED_KEYS + day_keys
  rows.each_with_index do |row, row_index|
    row_path = "#{path}:schedule.rows[#{row_index}]"
    unless row.is_a?(Hash)
      errors << "#{row_path}: must be a mapping"
      next
    end

    row.each_key do |key|
      next if allowed_row_keys.include?(key.to_s)

      errors << "#{row_path}.#{key}: unknown row key (allowed: time, all, #{day_keys.join(', ')})"
    end

    if row.key?('all') && day_keys.any? { |k| row.key?(k) }
      errors << "#{row_path}: cannot mix 'all' with per-day cells"
    end

    if row['all']
      inspect_schedule_cell(row['all'], "#{row_path}.all", errors)
    else
      day_keys.each do |key|
        next unless row.key?(key)

        inspect_schedule_cell(row[key], "#{row_path}.#{key}", errors)
      end
    end
  end
end

def inspect_committee_labels(labels, path, errors)
  unless labels.is_a?(Hash)
    errors << "#{path}:labels: must be a mapping of committee group => display title"
    return
  end

  labels.each do |group, title|
    errors << "#{path}:labels.#{group}: unknown committee group" unless COMMITTEE_GROUP_KEYS.include?(group.to_s)
    errors << "#{path}:labels.#{group}: label must be a string" unless title.is_a?(String)
  end
end

def inspect_committees_shape(data, path, errors)
  return unless data.is_a?(Hash)

  data.each do |key, value|
    if key.to_s == 'labels'
      inspect_committee_labels(value, path, errors)
      next
    end

    unless COMMITTEE_GROUP_KEYS.include?(key.to_s)
      errors << "#{path}:#{key}: unknown committee group"
      next
    end

    unless value.is_a?(Array)
      errors << "#{path}:#{key}: committee groups must be arrays"
      next
    end

    value.each_with_index do |member, index|
      unless member.is_a?(Hash)
        errors << "#{path}:#{key}[#{index}]: committee member must be a mapping"
        next
      end

      member.keys.each do |member_key|
        next if COMMITTEE_MEMBER_KEYS.include?(member_key.to_s)

        errors << "#{path}:#{key}[#{index}].#{member_key}: unknown committee member key"
      end
      errors << "#{path}:#{key}[#{index}].name: committee member requires name" unless member['name'].is_a?(String)
    end
  end
end

def inspect_page_shape(name, data, path, errors)
  required_keys = REQUIRED_PAGE_KEYS.fetch(name, [])
  required_keys.each do |required_key|
    next if data.key?(required_key)

    errors << "#{path}: missing required semantic key #{required_key}"
  end

  allowed_keys = ALLOWED_PAGE_KEYS[name]
  if allowed_keys
    data.keys.each do |key|
      next if allowed_keys.include?(key.to_s)

      errors << "#{path}:#{key}: unknown page key for #{name}"
    end
  end

  inspect_generic_page_keys(data, path, nil, errors)

  case name
  when 'keynote'
    inspect_keynote_shape(data, path, errors)
  when 'events'
    unless data['items'].is_a?(Array)
      errors << "#{path}:items: must be an array"
    else
      data['items'].each_with_index do |event, index|
        image_path = event['image_path']
        unless image_path.to_s.start_with?('/assets/years/')
          errors << "#{path}:items[#{index}].image_path: must use /assets/years/<year>/..."
        end
        if image_path.to_s.match?(%r{/years/\d{4}/years/\d{4}/})
          errors << "#{path}:items[#{index}].image_path: contains duplicated year asset prefix"
        end
        if image_path.to_s.start_with?('/assets/') && !local_asset_exists?(image_path)
          errors << "#{path}:items[#{index}].image_path: asset does not exist"
        end
      end
    end
  when 'program'
    schedule = data['schedule']
    if schedule && schedule['kind'] == 'timetable'
      inspect_timetable_schedule(schedule, path, errors)
    elsif schedule && schedule['kind'] == 'pdf'
      %w[url file_name].each do |required_key|
        errors << "#{path}:schedule.#{required_key}: PDF schedules require #{required_key}" unless schedule[required_key].is_a?(String)
      end
      url = schedule['url']
      if url.to_s.start_with?('/assets/') && !local_asset_exists?(url)
        errors << "#{path}:schedule.url: asset does not exist"
      end
    elsif schedule
      errors << "#{path}:schedule.kind: must be timetable or pdf"
    end
  when 'venue'
    data.fetch('sections', []).each_with_index do |section, index|
      next unless section.is_a?(Hash) && section['map']

      map = section['map']
      unless map.is_a?(Hash) && map['src'].is_a?(String)
        errors << "#{path}:sections[#{index}].map.src: maps require src"
      end
    end
  end
end

errors = []
Dir.glob(File.join(DATA_ROOT, '*', 'navbar.yml')).sort.each do |path|
  errors << "#{path}: navbar.yml is not used; navigation is derived from page data"
end

Dir.glob(File.join(DATA_ROOT, '*')).sort.each do |year_dir|
  next unless File.directory?(year_dir)

  year = File.basename(year_dir)
  NAV_PAGE_FILES.each do |data_key, wrapper_file|
    data_path = File.join(year_dir, "#{data_key}.yml")
    wrapper_path = File.join(ROOT, year, wrapper_file)
    next unless File.exist?(data_path)
    next if File.exist?(wrapper_path)

    errors << "#{data_path}: nav-backed page data requires wrapper #{wrapper_path}"
  end
end

Dir.glob(File.join(DATA_ROOT, '*', '*.yml')).sort.each do |path|
  year = File.basename(File.dirname(path))
  name = File.basename(path, '.yml')
  data = YAML.load_file(path, permitted_classes: [Date, Time], aliases: true)

  inspect_page_shape(name, data, path, errors) if PAGE_BODY_FILES.include?(name) && data.is_a?(Hash)
  inspect_committees_shape(data, path, errors) if name == 'committees'
  inspect_important_dates_shape(data, path, errors) if name == 'important_dates'
  inspect_news_shape(data, path, errors) if name == 'news'
  inspect_sponsors_shape(data, path, errors) if name == 'sponsors'
  inspect_value(data, path, nil, errors)
end

if errors.empty?
  puts 'Data shape OK'
else
  warn errors.join("\n")
  exit 1
end
