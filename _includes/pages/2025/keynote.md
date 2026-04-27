<div class="card">
    <div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>Keynote I</div>
    <div style="margin: 10px">
        <h5>Improving the HPC experience, did Julia get it right or will AI hide the problem (or both)?</h5>
        <p>Alan Edelman, MIT</p>
        <p markdown="1">
            For years I was sad that not enough hard work went into making HPC much easier on the human, and much more portable. I kind of felt that there was too much chasing "machoflops" and not enough software engineering that would result in bringing more programmers to HPC. My benchmark was how many undergraduates are using HPC for interesting projects. Another observation was that it seemed infrastructure was rarely funded or encouraged.
        </p>

        <p markdown="1">
            Julia has been and is making strides in this direction, but new to the table is AI (something this tech lover turned luddite wanted to avoid always fearful this bandwagon is going to collapse and collapse hard.) I will talk about the original ongoing efforts and our SmartSolve (Funded by DARPA DIAL) project that we hope will bring everything together for HPC. Most importantly we will encourage everyone to participate; we can not do this entirely ourselves and value your contributions.
        </p>
    </div>
</div>

<div class="card">
	<div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>Keynote II</div>
		<div style="margin: 10px">
        <h5>Task-Graphs: Why aren't we all using them?</h5>
        <p>Christian Trott (SNL)</p>
	<p markdown="1">
	Task-Graphs are a very attractive concept to express complex algorithms, manage asynchronicity and expose available concurrency. However, very few HPC applications are written in terms of task-graphs.  In this talk I will provide reflections on what I believe some of the reasons are, based on the experience  gained with Kokkos adoption in the last decade. To ground the discussion, this talk will provide an overview of the Kokkos::Graph design - a Kokkos capability that despite being introduced 4 years ago, has found very little adoption. A comparison with CUDA Graphs will demonstrate design tradeoffs in this space, and help highlight  adoption hurdles and correctness pitfalls that are likely an important part of the reason why task-graphs are not more widely used. Last but not least the talk will touch on how the recently approved ISO C++ 26 Execution framework ("Senders and Receivers") can help overcome some of these adoption hurdles, and allow us to realize the promise of a task-graph based application design. 
    </p>
</div>
</div>

<div class="card">
	<div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>Keynote III</div>
	<div style="margin: 10px">
		<h5>Chaos to Cosmos: Orchestrating Complex Scientific Applications with Dynamic Runtime Systems</h5>
		<p>Hatem Ltaief, KAUST</p>
	<p markdown="1">
Scientific computing is increasingly confronted with the challenge of orchestrating highly complex simulations and AI-driven workflows on heterogeneous hardware systems. The sheer scale of modern scientific applications—ranging from computational astronomy to genomic analysis and climate modeling—introduces difficult data dependencies, irregular execution patterns, and severe performance bottlenecks. Traditional static execution models when faced with complex irregular workflows struggle to efficiently harness the computational power of emerging hardware architectures, leading to suboptimal resource utilization and scalability limitations.  
    </p>

    <p markdown="1">
In this talk, we explore how dynamic runtime systems provide a paradigm shift, transforming computational chaos into a structured and efficient cosmos. We delve into research on task-based programming models, asynchronous execution, and mixed-precision algorithms, drawing from state-of-the-art developments in the field. By leveraging dynamic scheduling, data locality optimizations, and adaptive precision techniques, we demonstrate how these runtime systems mitigate bottlenecks, improve energy efficiency, and enable unprecedented scalability on modern supercomputing platforms.  
    </p>

    <p markdown="1">
By bridging the gap between numerical methods, system software, and cutting-edge hardware, this talk provides a roadmap for orchestrating complex scientific applications with dynamic, intelligent, and scalable runtime systems—turning computational disorder into scientific discovery.
    </p>
	</div>
</div>
