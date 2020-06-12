local crystal = require('Crystal.crystal')(getfenv()) --import library

import("string","math","table","random","class","color","tokenizer","crystal+") -->> crystal.packages

--[[
Tokenizer.add('#', 'HASHTAG') -->> Tokenizer.tokens['HASHTAG'] = '#'
Tokenizer.add('1234567890', 'DIGITS')
local Text = '#01!5?##2%^6653#(),3254'

local amount = 0
local amount2 = 0

for hashtag in string.gmatch(Text, Tokens['HASHTAG']) do
	amount = amount + 1
end

for _, Digit in pairs(string.separate(Tokens['DIGITS'])) do
	for Number in string.gmatch(Text, Digit) do
		amount2 = amount2 + 1
	end
end

print('Hashtags found:', amount, 'Digits found:', amount2) -->> 4, 12

local purple = Color.fromRGB(127, 0, 127) -->> {r: 127, g: 0, b: 127}
print(purple.r, purple.g, purple.b) -->> 127 0 127
local white = Color.fromHex('#FFFFFF') 
local lightRed = Color.fromHex('#EB0A05')
print(white.byte1, lightRed.byte1) -->> FF, EB
print(white.byte2, lightRed.byte2) -->> FF, 0A
print(white.byte3, lightRed.byte3) -->> FF, 05

local rand = Random.new(getseed()) -->> creates a new random object with random seed
local mynum = rand.next(1,10) -->> returns random # between 1 and 10
local percent = rand.percent(25) -->> returns true if random # between 25 and 100 is less than or equal to 25

if percent then
  print('25% chance, yet I still outputted!')
end

print(math.e, math.format(3742893)) -->> 2.7182.... 3,742,893

local array1 = {'hey there', 2, ""}
local array2 = {'part 2!',3.14,7}

local zipped = table.zip(array1,array2) -->> merges array1 and array2 into 1 table (works with any amount of arrays)
table.display(zipped) --> hey there, 2, part 2!,  , 3.14, 7, wow
table.display(table.numbers(array2)) -->> 3.14, 7
table.display(table.strings(array1)) -->> hey there, 

function src(parameter) -->> wrapped module
  local myTable = {'bar'}
  print(parameter..' says: ')
  table.display(myTable)
end
local class_mtd = { -->> where variables/functions of the class are stored
  print = function(x) return print(x) end,
  foo = 'foo',
  src = src, -->> myClass.src
}
local myClass = Class.new('CoolClass',class_mtd); -->> creates a new class object with name CoolClass and info class_mtd
--myClass.print('hi') -->> hi
--print(myClass.foo) -->> foo
local mod = module.new('MyModule',myClass.src) -->> use module src from class
mod.execute(mod.name) -->> mymodule says: foo, bar, 123
]]

local cpInstalled
for i,v in pairs(crystal.packages) do
	if v == 'crystal+' then cpInstalled = true break end
end
if cpInstalled then --check if pkg is installed
  _C:dump() --dump cache
end
