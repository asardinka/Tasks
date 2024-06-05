using Primes

# Функция для вычисления всех простых делителей числа n
function prime_factors(n)
    factors = []
    d = 2
    while d * d <= n
        while (n % d) == 0
            push!(factors, d)
            n ÷= d
        end
        d += 1
    end
    if n > 1
        push!(factors, n)
    end
    return factors
end

# Функция для нахождения первообразного корня

function find_primitive_root(p)
    if !isprime(p)
        error("p должно быть простым числом")
    end
    
    ϕ = p - 1
    factors = unique(prime_factors(ϕ))
    
    @inbounds for r in 2:ϕ
        flag = true
        @inbounds for factor in factors
            if powermod(r, div(ϕ , factor), p) == 1
                flag = false
                break
            end
        end
        if flag
            return r
        end
    end
    return -1 
end


function powermod(base, exp, m)
    result = 1
    base = base % m  
    
    while exp > 0
        if exp % 2 == 1  
            result = (result * base) % m
        end
        exp >>= 1 
        base = (base * base) % m
    end
    
    return result
end

# Реализация протокола Диффи-Хеллмана
function diffie_hellman(a, b, p, g)
    A = powermod(g, a, p)
    B = powermod(g, b, p)
    
    secret_A = powermod(B, a, p)
    secret_B = powermod(A, b, p)
    
    return secret_A, secret_B
end


p = BigInt(180_143_982_410_465_272_181) # Простое число | добавим 3 , 24 секунды

a = 31_415_926_535
b = 2_718_281_828_459_045

function main(p)
    g = find_primitive_root(p)

    if g != -1
        println("Простое число: $p")
        println("Первообразный корень: $g")
        
        secret_A, secret_B = diffie_hellman(a, b, p, g)
        
        println("Секретный ключ у стороны A: $secret_A")
        println("Секретный ключ у стороны B: $secret_B")
    else
        println("Не удалось найти первообразный корень для p = $p")
    end
end


@time main(p)
