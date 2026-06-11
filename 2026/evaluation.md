# Submission Details for SISAP 2026 Indexing Challenge

Below you will find all the details you need to get started.

**Quick Checklist**

- Pre-register your team via GitHub.
- Register your team in TIRA.
- Run a local dry run with the TIRA CLI.
- Authenticate with TIRA and submit your code.
- Wait for the organizers to trigger the full evaluation.

---

**Challenge Overview**

The SISAP 2026 Indexing Challenge features three tasks:

- **Task 1:** K-nearest neighbor graph construction (metric self-join) on 6.4M Wikipedia vectors (1024-dim, BGE-M3).
- **Task 2:** Maximum Inner Product Search on LLM attention workloads (256k vectors, 128-dim, Llama-3-8B).
- **Task 3:** Indexing very sparse high-dimensional vectors using SPLADE-v3 embeddings (~2.68M documents, 30,522-dim).

All tasks are evaluated inside Docker containers with **8 vCPUs and 24 GB RAM**. The CPUs used are **AMD EPYC 7F72 24-Core** Processor. Full task descriptions are available at: [sisap-challenges.github.io/2026](https://sisap-challenges.github.io/2026/)

---


**Submission via TIRA**

For this year, submissions are handled through **TIRA** ([tira.io/task-overview/sisap-2026](https://www.tira.io/task-overview/sisap-2026)). TIRA provides a reproducible, containerized evaluation framework.
Code submissions for SISAP 2026 are handled only through TIRA.
We can help troubleshoot submissions; see more info below.
Please register your team as soon as possible. 


### How to Submit

**Step 1 — Register your team**

1. Sign up or log in at [tira.io](https://www.tira.io/) (GitHub login supported).
2. Navigate to [tira.io/task-overview/sisap-2026](https://www.tira.io/task-overview/sisap-2026) and click **Register**.
3. Optionally add team members via [tira.io/g?type=my](https://www.tira.io/g?type=my).

**Step 2 — Verify locally**

Install the TIRA CLI and do a dry run against one of the spot-check datasets:

```bash
pip3 install --upgrade tira

tira-cli code-submission \
    --path . \
    --command '{YOUR EXECUTABLE} --input $inputDataset/*.h5 --task-description $inputDataset/config.json --output $outputDir' \
    --task sisap-2026 \
    --dataset task-1-spot-check-20260528-training \
    --dry-run
```

Use `task-2-spot-check-20260528-training` or `task-3-spot-check-20260528-training` if your approach only targets Task 2 or Task 3, respectively.

**Step 3 — Authenticate and submit**

Retrieve your authentication token from the TIRA task page (*Submit → Code Submissions → New Submission → I want to submit from my local machine*), then:

```bash
tira-cli login --token AUTH-TOKEN
tira-cli verify-installation --task sisap-2026 --team YOUR-TEAM

tira-cli code-submission \
    --path . \
    --command '{YOUR EXECUTABLE} --input $inputDataset/*.h5 --task-description $inputDataset/config.json --output $outputDir' \
    --task sisap-2026 \
    --dataset task-1-spot-check-20260528-training
```

Your program should write its output files to `$outputDir` in the format described on the [task description page](/2026/#result-submission-format).

**Step 4 — Trigger evaluation in the TIRA UI**

Navigate to the task page, click *Submit → Code Submissions*, select your submission, choose a dataset and hardware configuration. The organizers will handle execution on all datasets once your submission looks correct. During code submission, TIRA only runs small workloads. These are available in the baseline mentioned below.

---

**Python Baseline**

A working Python baseline is available to help you get started:
[github.com/sisap-challenges/sisap26-python-baseline](https://github.com/sisap-challenges/sisap26-python-baseline)

It includes Docker support, GitHub Actions CI, evaluation scripts, and plotting utilities. You are encouraged to fork it as the starting point for your own solution.

A Julia example is also available: [github.com/sisap-challenges/sisap2026-julia-example](https://github.com/sisap-challenges/sisap2026-julia-example)

---

**Important Dates**

| Date | Milestone |
|------|-----------|
| June 10, 2026  → **June 17, 2026** (extended) | **Submission of solution implementations deadline** |
| June 17, 2026  → **June 24, 2026** (extended) | Short paper description deadline |
| July 8, 2026 | Final ranking announcement |
| July 27, 2026 | Paper notification |
| August 13, 2026 | Camera-ready deadline |

---

**Short paper**

Please submit yourshort paper through the regular EasyChair submission system for [SISAP 2026](https://easychair.org/my/conference?conf=sisap2026). Pick "indexing challenge" as paper category. Submissions have to follow the rules of short papers described in the [call for paper](https://sisap.org/2026/callforpapers.html) (in particular, at most 8 pages in standard LNCS style), but should be provided **non-anonymized**. More detailed analysis can be provided through a technical report referenced in the short paper.

---

**Pre-registration**

If you have not yet pre-registered, please open a *"Pre-registration request"* issue at:
[github.com/sisap-challenges/challenge2026](https://github.com/sisap-challenges/challenge2026/)

---

### Troubleshooting

After registering your team at TIRA, you can reach out to the organizers via the platform. After login, you can use the following [direct link](https://www.tira.io/new-message?username=tira_org_sisap&title=Request%20&body=message%20body), or write a direct message to [Maik](https://www.tira.io/u/maik_froebe). We will help you with the submission process. 

---

We look forward to your submissions! For questions, contact the organizing committee at sisap-2026-indexing-challenge@googlegroups.com.

---

The SISAP 2026 Indexing Challenge Organizing Committee

Eric S. Téllez, Martin Aumüller, Maik Fröbe, Vladimír Míč
