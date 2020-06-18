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

local hashtag_amount = Tokenizer.sfind(Text, 'HASHTAG') --this looks for the token HASHTAG (the character #) in the text
local num_amount = Tokenizer.sfind(Text, 'DIGITS', true) --this looks for any numbers. the true means that it will turn 1234567890 into a table with each number and search for each value of the table in the text

print('Hashtags found:', hashtag_amount, 'Digits found:', num_amount) -->> 4, 12

local purple = Color.fromRGB(127, 0, 127) -->> {r: 127, g: 0, b: 127}
print(purple.r, purple.g, purple.b) -->> 127 0 127
local white = Color.fromHex('#FFFFFF') 
local lightRed = Color.fromHex('#EB0A05')
print(white.byte1, lightRed.byte1) -->> FF, EB
print(white.byte2, lightRed.byte2) -->> FF, 0A
print(white.byte3, lightRed.byte3) -->> FF, 05

local rand = Random.new() -->> returns a new random object "rand" with random seed
local randWithSeed = Random.new(5) -->> returns a new random object "randWithSeed" with seed of 5
print(randWithSeed.seed) -->> 5
print(rand.seed) -->> prints a pseudo random large number seed
local mynum = rand.next(1,10) -->> returns random # between 1 and 10 in with seed of random object "rand"
local percent = rand.percent(25) -->> returns true if random # between 25 and 100 is less than or equal to 25 (25% chance of returning true)

if percent then
  print('25% chance, yet I still outputted!')
end

print(math.e, math.format(37428893)) -->> 2.7182....  37,428,893
--math.format turns a number into a readable string
--i.e. 43734 would be turned into 43,734

local array1 = {'hey there', 2, ""}
local array2 = {'part 2!',3.14,7}

local zipped = table.zip(array1,array2) -->> merges array1 and array2 into 1 table called zippede (works with any amount of arrays)
table.display(zipped) -->> hey there, 2, part 2!,  , 3.14, 7, wow
table.display(table.numbers(array2)) --returns an array with all numbers in array2 >> 3.14, 7

--python-like classes
local MyClass = Class('Animal', --this part is identical to from module import class, this would work almost exactly like python in modules.
	function() --init function (identical to def __init__():)
		for i,v in pairs(MyClass.Methods) do --all methods added to the class are stored here
			for i,v in pairs(v) do
				v()
			end
		end
	end,
	{Dog = function() --this is indentical to def Dog():
		print('I am a dog')
	end},
	{Giraffe = function()
		print('I am a giraffe')
	end}
)
local Animal = MyClass() --load class to variable "Animal"
Animal.Dog() -->> I am a dog
Animal.Giraffe() -->> I am a giraffe
]]

if crystal.findpkg('crystal+') then --check if pkg is installed
  _C:dump() --dump cache
end
