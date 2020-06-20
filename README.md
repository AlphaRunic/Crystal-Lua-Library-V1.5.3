# Crystal.Lua v1.5.2 Beta Testing
## by: Riley "Alpha Runic" Peel

### Usage

- Requiring module |
`local crystal = require('Crystal.crystal')(
	{
		displayStats = true,
		warnings = true
	}
)`

- Importing packages |
`import ('package1', 'package2')` OR `import 'package'`

### Packages

- string (extra features)
  - `join { string: delimiter, tuple: strings }` | returns a string with delimiter between each string in strings
  - `split { string: to_split, string: delimiter }` | returns a table with elements of string split by delimiter
  - `separate { string: to_sep }` | returns a table with elements of string split by each character
  - `explode { string: delimiter, string: to_exp, int: limit }` | string.split with a limit of how many times it will split
  - `gsplit { string: to_split, string: delimiter }` | returns an iterator for each element in split table
  - `csplit { string: to_split, char: delimiter }` | string.split with a character instead of whole word
  - `center { string: to_center, int: spaces }` | returns a string in between the number of spaces specified
  - `bytes { string: for_bytes }` | returns a table with the byte of each character in string
  - `each_byte { string: for_bytes, void: callback }` | executes callback for each byte in string
  - `each_char { string: for_char, void: callback }` | executes callback for each character in string
  - `starts_with { string: for_sw, string: check_for }` | returns true if string starts with check_for
  - `ends_with { string: for_ew, string: check_for }` | returns true if string ends with check_for
  - `trim { string: to_trim }` | returns string to_trim without trailing or leading whitespaces
  - `truncate { string: to_trunc, int: size }` | returns the first "size" amount of characters in string
- math (extra features [constants not listed]) 
  - `csc { num: x }` | returns 1/sinx
  - `sec { num: x }` | returns 1/cosx
  - `cot { num: x }` | returns 1/tanx
  - `csch { num: x }` | returns 1/sinhx
  - `sech { num: x }` | returns 1/coshx
  - `coth { num: x }` | returns 1/tanhx
  - `acsc { num: x }` | returns 1/asinx
  - `asec { num: x }` | returns 1/acosx
  - `acot { num: x }` | returns 1/atanx
  - `acot2 { num: y, num: x }` | returns 1/atan2(y,x)
  - `sq { num: x }` | returns x^2
  - `cb { num: x }` | returns x^3
  - `expo { num: x }` | returns x^x
  - `cbrt { num: x }` | returns cube root of x
  - `lerp { num: a, num: b, num: alpha }` | returns a + (b - a) * alpha
  - `smooth { num: x, num: factor }` | smooths x by factor
  - `format { num: x }` | returns a string with comma separators (i.e. 1000 -> 1,000)
  - `round { num: x, num: decimal }` | rounds x to decimal or nearest whole
  - `hypot { num: x, num: y }` | returns the hypotenuse of a triangle with given side lengths of x and y
  - `fact { num: x }` | returns !x (factorial x) 
- table (extra features)
  - `strings { tab: t }` | returns a new table with all strings of t
  - `numbers { tab: t }` | returns a new table with all numbers of t 
  - `zip { tuple: tables }` | returns a new table with all values of every table given in it
  - `unzip_by { tab: zipped_tab, tuple tab: to_unzip }` | returns a new table with all values of to_unzip removed from zipped_tab
  - `intersect { tab: t, tuple tab: to_intersect }` | returns a new table with all values of to_intersect appended to t but removes duplicate values
  - `len { tab: t }` | returns length of t
  - `swap { tab: t, int: pos1, int: pos2}` | swaps value of pos1 with pos2
  - `display { tab: t }` | prints each element of t in format "index : value"
  - `empty { tab: t }` | removes all values of t 
  - `random { tab: t, int: min, int: max }` | returns a random value of table in between index min and max (default 1 and the length of t)
  - `findi { tab: t, any: key }` | returns true if key is an index or value of t, else returns false
  - `reverse { tab: t }` | returns t reversed
  - `sum { tab: t }` | returns the sum of all numbers in t
  - `diff { tab: t }` | returns the difference of all numbers in t
  - `prod { tab: t }` | returns the product of all numbers in t
  - `quot { tab: t }` | returns the quotient of all numbers in t
  - `mod { tab: t }` | returns the modulo of all numbers in t
  - `pow { tab: t }` | returns the exponentiality of all numbers in t
  - `mean { tab: t }` | returns the mean of all numbers in t
  - `median { tab: t }` | returns the median of all numbers (sorted) in t
  - `min { tab: t }` | returns the minimum value of t
  - `max { tab: t }` | returns the maximum value of t
  - `distinct { tab: t }` | removes all duplicates in t
  - `fill { tab: t, any: value, string or num: start_index, string or num: end_index }` | fills t from start_index to end_index with value
  - `first { tab: t }` | returns the first value of t
  - `last { tab: t }` | returns the last value of t
  - `from_pairs { tab: t0, tab: t1 }` |  returns key:value table from keys t0 and values t1
  - `reverse_each { tab: t, void: callback }` | executes callback for each value of t in reverse order
  - `slice { tab: t, int: position }` | slices t into two tables from position
  - `pack { any tuple: tuple }` | turns tuple into a table
  - `unpack { tab: t }` | turns t into a tuple
  - `shuffle { tab: t, bool: seed }` | shuffles table with a random seed if bool is true
- Random
  - `new { int: seed }` | creates a new random object with seed of seed, if none provided, defaults to a random seed
    - `next { num: x, num: y }` | returns a random number between x and y with seed of random obj
    - `percent { num: percentage }` | returns true if random number between one and one hundred is less than or equal to percentage with seed of random obj
    - `int seed` | seed of random obj
- lua-py (global)
  - `Class { string: name, tab: objects }` | creates a new class named name with objects objects
  - `raise { string: err }` | raises an error
  - `reversed { tab: t }` | returns iterator that iterates over t reversed
  - `range { int: x }` | returns number tuple of one to x
- Color
  - `fromRGB { int: r, int: g, int: b }` | returns color object
    - `int r` | red
    - `int g` | green
    - `int b` | blue
  - `fromHex { string: hex_code }` |
    - `string byte1` | first hex byte
    - `string byte2` | second hex byte
    - `string byte3` | third hex byte
- Tokenizer
  - `add { string: token, string: alias }` | adds token to token list (Tokens)
  - `remove { string: alias }` | removes token from token list (Tokens)
  - `sfind { string: search_text, string: token_alias, bool: split }` | looks in search_text for token token_alias, splits token into each character if bool is true
- Event
  - `new { string: name }` |  returns a new event with name name
    - `Connect { void: function }` | connects function to event fire sequence, returns new scriptconnection
      - `Disconnect { @none }` | disconnects scriptconnection from event fire sequence
    - `Fire { any tuple: args }` | calls all functions connected to event with arguments args
- Form
  - `new { string tab: questions, string tab: answers }` | returns a new form object
    - `Start { @none }` | reads input for user answers for each question [! yields !]
    - `Eval { @none }` | returns how many answers the user got correct and incorrect -- non case sensitive!
    - `tab Questions` | questions inputted for form object
    - `tab Answers` | answers inputted by user
- Sys (crys-sys)
  - `execute { string: command }` | parses command and executes function connected to it
  - `read_input { @none }` | reads one line of input and interprets it
  - `cmd_console { @none }` | reads lines of input to interpret until command exit is called
  - `clean { @none }` | collects garbage and displays how much is cleared
- crystal+ (global)
  - `object module` | create and execute code wrapped with module
    - `new { string: name, void: source }` | creates new module object with name of name and source of source
      - `execute { @none }` | executes source
  - `crystal.verify { @none }` | verifies author is correct
  - `bool crystal.verified` | true if verified, false if not
  - `object _C` | crystal cache
    - `dump { @none }` | destroys all data in cache
    
### Vanilla Crystal
  - `object crystal` | where crystal data is stored
    - `tab packages` | where packages are stored
    - `string version` | crystal version
    - `string author` | crystal author
    - `string git` | github repo
    - `tab settings` | settings inputted while requiring
    - `findpkg { string: pkg_name }` | returns true if pkg_name is installed
  - `rand { num: x, num: y }` | returns random number between x and y
  - `warn { string: warning }` | outputs a crystal warning with message warning
  - `now { @none }` | returns os.time() (the UNIX epoch)
  - `getseed { @none }` | returns a random seed
  - `vardump { any: variable }` | dumps a variables type and value into an object
  - `randomize { @none }` | uses randomseed with getseed()
  - `sleep { num: n }` | yields for n seconds
  - `yield { condition: cond }` | yields until cond is met
  - `scope { void: function }` | wraps function in a local scope
  - `sequence { void: function, int: iterations, num: wait_time }` | calls function iterations times with wait_time seconds in between, set iterations to inf or 0 for inf loop
  - `pcall { void: function }` | (modified) calls function in protected mode, returns normal pcall vals and debug traceback
  - `gencode { int: length, string: characters }` | generates a pseudo-random string length characters long and using characters of characters
  - `new { object: instance }` | creates a new instance of object
  - `memory { @none }` | returns crystal memory in kb
  - `int crystal.memory` | memory in use by crystal importer and all libraries installed 
