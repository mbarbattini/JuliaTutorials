using Plots, Statistics, Printf, LinearAlgebra, Test, LaTeXStrings

# # single line function
# getSum(x, y) = x + y
# x, y = 1, 2
# @printf("%d + %d = %d\n", x, y, getSum(x, y))

# # multiple lines function
# function canIVote(age=16)
#     if age > 18
#         println("Can Vote")
#     else
#         println("You can't vote")
#     end
# end

# canIVote()

# # arguments are always bass by value
# v1 = 5
# function changeV1(v1)
#     v1 = 10
# end
# changeV1(v1)
# println(v1)

# a exclamation point at the end of a function name is a convention to tell the programmer that
# what's in the function is going to modify one of the arguments. It doesn't actually do anything
function hello!(x::Int64, y::Int64)
    x = 7
    z = y*x
    z
end

# anonymous functions. Like arrow functions in javascript, inline and has no name
# the function part is "x -> x * y"
# v2 = map(x -> x^2, [1,2,3])
# println(v2)
# # add each corresponding element to each other
# v3 = map((x, y) -> x + y, [1,2], [3,4])
# println(v3)
# # add all the numbers from 1 to 100 together
v4 = reduce(+, 1:100)
println(v4)
# # find the longest word in a sentence
# sentence = "This is a string with a short word and a long word but who knows cuz that's crazy superduperduper crazy I mean what's going on"
# sArray = split(sentence)
# longest = reduce((x, y) -> length(x) > length(y) ? x : y, sArray)

# # math formulas without unnecessary multiplication symbols
# x = 2
# y = -1
# println(2x^2+5y^2+2x*y+cos(5x)y)

# # multiply every value in an array by 3
# a13 = [1,2,3]
# println(a13 .* 3)

# # symbols
# :Matthew
# println(:Matthew)

# # dictionary
# d2 = Dict(:pi=>3.14, :e=>2.718)

# plotly()
# scale = 0.2
# meshgrid(x, y) = (repeat(x, outer=length(y)), repeat(y, inner=length(x)))
# x,y = meshgrid(0:0.2:2, 0:0.2:2)
# u = @. cos(x)*y*scale
# v = @. sin(x)*y*scale
# quiver(x, y, quiver=(u,v))

# <: means "is a subtype of"
# abstract types cannot be instantiated, and it looks like they are used just as 
# orginization for a collection of different types
# Ex. The Ising struct is a child of the Hamiltonian type. We never instantiate a Hamiltonian type,
# we just instantiate the Ising type
# abstract type Hamiltonian{T, S<:AbstractMatrix{<:T}} end

# LinearAlgebra.ishermitian(H::Hamiltonian) = true
# LinearAlgebra.eigvals(H::Hamiltonian) = eigvals(parent(H))

# struct Ising{T, S<:AbstractMatrix{<:T}} <: Hamiltonian{T, S}
#     H::Hermitian{T, S}
#     J::Float64
#     h::Float64
#     L::Int
# end

# Base.parent(IH::Ising) = IH.H

# my_h = Ising(Hermitian([1. 0.; 0. -1.]), 1., 0., 1)
# println(ishermitian(my_h))
# println(eigvals(my_h))

# @testset for uplo in (:U, :L)
#     T = Bidiagonal(dv, ev, uplo)
#     @testset "Constructor and basic properties" begin
#         @test size(T, 1) == size(T, 2) == n
#         @test size(T) == (n, n)
#         @test Array(T) == diagm(0 => dv, (uplo == :U ? 1 : -1) => ev)
#         @test Bidiagonal(Array(T), uplo) == T
#         @test big.(T) == T
#     end
# end



# zeroArray = zeros(40)
# # create an empty array
# emptyArray = Int64[]
# # appending to the empty array just adds one value
# append!(emptyArray, 3)
# # assigning the zeroArray to emptyArray makes it the same size
# # Unlike in MATLAB, don't have to define a zero array with a explicit size
# # and then have to make sure the array you want to add is the same size
# emptyArray = zeroArray
# emptyArray




# there is no i++ in Julia

# f string equivalent: 
# name = 4
# string = "Hello, $(name)!"

# declare a (3,2) empty array of Float64
# a = Array{Float64}(undef, 3, 2)
# OR
# a = Array{Float64}(nothing, 3, 2)

# declare an empty row vector with 3 components
# a = Array{Float64}(undef, 0, 3)

# or just use Vector type
# EQUIVALENT to Array{T,1}
# a = Vector{Float64}(undef, 3)


# declare an empty column vector with 3 components
# a = Array{Float64}(undef, 3, 0)

# vertically stack a (10,3) array to an empty array
# need to make sure the 2nd dimension is equal for vcat (1st dimension equal for hcat)
# setting the first dimension to 0 means that when you 
# stack the array there will not be an extra row
a = Array{Float64}(undef, 0, 3)
b = fill(5, (10, 3))
c = vcat(a, b)
c 