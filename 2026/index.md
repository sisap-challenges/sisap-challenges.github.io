+++
title = "SISAP 2026 Indexing Challenge"
tags = ["sisap", "challenge"]
+++

{{redirect /}}

# SISAP 2026 Indexing Challenge: Task description and participation details
\toc

**[Final leaderboard for the SISAP 2026 Indexing Challenge](/sisap26-leaderboard/)**

~~~
<div style="background-color: #e6f7ff; border: 2px solid #1890ff; border-radius: 5px; padding: 15px; margin: 20px 0;">
    <h3 style="margin-top: 0; color: #0050b3;">Final Leaderboard Available</h3>
    <p>The SISAP 2026 challenge is now concluded. Final results are available in the <a href="/sisap26-leaderboard/">leaderboard</a>.</p>
</div>
~~~


The SISAP Indexing Challenge 2026 is now concluded. This page documents the tasks, datasets, rules, and hardware constraints used for the 2026 edition, and the final results are available in the [leaderboard](/sisap26-leaderboard/).

Datasets are available at [https://huggingface.co/datasets/sisap-challenges/SISAP2026/tree/main](https://huggingface.co/datasets/sisap-challenges/SISAP2026/tree/main); you can clone the full repository or download each file separately.

The challenge repository remains available at [https://github.com/sisap-challenges/challenge2026/](https://github.com/sisap-challenges/challenge2026/).

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
  - You are free to return the result set that includes the self-references, i.e., you return an `n x (k + 1)` matrix.


### Task 2: Maximum Inner Product Search on LLM attention workloads (Search under Distribution Shift)

In this task, participants are asked to develop memory-efficient indexing solutions to solve maximum inner product search queries in an LLM-inspired workload. Each solution will be run in a Linux container with limited memory and storage resources. 

- Container specifications: 8 virtual CPUs, 24 GB of RAM, the dataset will be mounted read-only into the container.  
- Wall clock time for the entire task: 1 hour.  
- Dataset: Llama-3-8B-262k (256,921 vectors, 128 dimensions)
- The task is split up into two separate phases: an _index preprocessing phase_ in which the dataset is presented, and a _search phase_ in which queries are presented.
- Similarity between two objects is measured by their dot product; note that vectors are not normalized.  
- The goal is to compute k=30 maximum inner product queries for the provided queries.  
- Operating point: Fastest search time that achieves an average recall of at least 0.8.  
- We provide a development dataset; the evaluation will use an undisclosed dataset of similar size computed with the same underlying LLM model, with a larger number of queries.

### Task 3: Indexing very sparse high-dimensional vectors
Learned sparse models bridge traditional inverted indexing and neural retrieval. However, their high dimensionality and learned term distributions challenge classical IR data structures.

This task investigates how to design scalable, memory-efficient indexing methods for such representations under realistic hardware constraints. In this task, participants are asked to develop memory-efficient indexing solutions to solve information retrieval-inspired tasks on very high-dimensional, sparse embeddings using the SPLADE-v3 sparse encoder model.

- Container specifications: 8 virtual CPUs, 24 GB of RAM, the dataset will be mounted read-only into the container.
- Wall clock time for the entire task: 8 hours.
- Dataset: NQ (Natural questions) dataset (from BEIR, https://github.com/beir-cellar/beir) embedded with SPLADE-v3, around 2.68M documents with 30,522 (sparse) dimensions. File: `nq.h5`.
- The task is split up into two separate phases: an index preprocessing phase in which the dataset is presented, and a search phase in which queries are presented.
- Similarity is measured by the dot product.
- The goal is to compute for each query the k=30 nearest neighbors.
- Operating point: Fastest search time that achieves an average recall (defined as the fraction of true closest returned) of at least 0.9.
- We provide a development dataset; the evaluation will run on the same dataset vectors with queries that are computed with the same underlying model.
- **Smaller development dataset**: We also provide a smaller dataset based on FIQA (Financial Question Answering) for development purposes.
  - File: `fiqa-dev.h5`
  - Size: 57k sparse vectors, 30,522 dimensions (SPLADE-v3 model)
  - Queries: 6,648 development queries
  - This dataset is useful for quick prototyping and testing of indexing structures before moving to the full NQ dataset.

### Test Data, Queries, Number of Hyperparameters:

- All test data is embedded into the dataset file. It uses an hdf5 file whose structure is described in [https://huggingface.co/datasets/sisap-challenges/SISAP2026](https://huggingface.co/datasets/sisap-challenges/SISAP2026).
- Task 1 dataset: the WIKIPEDIA dataset contains 6.4 million 1024-dimensional, normalized vector embeddings computed with the BGE-M3 model.  
- Task 2 dataset: the LLAMA dataset contains around 256k 128-dimensional vector embeddings by LLAMA3.2-8B; vectors are not normalized.  
- Task 3 dataset: The NQ dataset is taken from <https://github.com/beir-cellar/beir> and contains around 2.68 million vectors produced from the SPLADE-v3  model. 
- In all tasks, participants can build a single index, and are allowed to test 15 different search parameters.  
- For all tasks, gold standards are given as a matrix of object identifiers (indexing starts at 1).
- In task 1, the gold standard contains self-references, i.e., each point is its own nearest neighbor. These self-references will be removed before recall computation.
- For task 2 and task 3, all queries will be presented at once, and batch processing is explicitly encouraged.
- For task 1, we measure the total time as
  - the time needed to preprocess and load the data,
  - the build time for the index (1 index allowed), 
  - and the time it took to generate the k-NN graph from the index (15 separate hyperparameters possible).
- For task 2 and 3 only the search phase time is measured.
- Participants should provide these timings in the result file. We will audit the methodology and compare it to the measured wall-clock time of the container.

Additional datasets:

- For task 1, participants are invited to use the (smaller) datasets from the SISAP 2025 challenge  
- See [https://huggingface.co/datasets/SISAP-Challenges/SISAP2025](https://huggingface.co/datasets/SISAP-Challenges/SISAP2025) for more details 

### Result Submission Format

To ensure compatibility with the evaluation pipeline, results must be provided as HDF5 files following a specific structure and metadata format.

**File Content:**
Each HDF5 file must contain two datasets:
- `knns`: An $n \times k$ matrix of object identifiers (integers), where $n$ is the number of queries and $k$ is the number of neighbors. The $i$-th row contains the identifiers of the $k$ nearest neighbors of the $i$-th query. Identifiers must use **1-based indexing** (i.e., the first object in the dataset has ID 1).
- `dists`: An $n \times k$ matrix of distances (floats). The $i$-th row contains the distances of the $k$ nearest neighbors of the $i$-th query according your implementation.

**Note:** Matrices should follow **row-major order** (standard for C/Python/NumPy). For task 1, you may return a $n \times k + 1$ matrix that includes the self-reference. This will be removed for recall computation.

**Metadata (Attributes):**
The HDF5 file must include the following attributes at the root level:
- `algo`: Name of the algorithm (string).
- `task`: Name of the task (e.g., `task1`, `task2`, `task3`).
- `buildtime`: Index construction time in seconds (float). For task 1, also include data loading/preprocessing.
- `querytime`: Total search time in seconds (float).
- `params`: A string describing the parameters (e.g., `M=16,efConstruction=100`).

**Directory Structure:**
Files should be organized in the following directory structure:
`results/<task_name>/<unique_filename>.h5`

For example: `results/task1/myalgo_M16_ef100.h5`.

### Docker Container and Evaluation

The challenge used a reproducible evaluation framework based on Docker containers. The configuration below is preserved as reference for participants and future editions. To enforce the system requirements of the challenge, the container could be executed with the following limits:

```bash
docker run \
    -it \
    --cpus=8 \
    --memory=24g \
    --memory-swap=24g \
    --memory-swappiness 0 \
    --volume $(pwd)/data:/app/data:ro \
    --volume $(pwd)/results:/app/results:rw \
    sisap-baseline --task task3 --dataset fiqa-dev
```

- `--cpus=8`: Limits the container to 8 CPU cores.
- `--memory=24g`: Limits the RAM to 24 GB.
- `--memory-swap=24g`: Ensures that no swap is used beyond the RAM limit.
- `--volume`: Mounts the data directory as read-only and the results directory as read-write.
- `sisap-baseline`: This should be replaced with your image name.
- `--task` and `--dataset`: These are example arguments that your container entrypoint might accept to run the specific task and dataset.

### Hardware specifications

The evaluation will be carried out using AMD EPYC 7F72 24-Core Processors.

### Registration and Participation

The following process was used during the live challenge:

1. Teams registered by opening a *"Pre-registration request"* issue in the GitHub repository [https://github.com/sisap-challenges/challenge2026/](https://github.com/sisap-challenges/challenge2026/).  
2. During the development phase, participants had access to gold standards for all tasks.  
3. Teams submitted their solutions through TIRA. Submissions were required to run in Docker containers and results had to be written in a standard format to unify the evaluation. Please see the [submission details and evaluation page](/2026/evaluation/) for the archived workflow and examples.  
4. TIRA submissions were tested at the time of the challenge. Results were shared with the authors for verification and potential fixes before the final leaderboard was published. The short paper submitted with an entry therefore focused on a self-evaluation of the proposed system.  
5. The private workloads that were used in the evaluation are shared publicly after the evaluation has been carried out.
6. One person could only be part of a single team. 

### Paper Submissions

All participants should submit one short paper that details their system. If participants solve multiple tasks, the system must be described in a single paper (that might reference a technical report). Accepted papers will be part of the conference proceedings and part of a special session at SISAP 2026. 
Each accepted paper is required to be presented in person as an oral presentation at that session.
Submissions that are not accompanied by an accepted short paper will be disqualified and removed from the final rankings.
Please submit your short paper through the regular EasyChair submission system for [SISAP 2026](https://easychair.org/my/conference?conf=sisap2026). Pick "indexing challenge" as paper category. Submissions have to follow the rules of short papers described in the [call for paper](https://sisap.org/2026/callforpapers.html) (in particular, at most 8 pages in standard LNCS style), but should be provided **non-anonymized**. More detailed analysis can be provided through a technical report referenced in the short paper.

We thank all participants for their contributions to the SISAP Indexing Challenge 2026.

### Examples
- Julia example – <https://github.com/sisap-challenges/sisap2026-julia-example>
    - Working example.
    - GitHub Actions (check the artifacts for a brief [report](https://github.com/sisap-challenges/sisap2026-julia-example/actions/runs/22694672389)).
- Python example - <https://github.com/sisap-challenges/sisap26-python-baseline>
    - Working example.

Both examples remain available as reference baselines.

### Final comments

Any transformation of the dataset to load, index, and solve nearest neighbor queries is allowed. Transformations include but are not limited to packing into different data types, dimensional reduction, locality-sensitive hashing, product quantization, and transformation into binary sketches. Reproducibility and open science are primary goals of the challenge, so we accept only public GitHub repositories with working GitHub Actions as submissions. Indexing algorithms may already be published or original contributions, but a dedicated effort towards solving the respective tasks must be visible in the submission.


# Important Dates (all 2026)

- February 23. challenge opens
- May 22.  Evaluation pipeline available
- June 10  → June 17 (extended). Submission of solution implementations deadline.
- June 17  → June 24 (extended). Short paper descriptions deadline.
- July 8. Final leaderboard published.
- July 27. Paper notification.
- August 13. Participant (short paper) camera ready.

# Organization Committee

- Eric S. Téllez, INFOTEC-SECIHTI, México
- Martin Aumüller, ITU Copenhagen, Denmark
- Maik Fröbe, University of Jena, Germany
- Vladimír Míč, SDU Odense, Denmark

Write an email to [sisap-2026-indexing-challenge@googlegroups.com](mailto:sisap-2026-indexing-challenge@googlegroups.com) to contact any of the organizers.
