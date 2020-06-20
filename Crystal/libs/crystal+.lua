local m,s,t,smt = math,string,table,setmetatable
--if not crystal.findpkg('string') then import('string') end
					_G['module'] = {

							new = function(name, source)
								local self = {
									name=name,
									source=source,
									execute=function(...)
										source(...)
									end
								}
								return smt(self,module)
							end

						}

					local accepted_authors = {

						Runic = true,
						Ruunic = true,
						RUNIC = true,
						RUUNIC = true,
						['Riley Peel'] = true

					}

					crystal.verify = function()
						local function strfind(str,pat,pos)
							return s.find(str,pat,pos)
						end
						local function split(text, delimiter)
							local list = {}
							local pos = 1
							assert(text ~= '', "Delimiter is empty string! Use string.separate.") -- this would result in endless loops
							while 1 do
									local first, last = strfind(text, delimiter, pos)
									if first then -- found?
										t.insert(list, s.sub(text, pos, first-1))
										pos = last+1
									else
										t.insert(list, s.sub(text, pos))
										break
									end
							end
							return list
						end
						local hits, misses = 0, 0
						local prev
						for v, _ in pairs(accepted_authors) do
							for _, spl in pairs(split(v, ' ')) do
								if s.find(crystal.author, spl) then
									hits = hits + 1
								else
									if not v == s.lower(prev) and prev ~= nil then
										misses = misses + 1
									end
								end
							end
							prev = v
						end

						if hits > misses then 
							return true, hits, misses
						else
							return false, hits, misses
						end
					end
					crystal.verified = crystal.verify()

					_G['_C'] = {

						[1] = crystal.packages,
						[2] = crystal.memory,
						[3] = __,
						[4] = crystal,

						dump = function()
							local cleared = #_C
							for i = 1,#_C do
								if not i == 'dump' then
									--print('removed '..tostring(_C[i]))
									t.remove(_C,i)
								end
							end
							if crystal.settings.displayStats then
								local mem_removed = memory()-crystal.memory
								print('\nCleared '..cleared..' items from Crystal cache. Memory now: '..m.ceil((crystal.memory+mem_removed+(memory()/2.1)))..' KB\n')
							end
						end

					} --crystal cache
					
return crystal.verify, crystal.verified, module, _C