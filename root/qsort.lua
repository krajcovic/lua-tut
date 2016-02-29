-- poznámky začínají dvojicí znaků --:
-- extracted from Programming Pearls, page 110

-- středníky za příkazy nejsou povinné, zde se nepoužívají

--local math = require 'math'

-- Deklarace funkce začíná klíčovým slovem function, za nímž následuje
-- jméno funkce a v závorce seznam parametrů (bez udání typu)
function qsort(x,l,u,f)
    -- zápis podmínky, povšimněte si, že vlastní výraz není nutné
    -- psát do závorek a používá se klíčové slovo then
    if l<u then
        -- lokální proměnná, opět se nemusí udávat její typ
        local m=math.random(u-(l-1))+l-1  -- choose a random pivot in range l..u
        -- použití vícenásobného přiřazení umožňuje jednoduché prohození hodnot
        -- uložených v asociativním poli
        x[l],x[m]=x[m],x[l]               -- swap pivot to first position
        local t=x[l]                      -- pivot value
        m=l
        local i=l+1
        -- programová smyčka, platí pro ni podobná pravidla, jako pro výše
        -- okomentovanou podmínku
        while i<=u do
            -- invariant: x[l+1..m] < t <= x[m+1..i-1]
            if f(x[i],t) then
                m=m+1
                x[m],x[i]=x[i],x[m]       -- swap x[i] and x[m]
            end
            i=i+1
        end
        x[l],x[m]=x[m],x[l]               -- swap pivot to a valid place
        -- x[l+1..m-1] < x[m] <= x[m+1..u]
        -- rekurzivní volání (není zapotřebí použít žádnou formu předběžné deklarace)
        qsort(x,l,m-1,f)
        qsort(x,m+1,u,f)
    end
end 