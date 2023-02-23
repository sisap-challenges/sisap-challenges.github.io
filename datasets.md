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
```
Schuhmann, C., Beaumont, R., Vencu, R., Gordon, C., Wightman, R., Cherti, M., ... & Jitsev, J. (2022). Laion-5b: An open large-scale dataset for training next generation image-text models. arXiv preprint arXiv:2210.08402.
```

### Metadata

The metadata is publicly available through the [LAION-5B](https://laion.ai/blog/laion-5b/) effort and the [Hugging face repository](https://huggingface.co/laion). Please note that the LAION-5B dataset contains many NSFW materials that were discarded.


### Subset of the challenge
The dataset is divided into parts containing close to 1M vectors. We selected the first 112 parts (0000 to 0111); we used the first part to extract the public query set and the rest to extract the database. The subset use approximately 160GB of space and its associated metadata 20GB (the first 112 parts). Embeddings are distributed using single precision (16bits) floating point vectors bundled in the NumPy data-specific format `.npz`. They can be loaded on most platforms due to the format's popularity.

The challenge has three subsets:

- 10M subset: concatenation of 1-11 parts.
- 30M subset: concatenation of 1-33 parts.
- 100M subset: concatenation of 1-111 parts.
- queries: computed from part 0.

All parts should be concatenated in order and also removing NSFW entries (marked in metadata files).

#### Downloading the dataset

The embeddings are also publicly available from the original mirror site [https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/](https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/).

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

Adjust `N` if necessary. Please recall that subset 10M contains 11 parts, 30M contains 33 parts, and 100M is composed of 111 parts.

## Projections

We encourage people to construct their entire data pipeline to handle data for indexing and searching. However, we produced three different lower-dimensional projections that can be used. In particular, we computed two PCA projections using 32 and 96 dimensions and one more projection into binary sketches designed to work with bit-level hamming distance (using 1024 bits). Find below the URLs to download these bundles. 

**Note**: All these projections will reduce the result's quality with respect to the original embeddings (see the bottom of this page for more details). We will mention the kind of input used in the rank, but the rank will be global. The original data can be downloaded from the active LAION2B mirror instead. The metadata, if needed, should also be retrieved from the LAION2B mirror.


### Some technical specifications of the LAION-5B and the CLIP embeddings
 We provide different low dimensional projections packed in `HDF5`; queries and gold standards are also HDF5, i.e., `.h5` files. HDF5 can perform faster and more flexible _io_, which can help on large datasets. In particular, the sizes of the projection files are as follow:

```julia:./datasets/table
#hideall
urls = Dict()
sizes = Dict()
md5s = Dict()

for line in readlines("dataset-files-urls.txt")
    urls[basename(line)] = line
end

for line in readlines("dataset-files-size.txt")
    s, name = split(line)
    sizes[basename(name)] = s
end

for line in readlines("dataset-files-md5.txt")
    s, name = split(line)
    md5s[basename(name)] = s
end

function tablehead() 
    println("| dataset | description | size | md5      |")
    println("|---------|-------------|------|----------|")
end

files = [
  nothing => "32d PCA projections",
  "laion2B-en-pca32-n=100M.h5" => "100M subset",
  "laion2B-en-pca32-n=30M.h5" => "30M subset",
  "laion2B-en-pca32-n=10M.h5" => "10M subset",
  "laion2B-en-pca32-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-pca32-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-pca32.h5" => "10k public query set for 32d PCA projection",
  nothing => "96d PCA projections",
  "laion2B-en-pca96-n=100M.h5" => "100M subset",
  "laion2B-en-pca96-n=30M.h5" => "30M subset",
  "laion2B-en-pca96-n=10M.h5" => "10M subset",
  "laion2B-en-pca96-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-pca96-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-pca96.h5" => "10k public query set for 96d PCA projection",
  nothing => "1024-bit binary sketches",
  "laion2B-en-hamming-n=100M.h5" => "100M subset",
  "laion2B-en-hamming-n=30M.h5" => "30M subset",
  "laion2B-en-hamming-n=10M.h5" => "10M subset",
  "laion2B-en-hamming-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-hamming-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-hamming.h5" => "10k public query set for 1024-bit binary sketch projection",
  nothing => "768d-embeddings public dataset",
  "public-queries-10k.h5" => "10k public query set (original 768d embeddings)",
  nothing => "Gold standard list",
  "laion2B-en-public-gold-standard-100M.h5" => "100M gold standard",
  "laion2B-en-public-gold-standard-30M.h5" => "30M gold standard",
  "laion2B-en-public-gold-standard-10M.h5" => "10M gold standard",
  "small-laion2B-en-public-gold-standard-300K.h5" => "300K gold standard",
  "small-laion2B-en-public-gold-standard-100K.h5" => "100K gold standard",
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

two mirrors are given for these datasets, listed in the challenge site for our projections, queries, and gold-standard datasets.

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



Note that our projection models were trained with the 2d part of the LAION2B dataset (i.e, id=0001 with approx. 1M vectors). Other approaches may vary the resulting quality.