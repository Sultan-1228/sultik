
#############################################   1    ##################################################################
function next_repit_placement!(p::Vector{T}, n::T) where T<:Integer
    i = findlast(x->(x < n), p) 
    # i - это последний(первый с конца) индекс: x[i] < n, или - nothing, если такого индекса нет (p == [n,n,...,n])
    isnothing(i) && (return nothing)
    p[i] += 1
    p[i+1:end] .= 1 
    return p
end

println("Генерация следующего размещения с повторениями из n элементов {1,2,...,n} по k")
println(next_repit_placement!([1, 1, 1], 3))

println("Генерация всех размещений с повторениями из n элементов {1,2,...,n} по k")
n = 2; k = 3
prev = ones(Int,k)
println(prev)
while !isnothing(prev)
    global prev = next_repit_placement!(prev, n)
    !isnothing(prev) && println(prev)
end


#################################################### 2 #################################################################
function next_permute!(p::AbstractVector)
    n = length(p)
    k = 0 # firstindex(p) - 1
    for i in reverse(1:n - 1) # reverse(firstindex(p):lastindex(p) - 1)
        if p[i] < p[i + 1]
            k = i
            break
        end
    end
    k == firstindex(p) - 1 && return nothing # p[begin] > p[begin + 1] > ... > p[end]

    #утв: p[k] < p[k + 1] > p[k + 2] > ... > p[end]
    i = k + 1
    while i < n && p[i + 1] > p[k] # i < lastindex(p) && p[i + 1] > p[k]
        i += 1
    end
    #утв: p[i] - наименьшее из p[k + 1:end], большее p[k]
    p[k], p[i] = p[i], p[k]
    #утв: по-прежнему p[k + 1]>...>p[end]
    reverse!(@view p[k + 1:end])
    return p
end

println("Генерация следующей перестановки из n элементов {1,2,...,n} по k")
println(next_permute!([1, 2, 3, 4]))
println("Генерация всех перестановок из n элементов {1,2,...,n} по k")
p=[1, 2, 3, 4]
println(p)
while !isnothing(p)
    global p = next_permute!(p)
    !isnothing(p) && println(p)
end

############################################################ 3 ######################################################
println("Генерация всех всех подмножеств n-элементного множества {1,2,...,n} 1 способ")
# Первый способ - на основе генерации двоичных кодов чисел 0, 1, ..., 2^n-1

indicator(i::Integer, n::Integer) = reverse(digits(Bool, i; base=2, pad=n))

println("1 способ")
println(indicator(12, 5))
println("1 способ (Все)")
for i in range(0, 2^5 - 1)
    println(indicator(i, 5))
end


############################################################### 4 #####################################################################

function next_indicator!(indicator::AbstractVector{Bool}, k)
    
    i = lastindex(indicator)
    while indicator[i] == 0
        i -= 1
    end
    #УТВ: indic[i] == 1 и все справа - нули
    m = 0 
    while i >= firstindex(indicator) && indicator[i] == 1 
        m += 1
        i -= 1
    end
    if i < firstindex(indicator)
        return nothing
    end
    #УТВ: indicator[i] == 0 и справа m > 0 единиц, причем indicator[i + 1] == 1
    indicator[i] = 1
    indicator[i + 1:end] .= 0
    indicator[lastindex(indicator) - m + 2:end] .= 1
    return indicator 
end

println("Генерация всех k-элементных подмножеств n-элементного множества {1, 2, ..., n}")
n = 6
k = 3
a = 1:6
a[findall(next_indicator!([zeros(Bool, n-k); ones(Bool, k)], k))] |> println


############################################# 5 ############################################

function next_split!(s ::AbstractVector{Int64}, k)
    k == 1 && return (nothing, 0)
    i = k-1 # - это потому что s[k] увеличивать нельзя
    while i > 1 && s[i-1]>=s[i]
        i -= 1
    end
    #УТВ: i == 1 или i - это наименьший индекс: s[i-1] > s[i] и i < k
    s[i] += 1
    #Теперь требуется s[i+1]... - уменьшить минимально-возможным способом (в лексикографическом смысле) 
    r = sum(@view(s[i+1:k]))
    k = i+r-1 # - это с учетом s[i] += 1
    s[(i+1):(length(s)-k)] .= 1
    return s, k
end

println("Генерация всех разбиений натурального числа на положительные слагаемые")
println(next_split!(ones(Int64, 5), 5))



