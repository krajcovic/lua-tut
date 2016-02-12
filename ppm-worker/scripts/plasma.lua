-- Vykresleni plasmy

width=256
height=256

createBitmap(width, height)
clearBitmap()

function putpixel2(x, y, c)
    putpixel(x, y, c, c, c)
end

function plasma(x1, y1, x2, y2, c1, c2, c3, c4)
    local xc, yc = (x1+x2)/2, (y1+y2)/2
    -- podminka pro rekurzivni deleni
    if x2-x1<1 then
        return
    end
    -- 1---12--2
    -- |   |   |
    -- 13--cc--24
    -- |   |   |
    -- 3---34--4
    -- barvy ve stredech stran ctverce
    local c12, c13, c24, c34 = (c1+c2)/2, (c1+c3)/2, (c2+c4)/2, (c3+c4)/2
    -- posun prostredniho bodu
    local cc=(c12+c34)/2+math.random(x2-x1)*2-(x2-x1)
    cc=math.min(cc, 255)
    cc=math.max(cc, 0)
    putpixel2(x1, y1, c1)
    putpixel2(xc, y1, c12)
    putpixel2(x1, yc, c13)
    putpixel2(xc, yc, cc)
    -- rekurzivni rozdeleni ctverce
    plasma(x1, y1, xc, yc, c1, c12, c13, cc)
    plasma(xc, y1, x2, yc, c12, c2, cc, c24)
    plasma(x1, yc, xc, y2, c13, cc, c3, c34)
    plasma(xc, yc, x2, y2, cc, c24, c34, c4)
end

math.randomseed(42)
plasma(0, 0, width-1, height-1, 127, 0, 127, 240)

function save(path)
  saveBitmap(string.format("%s%s", path,  "lua8_3.ppm"))
end

-- finito 