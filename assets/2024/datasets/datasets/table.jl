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