local m,s,t,smt= math,string,table,setmetatable
--[[local rand = function (x,r)
	return m.random(x,r)
end--]]
return {
						new = function(seed)

							if seed == nil then
								seed = getseed()
							end
							m.randomseed(seed)

							return smt( {
								next = function(n0,n1)
									return rand(n0,n1)
								end,
								percent = function(perc)
									perc = perc or 50
									local r = rand(1,100)
									return r <= perc
								end,
								seed=seed
							}, Random)
							
						end,
					}