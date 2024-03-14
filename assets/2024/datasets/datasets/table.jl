# This file was generated, do not modify it. # hide
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
  "laion2B-en-clip768v2-n=30M.h5" => "30M subset",
  "laion2B-en-clip768v2-n=10M.h5" => "10M subset",
  "laion2B-en-clip768v2-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-clip768v2-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-clip768v2.h5" => "10k public query set (original 768d embeddings)",
  "private-queries-10k-clip768v2.h5" => "10k private query set (original 768d embeddings)",

  nothing => "32d PCA projections (pca32)",
  "laion2B-en-pca32v2-n=100M.h5" => "100M subset",
  "laion2B-en-pca32v2-n=30M.h5" => "30M subset",
  "laion2B-en-pca32v2-n=10M.h5" => "10M subset",
  "laion2B-en-pca32v2-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-pca32v2-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-pca32v2.h5" => "10k public query set for 32d PCA projection",
  "private-queries-10k-pca32v2.h5" => "10k private query set for 32d PCA projection",

  nothing => "96d PCA projections (pca96)",
  "laion2B-en-pca96v2-n=100M.h5" => "100M subset",
  "laion2B-en-pca96v2-n=30M.h5" => "30M subset",
  "laion2B-en-pca96v2-n=10M.h5" => "10M subset",
  "laion2B-en-pca96v2-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-pca96v2-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-pca96v2.h5" => "10k public query set for 96d PCA projection",
  "private-queries-10k-pca96v2.h5" => "10k private query set for 96d PCA projection",

  nothing => "1024-bit binary sketches (hamming)",
  "laion2B-en-hammingv2-n=100M.h5" => "100M subset",
  "laion2B-en-hammingv2-n=30M.h5" => "30M subset",
  "laion2B-en-hammingv2-n=10M.h5" => "10M subset",
  "laion2B-en-hammingv2-n=300K.h5" => "300K subset, for developing purposes",
  "laion2B-en-hammingv2-n=100K.h5" => "100K subset, for developing purposes",
  "public-queries-10k-hammingv2.h5" => "10k public query set for 1024-bit binary sketch projection",
  "private-queries-10k-pca96v2.h5" => "10k private query set for 1024-bit binary sketch projection",

  nothing => "Gold standard list (computed with 32-bit floating point arithmetic, 100 nearest neighbors)",
  "laion2B-en-public-gold-standard-v2-100M.h5" => "100M gold standard",
  "laion2B-en-public-gold-standard-v2-30M.h5" => "30M gold standard",
  "laion2B-en-public-gold-standard-v2-10M.h5" => "10M gold standard",
  "laion2B-en-public-gold-standard-v2-300K.h5" => "300K gold standard",
  "laion2B-en-public-gold-standard-v2-100K.h5" => "100K gold standard",

  nothing => "Gold standard for public queries (computed with 64-bit IEEE floating point arithmetic, 1000 nearest neighbors)",
  "laion2B-en-public-gold-standard-v2-100M-F64-IEEE754.h5" => "100M gold standard",
  "laion2B-en-public-gold-standard-v2-30M-F64-IEEE754.h5" => "30M gold standard",
  "laion2B-en-public-gold-standard-v2-10M-F64-IEEE754.h5" => "10M gold standard",
  "laion2B-en-public-gold-standard-v2-300K-F64-IEEE754.h5" => "300K gold standard",
  
  nothing => "Gold standard for private queries (computed with 64-bit IEEE floating point arithmetic, 1000 nearest neighbors)",
  "laion2B-en-private-gold-standard-v2-10M-F64-IEEE754.h5" => "10M private gold standard",
  "laion2B-en-private-gold-standard-v2-30M-F64-IEEE754.h5" => "30M private gold standard",
  "laion2B-en-private-gold-standard-v2-100M-F64-IEEE754.h5" => "100M private gold standard",

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