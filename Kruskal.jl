using DataStructures

struct Edge
    v::Int
    u::Int
    weight::Int
end

function Kruskal(edges::Vector{Edge}, vert::Int)

    uf = IntDisjointSets(vert)
    sorted_edges = sort(edges, by = e -> e.weight)
    result = []
    s = 0

    @inbounds for edge in sorted_edges
        if !in_same_set(uf, edge.u, edge.v)
            union!(uf, edge.u, edge.v)
            push!(result, edge)
            s += edge.weight
        end
    end

    return result, s
end

dist(v,u) = abs(u[1]-v[1])+abs(u[2]-v[2])

arr = [(2,2),(3,10),(5,2),(7,0)]
arr2 = [(0,2),(0,-3),(0,5),(0,-2)]
arr3 = [(0,1),(0,-9),(0,2),(0,-8)]

function main(arr)

    pushfirst!(arr,(0,0))
    n = length(arr)

    edges = Vector{Edge}([])

    for i in 1:n, j in 1:i-1
        edges = push!(edges, Edge(j,i, dist(arr[i],arr[j])))
    end

    t = []
    a, s = @time Kruskal(edges, n)
    
    for i in a
        push!(t, (i.v-1,i.u-1))
    end
    sort!(t)
    for i in t
        println(i[1], " - ",i[2])
    end
    println("SUM = ", s)
    
end

main(arr)




#=
using Plots

function plot_points(arr)
    
    x = [p[1] for p in arr]
    y = [p[2] for p in arr]
    
    
    plot(x, y, 
         seriestype = :scatter, 
         legend = false, 
         grid = true, 
         xlims = (minimum(x)-2, maximum(x) + 2), 
         ylims = (minimum(y)-2, maximum(y) + 2), 
         xlabel = "X", 
         ylabel = "Y",
         markersize = 10,    
         markercolor = :red, 
         gridalpha = 0)
         hline!([0], color = :black, linewidth = 2, linestyle = :dash)
         vline!([0], color = :black, linewidth = 2, linestyle = :dash)
end
plot_points(arr2)
=#


