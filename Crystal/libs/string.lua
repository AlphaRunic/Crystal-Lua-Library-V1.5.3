local m,s,t,smt = math,string,table,setmetatable
return {

						byte = s.byte,
						char = s.char,
						find = s.find,
						format = s.format,
						match = s.match,
						gmatch = s.gmatch,
						len = s.len,
						sub = s.sub,
						gsub = s.gsub,
						join = function(delimiter, ...)
							local list = { ... }
							local len = #list
							if len == 0 then
									return "" 
							end
							local st = list[1]
							for i = 2, len do 
									st = st .. delimiter .. list[i] 
							end
							return st
						end,
						split = function(text, delimiter)
							local list = {}
							local pos = 1
							assert(text ~= '', "Delimiter is empty string! Use string.separate.") -- this would result in endless loops
							while 1 do
									local first, last = s.find(text, delimiter, pos)
									if first then -- found?
										t.insert(list, s.sub(text, pos, first-1))
										pos = last+1
									else
										t.insert(list, s.sub(text, pos))
										break
									end
							end
							return list
						end,
						separate = function(s)
							local result = {};
							for match in s:gmatch("%S") do
									t.insert(result, match);
							end
							return result;
						end,
						explode = function(sep, str, limit)
							if not sep or sep == "" then
									return false
							end
							if not str then
									return false
							end
							limit = limit or m.huge
							if limit == 0 or limit == 1 then
									return { str }, 1
							end

							local r = {}
							local n, init = 0, 1

							while true do
									local s,e = s.find(str, sep, init, true)
									if not s then
										break
									end
									r[#r+1] = s.sub(str, init, s - 1)
									init = e + 1
									n = n + 1
									if n == limit - 1 then
										break
									end
							end

							if init <= s.len(str) then
									r[#r+1] = s.sub(str, init)
							else
									r[#r+1] = ""
							end
							n = n + 1

							if limit < 0 then
									for i=n, n + limit + 1, -1 do r[i] = nil end
									n = n + limit
							end

							return r, n
						end,
						gsplit = function(s, sep) --split but with coroutine iterator
							return coroutine.wrap(function()
									if s == '' or sep == '' then
										coroutine.yield(s)
										return
									end
									local lasti = 1
									for v,i in s:gmatch('(.-)'..sep..'()') do
										coroutine.yield(v)
										lasti = i
									end
									coroutine.yield(s:sub(lasti))
							end)
						end,
						csplit = function(str, sep) --split by character
							local ret={}
							local n=1
							for w in str:gmatch("([^"..sep.."]*)") do
									ret[n] = ret[n] or w -- only set once (so the blank after a string is ignored)
									if w=="" then
										n = n + 1
									end -- step forwards on a blank but not a string
							end
							return ret
						end,
						bytes = function(str)
							local bytes = {}
							for i,v in pairs(string.separate(str)) do
								bytes[i] = s.byte(v)
							end
							return bytes
						end,
						lower = s.lower,
						upper = s.upper,
						reverse = s.reverse,
						rep = s.rep,
						center = function(str, spaces)
							local space = ''
							if spaces == 0 then spaces = 1 end
							for i = 1,spaces do
								space = space..' '
							end
							return space..str..space
						end,
						each_byte = function(str, callback)
							for index, byte in pairs(string.bytes(str)) do
								callback ( byte )
							end
						end,
						each_char = function(str, callback)
							for index, char in pairs(string.separate(str)) do
								callback ( char )
							end
						end,
						starts_with = function(str, char)
							if string.separate(str)[1] == char then return true end
							return false
						end,
						ends_with = function(str, char)
							if string.separate(str)[#string.separate(str)] == char then return true end
							return false
						end,
						trim = function(str)
							local trimmed = ''
							local no_ws_split = string.separate(str)
							for i,v in pairs(no_ws_split) do
								trimmed = trimmed..v
							end
							if trimmed == '' then trimmed = str end
							return trimmed
						end,
						truncate = function(str, size)
							local truncated = ''
							local split = string.separate(str)
							for i,v in pairs(split) do
								if i <= size then truncated = truncated..v end
							end
							if truncated == '' then truncated = str end
							return truncated
						end

					}