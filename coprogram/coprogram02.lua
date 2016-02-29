-- Druhy demonstracni priklad prace s koprogramy:
-- vytvoreni koprogramu, vypis jeho stavu a spusteni
-- (anonymni) funkce koprogramu je vytvorena primo
-- ve volani coroutine.create()



-- vytvoreni koprogramu s vyuzitim anonymni funkce
koprogram = coroutine.create(
    function()
      print("*** Koprogram byl spusten ***")
      for i=0,10 do
        print(i)        
      end
    end
)

-- vypis typu objektu
print("Typ objektu:", koprogram)

-- zjisteni a vypis stavu koprogramu
print("Stav koprogramu:", coroutine.status(koprogram))

-- spusteni koprogramu
print(coroutine.resume(koprogram))

-- zjisteni a vypis stavu koprogramu
print("Stav koprogramu:", coroutine.status(koprogram))

print(coroutine.resume(koprogram))

-- finito 