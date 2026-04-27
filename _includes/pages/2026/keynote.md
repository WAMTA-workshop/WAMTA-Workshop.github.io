<div class="card">
	<div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>Keynote I</div>
	<div style="margin: 10px">
		<h5>Task-based programming models: tradeoffs between granularity and computing platforms</h5>
		<p>Rosa M. Badia, BSC-CNS</p>
Task-based programming defends that provides a simple programming
approach that leverages the computing infrastructure and reduces
global synchronizations. Since its inception has been extensively
applied to different computing platforms.  In particular, at BSC we
have developed instances of programming models for so diverse
infrastructures as the grid, multicore or the Cell processor, clusters
and large supercomputers, to the digital continuum or hybrid classic-quantum
approaches.  However, is the programming model so simple? What
the end-users say about it?  What are the issues that each computing
platform pose?  Is an autonomous runtime taking all decisions
appreciated by end-users? How can we debug or improve the performance
of distributed applications? The talk will present a perspective
overview of these topics and our views for the next future.
	</div>
</div>

<div class="card">
	<div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>Keynote II</div>
	<div style="margin: 10px">
		<h5>Fortran and the OpenMP API in a Modern GPU World</h5>
		<p>Michael Klemm, AMD</p>
    Modern day supercomputers are massively parallel, heterogeneous
	systems that employ accelerators (mostly GPU) to provide
	additional compute and memory performance to applications.  While
	C/C++, but also Python, gain traction in the HPC domain, Fortran
	continues to have a large developer base with new high-performance
	code written every day.  In this world, the OpenMP Application
	Programming Interface is one of the key components to support
	application developers and their need to write portable and
	performant code for such systems, especially in the context of
	large Fortran codes.  We will review the evolution of the OpenMP
	API from its early days in 1997 to the present day and how it
	supports large scale, heterogeneous applications.  We will recap
	how OpenMP initially supported portable multi-threading (for
	Fortran) and how it was extended to support task parallelism,
	single-instruction multiple-data, and heterogeneous computing.  We
	will also shortly touch on future plans for the OpenMP API
	versions 6.1 and 7.0.  The review of OpenMP features will be
	embedded in the journey of AMD to build the first and second
	exascale system, based on AMD EPYC(tm) Processors and AMD
	Instinct(tm) accelerators as well as a modern Fortran compiler
	based on LLVM Flang.  Buckle up and enjoy the ride!
	</div>
</div>

<div class="card">
	<div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>Keynote III</div>
	<div style="margin: 10px">
		<h5>Asychronous tasks: the cornerstone of targeting HPC on emerging architectures</h5>
		<p>Nick Brown, EPCC</p>
Whilst emerging architectures, such as the Cerebras WSE, were initially designed with AI/ML workloads in mind
their underlying capability results in great potential for traditional HPC too. However, a major challenge is in the
programming of these technologies not-least because approaching these architectures as traditional
imperative/BSP-style is a poor fit and results in slow performance. In this talk I will describe work targeting these
architectures for existing HPC workloads, written in Fortran, with programmer's codes requiring minimal modifications.
I will describe how we see that the target execution model naturally follows that of highly asynchronous many-tasks,
and how we can automate via MLIR the mapping to this paradigm from the imperative view.
	</div>
</div>
