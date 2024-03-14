+++
title = "LAION2B Dataset"
hascode = true
date = Date(2023, 02, 10)

tags = ["LAION2B", "dataset", "projections", "gold standard", "pca32", "pca96", "hamming"]
+++
# The LAION2B and projections

\toc

## About the LAION5B

The **LAION5B** dataset is an openly available image collection that has been used for learning very large visual and language deep-neural models; for instance, the famed stable diffusion generative model used it as the training set.

A more detailed description can be found here:
@@important
_Schuhmann, C., Beaumont, R., Vencu, R., Gordon, C., Wightman, R., Cherti, M., ... & Jitsev, J. (2022). Laion-5b: An open large-scale dataset for training next generation image-text models. arXiv preprint arXiv:2210.08402._
@@

The challenge use a 100M subset of the English subset, often called LAION2B, our objects are not marked as NFSW.
We use 768-dimensional vector embeddings.



### Some notes about the data

- You will get 768 dimensional 16-bit floating point vectors that may be changed to a 32-bit format to get full speed on legacy hardware.
- Our gold-standards were computed using dot product as similarity; vectors are almost $L_2$-normalized, so you can use the cosine distance or the angle distance as well to get a good aproximation.
- Our gold-standard `.h5` files contain the 1000 nearest neighbors of each query using two associated matrices `knns` and `dists`, i.e., columns correspond to queries and rows to nearest neighbors for each query.
  - The `knns` identifiers start indexing on 1.
  - The `dists` contains raw similarity values for each corresponding query and object; please consider that this is not a proper metric distance. People using metric properties can use the angle with minor changes. We will not check distance values for the final ranking. 

## Data

```julia:./datasets/table
#hideall
urls = Dict()
sizes = Dict()
md5s = Dict()

for line in readlines("2023/dataset-files-urls.txt")
    (length(line) == 0 || line[1] == '#') && continue
    urls[basename(line)] = strip(line)
end

for line in readlines("2023/dataset-files-size.txt")
    (length(line) == 0 || line[1] == '#') && continue
    s, name = split(strip(line))
    sizes[basename(name)] = s
end

for line in readlines("2023/dataset-files-md5.txt")
    (length(line) == 0 || line[1] == '#') && continue
    s, name = split(strip(line))
    md5s[basename(name)] = s
end

function tablehead() 
    println("| dataset | description | size | md5      |")
    println("|---------|-------------|------|----------|")
end

files = [
  nothing => "768d clip embeddings (clip768)",
  "laion2B-en-clip768v2-n=100M.h5" => "100M subset",
  "laion2B-en-clip768v2-n=300K.h5" => "300K subset, for developing purposes",
  "private-queries-10k-clip768v2.h5" => "10k private query set (original 768d embeddings)",

  nothing => "Gold standard for private queries (computed with 64-bit IEEE floating point arithmetic, 1000 nearest neighbors)",
  #"laion2B-en-private-gold-standard-v2-100M-F64-IEEE754.h5" => "100M private gold standard"
]

#open("assets/download-table.md", "w") do file
    for (name, desc) in files
        if name === nothing
            println()
            if desc !== nothing
                println("## ", desc)
                tablehead()
            end
        else
            println("| [$(name)]($(urls[name])) | $desc | $(sizes[name]) | $(md5s[name]) |")
        end
    end
#end

```

\textoutput{./datasets/table}


For instance, you can download the 10M subset and the query set using the following commands from a typical linux terminal:
```bash
curl -O https://sisap-23-challenge.s3.amazonaws.com/SISAP23-Challenge/laion2B-en-clip768v2-n=10M.h5
curl -O https://sisap-23-challenge.s3.amazonaws.com/SISAP23-Challenge/public-queries-10k-clip768v2.h5
```

<!--
## Projection's recall and baseline search times (bruteforce)
Each projection is an approximation of the original CLIP embeddings; therefore, they produce a quality reduction. For instance, we computed the upper bound recall scores (using brute force) for searching for the 30 nearest neighbors are:


```julia:./table-recall
#hideall
### using DataFrames, CSV
### table = CSV.read("recall-projections.csv", DataFrame)
### 
### # data size algo buildtime querytime params recall 
### 
### println("| data | size | recall | querytime (32 cores / 64 threads) |")
### println("|------|------|--------|-----------------------|")
### for r in eachrow(table)
###     recall = round(r.recall, digits=4)
###     querytime = round(r.querytime, digits=2)
###     println("|$(r.data)|$(r.size)|$(recall)|$(querytime)s|")
### end
## \textoutput{./table-recall}
```


-->

Note that our projection models were trained with our 10M subset. Other approaches may vary the resulting quality.


**Note**: Projections will reduce the result's quality concerning the original embeddings, but you can use these datasets to fast prototype your solution and for hyperparameter optimization. Please email us if you are interested in the associated metadata (which can also be obtained as described in the rest of the document.)


@@warn
The original dataset can be downloaded and processed to get different subsets as described in
[the downloading and preprocessing LAION](/downloading-laion/) page. We encourage challenge participants to use the provided bundles for consistency reasons.
@@
