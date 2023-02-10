# This file was generated, do not modify it. # hide
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