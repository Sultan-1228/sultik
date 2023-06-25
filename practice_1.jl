##########################   Задача № 1 ########################
function gcd_(a::T, b::T) where T<:Integer
    while !iszero(b)
        a, b = b, a % b
    end
    return abs(a)
end

##########################   Задача № 2 ########################
function gcdx_(a::T, b::T) where T<:Integer 
    u, v = one(T), zero(T) 
    u1, v1 = zero(T), one(T)
    while !iszero(b)
        k = div(a, b)
        a, b = b, a - k * b
        u1, v1, u, v = u - k * u1, v - k * v1, u1, v1
    end
    if isnegative(a) 
        a, u, v = -a, -u, -v
    end
    return a, u, v 
end

isnegative(a::Integer) = (a < 0)

##########################   Задача № 3 ########################
function inverse(a::Z{T,N}) where {T<:Integer, N}
    if gcd(a.a, N) != 1 
        return nothing
    else
        f, s, d = gcd_big(a.a, N)
        return Z{T,N}(s)
    end 
end

##########################   Задача № 4 ########################
function Diophantine_solve(a, b, c)
    d = gcd(a, b)
    if c % d != 0
        return nothing
    end
    
    a_d, x0, y0 = extended_euclidean_algorithm(a, b)
    x = x0 * (c ÷ d)
    y = y0 * (c ÷ d)
    
    return x, y
end

##########################   Задача № 5 ########################
struct Residue{T,M}
    a::T
end

# Оператор сложения
function Base.:+(x::Residue{T,M}, y::Residue{T,M}) where {T,M}
    Residue{T,M}((x.a + y.a) % M)
end

# Оператор вычитания
function Base.:-(x::Residue{T,M}, y::Residue{T,M}) where {T,M}
    Residue{T,M}((x.a - y.a) % M)
end

# Унарный минус
function Base.:-(x::Residue{T,M}) where {T,M}
    Residue{T,M}((-x.a) % M)
end

# Оператор умножения
function Base.:*(x::Residue{T,M}, y::Residue{T,M}) where {T,M}
    Residue{T,M}((x.a * y.a) % M)
end

# Оператор возведения в степень
function Base.:^(x::Residue{T,M}, n::Integer) where {T,M}
    Residue{T,M}(powmod(x.a, n, M))
end

# Обращение обратимых элементов
function inverse(x::Residue{T,M}) where {T,M}
    gcd_val, inv_val, _ = gcdx(x.a, M)
    if gcd_val != one(T)
        error("Element is not invertible")
    end
    Residue{T,M}(inv_val)
end

# Определение вывода значения в REPL
function Base.display(x::Residue{T,M}) where {T,M}
    display(x.a)
end


################################## ЗАДАЧА №6  ###############################
struct Polynom{T}
    coeffs::Vector{T}

    function Polynom(coeffs::Vector{T}) where {T<:Number}
        while length(coeffs) > 1 && coeffs[end] == zero(T)
            pop!(coeffs)
        end
        return new{T}(coeffs)
    end
end


import Base: +, -, *, show

#Операция +
+(a::Polynom{T}, b::Polynom{T}) where {T<:Number} = Polynom{T}(a.coeffs + b.coeffs)

#Операция -
-(a::Polynom{T}, b::Polynom{T}) where {T<:Number} = Polynom{T}(a.coeffs - b.coeffs)

#Унарный -
-(a::Polynom{T}) where {T<:Number} = Polynom{T}(-a.coeffs)
end

# Кортеж коэффицентов

K = Z{Polynom{Int}, (1, 1)}(Polynom{Int}([1, 1, 1]))
