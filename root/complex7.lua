-- Ctvrty demonstracni priklad:
-- 1) pretizeni operatoru +, -, * a / pro komplexni cisla
--    vraceny vysledek je taktez "objektem" typu komplexni cislo
-- 2) skryti metatabulky do uzaveru

Complex = {}

-- Konstruktor pro komplexni cisla
function Complex:new( real, imag )
  local value = { real = real, imag = imag }
  local metatable =  {
    -- Pro "objektovy" zpusob volani metod
    __index = Complex,

    -- Metametoda pro operator +
    __add = function(x, y)
      return setmetatable({real = x.real + y.real, imag = x.imag + y.imag }, getmetatable(x))
    end,

    -- Metametoda pro operator -
    __sub = function(x, y)
      return setmetatable({ real = x.real - y.real, imag = x.imag - y.imag }, getmetatable(x))
    end,

    -- Metametoda pro operator *
    __mul = function(x, y)
      local result = { real = x.real * y.real - x.imag * y.imag, imag = x.real * y.imag + x.imag * y.real }
      return setmetatable(result, getmetatable(x))
    end,

    --   Metametoda pro operator /
    __div = function(x, y)
      local mag = y.real ^ 2 + y.imag ^ 2
      local y_upravene = { real = y.real/mag, imag = - y.imag/mag}
      return self.__mul(x,y_upravene)
    end
  }
  return setmetatable(value, metatable)

end

-- Metoda print
function Complex:print()
  print(self.real, self.imag)
end

-- Otestujeme funkcnost tridy Complex
function test()
  -- Objekty predstavujici komplexni cisla
  z1 = Complex:new(4, 3)
  z2 = Complex:new(2, 0)

  z1:print()
  z2:print()

  -- Zkouska pretizeni aritmetickych operatoru
  x = z1 + z2
  x:print()

  y = z1 - z2
  y:print()

  z = z1 * z2
  z:print()

  w = z1 / z2
  w:print()

  -- Vysledek operaci nad komplexnimi cisly
  -- ma prirazenou metatabulku pro komplexni cisla
  Complex.print(x + y)
  Complex.print(y - z)
  --  Complex.print(z * w)
  --  Complex.print(w / z)
end

-- Spusteni testu
test()

-- finito 