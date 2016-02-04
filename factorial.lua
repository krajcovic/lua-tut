--Ukazka faktorialu

function factorial(n)
  if n == 0 then
    return 1 
  else 
    return n * factorial(n-1)
  end
end


print "Vypocet faktorialu"
print "Zadej cislo: "

a = io.read("*number")
print ("Faktorial cisla ",a," je ", factorial(a))