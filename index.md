+++
title = "SISAP Indexing Challenge and Demo Track"
tags = ["sisap", "challenge"]
+++

# SISAP 2023 Indexing Challenge and Demo Track 

Over time, data-centric science has to undertake increasingly complex tasks requiring larger amounts of high-dimensional data and more compute cycles to be complete. Over the same period, researchers have discovered inherent limitations to fundamental proximity indexing algorithms. We know now that there cannot be an algorithm that is both precise and fast for finding the nearest neighbors of a query in a collection. The above has discouraged researchers from making precise complexity models for new indexing algorithms; most work in indexing is heuristic and validated over common test beds.

The International Conference on Similarity Search and Applications (SISAP) is an annual forum for researchers and application developers in the area of similarity data management. It aims at the technological problems shared by numerous application domains, such as data mining, information retrieval, multimedia, computer vision, pattern recognition, computational biology, geography, biometrics, machine learning, and many others that use similarity search as a necessary supporting service. Machine learning, dense retrieval, and multimedia indexing have taken the scene of similarity search as the most challenging task among applications. This call reflects on this observation.

In 2023 we are launching the _Indexing Challenge and Demo Track_ with a test bed to compare new and existing indexing algorithms in a common task. Current data pools are in the order of several billion objects to train a generative deep neural network; we will be steering towards indexing datasets in this size in upcoming editions of this challenge. For this year, we are launching the challenge with datasets sized one to one hundred million objects. We aim to provide a common test bed to report on theoretical and practical advances in proximity indexing objects in different scales.

To make results comparable, we ask participants to normalize the results using sequential $k$-nn search, reporting speedup with respect to this baseline instead of plain query speed or throughput. We will also verify those solutions that can be reproduced in a reasonable effort and time (below, we provide a set of guidelines to help with this goal) using a common workstation.


## Aims and scope
We aim for systems that solve any of the below-described tasks, i.e., Task A, Task B, or Task C. Participation is made in the form of teams. Teams will nominate at least one person to communicate with organizers. A person can be part of just one team.

The team should create a GitHub repository with the system and a GitHub Action (GHA) showcasing the system works for a small subset of the task being tackled. The team should share the repository to reproduce and compare the system's results; any help request and submission must mention the precise commit hash to be verified.

@@warn
The GitHub repository can remain private during the challenge, although it is expected to be made public after the challenge or at the very least give access to the organizers. We expect the repository to work with the GitHub Actions continuous integration and correctly run a small test bed containing all the necessary configurations and hyper-parameters to run tasks.
@@

Solutions working on different subsets should also specify the setup to reproduce results. The solution should store its output in a prescribed format for each task. Repositories should give enough information to determine what functions should be run and if hyperparameters should be set for each subset and task; this is critical for solutions working on several tasks and several dataset subsets.

Authors are encouraged to prepare a short paper reporting its design, ablation study, result, and discussion in a traditional SISAP short paper format. This report will be included in the main conference proceedings published by Springer in its LNCS series.

