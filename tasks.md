+++
title = "Implementation Tasks"
hascode = true
date = Date(2023, 02, 10)

tags = ["LAION2B", "Task A", "Task B", "Task C", "similarity search challenges", "Important dates"]
+++

# Tasks of the Implementation Challenge and Demo Track

\tableofcontents <!-- you can use \toc as well -->

## Task A: Indexing and searching a LAION-5B deep features subset

The LAION2B deep features dataset contains 768-dimensional vectors using 16-bit floating point numbers, using dot product as a similarity measure. This task asks for solutions that work on a subset of this dataset. Any transformation to the dataset to load, index, and solve $k$ nearest neighbor queries is allowed. Transformations include, but are not limited to, packing into different data types, dimensional reduction, locality sensitive hashing, product quantization, and binary sketches. Indexing algorithms can be an original part of the contribution or, alternatively, already published indexes can be used. The entire pipeline should be included and tested in the GitHub's Actions (GHA) to reproduce the results; the hyperparameters must be clearly specified on the GHA for all the reported subsets.

- **Input queries:** Query set, retrieve $k=30$ neighbors.
- **Input dataset:** A subset of the LAION2B dataset (including projections). 
- **Output:** two $k\times n$ matrices (see file formats below), one for object identifiers (integers) and other for distances (floating point numbers). The $i$th columns should contain identifiers and distances of the approximate $k$ nearest neighbors of the $i$th query sorted by the distance in ascending order.
- **Measurement:** Recall of the computed $k$ nearest neighbor versus a gold-standard, speedup w.r.t bruteforce search. We will reproduce your results post-challenge and produce rankings on quality and search time using a different query set.

## Task B: Binary sketches
Search methods working on main memory could take advantage of fast RAM memory accesses instead of slower secondary memory accesses. Nevertheless, large high-dimensional datasets may impose hard limits on what can be maintained in the main memory simultaneously, even on high-end hardware systems. Binary sketches under the Hamming distance are compact representations of objects, they have a small memory footprint and distances can be computed efficiently using instructions like SIMD-\texttt{popcount}, available in almost any modern processor.

This task asks for methods that take a dataset and a distance function to project it into binary sketches where the Hamming distance can be used to measure its dissimilarity. The goal is to provide fast methods to achieve high-quality binary mappings under the mentioned terms.

- **Input queries:** Query set, searching for $k=30$ nearest neighbors.
- **Input dataset:** A subset of the LAION2B dataset (including projections), as described in Task A.
- **Output:** Two matrices of binary-sketches of 1024-bits, i.e., packed into 16 unsigned 64 bit integers, using a \texttt{.h5} file using a group named \textit{queries} and \textit{db} for the queries and the database, respectively.
- **Measurement:** Recall the computed $k=30$ nearest neighbor versus a gold standard using the binary sketches under Hamming, construction and/or learning time, and projection time. We will reproduce your results post-challenge, produce rankings on quality, and create the model using a different gold standard.

@@warn
N- **Note 1:** It is well known other approaches like product quantization, locality-sensitive hashing, and dimensional reduction methods also aim at reducing the memory footprint. However, they are beyond the scope of Task B.
- **Note 2:** There is a complementary task below.
@@

## Task C: Indexing and searching on binary sketches

This task asks for solutions for fast indexing binary sketches under the Hamming distance. Participants can use their solutions on Task B to compute the projections or a set of binary sketches added with a variant of the brief permutation binary sketches.[^2]

- **Input queries:** The query set on the original space or the query set on the pre-computed binary sketches, searching for $k=30$ neighbors.
- **Input dataset:** Several parts of the LAION2B in the original space (without NSFW registers, as described in Task A.) or the dataset set projected with the pre-computed binary sketches.
- **Output:** two $k\times n$ matrices (see file formats below), one for object identifiers (integers) and other for distances (floating point numbers). The $i$th columns should contain identifiers and distances of the approximate $k$ nearest neighbors of the $i$th query sorted by the distance in ascending order.
- **Measurement:** Recall the computed $k$ nearest neighbor versus a gold standard using the binary sketches (against the task-A gold standard) and search time.
    We will reproduce your results post-challenge.

[^2]: Santoyo, F., Chávez, E., & Téllez, E. S. (2014). A compressed index for hamming distances. In Similarity Search and Applications: 7th International Conference, SISAP 2014, Los Cabos, Mexico, October 29-31, 2014. Proceedings 7 (pp. 113-126). Springer International Publishing.