<!--
Add here global page variables to use throughout your
website.
The website_* must be defined for the RSS to work
-->
@def website_title = "SISAP 2023 Implementation Challenge and Demo Track"
@def website_descr = "Main site for the call for implementation and challenge"
@def website_url   = "https://sisap-challenges.github.io/"

@def author = "sisap challenge committee"

@def mintoclevel = 2

<!--
Add here files or directories that should be ignored by Franklin, otherwise
these files might be copied and, if markdown, processed by Franklin which
you might not want. Indicate directories by ending the name with a `/`.
-->
@def ignore = ["node_modules/", "franklin", "franklin.pub"]

<!--
Add here global latex commands to use throughout your
pages. It can be math commands but does not need to be.
For instance:
* \newcommand{\phrase}{This is a long phrase to copy.}
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}
\newcommand{\textit}[1]{~~~<em>#1</em>~~~}
\newcommand{\texttt}[1]{`#1`}
\newcommand{\linksfirst}{~~~<div><span>2023 edition: </span>
      <a href="/2023/tasks/">Tasks</a> |
      <a href="/2023/evaluationmethodology/">Methodology</a> |
      <a href="/2023/datasets/">Datasets</a> |
      <a href="/2023/repoexamples/">Repository examples</a> |
      <a href="/2023/committee/">Committee and pre-registration</a>
  </div>~~~}

\newcommand{\linkstwentyfour}{~~~<div><span>2024 edition: </span>
      <a href="/2024/tasks/">Tasks</a> |
      <a href="/2024/evaluationmethodology/">Methodology</a> |
      <a href="/2024/datasets/">Datasets</a> |
      <a href="/2024/repoexamples/">Repository examples</a> |
      <a href="/2024/committee/">Committee and pre-registration</a>
  </div>~~~}
