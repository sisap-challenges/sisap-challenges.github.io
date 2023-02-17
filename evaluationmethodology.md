+++
title = "Evaluation methodology"
hascode = true
date = Date(2023, 02, 10)

tags = ["LAION2B", "dataset"]
+++

# Evaluation

Unfortunately, we do not have the computational infrastructure to provide participants with resources (e.g., virtual machines) with the capabilities needed to run their system solutions in fair conditions to measure performance and quality. We ask people to report their experimental setup and normalize their results w.r.t. the brute force solution. The quality should be measured with our public gold standards computed with the original set of embeddings.

However, we will turn our approach to verify whichever participant report as long as they adhere to a simple set of guidelines based on GitHub's Actions continuous integration platform. Each task has different objectives, but all involve queries in some form. Our methodology divides our query set into two stages: a 10k public query set with its associated ground truth that participants will use to benchmark and characterize their approach. Another 10k query set undisclosed will be used to perform our verification report.

## Post-evaluation system verification


The final ranking per task will be published after the submission deadline and before the camera-ready stage so that participants can report their position in the final rank. Partial ranks will be computed using GHA or our primary approach using a small subset of the dataset, e.g., 1M. We will consider only correct GHA running on Ubuntu Linux, it can be test using GHA. Note that we will ignore network-based solutions (calling external API beyond installations) and closed-source platforms (e.g., we cannot handle Matlab solutions.)

We will use a docker instance using a specified version of Linux (that one working in GHA) with Docker using a 32-core Intel(R) Xeon(R) CPU E7-4809 workstation with 128GiB of RAM without GPU.[^1] Construction time will be wall-clocked to at most 12 hours. For the index construction we encourage participants to use multithreading or multiprocessing, searching will always be single-core. Special attention should be paid to storage/retrieval sub-tasks, for verification we will switch between multithread (construction) and single thread instances (querying). The evaluation will timeout after one day.

[^1]: Note that this CPU does not support natively half-precision floating point operations (e.g., `bfloat16`), and therefore, we recommended using 32-bit floating point arithmetic to take advantage of the platform. This will duplicate memory requirements on teams using original clip embeddings. Our PCA projections already use single-precision floating point numbers.

The core idea is to clone the repository, instantiate the specified packages (as defined for GHA), and run the with the available resources changing the input database and query sets (changing input files.) The participant should include all necessary data steps and hyperparameters to reproduce their results effectively in the continuous integration pipeline. We will record and verify raw times for construction, search, and the resulting quality. We will maintain communication with the authors to solve any issues in the evaluation process. 

## About repositories and continuous integration setup
The reproducibility of similarity search methods is essential. We encourage sharing solutions using public GitHub repositories, preferentially under an open-source license to boost its usage and simplify its reproducibility by the community. Of course, repository documentation, notebooks, and tutorials are always welcome.

In the same terms, we ask for using GHA to ensure reproducibility under a limited-size dataset. GHA is a continuous integration platform that can run specified scripts after a repository is updated. We plan to use GHA to ask participants to ensure that indexing and searching methods work in one of the supported platforms. 

- [Examples of working repositories (Python and Julia)](https://sisap-challenges.github.io/repoexamples/)
