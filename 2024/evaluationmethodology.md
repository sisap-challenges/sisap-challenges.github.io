+++
title = "Evaluation methodology"
hascode = true
date = Date(2024, 03, 13)

tags = ["LAION2B", "methodology"]
+++
\linkstwentyfour

# Evaluation

Unfortunately, we do not have the computational infrastructure to provide participants with resources with the capabilities needed to run their system solutions in fair conditions to measure performance and quality. .

However, we will turn our approach to verify whichever participant report as long as they adhere to a simple set of guidelines based on GitHub's Actions continuous integration platform. Participants also need to define a Docker file to run their approach. Each task has different objectives, but all involve queries in some form. Our methodology divides our query set into two stages: a 10k public query set with its associated ground truth that participants will use to benchmark and characterize their approach. Another query set undisclosed (private) will be used to perform our verification report.

## Post-evaluation system verification

The final ranking per task will be published after the submission deadline and before the camera-ready stage so that participants can report their position in the final rank. We will consider only correct Github Actions (GHA) running on Ubuntu Linux. In this 2024 we also ask for a working Dockerfile. Note that we will ignore network-based solutions (calling external API beyond installations) and closed-source platforms (e.g., we cannot handle Matlab solutions.)

We are unable to give access to GPUs.[^1] We encourage participants to use multithreading or multiprocessing in the construction and searching stages to take advantage of the hardware. The evaluation will timeout as specified in each task description.

[^1]: Our computer may not support natively half-precision floating point operations (e.g., `bfloat16`), and therefore, we recommended using 32-bit floating point arithmetic to take advantage of the platform. This will duplicate memory requirements.


The reproducibility of similarity search methods is essential. We encourage sharing solutions using public GitHub repositories, preferentially under an open-source license to boost its usage and simplify its reproducibility by the community. Of course, repository documentation, notebooks, and tutorials are always welcome.


- [Examples of working repositories (Python and Julia)](/2024/repoexamples/)

