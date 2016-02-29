-- Treti demonstracni priklad prace s koprogramy:
-- vytvoreni koprogramu, zavolani coroutine.yield()
-- a nasledne coroutine.resume()



-- vytvoreni koprogramu s vyuzitim anonymni funkce
koprogram = coroutine.create(
    function()
        print("*** telo koprogramu pred zavolanim yield ***")
        coroutine.yield()
        print("*** telo koprogramu po zavolani yield ***")
    end
)

-- vypis typu objektu
print("Typ objektu:", koprogram)

-- zjisteni a vypis stavu koprogramu
print("Stav koprogramu:", coroutine.status(koprogram))

-- spusteni koprogramu
coroutine.resume(koprogram)

-- zjisteni a vypis stavu koprogramu
print("Stav koprogramu:", coroutine.status(koprogram))

-- spusteni koprogramu
coroutine.resume(koprogram)

-- zjisteni a vypis stavu koprogramu
print("Stav koprogramu:", coroutine.status(koprogram))

-- finito 