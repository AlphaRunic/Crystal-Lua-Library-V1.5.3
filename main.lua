local crystal = require('Crystal.crystal')(
	{
		displayStats = true,
	}
) --import library

import("string","math","table","random","class","color","tokenizer","crystal+") -->> crystal.packages

--[[
Tokenizer.add('#', 'HASHTAG') -->> Tokenizer.tokens['HASHTAG'] = '#'
Tokenizer.add('1234567890', 'DIGITS')
local Text = '#01!5?##2%^6653#(),3254'

local hashtag_amount = Tokenizer.sfind(Text, 'HASHTAG') --this looks for the character # in the text
local num_amount = Tokenizer.sfind(Text, 'DIGITS', true) --this looks for any numbers. the true means that it will turn 1234567890 into a table with each number and search for each value in the table

print('Hashtags found:', hashtag_amount, 'Digits found:', num_amount) -->> 4, 12

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

print(math.e, math.format(37428893)) -->> 2.7182.... 37,428,893

local array1 = {'hey there', 2, ""}
local array2 = {'part 2!',3.14,7}

local zipped = table.zip(array1,array2) -->> merges array1 and array2 into 1 table (works with any amount of arrays)
table.display(zipped) -->> hey there, 2, part 2!,  , 3.14, 7, wow
table.display(table.numbers(array2)) --puts all numbers from array2 into an array which is returned by table.numbers >> 3.14, 7

--python-like classes
local MyClass = Class('Animal', --this part is identical to from module import class, this would work almost exactly like python in modules.
	function()
		for i,v in pairs(MyClass.Methods) do --all methods added to the class are stored here
			for i,v in pairs(v) do
				v()
			end
		end
	end,
	{Dog = function()
		print('I am a dog')
	end},
	{Giraffe = function()
		print('I am a giraffe')
	end}
)
local Animal = MyClass()
Animal.Dog() -->> I am a dog
Animal.Giraffe() -->> I am a giraffe

if crystal.findpkg('crystal+') then --check if pkg is installed
  _C:dump() --dump cache
end
]]