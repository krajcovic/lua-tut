-- Vytvoreni objektu pomoci uzaveru

-- Konstruktor objektu
function Complex(paramReal, paramImag)
  -- asociativni pole, ve kterem jsou ulozeny
  -- jak atributy objektu, tak i jeho metody
  local self={}

  -- vytvoreni a inicializace atributu
  self.real = paramReal
  self.imag = paramImag

  -- vytvoreni metody print
  self.print = function()
    print(self.real.."+i"..self.imag)
  end

  -- vytvoreni metody add
  self.add = function(paramReal, paramImag)
    self.real = self.real + paramReal
    self.imag = self.imag + paramImag
  end

  -- vytvoreni metody subract
  self.subt = function(paramReal, paramImag)
    self.real = self.real - paramReal
    self.imag = self.imag - paramImag
  end

  -- navratovou hodnotou konstruktoru je uzaver
  return self
end

-- vytvoreni dvojice objektu
c1 = Complex(1, 2)
c2 = Complex(3, 4)

-- tisk hodnot obou objektu
c1.print()
c2.print()

-- zmena atributu prvniho objektu
c1.add(10, 20)

-- tisk hodnot obou objektu
c1.print()
c2.print()


c1.subt(5,6)
c1.print()
c2.print()
-- finito 