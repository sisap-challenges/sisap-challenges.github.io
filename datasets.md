+++
title = "LAION2B Dataset"
hascode = true
date = Date(2023, 02, 10)

tags = ["LAION2B", "dataset", "projections", "gold standard", "pca32", "pca96", "hamming"]
+++

# About the LAION2B 

For the challenge and demo track, we selected a 10M, 30M, and 100M-size subsets of the English LAION-5B using Contrastive Language–Image Pre-training (CLIP) embeddings and a set of 10k independent queries to compute a gold standard for each subset.
CLIP vectors are typically 768-dimensional and compared under the cosine similarity. Please note that the LAION-5B dataset contains many NSFW materials that were discarded.

The metadata is publicly available through the [LAION-5B](https://laion.ai/blog/laion-5b/) effort and the [Hugging face repository](https://huggingface.co/laion).

The dataset is divided into parts containing close to 1M vectors. We selected the first 112 parts; we used the first part to extract the public query set and the rest to extract the database. Please recall that vectors associate with NSFW images were removed.

# Downloading the original data

The embeddings are also publicly available from the original mirror site [https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/](https://mystic.the-eye.eu/public/AI/cah/laion5b/embeddings/).

# Filtering out NSFW to get the precise subsets.
Each dataset part has metadata and embedding files; medatada should be loaded first, an Apache parquet table where we can find valuable metadata like URL, associated description, and NSFW status, among many other fields. Participants must use the NSFW field to obtain a mask for _NSFW_ that should be used to get the desired sub-matrix. We provode code examples for Python and Julia.

There you can find models and other related stuff. They also published a description of the dataset on NIPS.

# Projections

We encourage people to construct their entire data pipeline to handle data for indexing and searching. However, we produced three different lower-dimensional projections that can be used. In particular, we computed two PCA projections using 32 and 96 dimensions and one more projection into binary sketches designed to work with bit-level hamming distance (using 1024 bits). These bundles can be accessed from the challenge's site. [CITE]. Note that all these projections will reduce the result's quality with respect to the original embeddings. The original data should be downloaded from the active LAION2B mirror instead. The metadata, if needed, should also be retrieved from the LAION2B mirror.


## Some technical specifications of the LAION-5B and the CLIP embeddings
The embeddings use approximately 160GB of space and its associated metadata 20GB (the first 112 parts). Embeddings are 768-dimensional vectors of single precision (16bits) floating point numbers bundled in the NumPy data-specific format `.npz`. They can be loaded on most platforms due to the format's popularity. We provide different low dimensional projections packed in `HDF5`; queries and gold standards are also HDF5, i.e., `.h5` files. HDF5 can perform faster and more flexible _io_, which can help on large datasets. In particular, the sizes of the projection files are as follow:

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