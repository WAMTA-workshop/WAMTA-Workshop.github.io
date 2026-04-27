<div class="card">
	<div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>Keynote I</div>
	<div style="margin: 10px">
		<h5>PGAS: A View from Berkeley</h5>
		<p>Damian Rouson, Lawrence Berkeley National Laboratory</p>

		<p markdown="1">
			Partitioned Global Address Space (PGAS) programming models, languages, and libraries offer HPC software
			developers a set of abstractions that facilitate parallel communication and computation, including remote memory
			access and remote procedure calls. This talk will give a high-level overview of PGAS research and development at
			Berkeley Lab, covering our contributions to the PGAS software ecosystem, including our work on unit tests for
			the PGAS features in the LLVM Flang Fortran compiler; creating the Caffeine coarray Fortran parallel runtime
			library [\[1\]](https://go.lbl.gov/caffeine); producing the UPC++ PGAS template library
			[\[2\]](https://go.lbl.gov/upcxx); and developing the GASNet-EX exascale networking middleware that supports a
			range of PGAS languages, libraries, and frameworks [\[3\]](https://gasnet.lbl.gov). The talk will also highlight
			the use of the aforementioned technologies in task-scheduling frameworks, including FEATS
			[\[4\]](https://github.com/sourceryinstitute/feats), Legion [\[5\]](https://legion.stanford.edu), and DepSpawn
			[\[6\]](https://github.com/UDC-GAC/upcxx_depspawn).

			<!--
			[1] Caffeine: https://go.lbl.gov/caffeine
			[2] UPC++: https://go.lbl.gov/upcxx
			[3] GASNet-EX: https://gasnet.lbl.gov
			[4] FEATS: https://github.com/sourceryinstitute/feats
			[5] Legion: https://legion.stanford.edu
			[6] UPC++ DepSpawn: https://github.com/UDC-GAC/upcxx_depspawn
			-->
		</p>
<ul>
     <li> <a href="https://youtu.be/sawEv3UFcmE">Video</a></li>
     </ul>
    
	</div>
</div>

<div class="card">
	<div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>Keynote II</div>
		<div style="margin: 10px">
		<h5>Application Examples of Leveraging Task Parallelism with Chapel</h5>
		<p>Michelle Strout, The University of Arizona and HPE</p>
        The Chapel programming language provides constructs for expressing a wide range of parallelism patterns, while also remaining easy-to-use. This talk will show usage examples from machine learning, data analytics, aeronautical engineering, hydrology, and other application areas. Perspectives of how existing workflows were adjusted to leverage Chapel and the resulting performance and scaling will also be presented.
	 <ul>
     <li> <a href="https://zenodo.org/record/7658948">Slides</a></li>
     <li> <a href="https://www.youtube.com/watch?v=nS-g6ZCjAKQ">Video</a></li>
     </ul>
    </div>
</div>

<div class="card">
	<div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>Keynote III</div>

	<div style="margin: 10px">
		<h5>Heterogeneous distributed runtimes for fine-granularity tasks: A possible revolution in parallel programming
</h5>
		<p>George Bosilca, University of Tennessee, Knoxville</p>
Challenges introduced by highly hybrid many-cores architectures have a lasting impact on the portability and performance of applications, partially due to traditional programming paradigms. These programming paradigms lack the flexibility and capabilities required to deal with large amounts of potential parallelism and a dynamic hybrid execution environment, putting the performance and scalability of applications at risk. Advances in task-based runtime have shown to provide a plausible solution to this problem, one that not only increase the domain scientists’ productivity but also deliver codes that are more efficient, more scalable, and more adaptable to various hardware architectures, and show an increased portability potential to transition from one generation of hardware to another. This talk will describe a distributed task-based runtime, PaRSEC, and highlight its data management strategies and features to allow the implementation of highly efficient and scalable algorithms at any scale.

	 <ul>
     <li> <a href="https://zenodo.org/record/7659237">Slides</a></li>
     </ul>

</div>
</div>
