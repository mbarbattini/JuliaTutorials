using LinearAlgebra, Plots, LsqFit, CSV, DataFrames

function cross_ndim(r1::Array, r2::Array)
    result = zeros(size(r1))
    result[1] = r1[2] .* r2[3] .- r1[3] .* r2[2]
    result[2] = r1[3] .* r2[1] .- r1[1] .* r2[3]
    result[3] = r1[1] .* r2[2] .- r1[2] .* r2[1]
    return result
end

function biot_savart(currentVertices::Array{Float64}, targetVertices::Array{Float64}, current::Float64)
    """
    currentVertices: AbstractArray{nPoints, 3}
    targetVertices: AbstractArray{nPoints, 3}
    """
    
    nPoints = size(currentVertices, 1)
    field = zeros(size(targetVertices, 1))
    for i=1:nPoints - 1
        r1 = currentVertices[i]
        r2 = currentVertices[i+1]

        a1 = targetVertices' .- r1
        a2 = targetVertices' .- r2
        println(size(a1))

        f = cross_ndim(a1, a2)

        d1 = sqrt(sum(abs2, a1))
        d2 = sqrt(sum(abs2, a2))

        # m = map((x,y)->(x*y), a1, a2)
        m = a1.*a2
        f *= (d1 + d2) / (d1 * d2 * (d1 * d2 + sum(m)))

        field += f
    end
    field' * 1e-7 * current
end

total_contours = 20
# coilVertices = Array{Float64, 2}(undef, 1, 3)
# coilVertices = Vector{Float64}()
coilVertices = zeros(0,3)
# coilVertices = Array{Float64, 2}[]
for i=1:total_contours
    path = "C:\\Users\\H457071\\Desktop\\Test 9-26_Coils\\coilContour_$(i).csv"
    
    csv_reader = CSV.File(path)

    df = CSV.File(path) |> DataFrame

    data = Matrix(df)   
    
    global coilVertices = vcat(coilVertices, data)

end

target_points = zeros(40, 3)
target_points[:,2] .= rand(Float64, 40)

biot_savart(coilVertices, target_points, 1.0)




