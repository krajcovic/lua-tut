-- Druhy demonstracni priklad:
-- pretizeni operatoru +, -, * a / pro komplexni cisla

Complex = {}

-- Metatabulka pro objekty predstavujici komplexni cisla
complex_meta = {
  -- Pro "objektovy" zpusob volani metod
  __index = Complex,

  -- Metametoda pro operator +
  __add = function(x, y)
    return { real = x.real + y.real, imag = x.imag + y.imag }
  end,

  -- Metametoda pro operator -
  __sub = function(x, y)
    return { real = x.real - y.real, imag = x.imag - y.imag }
  end,

  -- Metametoda pro operator *
  __mul = function(x, y)
    return { real = x.real * y.real - x.imag * y.imag, imag = x.real * y.imag + x.imag * y.real }
  end,

  -- Metametoda pro operator /
  __div = function(x, y)
    local mag = y.real ^ 2 + y.imag ^ 2
    local y_upravene = { real = y.real/mag, imag = - y.imag/mag}
    return complex_meta.__mul(x,y_upravene)
  end
}

-- Konstruktor pro komplexni cisla
function Complex:new(real, imag)
  local value = { real = real, imag = imag }
  return setmetatable(value, complex_meta)
end

-- Metoda print
function Complex:print()
  print(self.real, self.imag)
end

-- Objekty predstavujici komplexni cisla
z1 = Complex:new(4, 3)
z2 = Complex:new(2, 0)

-- Zkouska pretizeni aritmetickych operatoru
x = z1 + z2
print(x.real, x.imag)

y = z1 - z2
print(y.real, y.imag)

z = z1 * z2
print(z.real, z.imag)

w = z1 / z2
print(w.real, w.imag)

-- Vysledek operaci ma sice typ asociativni pole,
-- ale jiz nema prirazenou metatabulku, proto
-- pokus o vyvolani operatoru + vede k chybe
--a = x + y

-- finito 