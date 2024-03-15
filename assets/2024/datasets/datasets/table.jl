# This file was generated, do not modify it. # hide
#hideall
urls = Dict()
sizes = Dict()
md5s = Dict()

for line in readlines("2024/dataset-files-urls.txt")
    (length(line) == 0 || line[1] == '#') && continue
    urls[basename(line)] = strip(line)
end

for line in readlines("2024/dataset-files-size.txt")
    (length(line) == 0 || line[1] == '#') && continue
    s, name = split(strip(line))
    sizes[basename(name)] = s
end

for line in readlines("2024/dataset-files-md5.txt")
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
  "laion2B-en-clip768v2-n=10M.h5" => "10M subset, for developing purposes",
  "laion2B-en-clip768v2-n=300K.h5" => "300K subset, for developing purposes",

  nothing => "Gold standard files",
  "gold-standard-dbsize=100M--public-queries-2024-laion2B-en-clip768v2-n=10k.h5" => "gold standard for the 100M subset (public queries 2024)",
  "gold-standard-dbsize=10M--public-queries-2024-laion2B-en-clip768v2-n=10k.h5" => "gold standard for the 10M subset (public queries 2024)",
  "gold-standard-dbsize=1M--public-queries-2024-laion2B-en-clip768v2-n=10k.h5" => "gold standard for the 1M subset (public queries 2024)",
  "gold-standard-dbsize=300K--public-queries-2024-laion2B-en-clip768v2-n=10k.h5" => "gold standard for the 300K subset (public queries)",

  nothing => "Public queries",
  "public-queries-2024-laion2B-en-clip768v2-n=10k.h5" => "public queries 2024 (this query set correspond to the 2023 private query set)"
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