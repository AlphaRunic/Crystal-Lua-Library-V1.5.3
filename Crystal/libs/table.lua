local m,s,t,smt = math,string,table,setmetatable
table ={
						
						concat = t.concat,
						foreach = t.foreach,
						foreachi = t.foreachi,
						sort = t.sort,
						insert = t.insert,
						remove = t.remove,
						strings = function(t) 
							local strs = {};
							assert(t~=nil and type(t) == 'table','Invalid parameters.')
							for i,v in pairs(t) do
								if type(v) == 'string' then table.insert(strs,#strs+1,v) end
							end
							if #strs < 1 then return false end
							return strs;
						end,
						numbers = function(t)
							local nums = {};
							assert(t~=nil and type(t) == 'table','Invalid parameters.')
							for i,v in pairs(t) do
								if type(v) == 'number' then table.insert(nums,#nums+1,v) end
							end
							if #nums < 1  then return false end
							return nums;
						end,
						zip = function(...)
							local args = {...}
							assert(#args > 1, 'Zip requires 2 or more tables. Provided: '..tostring(#args))
							local zipped = {}
							for i,v in pairs(args) do
								for i,v in pairs(v) do
									t.insert(zipped,#zipped+1,v)
								end
							end
							return zipped
						end,
						unzip_by = function(zipped, ...)
							local args = {...}
							assert(#args > 1, 'Unzip requires 2 or more tables to unzip. Provided: '..tostring(#args))
							local unzipped = {}
							for i,v in pairs(args) do
								for i,v in pairs(v) do
									zipped[i] = nil
								end
							end
							unzipped = zipped
							return unzipped
						end,
						intersect = function(t, ...)
							local args = {...}
							assert(#args>1)
							local intersected = t
							for i,v in pairs(args) do
								for i,v in pairs(v) do
									if not intersected[i] == v then intersected[i] = v end
								end
							end
							return intersected
						end,
						len = function(t)
							return #t
						end,
						swap = function(tab,pos1,pos2)
							local swapped = {}
							assert(tab~=nil and type(tab) == 'table' and table[pos1]~=nil and table[pos2]~=nil,'Missing values or invalid parameters.')
							t.insert(swapped,#swapped+1,tab[pos1])
							t.insert(swapped,#swapped+1,tab[pos2])
							tab[pos2],tab[pos1] = swapped[1],swapped[2]
							t.remove(swapped,1)
							t.remove(swapped,2)
							swapped = nil
							return t
						end,
						display = function(t)
							for i,v in pairs(t) do
								if not i then 
									i = 'nil'
								elseif not v then
									v = 'nil'
								end
								print(tostring(i)..' : '..tostring(v))
							end
						end,
						empty = function(t)
							for i = 1,#t do
								t.remove(t,i)
							end
							return t
						end,
						random = function(t, min, max)
							min, max = min or 1, max or #t
							local rnum = m.random(min, max)
							local n = 0
							local rval
							for i,v in pairs(t) do
								n = n + 1
								if n == rnum then
									rval = v
									n = 0
								end
							end
							return rval
						end,
						findi = function(t, key)
							for index, value in pairs(t) do
								if key == index or value then
									return true
								end
							end
							return false
						end,
						reverse = function(tab)
							local reversed = {}
							local count = 1
							for i = -#tab, 0 do
								reversed[count] = tab[-i]
								count = count + 1
							end
							return reversed
						end,
						sum = function(t)
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = result + v
								end
							end
							return result
						end,
						diff = function()
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = result - v
								end
							end
							return result
						end,
						prod = function(t)
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = result * v
								end
							end
							return result
						end,
						quot = function(t)
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = result / v
								end
							end
							return result
						end,
						mod = function(t)
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = math.floor(result / v) * v
								end
							end
							return result
						end,
						pow = function(t)
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = result ^ v
								end
							end
							return result
						end,
						mean = function(t)
							local sum = table.sum(t)
							return sum / #t
						end,
						median = function(t)
							t = t.sort(t)
							return t[m.floor((#t/2)+.5)]
						end,
						min = function(t)
							local small_to_large = t.sort(t)
							return small_to_large[1]
						end,
						max = function(t)
							local small_to_large = t.sort(t)
							local large_to_small = table.reverse(small_to_large)
							return large_to_small[1]
						end,
						distinct = function(t)
							local distinctified = {}
							for ind,val in pairs(t) do
								if distinctified[ind] == nil then
									distinctified[ind] = val
								end
							end
							return distinctified
						end,
						fill = function(t, val, start_i, end_i)
							for i = start_i, end_i do
								t[i] = val
							end
						end,
						first = function(t)
							local fi,fv
							for i,v in pairs(t) do
								fi = i
								fv = v
								return
							end
							return fi,fv
						end,
						last = function(t)
							local lasti,lastv
							for i,v in pairs(t) do
								lasti = i
								lastv = v
							end
							return lastv,lasti
						end,
						from_pairs = function(t0,t1)
							local res = {}
							for i, k in pairs(t0) do
								res[k] = t1[i]
							end
							return res
						end,
						reverse_each = function(t,fn)
							t = table.reverse(t)
							return table.foreach(t,fn)
						end,
						slice = function(t,p)
							local half1 = {}
							local half2 = {}
							for i,v in pairs(t) do
								if i == p then
									half1[i] = v
								else
									half2[i] = v
								end
							end
							return {half1, half2}
						end,
						pack = function(...)
							return { ... }
						end,
						unpack = function(t)
							return unpack(t)
						end,
						shuffle = function(t, seed)
							if seed then randomize() end
							local _shuffled = {}
							t.foreach(t,function(index,value)
								local randPos = m.floor(m.random()*index)+1
								_shuffled[index] = _shuffled[randPos]
								_shuffled[randPos] = value
							end)
							return _shuffled
						end,
						tostring = function( tbl )
							-- to convert table into string
							local result, done = {}, {}
							for k, v in ipairs( tbl ) do
								table.insert( result, table.val_to_str( v ) )
								done[ k ] = true
							end
							for k, v in pairs( tbl ) do
								if not done[ k ] then
									table.insert( result,
									table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
								end
							end
							return "{" .. table.concat( result, "," ) .. "}"
						end

					}
return table