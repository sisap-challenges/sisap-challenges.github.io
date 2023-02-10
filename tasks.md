+++
title = "Implementation Tasks"
hascode = true
date = Date(2023, 02, 10)

tags = ["LAION2B", "Task A", "Task B", "Task C", "similarity search challenges"]
+++

\tableofcontents <!-- you can use \toc as well -->

## Task A: Indexing and searching a LAION-5B deep features subset

The LAION-5B deep features dataset contains 768-dimensional vectors using 16-bit floating point numbers, using dot product as a similarity measure. This task asks for solutions that work on a subset of this dataset. Any transformation to the dataset to load, index, and solve $k$ nearest neighbor queries is allowed. Transformations include, but are not limited to, packing into different data types, dimensional reduction, locality sensitive hashing, product quantization, and binary sketches. Indexing algorithms can be an original part of the contribution or, alternatively, already published indexes can be used. The entire pipeline should be included and tested in the GitHub's Actions (GHA) to reproduce the results; the hyperparameters must be clearly specified on the GHA for all the reported subsets.

- Input queries: Query set, number of $k$ neighbors.
- Input dataset: Several parts of the LION-5B adding up to $n$ vectors. 
- Output: two $k\times n$ matrices, one for object identifiers (integers) and other for distances (floating point numbers). The $i$th columns should contain identifiers and distances of the approximate $k$ nearest neighbors of the $i$th query sorted by the distance in ascending order.
- Measurement: Recall of the computed $k$ nearest neighbor versus a gold-standard, speedup w.r.t bruteforce search, HNSW and FAISS. We will reproduce your results post-challenge and produce rankings on quality and search time using a different query set.

Note: all input datasets should ignore non-NSFW registers; therefore, identifiers consider NSFW entries nonexistent.

## Task B: Binary sketches
Search methods working on main memory could take advantage of fast RAM memory accesses instead of slower secondary memory accesses. Nevertheless, large or high-dimensional datasets may impose hard limits on what can be maintained in the main memory simultaneously, even on high-end hardware systems. Binary sketches under the hamming distance are compact representations of objects, they have a small memory footprint and distances can be computed fastly using instructions like SIMD `popcount`, available in almost any modern processor. Binary sketches can be easily adjusted to work in virtually any metric unlike other approaches that may require a deep knowledge of the dataset and the particular metric.

This task asks for methods that take a dataset and a distance function to project it into binary sketches where the Hamming distance can be used to measure its dissimilarity. The goal is to provide fast methods to achieve high-quality binary mappings under the mentioned terms.

- Input queries: Query set on the original space, number of $k$ neighbors.
- Input dataset: Several parts of the LION-5B in the original space, as described in Task A.
- Output: Two matrices of binary-sketches of 1024-bits, i.e., packed into 16 unsigned 64 bit integers, using a `.h5` file using a group named _queries_ and _db_ for the queries and the database, respectively.
- Measurement: Recall the computed $k$ nearest neighbor versus a gold standard using the binary sketches under Hamming, construction and/or learning time, and projection time.
We will reproduce your results post-challenge, produce rankings on quality, and create the model using a different gold standard.

@@warn
Note: It is well known other approaches like product quantization, locality-sensitive hashing, and dimensional reduction methods also aim at reducing the memory footprint. We postulated this task for being more general and speedy than the alternatives. There is a complementary task below.
@@

## Task C: Indexing and searching on binary sketches
This task asks for solutions for fast indexing binary sketches under the Hamming distance. Participants can use their solutions on Task B to compute the projections or a set of binary sketches added with a variant of the brief permutation binary sketches [cite].

- Input queries: The query set on the original space or the query set on the pre-computed binary sketches, number of $k$ neighbors.
- Input dataset: Several parts of the LION-5B in the original space (without NSFW registers, as described in Task A.) or the dataset set projected with the pre-computed binary sketches.
- Output: Two matrices of binary-sketches of 1024-bits, i.e., packed into 16 unsigned 64 bit integers, using a `.h5` file using a group named _queries_ and _db_ for the queries and the database, respectively.
- Measurement: Recall the computed $k$ nearest neighbor versus a gold standard using the binary sketches (against the task-A gold standard) and search time. We will reproduce your results post-challenge.


## Reports
We expect that participants prepare a detailed report of their solution in a typical SISAP's _shortpaper format_ with a focus on reproducibility and comparing their speedup against a brute force solution in its machine and the resulting quality w.r.t. recall.
Organizers and an ad-hoc committee will review these short papers if the number of papers is large, looking to increase the paper's quality.

On the other hand, we will produce an overview of the challenge giving the necessary context, explaining baselines, the entire table of results, and approaches, and reproducing benchmarks approaches with a common infrastructure and different query sets.