

-- Vytvoreni obrazce se spiralou

width=256
height=256

createBitmap(width, height)
clearBitmap()

for y=0, 255 do
    for x=0, 255 do
        local xc=x-width/2
        local yc=y-height/2
        local angle=math.atan2(xc, yc)
        local magnitude=math.sqrt(xc^2 + yc^2)
        local r=127+127*math.cos(20*angle)
        local g=127+127*math.cos(10*angle+1/4*magnitude)
        local b=127+127*math.cos(00*angle+1/6*magnitude)
        putpixel(x, y, r, g, b)
    end
end

function save(path)
  saveBitmap(string.format("%s%s", path,  "lua8_4.ppm"))
end

-- finito 