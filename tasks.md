+++
title = "Implementation Tasks"
hascode = true
date = Date(2023, 02, 10)

tags = ["LAION2B", "Task A", "Task B", "Task C", "similarity search challenges", "Important dates"]
+++

# Tasks of the Implementation Challenge and Demo Track

\tableofcontents <!-- you can use \toc as well -->

## Task A: Indexing and searching a LAION-5B deep features subset

The LAION2B deep features dataset contains 768-dimensional vectors using 16-bit floating point numbers, using dot product as a similarity measure. This task asks for solutions that work on a subset of this dataset. Any transformation to the dataset to load, index, and solve $k$ nearest neighbor queries is allowed. Transformations include, but are not limited to, packing into different data types, dimensional reduction, locality-sensitive hashing, product quantization, and binary sketches. Indexing algorithms can be an original part of the contribution, or alternatively, already published indexes can be used. The entire pipeline should be included and tested in GitHub's Actions (GHA) to reproduce the results; the hyperparameters must be clearly specified on the GHA for all the reported subsets.

- **Input queries:** Query set, retrieve $k=10$ neighbors.
- **Input dataset:** A subset of the LAION2B dataset, i.e., see [clip768 files](https://sisap-challenges.github.io/datasets/). More detailed, 300K subset for partial ranking and 10M, 30M, and 100M for final ranking. 
- **Output:** two $k\times n$ matrices in a single HDF5 files, one for object identifiers (key _knns_, integers) and other for distances (key _dists_, floating point numbers). Note that results should follow column-major order, i.e., the $i$th columns should contain identifiers and distances of the approximate $k$ nearest neighbors of the $i$th query sorted by the distance in ascending order, plus additional metadata. Also, _knns_ identifiers should start with **one** (not **zero**). See <https://github.com/sisap-challenges/sisap23-laion-challenge-evaluation> for more details.
- **Ranking:** Best queries-per-second for results having a recall bigger than $0.9$ w.r.t a public gold standard (partial ranking, working with GitHub Actions) and w.r.t. a private gold standard (final ranking).

@@warn
We will reproduce your results post-challenge and produce rankings on quality and search time using a different query set. So, it is essential that your solution can be replicated.

Please visit <https://sisap-challenges.github.io/repoexamples/> for working examples. In particular, please follow the guidelines of <https://github.com/sisap-challenges/sisap23-laion-challenge-evaluation> to simplify evaluating your solution. Note that the available examples can be used as starting points.
@@

## Task B: Binary sketches
Search methods working on main memory could take advantage of fast RAM memory accesses instead of slower secondary memory accesses. Nevertheless, large high-dimensional datasets may limit what can be maintained in the main memory simultaneously, even on high-end hardware systems. Binary sketches under the Hamming distance are compact representations of objects, they have a small memory footprint, and distances can be computed efficiently using instructions like SIMD-\texttt{popcount}, available in almost any modern processor.

This task asks for methods that use a dataset and a distance function to project it into binary sketches where the Hamming distance can measure its dissimilarity. The goal is to provide fast methods to achieve high-quality binary mappings under the mentioned terms.

- **Input queries:** Idem Task A.
- **Input dataset:** Idem Task A.
- **Output:** Idem Task A, with queries solved with an exact algorithm and the Hamming distance (i.e., brute force). Additionally, two matrices of binary sketches of 1024-bits packed into 16 unsigned 64-bit integers, using a \texttt{.h5} file using a group named \textit{queries} and \textit{db} for the binary sketches of the queries and the database, respectively.
- **Ranking:** Recall of the computed $k=10$ nearest neighbor versus the gold standard. Partial ranking will be computed w.r.t. the public gold standard. The final ranking will be computed w.r.t. a private gold standard.

@@warn
N- **Note 1:** It is well known other approaches like product quantization, locality-sensitive hashing, and dimensional reduction methods also aim at reducing the memory footprint. However, they are beyond the scope of Task B.
- **Note 2:** There is a complementary task below.
@@

## Task C: Indexing and searching on binary sketches

This task asks for solutions for fast indexing binary sketches under the Hamming distance. Participants can use their solutions on Task B to compute the projections or a set of binary sketches added with a variant of the brief permutation binary sketches.[^2]

- **Input queries:** Idem Task A.
- **Input dataset:** I task A.
- **Output:** Idem Task B, but we expect that teams use an index working with the Hamming distance instead of brute force.
- **Ranking:** Best queries-per-second for results having a recall bigger than $90%$ of our baseline recall[^2] w.r.t a public gold standard (partial ranking, working with GitHub Actions) and w.r.t. a private gold standard (final ranking).

[^2]: Santoyo, F., Chávez, E., & Téllez, E. S. (2014). A compressed index for hamming distances. In Similarity Search and Applications: 7th International Conference, SISAP 2014, Los Cabos, Mexico, October 29-31, 2014. Proceedings 7 (pp. 113-126). Springer International Publishing.