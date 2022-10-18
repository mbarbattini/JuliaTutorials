using LinearAlgebra, LaTeXStrings, SparseArrays, ArnoldiMethod

σᶻ =  [1 0 ; 0 -1]
σˣ = [0 1 ; 1 0]

⊗(x, y) = kron(x, y)
id = [1 0 ; 0 1]

# explicit tensor products
h = 1
H = - σᶻ⊗σᶻ⊗id⊗id - id⊗σᶻ⊗σᶻ⊗id - id⊗id⊗σᶻ⊗σᶻ
H -= h*(σˣ⊗id⊗id⊗id + id⊗σˣ⊗id⊗id + id⊗id⊗σˣ⊗id + id⊗id⊗id⊗σˣ)


function TransverseFieldIsing(;N,h)
    id = [1 0; 0 1]
    σˣ = [0 1; 1 0]
    σᶻ = [1 0; 0 -1]
    
    # vector of operators: [σᶻ, σᶻ, id, ...]
    first_term_ops = fill(id, N)
    first_term_ops[1] = σᶻ
    first_term_ops[2] = σᶻ
    
    # vector of operators: [σˣ, id, ...]
    second_term_ops = fill(id, N)
    second_term_ops[1] = σˣ
    
    H = zeros(Int, 2^N, 2^N)
    for i in 1:N-1
        # tensor multiply all operators
        H -= foldl(⊗, first_term_ops)
        # cyclic shift the operators
        first_term_ops = circshift(first_term_ops,1)
    end
    
    for i in 1:N
        H -= h*foldl(⊗, second_term_ops)
        second_term_ops = circshift(second_term_ops,1)
    end
    H
end

# TransverseFieldIsing(N=10, h=1)

function TransverseFieldIsing_sparse(;N,h)
    id = [1 0; 0 1] |> sparse
    σˣ = [0 1; 1 0] |> sparse
    σᶻ = [1 0; 0 -1] |> sparse
    
    first_term_ops = fill(id, N)
    first_term_ops[1] = σᶻ
    first_term_ops[2] = σᶻ
    
    second_term_ops = fill(id, N)
    second_term_ops[1] = σˣ
    
    H = spzeros(Int, 2^N, 2^N) # note the spzeros instead of zeros here
    for i in 1:N-1
        H -= foldl(⊗, first_term_ops)
        first_term_ops = circshift(first_term_ops,1)
    end
    
    for i in 1:N
        H -= h*foldl(⊗, second_term_ops)
        second_term_ops = circshift(second_term_ops,1)
    end
    H
end

# H = TransverseFieldIsing_sparse(N=10, h=1)
# H ≈ TransverseFieldIsing(N=10, h=1)

# @time TransverseFieldIsing(N=10, h=1)
# @time TransverseFieldIsing_sparse(N=10, h=1)
# pritnln("Speedup: {}", t1/t2)

function eigen_sparse(x)
    decomp, history = partialschur(x, nev=1, which=SR()); # only solve for the ground state
    vals, vecs = partialeigen(decomp);
    return vals, vecs
end

@time H = TransverseFieldIsing(N=8,h=100)

@time vals, vecs = eigen(H)
groundstate = vecs[:,1]
abs2.(groundstate)