-- Funkce obsahujici lokalni promennou.
-- Tato funkce vraci anonymni funkci
-- jako svuj vysledek.
function generateClosure()
    -- lokalni promenna, ktera neni
    -- z okolniho programu dostupna
    local y = 1
    -- anonymni funkce vytiskne hodnotu
    -- lokalni promenne funkce "generateClosure"
    -- a potom se pokusi o zmenu jeji hodnoty:
    local result = function()
        print(y)
        y = y + 1
    end
    -- po vytvoreni zarodku uzaveru
    -- zmenime hodnotu lokalni promenne
    y = 42
    -- vratime vytvorenou funkci - uzaver
    return result
end

-- ziskame uzaver, tj. instanci anonymni funkce
closure = generateClosure()

-- vytiskne se posloupnost hodnot 42, 43, 44 a 45
closure()
closure()
closure()
closure()

-- finito 

-- Demonstracni priklad:
-- pouziti uzaveru

-- pomocna funkce vracejici uzaver
function defPosloupnosti(n)
    -- pamatovana hodnota, ktera vsak
    -- neni z okolniho programu dostupna
    local y = 1
    -- pocitadlo volani = exponent
    local index = 0
    -- anonymni funkce vytiskne pamatovanou
    -- hodnotu a nakonec ji vynasobi zvolenou konstantou
    return function()
        print(index, y)
        y = y * n
        index = index + 1
    end
end

print("mocniny cisla 2")
-- ziskani uzaveru
generator = defPosloupnosti(2)

-- postupne se budou tisknout
-- mocniny cisla 2
for i=0, 16 do
    generator()
end

print()

print("mocniny cisla 3")
-- ziskani uzaveru
generator = defPosloupnosti(3)

-- postupne se budou tisknout
-- mocniny cisla 3
for i=0, 16 do
    generator()
end

print()

print("mocniny cisla 10")
-- ziskani uzaveru
generator = defPosloupnosti(10)

-- postupne se budou tisknout
-- mocniny cisla 3
for i=0, 16 do
    generator()
end

-- finito 