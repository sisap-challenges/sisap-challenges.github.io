+++
title = "SISAP Indexing Challenge and Demo Track"
tags = ["sisap", "challenge"]
+++
# SISAP 2023 Indexing Challenge and Demo Track 

The International Conference on Similarity Search and Applications (SISAP) is an annual forum for researchers and application developers in the area of similarity data management. It aims at the technological problems shared by numerous application domains, such as data mining, information retrieval, multimedia, computer vision, pattern recognition, computational biology, geography, biometrics, machine learning, and many others that use similarity search as a necessary supporting service. Machine learning, dense retrieval, and multimedia indexing have taken the scene of similarity search as the most challenging task among applications. This call reflects on this observation.

In 2023 we are launching the \textit{SISAP Indexing Challenge} with a test bed to compare new and existing indexing algorithms in three common tasks. Current data pools are in the order of several billion objects to train a generative deep neural network; we will be steering towards indexing datasets in this size in upcoming editions of this challenge. For this year, we are launching the challenge with datasets fitting on a single modern desktop computer, sized from ten million to one hundred million objects. We aim at providing a common test bed to compare new indexes, re-implementations of previously known indexes and an overview of the behavior of similarity search at various size scales.

## Important information
- Task list and description: [https://sisap-challenges.github.io/tasks/](https://sisap-challenges.github.io/tasks/).
- Evaluation: [https://sisap-challenges.github.io/tasks/](https://sisap-challenges.github.io/tasks/).
- Important dates: see below.
- Datasets:  [https://sisap-challenges.github.io/datasets/](https://sisap-challenges.github.io/datasets/).
- Example GitHub repositories (Actions enabled):  [https://sisap-challenges.github.io/repoexamples/](https://sisap-challenges.github.io/repoexamples/).


## News:
- **Mar. 28th, 2023:** The evaluation methodology was changed to allow multithreading searches (more [details](https://sisap-challenges.github.io/evaluationmethodology/).)
- **May. 31st, 2023:** The gold standards were recomputed using 64-bit IEEE floating point arithmetic, yet storing 32-bit FP values for compatibility. The new files can be downloaded from the [datasets](https://sisap-challenges.github.io/datasets/) page. The new gold standards were computed in response to a list of observations from Vladimír Míč about distance values in the gold standard. Vladimir computed several sanity checks and found queries with many near duplicates and others with ties on critical rank positions. We think the new gold standard help with some issues, but most problems seem part of the dataset (for instance, see [^1]). Currently, the plan is as follows:
  - Remove problematic query objects from the query set.
  - Adjust the metric score to be fair and/or ask for more $k$ nearest neighbors to reduce the impact of problematic queries.
  - Ensure that the evaluation query set (private) is free of these issues.
  - Publish the private query set and its gold standard after the challenge.

[^1]: Webster, R., Rabin, J., Simon, L., & Jurie, F. (2023). On the De-duplication of LAION-2B. arXiv preprint arXiv:2303.12733.

## Important dates
- **Feb. 20th, 2023:** Call for participation published, expression of interest opened.[^2]
- **Apr. 3rd, 2023:** Expression of interest closes.
- ~**Jul. 10th, 2023:** Submission of proposed implementations.~
- **Jul. 16th, 2023:** Submission of proposed implementations.
- **Jul. 31st, 2023:** Short paper deadline (AoE).
- **Aug. 14th, 2023:** Paper notification. 
- **Aug. 20th, 2023:** Publication of final rankings. 
- **Sept. 4th, 2023:** Camera-ready.
- **Oct. 9th-11th, 2023:** SISAP 2023 in A Coruña, Spain, with a special session for the challenge.

[^2]: Visit <https://sisap-challenges.github.io/committee/> for more instructions.

## Reports
We expect that participants prepare a detailed report of their solution in a typical SISAP's _shortpaper format_ with a focus on reproducibility and comparing their speedup against a brute force solution in its machine and the resulting quality w.r.t. recall.
Organizers and an ad-hoc committee will review these short papers if the number of papers is large, looking to increase the paper's quality. All participants can submit a report regardless of its final rank position. As in other SISAP's tracks and sessions, the acceptance will be based on the quality of contribution and the manuscript itself.
