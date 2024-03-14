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
- **Public queries:** The 10K private queries from the previous year's challenge will be used as the public query set. Queries asks for the 30nn ($k=30$).
- **Private queries:** An undisclosed set of 100K queries will be used for the final evaluation. Queries will be asking for the 30nn ($k=30$). 
- **Similarity measure:** Dot product similarity.
- **Output:** two $k\times |queries|$ matrices in a single HDF5 filename (one file per search hyperparameter probe)
  - `knns` matrix to store object identifiers (integers)
  - `dists` matrix to store distances. Note that results should follow column-major order, i.e., the $i$th columns should contain identifiers and distances of the approximate $k$ nearest neighbors of the $i$th query sorted by the distance in ascending order, plus additional metadata. Also, _knns_ identifiers must follow **1**-based indexing (**0**-based indexing solutions must add 1 to evaluate correctly). <!--See <https://github.com/sisap-challenges/sisap23-laion-challenge-evaluation> for more details.-->
  - see examples for more details about these matrices and required metadata.


@@warn
We will reproduce your results post-challenge and produce rankings on quality and search time using a different query set. So, it is essential that your solution can be replicated.

Please visit [examples](/2024/repoexamples/) section for working examples.
Note that the available examples can be used as starting points.
@@

