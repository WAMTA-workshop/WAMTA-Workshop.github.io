# WAMTA Workshop Website

The multi-year WAMTA workshop website built using Jekyll. The current edition is selected by `current_year` in `_config.yml`.

## Features

- Year-specific data files live in `_data/years/{year}/`.
    - `conference.yml`: conference information for each WAMTA edition.
        - `full_title`: conference full name e.g., Workshop on Asynchronous Many-Task Systems and Applications 2026.
        - `short_title`: conference short name e.g., WAMTA 26
        - `description`: short description about the conference (< 160 char)
        - `location`: conference location
        - `logo_path`: conference logo
        - `slideshow`: image slideshow
        - `navbar`: navigation menu.
        - `news`: news section.
        - `sponsors`: sponsor section.
        - `deadlines`: important deadline dates; past-due dates will be automatically printed with a strikethrough.
        - `social_media`: social media on the navbar. (currently supports Facebook and Twitter.)
        - `organizing_committee`: organizing committee
        - `steering_committee`: steering committee
        - `technical_program_committee`: technical program committee
    - `schedule.yml`: structured schedule/timetable data for that year.
        - `date`: machine-readable date for a schedule day.
        - `dateReadable`: display label for a schedule day.
        - `timeslots`: list of scheduled sessions or services.
        - `startTime`, `endTime`: time range for a timeslot.
        - `title`: timeslot or event title.
        - `type`: timeslot or presentation type.
        - `speaker`, `chair`: speaker and chair labels for a timeslot.
        - `events`: nested list of presentations in a timeslot.
        - `speakers`: event speaker metadata.
    - `presentations.yml`: structured presentation metadata for that year.
        - `id`: presentation identifier.
        - `title`: presentation title.
        - `speakers`: presentation speaker metadata.
        - `type`: presentation type.
    - more configurations to come.
- Year-specific page bodies live in `_includes/pages/{year}/...` and are resolved by `_layouts/workshop-page.html`.
- Google Analytics: in `_config.yml`
- Font-awesome
- Bootstrap v4.

## Preview

### home page
![home page image](./preview/home.png)

### committee page
![committee page image](./preview/committee.png)

### Deadlines

### Admin page

### mobile version
<img src="./preview/mobile.png" alt="mobile version image" style="height: 800px;"/>

## Usage

### With Jekyll Admin.


## TODO

 - [ ] Add https://www.timeanddate.com/ link to deadlines.
 - [ ] Separate some layouts/includes into a theme, make the project extensible with different themes.
 - [x] Jekyll Admin integrated
 - [ ] Use Jekyll posts to update news.
 - [ ] Clean Jekyll pages, put HTML code into layout/includes, pure Markdown in pages.
 - [ ] Makefile integration for Docker run, SSH upload, rsync