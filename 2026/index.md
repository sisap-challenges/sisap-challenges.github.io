+++
title = "SISAP 2026 Indexing Challenge"
tags = ["sisap", "challenge"]
+++

{{redirect /}}

# SISAP 2026 Indexing Challenge: Task description and participation details
\toc

The SISAP Indexing Challenge 2026 invites researchers and practitioners to participate in exciting tasks to advance the state of the art in similarity search and indexing. The challenge provides a platform for presenting innovative solutions and pushing the boundaries of efficiency and effectiveness in large-scale similarity search indexes. This year, we are proposing three challenging tasks.

Datasets are available at [https://huggingface.co/datasets/sadit/SISAP2026/tree/main](https://huggingface.co/datasets/sadit/SISAP2026/tree/main); you can clone the full repository or download each file separately.

### Task 1: K-nearest neighbor graph (a.k.a. metric self-join)

In this task, participants are asked to develop memory-efficient indexing solutions that will be used to compute an approximation of the _k_-nearest neighbor graph for *k=15*. Each solution will be run in a Linux container with limited memory and storage resources.

- Container specifications: 8 virtual CPUs, 24 GB of RAM, the dataset will be mounted read-only into the container.  
- Wall clock time for the entire task: 8 hours.  
- Dataset: WIKIPEDIA (6.4 million vectors, 1024 dimensions).  
- Similarity between two objects is measured by their dot product; vectors are normalized.  
- The goal is to compute the *k-nearest neighbor graph (without self-references)*, i.e., find the *k*\-nearest neighbors using all objects in the dataset as queries.  
  - We will measure the graph’s quality as the recall against a provided gold standard and the full computation time (i.e., including preprocessing, indexing, search, and postprocessing such as re-ranking)
  - Operating point: Fastest graph construction time that achieves an average recall of at least 0.8. 
  - We provide a development dataset; the evaluation phase will use an undisclosed dataset of similar size computed with the same neural model.


### Task 2: Maximum Inner Product Search on LLM attention workloads (Search under Distribution Shift)

In this task, participants are asked to develop memory-efficient indexing solutions to solve maximum inner product search queries in an LLM-inspired workload. Each solution will be run in a Linux container with limited memory and storage resources. 

- Container specifications: 8 virtual CPUs, 24 GB of RAM, the dataset will be mounted read-only into the container.  
- Wall clock time for the entire task: 1 hour.  
- Dataset: Llama-3-8B-262k (256,921 vectors, 128 dimensions)  
- For index building, a small set of 1,000 queries that can be used during the index building. These queries are distinct from the queries later used in testing.  
- Similarity between two objects is measured by their dot product; note that vectors are not normalized.  
- The goal is to compute k=30 maximum inner product queries for 10,000 query points.   
- Operating point: Fastest search time that achieves an average recall of at least 0.8.  
- We provide a development dataset; the evaluation will use an undisclosed dataset of similar size computed with the same underlying LLM model.

### Task 3: Indexing very sparse high-dimensional vectors
Learned sparse models bridge traditional inverted indexing and neural retrieval. However, their high dimensionality and learned term distributions challenge classical IR data structures.

This task investigates how to design scalable, memory-efficient indexing methods for such representations under realistic hardware constraints. In this task, participants are asked to develop memory-efficient indexing solutions to solve information retrieval-inspired tasks on very high-dimensional, sparse embeddings using the SPLADE-v3 sparse encoder model.

- Container specifications: 8 virtual CPUs, 24 GB of RAM, the dataset will be mounted read-only into the container.
- Wall clock time for the entire task: 8 hours.
- Dataset: NQ (Natural questions) dataset (from BEIR, https://github.com/beir-cellar/beir) embedded with SPLADE-v3, around 2.68M documents with 30,522 (sparse) dimensions.
- Similarity is measured by the dot product.
- The goal is to compute for each query the k=30 nearest neighbors.
- Operating point: Fastest search time that achieves an average recall (defined as the fraction of true closest returned) of at least 0.9.
- We provide a development dataset; the evaluation will run on the same dataset vectors with queries that are computed with the same underlying model.

### Test Data, Queries, Number of Hyperparameters:

- All test data is embedded into the dataset file. It uses an hdf5 file whose structure is described in [https://huggingface.co/datasets/sadit/SISAP2026](https://huggingface.co/datasets/sadit/SISAP2026).   
- Task 1 dataset: the WIKIPEDIA dataset contains 6.4 million 1024-dimensional, normalized vector embeddings computed with the BGE-M3 model.  
- Task 2 dataset: the LLAMA dataset contains around 256k 128-dimensional vector embeddings by LLAMA3.2-8B; vectors are not normalized.  
- Task 3 dataset: The NQ dataset is taken from <https://github.com/beir-cellar/beir> and contains around 2.68 million vectors produced from the SPLADE-v3  model. 
- In all tasks, participants can build a single index, and are allowed to test 15 different search parameters.  
- For all tasks, gold standards are given as a matrix of object identifiers (indexing starts at 1).  
- In task 1, the gold standard contains self-references, i.e., each point is its own nearest neighbor. These self-references will be removed before recall computation.

Additional datasets:

- For task 1, participants are invited to use the (smaller) datasets from the SISAP 2025 challenge  
- See [https://huggingface.co/datasets/sadit/SISAP2025](https://huggingface.co/datasets/sadit/SISAP2025) for more details 

### Hardware specifications

Details of the evaluation machine will soon be available. 

### Registration and Participation

1. To facilitate running the challenge, please register for the challenge by opening a *"Pre-registration request"* issue in the GitHub repository [https://github.com/sisap-challenges/challenge2026/](https://github.com/sisap-challenges/challenge2026/). Fill out the required data, taking into account that the given data will be used to keep in contact while the challenge remains open. We use this system to keep track of potential participants; for later registration, contact the organizers first.  
2. During the development phase, participants will have access to gold standards for all tasks.  
3. Teams are required to provide public GitHub repositories with working GitHub Actions and clear instructions on how to run their solutions with the correct hyperparameters (up to 15 sets) for each task. You can use a small dataset like the SISAP2025’s CCNEWS. Submissions are required to run in Docker containers. Results have to be written in a standard format to unify the evaluation. Examples will be released soon. Please visit the challenge website for updates.  
4. Participants' repositories will be cloned and tested at the time of the challenge. Results will be shared with the authors for verification and potential fixes before the final rankings are published. The short paper that is to be submitted following an entry will be submitted before the final rankings are published and should thus focus on a self-evaluation of the proposed system.  
5. The private workloads that are used in the evaluation are shared publicly after the evaluation has been carried out.

### Paper Submissions

All participants should submit a short paper that details their system. Accepted papers will be part of the conference proceedings and part of a special session at SISAP 2026\. Each accepted paper is required to be presented in person as an oral presentation at that session. 

We look forward to your participation and innovative solutions in the SISAP Indexing Challenge 2026\! Let's push the frontiers of similarity search and indexing together.

#### Final comments

Any transformation of the dataset to load, index, and solve nearest neighbor queries is allowed. Transformations include but are not limited to packing into different data types, dimensional reduction, locality-sensitive hashing, product quantization, and transformation into binary sketches. Reproducibility and open science are primary goals of the challenge, so we accept only public GitHub repositories with working GitHub Actions as submissions. Indexing algorithms may already be published or original contributions, but a dedicated effort towards solving the respective tasks must be visible in the submission.

#### Examples
- Julia example – <https://github.com/sisap-challenges/sisap2026-julia-example>
    - Working examples for Task 1 and Task 2.
    - GitHub Actions (check the artifacts for a brief [report](https://github.com/sisap-challenges/sisap2026-julia-example/actions/runs/22694672389)).
- Python example - to be release soon.

# Important Dates (all 2026)

- February 23. Call for Participation.
- End of March. Evaluation pipeline available
- June 10. Submission of solution implementations deadline.
- June 17. Short paper descriptions deadline.
- July 8. Final ranking announcement.
- July 27. Paper notification.
- August 13. Participant (short paper) camera ready.

# Organization Committee

- Eric S. Téllez, INFOTEC-SECIHTI, México
- Martin Aumüller, ITU Copenhagen, Denmark
- Vladimír Míč, Aarhus University, Denmark

Write an email to [sisap-2026-indexing-challenge@googlegroups.com](mailto:sisap-2026-indexing-challenge@googlegroups.com) to contact any of the organizers.
