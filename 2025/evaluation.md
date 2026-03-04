+++
title = "Results of the SISAP 2025 Indexing Challenge"
tags = ["sisap", "challenge"]
+++

# Results of the SISAP 2025 Indexing Challenge
\toc

## Participating Teams

| Team | Members | Task | Paper | Repo |
|------|---------|------|-------|------|
| BrownCICESE | Foster, Magdaleno-Gatica, Kimia | 1, 2 | [Refinement-Based Graph Construction for Search in Low-Memory Systems](https://link.springer.com/chapter/10.1007/978-3-032-06069-3_38) | <https://github.com/sisap-challenges/sisap25-BrownCICESE>
| cm-lll | Lou, Ma, Luo, Ruan, Wu, Lu, Mao | 1 | [Memory-Constrained DiskANN](https://link.springer.com/chapter/10.1007/978-3-032-06069-3_34) | <https://github.com/sisap-challenges/sisap25-cm-lll>
| Crusty Coders | Dearle, Connor, Claydon, McKeogh | 1, 2 | [Fast, Compact NN-Table Build Using Equi-Voronoi Polytopes](https://link.springer.com/chapter/10.1007/978-3-032-06069-3_37) | <https://github.com/sisap-challenges/sisap25-metric_space_rust>
| DCC-UChile | Bustos, Chen | 2 | [SISAP Indexing Challenge 2025 -- Solution for Task 2 Using Root Join](https://link.springer.com/chapter/10.1007/978-3-032-06069-3_36) | <https://github.com/sisap-challenges/sisap25-DCC-Uchile>
| hforest | Imamura | 1, 2 | — | <https://github.com/sisap-challenges/sisap25-hforest>
| JLapeyra | Lapeyra | 1, 2 | — | <https://github.com/sisap-challenges/sisap25-Lapeyra>
| TeamDoubleFiltering | Higuchi, Imamura, Shinohara, Hiratta, Kuboyama | 1 | [Double Filtering Using Short and Long Quantized Projections](https://link.springer.com/chapter/10.1007/978-3-032-06069-3_35) | <https://github.com/sisap-challenges/sisap25-TeamDoubleFiltering>

Four teams participated in both tasks, two teams focused solely on Task 1, and one team addressed only Task 2. Two baselines were provided: *BL-SearchGraph* (a graph-based index using `SimilaritySearch.jl`) and *BL-Bruteforce* (parallel exhaustive scan), both using PCA projection and 8-bit scalar quantization.

## Task 1: Resource-limited Indexing

Task 1 required memory-efficient approximate nearest neighbor search on the PUBMED23 dataset (23.9 million 384-dimensional vectors, 35 GB on disk). Solutions operated under 16 GB RAM, 8 virtual CPUs, and a 12-hour wall-clock limit. The ranking criterion was the highest search throughput (queries/second) among configurations achieving at least 0.7 average recall for $k=30$ nearest neighbors using out-of-distribution queries.

### Results for Task 1

| Team | Rank | Recall | Build time (s) | Query time (s) | Throughput (q/s) | Container time (s) | Median rmem (GB) | Max rmem (GB) |
|------|------|--------|----------------|----------------|------------------|--------------------|-------------------|---------------|
| BL-SearchGraph | 1 | 0.7322 | 4,320 | 0.60 | 16,769 | 4,667 | 9.6 | 13.2 |
| BrownCICESE | 2 | 0.7884 | 9,563 | 1.44 | 6,928 | 9,646 | 14.2 | 14.3 |
| TeamDoubleFiltering | 3 | 0.7212 | — | 9.25 | 1,081 | 324 | 9.6 | 9.6 |
| hforest | 4 | 0.7053 | 2,243 | 15.70 | 637 | 2,594 | 12.2 | 16.0 |
| cm-lll | 5 | 0.8347 | 6,419 | 34.61 | 289 | 6,457 | 11.6 | 11.6 |
| Crusty Coders | 6 | 0.8048 | 2,980 | 178.00 | 56 | 3,161 | 14.5 | 14.5 |
| JLapeyra | 7 | 1.0000 | — | 870.32 | 11 | 873 | 7.9 | 15.3 |
| BL-Bruteforce | 8 | 0.8559 | 0 | 1,265.15 | 8 | 1,588 | 5.2 | 5.3 |

The ranking was led by the BL-SearchGraph baseline. The top-performing participant was **BrownCICESE** (rank 2) with a query time of 1.44 seconds. **TeamDoubleFiltering** stands out for overall efficiency: its total pipeline time of 324 seconds is nearly five times faster than the brute-force baseline, and its query phase is over 100 times faster. All participating teams surpassed the BL-Bruteforce baseline.

The following figure shows the speed–recall trade-offs for teams with multiple hyperparameter configurations.

![Performance for Task 1](/assets/2025/fig-task1.png)

## Task 2: $k$-NN Graph Construction

Task 2 required memory-efficient approximation of the $k$-nearest neighbor graph for $k=15$ on the GOOAQ dataset (3 million 384-dimensional vectors, 7.4 GB on disk). The same resource limits applied (16 GB RAM, 8 vCPUs, 12 hours). Solutions were ranked by total container time for configurations achieving at least 0.8 average recall.

### Results for Task 2

| Team | Rank | Recall | All-knn time (s) | Container time (s) | Median rmem (GB) | Max rmem (GB) |
|------|------|--------|-------------------|---------------------|-------------------|---------------|
| hforest | 1 | 0.8049 | 99 | 105 | 7.1 | 7.4 |
| BL-SearchGraph | 2 | 0.8257 | 112 | 165 | 1.9 | 2.3 |
| BrownCICESE | 3 | 0.8198 | 446 | 450 | 6.2 | 6.2 |
| Crusty Coders | 4 | 0.8012 | 542 | 548 | 3.1 | 3.1 |
| BL-Bruteforce (160d) | — | 0.5210\* | 9,378 | 9,410 | 1.2 | 1.6 |
| JLapeyra | — | 0.9944 | 61,430 | 61,433\* | 5.4 | 14.8 |
| DCC-UChile | — | 0.5432\* | 113,203 | 113,213\* | 8.2 | 16.0 |

\* Did not meet all constraints (time limit and/or minimum recall).

The **hforest** team achieved the first position, completing the task in just 105 seconds. BL-SearchGraph was second at 165 seconds, followed by BrownCICESE (450 s) and Crusty Coders (548 s). JLapeyra achieved near-perfect recall but exceeded the 12-hour time limit. DCC-UChile did not meet either the time or recall constraints.

![Performance for Task 2](/assets/2025/fig-task2.png)

## Winner Ceremony

The diverse set of approaches were presented during a special session at [SISAP 2025](https://sisap.org/2025/index.html).

### Honorable Mentions

The challenge committee awarded two honorable mentions for outstanding contributions:

**BrownCICESE** (Tasks 1 & 2), represented at the conference by Cole Foster, received an honorable mention for their competitive performance across both tasks. Their scalar-quantization approach with HSP-based graph indexing achieved the highest throughput among all participants in Task 1 and placed third in Task 2, demonstrating a versatile and effective solution.

![Cole Foster representing team BrownCICESE at the award ceremony](/assets/2025/sisap_task12_price.JPG)

**Crusty Coders** (Task 2), represented at the conference by Alan Dearle, Richard Connor, and Ben Claydon, received an honorable mention for their novel ultra-quantization technique. Their 2-bit compression scheme with a modified NN-Descent algorithm achieved a compact and efficient $k$-NN graph construction, placing fourth in Task 2 with a total time of 548 seconds while using only 3.1 GB of memory.

![Alan Dearle, Richard Connor, and Ben Claydon representing team Crusty Coders at the award ceremony](/assets/2025/sisap_task2.JPG)

## Reference

For the full technical details, see the [Overview of the SISAP 2025 Indexing Challenge](https://link.springer.com/chapter/10.1007/978-3-032-06069-3_33) by E. S. Tellez, E. Chavez, M. Aumüller, and V. Mic, published in the [SISAP 2025 proceedings](https://link.springer.com/book/10.1007/978-3-032-06069-3).
