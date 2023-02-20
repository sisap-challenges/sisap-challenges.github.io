# This file was generated, do not modify it. # hide
#hideall
using DataFrames, CSV
table = CSV.read("recall-projections.csv", DataFrame)

# data size algo buildtime querytime params recall 

println("| data | size | recall | querytime (32 cores / 64 threads) |")
println("|------|------|--------|-----------------------|")
for r in eachrow(table)
    recall = round(r.recall, digits=4)
    querytime = round(r.querytime, digits=2)
    println("|$(r.data)|$(r.size)|$(recall)|$(querytime)s|")
end