

-- vymazani obrazovky
clean()

-- posun zelvy tak, aby byl
-- vykresleny obrazek vystredeny
right(135)
penup()
forward(350)
left(135)
pendown()

-- vlastni obrazec
for i=0, 90 do
    forward(500)
    left(92)
end 