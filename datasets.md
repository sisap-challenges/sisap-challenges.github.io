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
The collection equips each image with a URL handle, allowing people to showcase demonstrations easily.

A more detailed description can be found here:
@@important
_Schuhmann, C., Beaumont, R., Vencu, R., Gordon, C., Wightman, R., Cherti, M., ... & Jitsev, J. (2022). Laion-5b: An open large-scale dataset for training next generation image-text models. arXiv preprint arXiv:2210.08402._
@@

The English subset, often called LAION2B, contains over 2 billion objects.


### Subset of the challenge
The dataset is divided into parts containing close to 1M vectors. We selected the first 112 parts (0000 to 0111); we used the first part to extract the public query set and the rest to extract the database. The subset use approximately 160GB of space and its associated metadata 20GB (the first 112 parts). Embeddings are distributed using single precision (16bits) floating point vectors bundled in the NumPy data-specific format `.npz`. They can be loaded on most platforms due to the format's popularity.

The challenge has three subsets:

- 10M subset: concatenation of 1-11 parts.
- 30M subset: concatenation of 1-33 parts.
- 100M subset: concatenation of 1-111 parts.
- public queries: computed from part 0.

All parts should be concatenated in order and also removing NSFW entries (marked in metadata files).

## Subsets

We provide access to different subsets of the dataset and also created three different lower-dimensional projections that can be used. In particular, we computed two PCA projections using 32 and 96 dimensions and one more projection into binary sketches designed to work with bit-level hamming distance (using 1024 bits). Find below the URLs to download these bundles. 

```julia:./datasets/table
#hideall
urls = Dict()
sizes = Dict()
md5s = Dict()

for line in readlines("dataset-files-urls.txt")
    (length(line) == 0 || line[1] == '#') && continue
    urls[basename(line)] = strip(line)
end

for line in readlines("dataset-files-size.txt")
    (length(line) == 0 || line[1] == '#') && continue
    s, name = split(strip(line))
    sizes[basename(name)] = s
end

for line in readlines("dataset-files-md5.txt")
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
  "laion2B-en-clip768v2-n=100M.h5" => "100K subset",
  "laion2B-en-clip768v2-n=30M.h5" => "100K subset",
  "laion2B-en-clip768v2-n=10M.h5" => "100K subset",
  "laion2B-en-clip768v2-n=300K.h5" => "100K subset, for developing purposes",
  "laion2B-en-clip768v2-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-clip768v2.h5" => "10k public query set (original 768d embeddings)",
  nothing => "32d PCA projections (pca32)",
  "laion2B-en-pca32v2-n=100M.h5" => "100M subset",
  "laion2B-en-pca32v2-n=30M.h5" => "30M subset",
  "laion2B-en-pca32v2-n=10M.h5" => "10M subset",
  "laion2B-en-pca32v2-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-pca32v2-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-pca32v2.h5" => "10k public query set for 32d PCA projection",
  nothing => "96d PCA projections (pca96)",
  "laion2B-en-pca96v2-n=100M.h5" => "100M subset",
  "laion2B-en-pca96v2-n=30M.h5" => "30M subset",
  "laion2B-en-pca96v2-n=10M.h5" => "10M subset",
  "laion2B-en-pca96v2-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-pca96v2-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-pca96v2.h5" => "10k public query set for 96d PCA projection",
  nothing => "1024-bit binary sketches (hamming)",
  "laion2B-en-hammingv2-n=100M.h5" => "100M subset",
  "laion2B-en-hammingv2-n=30M.h5" => "30M subset",
  "laion2B-en-hammingv2-n=10M.h5" => "10M subset",
  "laion2B-en-hammingv2-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-hammingv2-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-hammingv2.h5" => "10k public query set for 1024-bit binary sketch projection",
  nothing => "Gold standard list",
  "laion2B-en-public-gold-standard-v2-100M.h5" => "100M gold standard",
  "laion2B-en-public-gold-standard-v2-30M.h5" => "30M gold standard",
  "laion2B-en-public-gold-standard-v2-10M.h5" => "10M gold standard",
  "laion2B-en-public-gold-standard-v2-300K.h5" => "300K gold standard",
  "laion2B-en-public-gold-standard-v2-100K.h5" => "100K gold standard",
  nothing => "Associated captions and image urls (tabular delimited files)",
  "meta-10M.tsv" => "metadata for the 10M subset",
  "meta-30M.tsv" => "metadata for the 30M subset",
  "meta-100M.tsv" => "metadata for the 100M subset",
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

People likes demonstrations, and that it is were metadata comes again. You can also download a subset of the associated metadata using the next command:
```bash
curl -O https://sisap-23-challenge.s3.amazonaws.com/SISAP23-Challenge/meta-10M.tsv
```

Please review the simple [jupyter-based demo](https://github.com/sisap-challenges/sisap2023/blob/main/demo10M.ipynb) to see how it can be used.

The `-C -` flags can be added if you need to resume a broken download.

@@warn
Metadata for 100K and 300K does not correspond to first 100K and 300K elements of large subsets. More precisely, 100K and 300K subsets include registers with NSFW missing values while large subsets remove missing values.
@@

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

Note that our projection models were trained with the 2d part of the LAION2B dataset (i.e, id=0001 with approx. 1M vectors). Other approaches may vary the resulting quality.


**Note**: Projections will reduce the result's quality concerning the original embeddings, but you can use these datasets to fast prototype your solution and for hyperparameter optimization. Please email us if you are interested in the associated metadata (which can also be obtained as described in the rest of the document.)

@@warn
The original dataset can be downloaded and processed to get different subsets as described in
[the downloading and preprocessing LAION](/downloading-laion/) page. We encourage challenge participants to use the provided bundles for consistency reasons.
@@