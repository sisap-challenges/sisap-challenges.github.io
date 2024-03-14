+++
title = "Evaluation methodology"
hascode = true
date = Date(2024, 03, 13)

tags = ["LAION2B", "methodology"]
+++

# Evaluation

Unfortunately, we do not have the computational infrastructure to provide participants with resources with the capabilities needed to run their system solutions in fair conditions to measure performance and quality. .

However, we will turn our approach to verify whichever participant report as long as they adhere to a simple set of guidelines based on GitHub's Actions continuous integration platform. Participants also need to define a Docker file to run their approach. Each task has different objectives, but all involve queries in some form. Our methodology divides our query set into two stages: a 10k public query set with its associated ground truth that participants will use to benchmark and characterize their approach. Another query set undisclosed (private) will be used to perform our verification report.

## Post-evaluation system verification

The final ranking per task will be published after the submission deadline and before the camera-ready stage so that participants can report their position in the final rank. Partial ranks will be computed using GHA or our primary approach using a small subset of the dataset, e.g., 1M. We will consider only correct GHA running on Ubuntu Linux, it can be test using GHA. Note that we will ignore network-based solutions (calling external API beyond installations) and closed-source platforms (e.g., we cannot handle Matlab solutions.)

We will use a docker instance using a specified version of Linux (that one working in GHA) with Docker; we are unable to give access to GPUs.[^1] We encourage participants to use multithreading or multiprocessing in the construction and searching stages to take advantage of the hardware. The evaluation will timeout after one day.

[^1]: Our comuter may not support natively half-precision floating point operations (e.g., `bfloat16`), and therefore, we recommended using 32-bit floating point arithmetic to take advantage of the platform. This will duplicate memory requirements on teams using original clip embeddings.


## About repositories and continuous integration setup
The core idea is to clone the repository, instantiate the specified packages (as defined for GHA), and run the with the available resources changing the input database and query sets (changing input files.) The participant should include all necessary data steps and hyperparameters to reproduce their results effectively in the continuous integration pipeline. We will record and verify raw times for construction, search, and the resulting quality. We will maintain communication with the authors to solve any issues in the evaluation process. 

The reproducibility of similarity search methods is essential. We encourage sharing solutions using public GitHub repositories, preferentially under an open-source license to boost its usage and simplify its reproducibility by the community. Of course, repository documentation, notebooks, and tutorials are always welcome.

In the same terms, we ask for using GHA to ensure reproducibility under a limited-size dataset. GHA is a continuous integration platform that can run specified scripts after a repository is updated. We plan to use GHA to ask participants to ensure that indexing and searching methods work in one of the supported platforms. 

- [Examples of working repositories (Python and Julia)](/2024/repoexamples/)
