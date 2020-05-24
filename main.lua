local crystal = require'Crystal/crystal'()
import("math","string","table","random","class","crystal+") -->> crystal.packages

local rand = Random.new(getseed()) -->> creates a new random object
local mynum = rand.next(1,10) -->> returns random # between 1 and 10

local percent = Random.percent(25) -->> returns true if random # between 25 and 100 is less than or equal to 25

if percent then
  print('25% chance, yet I still outputted!')
end

local array1 = {'hey there',2,""}
local array2 = {'part 2!',3.14,7}
local array3 = {'wow'}

local zipped = table.zip(array1,array2,array3) -->> merges array1, array2, and array3 into one table
table.display(zipped) --> hey there, 2,  , part 2!, 3.14, 7, wow

table.display(table.numbers(array2)) -->> 3.14, 7
table.display(table.strings(array1)) -->> hey there, 

local class_mtd = { -->> where variables/functions of the class are stored
  print = function(x) return print(x) end,
}
local myClass = Class.new('CoolClass',class_mtd); -->> creates a new class object with name CoolClass and info class_mtd

--myClass.print('hi') -->> hi

if crystal.packages['crystal+'] then --check if pkg is installed
  _C.dump()
end