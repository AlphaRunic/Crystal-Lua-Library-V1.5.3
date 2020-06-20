local m,s,t,smt = math,string,table,setmetatable
return {

						--functions
						deg = m.deg,
						rad = m.rad,
						ceil = m.ceil,
						floor = m.floor,
						sin = m.sin,
						sinh = m.sinh,
						cos = m.cos,
						cosh = m.cosh,
						tan = m.tan,
						tanh = m.tanh,
						asin = m.asin,
						acos = m.acos,
						atan = m.atan,
						atan2 = m.atan2,
						mod = m.fmod,
						inf = m.huge,
						huge = m.huge,
						log = m.log,
						log10 = m.log10,
						max = m.max,
						min = m.min,
						randomseed = m.randomseed,
						csc = function(x) if not x then return end return 1/m.sin(x) end,
						csch = function(x) if not x then return end return 1/m.sinh(x) end,
						sec = function(x) if not x then return end return 1/m.cos(x) end,
						sech = function(x) if not x then return end return 1/m.cosh(x) end,
						cot = function(x) if not x then return end return 1/m.tan(x) end,
						coth = function(x) if not x then return end return 1/m.tanh(x) end,
						acsc = function(x) if not x then return end return 1/m.asin(x) end,
						asec = function(x) if not x then return end return 1/m.acos(x) end,
						acot = function(x) if not x then return end return 1/m.atan(x) end,
						acot2 = function(y,x) if not x or y then return end return 1/m.atan2(y,x) end,
						rt = function(x,r) if not x then return end if not r then r = 2 end return m.pow(x,1/r) end,
						sq = function(x) if not x then return end return x^2 end,
						cb = function(x) if not x then return end return x^3 end,
						expo = function(x) if not x then return end return x^x end,
						cbrt = function(x) if not x then return end return m.pow(x,1/3) end,
						sqrt = function(x) if not x then return end return m.sqrt(x) end,
						pow = function(x,y) if not x or y then return end return m.pow(x,y) end,
						exp = function(x) if not x then return end return m.exp(x) end,
						abs = function(x) if not x then return end return m.abs(x) end,
						random = function(x,y) if not x or y then return end return m.random(x,y) end,
						lerp = function(a,b,t) if not a or b then return end if not t then t = 1 end return a + (b - a) * t end,
						smooth = function(x,t) if not x then return end if not t then t = 1 end return x / ((math.e*t)/(2+1/3)) end,
						format = function(n, d)
							local function comma_value(amount)
								local formatted = amount
								while true do  
									formatted, k = s.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
									if (k==0) then
										break
									end
								end
								return formatted
							end
							local function round(val, decimal)
								if (decimal) then
									return m.floor( (val * 10^decimal) + 0.5) / (10^decimal)
								else
									return m.floor(val+0.5)
								end
							end
							function format_num(amount, decimal, prefix, neg_prefix)
								local str_amount,  formatted, famount, remain

								decimal = decimal or 0  -- default 2 decimal places
								neg_prefix = neg_prefix or "-" -- default negative sign

								famount = m.abs(round(amount,decimal))
								famount = m.floor(famount)

								remain = round(m.abs(amount) - famount, decimal)

											-- comma to separate the thousands
								formatted = comma_value(famount)

											-- attach the decimal portion
								if (decimal > 0) then
									remain = s.sub(tostring(remain),3)
									formatted = formatted .. "." .. remain ..
															s.rep("0", decimal - s.len(remain))
								end

											-- attach prefix string e.g '$' 
								formatted = (prefix or "") .. formatted 

											-- if value is negative then format accordingly
								if (amount<0) then
									if (neg_prefix=="()") then
										formatted = "("..formatted ..")"
									else
										formatted = neg_prefix .. formatted 
									end
								end

								return formatted
							end

							return format_num(n, d)
						end,
						round = function(val, decimal)
							if (decimal) then
								return m.floor( (val * 10^decimal) + 0.5) / (10^decimal)
							else
								return m.floor(val+0.5)
							end
						end,
						hypot = function(base, height) return base^2+height^2 end,
						fact = function(n)
							if (n == 0) then
								return 1
							else
								return n * math.fact(n - 1)
							end
						end,
						--constants
						e = m.exp(1),
						phi = 1.61803398874989484820,
						deli = m.pow(2,1/3),
						epsilon = .00001,
						pi = m.pi,
						pyth = m.sqrt(2),
						thed = m.sqrt(3),
						frtf = m.pow(5,1/4),
						em = .57721566490153286060,
						gelf = 23.1406926327792690057,

					}