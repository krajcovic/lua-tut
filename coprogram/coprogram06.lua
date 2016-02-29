-- Sesty demonstracni priklad prace s koprogramy:
-- predavani parametru mezi koprogramem a volajici funkci



-- vytvoreni koprogramu s vyuzitim anonymni funkce
koprogram = coroutine.create(
    function(a,b)
        print("Predane parametry do koprogramu: ", a, b);
        coroutine.yield(a + b, a - b)
        print("*** telo koprogramu po zavolani yield")
        return a * b, a / b
    end
)

-- vypis typu objektu
print("Typ objektu:", koprogram)

-- zjisteni a vypis stavu koprogramu
print("Stav koprogramu pred jeho spustenim:", coroutine.status(koprogram))

print("Vysledek prvniho volani resume: ", coroutine.resume(koprogram, 1, 2))

print("Vysledek druheho volani resume: ", coroutine.resume(koprogram))

-- zjisteni a vypis stavu koprogramu
print("Stav koprogramu po jeho ukonceni:", coroutine.status(koprogram))

-- finito 