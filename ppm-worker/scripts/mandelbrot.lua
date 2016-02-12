-- Vykresleni Mandelbrotovy mnoziny

width=320
height=240
maxiter=120

function mandelbrot(x, y, maxiter)
    local zx, zy, cx, cy=0, 0, x, y
    local iter
    for iter=0, maxiter do
        local zx2, zy2 = zx*zx, zy*zy
        
        -- z=z^2+c
        zx, zy = zx2-zy2+cx, 2*zx*zy+cy
        
        -- test na bailout
        if zx2+zy2>4 then
            return iter
        end
    end
    return 0
end

createBitmap(width, height)
clearBitmap()

for y=0, height-1 do
    for x=0, width-1 do
        local i=mandelbrot(x/(width/4)-2, y/(height/3)-1.5, maxiter)
        putpixel(x, y, 20*i, 40*i, 60*i)
    end
end


function save(path)
  saveBitmap(string.format("%s%s", path,  "lua8_2.ppm"))
end

-- finito 