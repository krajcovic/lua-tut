

-- priklad na pouziti aritmetickych operatoru

-- promenne, se kterymi se budou vypocty provadet
a=10
b=20

-- vypiseme hodnoty promennych
print("a=", a)
print("b=", b)

-- vysledky aritmetickych vyrazu
print("a+b=", a+b)
print("a-b=", a-b)
print("a*b=", a*b)
print("a/b=", a/b) -- vysledkem teto operace je realne cislo
print("a%b=", a%b)
print("a^b=", a^b)

-- pomoci operatoru umocnovani lze vypocitat i odmocninu
print("sqrt(2)=", 2^(0.5))

-- vypocet celych kladnych mocnin zakladu 2
print()
print("mocniny cisla 2")

print("x", "2^x")
for x=0,16 do
    print(x, 2^x)
end

-- vypocet celych zapornych mocnin zakladu 2
print()
print("x", "2^(-x)")
for x=0,16 do
    print(x, 2^(-x))
end

-- finito 

-- logicke operatory
print()
print("logicky operator and")
print("false and false  =", false and false)
print("true  and false  =", true  and false)
print("false and true   =", false and true )
print("true  and true   =", true  and true )
print("true  and 'ahoj' =", true  and 'ahoj')
print("true  and nil    =", true  and nil)
print("false and 'ahoj' =", false and 'ahoj')
print("nil   and 'ahoj' =", nil   and 'ahoj')
print("'ahoj' and nil   =", 'ahoj'and nil)

print()
print("logicky operator or")
print("false or false  =", false or false)
print("true  or false  =", true  or false)
print("false or true   =", false or true )
print("true  or true   =", true  or true )
print("true  or 'ahoj' =", true  or 'ahoj')
print("true  or nil    =", true  or nil)
print("false or 'ahoj' =", false or 'ahoj')
print("nil   or 'ahoj' =", nil   or 'ahoj')
print("'ahoj' or nil   =", 'ahoj'or nil)

print()
print("logicky operator not")
print("not false=", not false)
print("not true =", not true)
print("not nil  =", not nil)
print("not ''   =", not '') -- prazdny retezec je "pravdivy"
print("not not ''=", not not '')

-- finito 