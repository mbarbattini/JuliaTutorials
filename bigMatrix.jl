using LinearAlgebra, LaTeXStrings

@time begin
dimension = 10000
nRandomEntries = 523_223

A = zeros((dimension,dimension))
for i=1:nRandomEntries
    re = rand(0:1000)
    ri1, ri2 = rand(1:dimension), rand(1:dimension)
    A[ri1, ri2] =  re
end
LinearAlgebra.eigvals(A)
end