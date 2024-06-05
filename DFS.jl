function dfs(v, e, visited, result)
    if visited[v] == :permanent
        return
    elseif visited[v] == :temporary
        error("Обнаружена циклическая зависимость")
    end

    visited[v] = :temporary
    for u in e[v]
        dfs(u, e, visited, result)
    end
    visited[v] = :permanent
    push!(result, v)
end


function decision(vertices, edges)
    visited = Dict{String, Symbol}()

    for v in vertices
        visited[v] = :unvisited
    end

    result = Vector{String}()
    for v in vertices
        if visited[v] == :unvisited
            dfs(v, edges, visited, result)
        end
    end

    return result
end



vertices = ["a", "b", "c", "d"]
edges = Dict(
"a" => [], 
"b" => ["a"], 
"c" => ["a"], 
"d" => ["b", "c"])

vertices2 = ["a", "b", "c", "d", "e", "f"]
edges2 = Dict(
"a" => ["b", "c"],
"b" => [], 
"c" => [], 
"d" => ["a"], 
"e" => ["c", "f"], 
"f" => ["d"])

function main(v,e)
    println(decision(v,e))
end

@time main(vertices,edges)