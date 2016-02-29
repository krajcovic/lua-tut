-- konstrukce asociativního pole se třemi položkami
poleA={klic1="hodnota1", klic2="hodnota2", klic3="hodnota3"}

-- při vynechání klíčů se automaticky doplní hodnoty 1, 2 a 3
poleB={"hodnota1", "hodnota2", "hodnota3"}

-- promíchání obou předešlých způsobů ("hodnota2" má přiřazený klíč 1 a "hodnota4" klíč 2)
poleC={klic1="hodnota1", "hodnota2", klic2="hodnota3", "hodnota4"}

-- přepis hodnot některých položek ("hodnota1" na "hodnotax") asociativního pole
-- ve chvíli, kdy tyto položky mají stejné klíče (každý klíč musí být jedinečný)
poleD={klic1="hodnota1", "hodnota2", klic2="hodnota3", "hodnota4", klic1="hodnotax"} 

print(poleA)

print(poleB["klic1"])
print(poleB["klic2"])
print(poleB["klic3"]) -- neexistující prvek, vypíše se "nil"
print(poleB.klic1)
print(poleB.klic2)
print(poleB.klic3)    -- neexistující prvek, vypíše se "nil"