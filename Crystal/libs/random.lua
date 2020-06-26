local m,s,t,smt= math,string,table,setmetatable
--[[local rand = function (x,r)
	return m.random(x,r)
end--]]
local function round (num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
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
									perc = perc/100 or .5
									local r = rand(0,1)
									r = round( r, 2 )
									return r >= perc
								end,
								seed=seed
							}, Random)
							
						end,
					}