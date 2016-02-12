-- Vytvoreni jednoducheho obrazce zalozeneho na aliasu

width=256
height=256

--function test(path)
--  print(string.format("%s%s", path, "lua.ppm"))
--end
--
--test("images/")

createBitmap(width, height)
clearBitmap()

for y=0, height-1 do
    for x=0, width-1 do
        local r=x
        local g=127+127*math.cos(((x-width/2)^2+(y-64)^2)/10)
        local b=y
        putpixel(x, y, r, g, b)
    end
end

function save(path)
  saveBitmap(string.format("%s%s", path,  "lua8_1.ppm"))
end

-- finito   