-- Paty demonstracni priklad prace s koprogramy:
-- predani parametru koprogramu pri jeho prvnim spusteni


-- vytvoreni koprogramu s vyuzitim anonymni funkce
koprogram = coroutine.create(
    function(opakovani, min)
        print("Predany pocet opakovani: ", opakovani, min)
        if opakovani <= min then
            return
        end
        for i=1, opakovani do
            print("*** telo koprogramu pred zavolanim yield: "..i.." ***")
            coroutine.yield()
            print("Predany pocet opakovani: ", opakovani, min)
            print("*** telo koprogramu po zavolani yield: "..i.." ***")
        end
    end
)

-- vypis typu objektu
print("Typ objektu:", koprogram)

-- zjisteni a vypis stavu koprogramu
print("Stav koprogramu pred jeho spustenim:", coroutine.status(koprogram))

coroutine.resume(koprogram, 5, 3)

print("Stav koprogramu pred vstupem do smycky:", coroutine.status(koprogram))

counter = 0
-- spusteni a znovuspusteni koprogramu
while coroutine.resume(koprogram, 6, 8) do
    counter = counter + 1
    print("Funkce coroutine.resume() volana "..counter.."x")
    print("Stav koprogramu ve smycce while:", coroutine.status(koprogram))
end

-- zjisteni a vypis stavu koprogramu
print("Stav koprogramu po ukonceni smycky while:", coroutine.status(koprogram))

-- finito 