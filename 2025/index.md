+++
title = "SISAP 2025 Indexing Challenge and Demo Track"
tags = ["sisap", "challenge"]
+++
{{redirect /}}

# Task description and call for participation SISAP 2025 Indexing Challenge

The SISAP Indexing Challenge 2025 invites researchers and practitioners to participate in exciting tasks to advance the state of the art in similarity search and indexing. The challenge provides a platform for presenting innovative solutions and pushing the boundaries of efficiency and effectiveness in large-scale similarity search indexes. This year, we are opening two challenging tasks.

Datasets can be found in [https://huggingface.co/datasets/sadit/SISAP2025/tree/main](https://huggingface.co/datasets/sadit/SISAP2025/tree/main); you can clone the full repository or download each file.

### Task 1: Resource-limited indexing 

This task challenges participants to develop memory-efficient indexing solutions with reranking capabilities. Each solution will be run in a Linux container with limited memory and storage resources.

- Container specifications: 8 virtual CPUs, 16 GB of RAM, the dataset will be mounted read-only into the container.  
- Wall clock time for the entire task: 12 hours.  
- Minimum average recall to be considered in the final ranking: 0.7.  
- Dataset: PUBMED23 (23 million vectors (384 dimensions) with *out-of-distribution* queries).  
- The goal is to evaluate k=30 nearest neighbors for a large set of query objects, as follows:  
  - The final score of each team is measured as the best throughput evaluated on up to 16 different search hyperparameters.  
  - Teams are provided with a public set of 11,000 query objects for development purposes.  
  - A private set of 10,000 new queries will be used for the final evaluation. 

### Task 2: K-nearest neighbor graph (a.k.a. metric self-join)

In this task, participants are asked to develop memory-efficient indexing solutions that will be used to compute an approximation of the *k-*nearest neighbor graph for *k=15*. Each solution will be run in a Linux container with limited memory and storage resources.

- Container specifications: 8 virtual CPUs, 16 GB of RAM, the dataset will be mounted read-only into the container.  
- Wall clock time for the entire task: 12 hours.  
- Minimum average recall to be considered in the final ranking: 0.8.  
- Dataset: GOOAQ (3 million vectors (384 dimensions) ).  
- The goal is to compute the *k-nearest neighbor graph (without self-references)*, i.e., find the *k*\-nearest neighbors using all objects in the dataset as queries.  
  - We will measure graph’s quality as the recall against a provided gold standard and the full computation time (i.e., including preprocessing, indexing, and search, and postprocessing)  
  - We provide a development dataset; the evaluation phase will use an undisclosed dataset of similar size computed with the same neural model.

#### Test Data and Queries:

- The h5 file structure is described in [https://huggingface.co/datasets/sadit/SISAP2025](https://huggingface.co/datasets/sadit/SISAP2025).  
- Each file contains vector embeddings computed in Sentence-BERT models over text datasets; for Task 1 we provide *in-distribution* queries and *out-of-distribution* queries for each dataset, so you can develop and compare your methods with different datasets.  
- Similarity between two objects is measured by their dot product.  
- Gold standards are given as a matrix of object identifiers (indexing starts at 1).  
- Task 2 gold standards contain self-references that will be removed before recall computation.

#### The evaluation will be carried out on a machine with the following specifications:

- 2x Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz, 28 cores in total  
- 512 GB RAM (DDR4, 2400 MT/s)  
- 1 TB SSD 

### Registration and Participation

1. Register for the challenge by opening a *"Pre-registration request"* issue in the GitHub repository [https://github.com/sisap-challenges/challenge2025/](https://github.com/sisap-challenges/challenge2025/). Fill out the required data, taking into account that the given data will be used to keep in contact while the challenge remains open.  
2. During the development phase, participants will have access to a gold-standard corresponding to that phase.  
3. Teams are required to provide public GitHub repositories with working GitHub Actions and clear instructions on how to run their solutions with the correct hyperparameters (up to 16 sets) for each task. You can use a small dataset like the given CCNEWS. Submissions are required to run in docker containers. Examples will be released soon, please visit the challenge site for updates.  
4. Participants' repositories will be cloned and tested at the time of the challenge. Results will be shared with the authors for verification and potential fixes before the final rankings are published.  
5. The evaluation queryset for Task 1 and the evaluation dataset for Task 2 will be disclosed after the evaluation phase.

### Paper Submissions

All participants will be considered for paper submissions. We aim to accommodate all accepted papers within the conference program. Papers should be short, focusing on the presentation and poster.

We look forward to your participation and innovative solutions in the SISAP Indexing Challenge 2025\! Let's push the frontiers of similarity search and indexing together.

#### Final comments

Any transformation of the dataset to load, index, and solve nearest neighbor queries is allowed. Transformations include but are not limited to, packing into different data types, dimensional reduction, locality-sensitive hashing, product quantization, or transforming into binary sketches. Reproducibility and open science are primary goals of the challenge, so we accept only public GitHub repositories with working GitHub Actions as submissions. Indexing algorithms may be already published or original contributions.

You can find more detailed information, data access, and registration at the SISAP Indexing Challenge website [https://sisap-challenges.github.io/2025/](https://sisap-challenges.github.io/2025/)

### Important Dates

- Jan. 27th. Task proposal deadline. 
- Feb. 10th. Task proposal acceptance notification Note: [No proposals were received](https://sisap-challenges.github.io/2025/call-for-proposals2025/index.html).
- Feb. 21th. Call for Participation on the Indexing Challenge.
- June 6th. Submission of solution implementations deadline.  
- June 13th. Short paper descriptions deadline.  
- July 1st. Final ranking announcement.  
- July 11th. Paper notification.  
- July 31st. Participant (short paper) camera ready.

## SISAP Indexing Challenge Chairs

- Edgar L. Chavez, CICESE, México <elchavez@cicese.edu.mx>  
- Eric S. Téllez, INFOTEC-SECIHTI, México <eric.tellez@ieee.org>  
- Martin Aumüller, ITU Copenhagen, Denmark <maau@itu.dk>  
- Vladimir Mic, Aarhus University, Denmark <v.mic@cs.au.dk>

