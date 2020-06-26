crystal = require 'Crystal.crystal' {
	displayStats = true,
	warnings = true				
} --import library

--import using tuple or individually (i.e. import 'string')
import ( 
	"string",
	"math",
	"table",
	"random",
	"color",
	"tokenizer",
	"event",
	"form",
	"crys-sys",
	"crystal+"
) -->> crystal.packages, to find: crystal.findpkg(pkg)

--import 'crys-sys'



--Sys.execute('exe foo.lua bar') -->> prints any args given, in this case "bar"
Sys.cmd_console() --reads any input as a crystal system command until command "exit" is executed
--Sys.read_input() --reads one line of input as a command
--Sys.execute('cls','clean','echo hello world') --clears console, then collects lua script garbage, then echoes

Sys.clean() --cleans garbage

local my_variable = 'hey there!'
local obj_var = vardump(my_variable) --turns my_var into a table with a type and a value
print(obj_var.type, obj_var.value) -->>	string hey there!

print(string.gencode(6, '1234567890')) --any random 6 character sequence of numbers
print(string.gencode(10)) --any random 10 character sequence of lowercase & uppercase letters and numbers
print(string.gencode(6, '!@#$%^&*()-_=+`~\{\}|\[\]:";\\\'<>?,.')) -- any random 6 character sequence of symbols

test = new { Form } { --create a new form
	{ --questions
		'What\'s your name?', --q1
		'What\'s your age?', --q2
		'What\'s your dog\'s name?' --q3
	},
	{ --answers
		'Riley', --a1
		'15', --a2
		'Bentley' --a3
	}
};

test:Start() --start listening for answers in console

right, wrong = test:Eval() --when test is finished, evaluate answers
print('I got '..right..'/'..#test.Questions..' correct, '..wrong..' wrong.') --display evaluation

for ans_num, ans in pairs(test.Answers) do
	local right_or_wrong
	if ans.correct == true then right_or_wrong = ' correct.' else right_or_wrong = ' incorrect.' end
	print('I got '..test.Questions[ans_num]..right_or_wrong)
end --evaluate each question

local rn = now()
local TimeChangeEvent = new { Event } { 'TimeChange' } --create a new bindable event

local connection --script connection returned by event:connect
local _break
function onTimeChanged(t)
	--t == now()
	print('Time changed. UNIX epoch is now: '..tostring(t))
	if t - rn == 3 then
		print('3 seconds passed, disconnecting...')
		connection:Disconnect() --disconnect after 3 seconds
		_break = true --break while loop
	end
end

--set connection
connection = TimeChangeEvent:Connect(onTimeChanged)

while not _break do
	os.execute('sleep '..(1)) --fire every second until _break = true
	TimeChangeEvent:Fire(now()) --calls all functions connected to event "TimeChangeEvent" with params now(), therefore "onTimeChanged" is called with var "t" as now().
end
TimeChangeEvent:Fire(now()) --does nothing

Tokenizer.add('#', 'HASHTAG') -->> Tokenizer.tokens['HASHTAG'] = '#'
Tokenizer.add('1234567890', 'DIGITS')
Tokenizer.add('qwertyuiopasdfghjklzxcvbnm', 'LOWER_LETTERS')
Tokenizer.add('QWERTYUIOPASDFGHJKLZXCVBNM', 'UPPER_LETTERS')

local Text = '#01!df5?#bds#2%^66asd53#(),3254'

local hashtag_amount = Tokenizer.sfind(Text, 'HASHTAG') --this looks for the token HASHTAG (the character #) in the text
local num_amount = Tokenizer.sfind(Text, 'DIGITS', true) --this looks for any numbers. the true means that it will turn 1234567890 into a table with each number and search for each number in the text
local letter_amount = Tokenizer.sfind(Text, 'LOWER_LETTERS', true) + Tokenizer.sfind(Text, 'UPPER_LETTERS', true) --adding the lowercase and uppercase amount to get letter amount

print('Hashtags found:', hashtag_amount, 'Digits found:', num_amount, 'Letters found: '..letter_amount) -->> 4, 12, 8

local purple = Color.fromRGB(127, 0, 127) -->> {r: 127, g: 0, b: 127}
print(purple.r, purple.g, purple.b) -->> 127 0 127
local lightRed = Color.fromHex('#EB0A05')
print(lightRed.byte1, lightRed.byte2, lightRed.byte3) -->> EB 0A 05

local title = 'centered title'
print(string.center(title, 4)) --centers string between 4 spaces, returns "    centered title    "
local get_bytes = 'hello'
table.display(string.bytes(get_bytes)) --each index of table of each byte of each character in "get_bytes"

randomize() --randomizes the environment (random seed)
local rand = new { Random } {}; -->> returns a new random object "rand" with random seed
local randWithSeed = new { Random } { 5 }; -->> returns a new random object "randWithSeed" with seed of 5
print(randWithSeed.seed) -->> 5
print(rand.seed) -->>  pseudo random large number seed
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

local keys = {'Banana','Apple','Pear'}
local values = {5, 3, 4}
local kv_paired = table.from_pairs(keys, values) -->> {Banana: 5, Apple: 3, Pear: 4}
table.display(kv_paired) -->> banana:5 apple:3 pear:4

local zipped = table.zip(array1,array2) -->> merges array1 and array2 into 1 table called zipped (works with any amount of arrays)
--table.display(zipped) -->> hey there, 2, part 2!,  , 3.14, 7, wow
table.display(table.numbers(zipped)) --returns an array with all numbers in zipped >> 3.14, 7, 2
table.display(table.reverse(zipped)) --wow, 7, 3.14, part 2!, 2, hey there

--python-like classes
class 'Animal_Class' {
	__init__ = function (self)
		self.planet = 'earth'
		print ('planet is set')
	end,
	dog = function (self)
		print ('i am a dog. i live on '..self.planet)
	end
} --global variable Animal_Class will load class

Animal = new { Animal_Class } {}; -->> planet is set
Animal.dog () -->> i am a dog. i live on earth

--range() from python
joe, bob, jordan = range(3)
print(joe, bob, jordan) -->> 1 2 3

local my_num_tab = {1, 2, 3, 4}

for _,v in reversed(my_num_tab) do 
	print(v)
end -->> 4 3 2 1
--]]

if crystal.findpkg('crystal+') then --check if pkg is installed
  _C:dump() --dump cache
end
