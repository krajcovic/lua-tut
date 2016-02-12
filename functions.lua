-- Druhy demonstracni priklad:
-- definice vlastnich funkci bez vyuziti
-- "syntaktickeho cukru"

-- funkce obsahujici lokalni promennou
-- (hodnota typu funkce je prirazena
--  promenne pojmenovane "printHello")
printHello = function()
    local helloStr = "Hello"
    print(helloStr)
end

worldStr="World"

-- funkce vyuzivajici globalni promennou
-- (hodnota typu funkce je prirazena
--  promenne pojmenovane "printWorld")
printWorld = function()
    -- ke globalni promenne je pripojena
    -- retezcova konstanta (literal)
    print(worldStr .. "!")
end

-- volani obou funkci
printHello()
printWorld()

-- zmena globalni promenne
-- se projevi i ve volane funkci
worldStr=42
printWorld()

-- finito 

-- Ctvrty demonstracni priklad:
-- volitelne parametry funkci

function fce(x, y, z)
    print(x, y, z)
end

-- volani funkce fce s ruznym poctem parametru
fce(1, 2, 3)
fce(1, 2, 3, 4) -- posledni hodnota se nevyuzije
fce()
fce(42)
fce(42, 6502)
fce(nil, 6502)
-- lze pouzit i retezce popr. hodnoty dalsich typu typu
fce("Hello", "world", "!")
fce("Hello".." world", "!" )
fce("Hello".." world".."!" )

-- finito 

-- Sedmy demonstracni priklad:
-- vyuziti rekurze

-- funkce pro rekurzivni vypocet faktorialu
function factorial(n)
    -- faktorial je definovan pouze pro prirozena cisla a nulu
    if n < 0 then
        return nil
    -- rekurze je ukoncena pri n=0
    elseif n == 0 then
        return 1
    else
        return n*factorial(n-1)
    end
end

-- vypis tabulky s faktorialy
print()
print("Factorial")
print("n", "n!")
for n = -5, 10 do
    print(n, factorial(n))
end

-- rekurzivni vypocet binomickeho koeficientu
function binomical(n, k)
    if k == 0 then
        return 1
    else
        return binomical(n - 1, k - 1) * n / k;
    end
end

-- vypis nekterych hodnot "n nad k"
print()
print("Binomical coefficients")
print("n", "k", "n nad k")
for k = 0, 10 do
    for n = k, 10 do
        print(n, k, binomical(n, k))
    end
end

-- finito 