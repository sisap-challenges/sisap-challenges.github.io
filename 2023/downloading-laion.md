+++
title = "Downloading the LAION2B Dataset"
hascode = true
date = Date(2023, 03, 23)

tags = ["LAION2B"]
+++
# Downloading and processing the original LAION2B dataset

\toc

## Parts
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
