+++
title = "Tasks"
hascode = true
date = Date(2024, 03, 13)

tags = ["LAION2B", "Task 1", "Task 2", "Task 3", "similarity search challenges"]
+++

# Tasks of the Implementation Challenge and Demo Track

\tableofcontents <!-- you can use \toc as well -->

Test Data and Queries:
Approximately 100 million CLIP descriptors extracted from the LAION database
Similarity between two objects is measured by their dot product. The similarity function is a dot product
The goal is to evaluate 30 nearest neighbours queries using 10K query objects described below

## Task 1: Unleashed Indexing
In this task, participants have access to all resources on our testing computer to build their indexing solutions. The goal is to achieve the highest search performance within the given constraints.
- Wall clock time for index construction: 12 hours.
- Minimum recall to be considered in the final ranking: $0.8$.
- Ranking: Highest throughput/fastest search time with average recall of at least 0.8.
- Search performance will be evaluated using 30 different search hyperparameters.
- Saving the index is not required for running the search.

## Task 2: Memory-Constrained Indexing with Reranking
This task challenges participants to develop memory-efficient indexing solutions with reranking capabilities. Participants will be provided with a virtual machine (VM) with limited memory and storage resources.
- Container specifications: RAM = 32 GB, SSD = 512 GB.
- Wall clock time for index construction: 24 hours
- Ranking: highest throughput/fastest search time with average recall of at least 0.8. 
- Search performance will be evaluated with the best performance among 30 different search hyperparameters

## Task 3: Memory-Constrained Indexing without Reranking
In this task, participants are asked to develop memory-efficient indexing solutions that will be used without reranking the search results. The container provided will have higher memory capacity compared to Task 2. Participants have to build an index in the first phase. In the search phase, the original vectors are not available.
- Container specifications: RAM = 64 GB (read-only access to the database)
- Wall clock time for index construction: 12 hours
- Ranking: highest throughput/fastest search time with average recall of at least 0.5. 
- Search performance will be evaluated with the best performance using 30 different search hyperparameters


## Datasets and queries

- **Input dataset:** The 100M subset of the LAION2B dataset, i.e., see [clip768 files](/2024/datasets/). 
- **Public queries:** The 10K private queries from the previous year's challenge will be used as the public query set. Queries asks for the 30nn.
- **Private queries:** An undisclosed set of 100K queries will be used for the final evaluation. Queries will be asking for the 30nn. 
- **Similarity measure:** Dot product similarity.


## Task A: Indexing and searching a LAION-5B deep features subset

The LAION2B deep features dataset contains 768-dimensional vectors using 16-bit floating point numbers, using dot product as a similarity measure. This task asks for solutions that work on a subset of this dataset. Any transformation to the dataset to load, index, and solve $k$ nearest neighbor queries is allowed. Transformations include, but are not limited to, packing into different data types, dimensional reduction, locality-sensitive hashing, product quantization, and binary sketches. Indexing algorithms can be an original part of the contribution, or alternatively, already published indexes can be used. The entire pipeline should be included and tested in GitHub's Actions (GHA) to reproduce the results; the hyperparameters must be clearly specified on the GHA for all the reported subsets.

- **Input queries:** Query set, retrieve $k=10$ neighbors.
- **Output:** two $k\times n$ matrices in a single HDF5 files, one for object identifiers (key _knns_, integers) and other for distances (key _dists_, floating point numbers). Note that results should follow column-major order, i.e., the $i$th columns should contain identifiers and distances of the approximate $k$ nearest neighbors of the $i$th query sorted by the distance in ascending order, plus additional metadata. Also, _knns_ identifiers must follow **1**-based indexing (**0**-based indexing solutions must add 1 to evaluate correctly). <!--See <https://github.com/sisap-challenges/sisap23-laion-challenge-evaluation> for more details.-->
- **Ranking:** Best queries-per-second for results having a recall bigger than $0.9$ w.r.t a public gold standard (partial ranking, working with GitHub Actions) and w.r.t. a private gold standard (final ranking).

@@warn
We will reproduce your results post-challenge and produce rankings on quality and search time using a different query set. So, it is essential that your solution can be replicated.

Please visit [examples](/2024/repoexamples/) section for working examples.
Note that the available examples can be used as starting points.
@@

