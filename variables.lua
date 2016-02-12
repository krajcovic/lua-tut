--x=10                              -- vytvoreni globalni promenne x
print("globalni x=", x)

do                                -- zacatek bloku
  x=20                    -- vytvoreni lokalni promenne x
  print("1. lokalni x=", x)
  do                            -- zacatek zanoreneho bloku
    --        local x=30                -- vytvoreni lokalni promenne x
    print("2. lokalni x=", x)
end                           -- konec zanoreneho bloku
print("1. lokalni x=", x)
end                               -- konec bloku

print("globalni x=", x)


i,j=10,20                  -- vicenasobne prirazeni
print("i=", i)
print("j=", j)

i,j=j,i                    -- prohozeni obsahu dvou promennych
print("i=", i)
print("j=", j)

funkce = print
print("funkce=", funkce)
--print = 1
a = 2
funkce("dofile=", print)

x=10                       -- vytvoreni globalni promenne x s ciselnou hodnotou
print("x=", x)

url="www.root.cz"          -- vytvoreni globalni promenne s retezcovou hodnotou
print("url=", url)

a=nil                      -- vytvoreni globalni promenne s hodnotou nil
print("a=", a)

b=true                     -- vytvoreni globalni promenne s logickou hodnotou
print("b=", b)

c=false                    -- vytvoreni globalni promenne s logickou hodnotou
print("c=", c)


level =0
t = {name="test", what="what"}
event = "call"
if event=="call" then
  level=level+1
else
  level=level-1
  if level<0 then
    level=0
  end
end
if t.what=="main" then
  if event=="call" then
    io.write("begin ", t.short_src)
  else
    io.write("end ", t.short_src)
  end
elseif t.what=="Lua" then
  io.write(event, " ", t.name or "(Lua)"," <",t.linedefined,":",t.short_src,">")
else
  io.write(event, " ", t.name or "(C)"," [",t.what,"] ")
end



for i=0,100,10 do
  print(i)
end

months={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"}

for poradi,month in pairs(months) do
  print(poradi , ":" , month)
end
