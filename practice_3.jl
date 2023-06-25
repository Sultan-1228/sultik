Задача № 1 ##################################################################
function isprime(n::IntType) where IntType <: Integer # является ли заданное число простым
    for d in 2:IntType(ceil(sqrt(n)))
        if n % d == 0
            return false
        end
    end
    return true
end

Задача № 2 ##############################################################
function Resheto_Eratosfena(n::Integer)
    simple_i = ones(Bool, n)
    simple_i[begin] = false
    i = 2
    simple_i[i^2:i:n] .= false 
    i=3
   
    while i <= n
        simple_i[i^2:2i:n] .= false
        i+=1
        while i <= n && simple_i[i] == false
            i+=1
        end

    end
    return findall(simple_i)
end

################# Задача № 3 #######################
function Factorize(n::IntType) where IntType <: Integer
    list = NamedTuple{(:div, :deg), Tuple{IntType, IntType}}[]
    for p in eratosphenes_sieve(Int(ceil(n/2)))
        k = degree(n, p) 
        if k > 0
            push!(list, (div=p, deg=k))
        end
    end
    return list
end

function degree(n, p) 
    k=0
    n, r = divrem(n,p)
    while n > 0 && r == 0
        k += 1
        n, r = divrem(n,p)
    end
    return k
end


# № 4 ----------------------------------
function mean_dev(mass)
    T = eltype(mass)
    n = 0; s¹ = zero(T); s² = zero(T)
    for a ∈ mass
    n += 1; s¹ .+= a; s² += a*a
    end
    mean = s¹ ./ n
    return mean, sqrt(s²/n - mean*mean)
    end

