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
  "laion2B-en-clip768-n=100M.h5" => "100K subset",
  "laion2B-en-clip768-n=30M.h5" => "100K subset",
  "laion2B-en-clip768-n=10M.h5" => "100K subset",
  "laion2B-en-clip768-n=300K.h5" => "100K subset, for developing purposes",
  "laion2B-en-clip768-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-clip768.h5" => "10k public query set (original 768d embeddings)",
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
  "small-laion2B-en-public-gold-standard-v2-300K.h5" => "300K gold standard",
  "small-laion2B-en-public-gold-standard-v2-100K.h5" => "100K gold standard",
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


# Original LAION parts
The LAION dataset is distributed in pairs of metadata and embeddings, bundled in parts of nearly 1 million each. Please note that the dataset contains many NSFW materials that must be discarded for our challenge, and this is made with the metadata information.

### Metadata

The metadata is publicly available through the [LAION-5B](https://laion.ai/blog/laion-5b/) effort and the [Hugging face repository](https://huggingface.co/laion). 

## Downloading the dataset

The embeddings are publicly available from the original mirror site [https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/](https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/).

For instance, you can retrieve the first two parts (and its associated meta data) using a typical Linux installation using the terminal, as follows:

```bash

mkdir laion2B-en
cd laion2B-en

curl -O https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/laion2B-en/img_emb/img_emb_0000.npy
curl -O https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/laion2B-en/laion2B-en-metadata/metadata_0000.parquet
curl -O https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/laion2B-en/img_emb/img_emb_0001.npy
curl -O https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/laion2B-en/laion2B-en-metadata/metadata_0001.parquet
```

You can download all parts using the following bash script
```bash
for i in {0000..1111}; do
    echo curl -O https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/laion2B-en/img_emb/img_emb_$i.npy
done
```

Remove the `echo` command to actually start downloading.

Troubleshooting: You can restart and resume partial downloads adding `-C -` to the `curl` command line, as follows:

```bash
curl -C - -O https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/laion2B-en/img_emb/img_emb_0000.npy
```

### Filtering out NSFW to get the precise subsets
Each dataset part has metadata and embedding files. The metadata file is an Apache parquet table where we can find registers containing information like URL, description, and NSFW status, among other fields. Participants must use the NSFW field to obtain a mask for _NSFW_ that should be used to get the desired sub-matrix. 

The following script for the Julia language can be used for this purpose. Once you have downloaded the LAION parts and metadata, run the Julia REPL in the directory where you saved the files. The necessary packages will be asked to be installed:

```julia
using Parquet2, DataFrames, Glob, Printf, JLD2, CSV, OhMyREPL

let N = 111
    D = Float16[]; sizehint!(D, 768 * (N * 10^6)); L = []
    for i in 1:N
        embfile = @sprintf "img_emb_%04d.h5" i
        metafile = @sprintf "metadata_%04d.parquet" i
        @show embfile, metafile
        df = DataFrame(Parquet2.select(Parquet2.Dataset(metafile), :caption, :NSFW, :LICENSE, :url), copycols=false)
        mask = [(!ismissing(r.NSFW) && r.NSFW != "NSFW") for r in eachrow(df)]
        df = df[mask, :]
        X = jldopen(f->f["emb"], embfile)
        @assert size(X, 1) == 768
        @assert size(X, 2) == length(mask)
        length(L) == 0 ? push!(L, df) : append!(L[1], df)
        X = X[:, mask]
        append!(D, vec(X))
        @show N => (768, length(D) ÷ 768)
        if i in (11, 33, 111)
            CSV.write("metadata-$i.tsv", L[1], delim='\t')  # you can use this file to create demos
            # the copy is necessary only because reshape marks the array as shared and
            # append! will raise errors
            jldsave("laion2B-$i.h5", emb=reshape(copy(D), (768, length(D) ÷ 768)))
        end
    end
end
```

Package versions:
```
  [336ed68f] CSV v0.10.9
  [a93c6f00] DataFrames v1.4.4
  [c27321d9] Glob v1.3.0
  [033835bb] JLD2 v0.4.30
  [5fb14364] OhMyREPL v0.5.13
  [98572fba] Parquet2 v0.2.8
```

Adjust `N` if necessary. Please recall that subset 10M contains 11 parts, 30M contains 33 parts, and 100M is composed of 111 parts.

@@warn
Original LAION parts are distributed in `npz` format and you can load them with `numpy` or the `NPZ.jl` package when you work with Julia.
@@
