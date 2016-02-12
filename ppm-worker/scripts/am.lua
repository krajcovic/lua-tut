-- Animace amplitudove modulace pri postupne
-- zmene frekvence druheho signalu

width=400
height=300

createBitmap(width, height)

-- amplituda a frekvence prvniho signalu
a1=70
f1=4

-- amplituda a menici se frekvence druheho signalu
a2=30

for f2=10, 50 do
    clearBitmap()
    for x=0, width-1, 0.1 do
        wave1 = a1*math.cos(f1*x/(width/2))
        y=height/3 + wave1
        putpixel(x, y, 255, 0, 0)

        wave2 = a2*math.cos(f2*x/(width/2))
        y=height/3 + wave2
        putpixel(x, y, 0, 0, 255)

        -- vypocet AM
        y=3*height/4 + wave1*wave2/50
        putpixel(x, y, 255, 255, 255)
    end

    saveBitmap("images/lua8_5_"..f2..".ppm")
end

function save(path)
  saveBitmap(string.format("%s%s", path,  "lua8_5.ppm"))
end

-- finito 