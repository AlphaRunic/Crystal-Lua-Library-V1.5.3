local m,s,t,smt = math,string,table,setmetatable

return function(settings)

	local defsettings = {
		displayStats = true,
	};
	
	settings = settings or defsettings;
	if settings == {} then settings = defsettings end;

  local packages = { };

  local accepted = {

    math = 'math',
    string = 'string',
    table = 'table',
    random = 'random',
    color = 'color',
    tokenizer = 'tokenizer',
		lua_py = 'lua_py',
    ['crystal.rbx'] = 'crystal.rbx',
    ['crystal+'] = 'crystal+'
		
  } --valid packages

  import = function(...)
  
    local pkgList = { ... };
    assert(#pkgList >= 1, 'Provided package list is empty.');    

    for pkgNum, pkgName in pairs(pkgList) do

			pkgName = s.lower(pkgName)
			local skip
			if crystal.findpkg(pkgName) then
				warn('Package "'..pkgName..'" is already installed.')
				t.remove(pkgList, pkgNum)
				skip = true
			end
			
			if not skip then
				assert(accepted[pkgName] ~= nil, 'Package name "'..pkgName..'" is invalid. ');

				packages[pkgNum] = pkgName;

				--all library data!
				if pkgName == 'math' then

					math = {

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
									formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
									if (k==0) then
										break
									end
								end
								return formatted
							end
							local function round(val, decimal)
								if (decimal) then
									return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
								else
									return math.floor(val+0.5)
								end
							end
							function format_num(amount, decimal, prefix, neg_prefix)
								local str_amount,  formatted, famount, remain

								decimal = decimal or 0  -- default 2 decimal places
								neg_prefix = neg_prefix or "-" -- default negative sign

								famount = math.abs(round(amount,decimal))
								famount = math.floor(famount)

								remain = round(math.abs(amount) - famount, decimal)

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

				elseif pkgName == 'table' then

					table = {
						
						concat = t.concat,
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
						end,
						random = function(t, min, max)
							min, max = min or 1, max or #t
							local rnum = m.random(min, max)
							local n = 0
							local rval
							for i,v in pairs(t) do
								n = n + 1
								if n == rnum then
									return rval == v, n == 0
								end
							end
							return rval
						end,
						find = function(t, key)
							for index, value in pairs(t) do
								if key == index or value then
									return true
								end
							end
							return false
						end,

					}

				elseif pkgName == 'string' then

					string = {

						byte = s.byte,
						char = s.char,
						find = s.find,
						format = s.format,
						match = s.match,
						gmatch = s.gmatch,
						len = s.len,
						sub = s.sub,
						gsub = s.gsub,
						join = function(list, delimiter)
							local len = getn(list)
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

							if init <= strlen(str) then
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
						lower = s.lower,
						upper = s.upper,
						reverse = s.reverse,
						rep = s.rep,
						sum = function(t)
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = result + v
								end
							end
							return result
						end,
						sub = function()
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = result - v
								end
							end
							return result
						end,
						mult = function(t)
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = result * v
								end
							end
							return result
						end,
						div = function(t)
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
						exp = function(t)
							local result = 0
							for _, v in pairs(t) do
								if type(v) == 'number' then
									result = result ^ v
								end
							end
							return result
						end

					}

				elseif pkgName == 'tokenizer' then

					local find = function(t, key)
						for index, value in pairs(t) do
							if key == index or value then
								return true
							end
						end
						return false
					end

					if not find(crystal.packages, 'string') then
						import('string')
					end
				
					Tokens = {};
					Tokenizer = {

						add = function(phrase, tokenname)
							tokenname = tostring(tokenname)
							local Token = {phrase = phrase, name = tokenname}
							Tokens[tokenname] = phrase
							return smt(Token, Tokenizer)
						end,
						remove = function(tokenname)
							if Tokens[tokenname] ~= nil then
								Tokens[tokenname] = nil
							end
						end,
						sfind = function(text, token, split)
							assert(text ~= nil and token ~= nil and type(text) == 'string' and type(token) == 'string', 'Text or token not found or invalid.')
							local amount = 0
							if split then
								for _, char in pairs(string.separate(Tokens[token])) do
									for tokenFound in s.gmatch(text, char) do
										amount = amount + 1
									end
								end
							else
								for tokenFound in s.gmatch(text, Tokens[token]) do
									amount = amount + 1
								end
							end
							return amount
						end

					}

				elseif pkgName == 'random' then

					Random = {
						new = function(seed)
							local self = {}

							if not seed then
								seed = randomize()
							end

							self.next = function(n0,n1)
								return m.random(n0, n1)
							end
							self.percent = function(perc)
								perc = perc or 1
								local r = m.random(0, perc)
								return r <= perc
							end
							self.seed = seed

							return smt(self, Random)
						end,
					}

				elseif pkgName == 'lua_py' then

					Class = function(...)
					
							local args = { ... };
							local name, __init__;
							local methods = {};

							for i,v in pairs(args) do
								if i == 1 then
									name = v
								elseif i == 2 then
									__init__ = v 
								else
									t.insert(methods,#methods+1,v)
								end
							end

							local self = {
								Name = name,
								Methods = methods,
								__init__ = __init__ or function() end
							};

							assert(name ~= nil and type(name) == 'string' or type(name) == 'number' and methods ~= nil and type(methods) == 'table','Invalid methods or name');
							local function setChildren()
								for i,v in pairs(self.Methods) do
									for i,v in pairs(v) do
										self[i] = v
									end
								end
							end
							setChildren();

							return function()
								return self
							end
					end;

					raise = error;

				elseif pkgName == 'color' then

					if not crystal.findpkg('string') then import('string') end

					Color = {

						fromRGB = function(r, g, b)
							local newColor = {
								r = r,
								g = g,
								b = b
							}
							return setmetatable(newColor, Color)
						end,

						fromHex = function(hex)
							local split = string.separate(hex)
							local newColor = {
								byte1 = split[2]..split[3],
								byte2 = split[4]..split[5],
								byte3 = split[6]..split[7]
							}
							return setmetatable(newColor, COlor)
						end,

					}

				elseif pkgName == 'crystal.rbx' then

					local function serv(name)
						return game:GetService(name)
					end
					local function ffcoc(model, childName)
						return model:FindFirstChildOfClass(childName)
					end

					--shorthand vars

					plrs = serv('Players')
					if requirer:IsA('LocalScript') then
						plr = plrs.LocalPlayer
						repeat wait() until plr.character
						chr = plr.character
						pgui = plr.PlayerGui
						backpack = plr.Backpack
						pscripts = plr.PlayerScripts
						toolequipped = function()
							return ffoc(chr, 'Tool')
						end
					end

					ws = workspace
					light = serv('Lighting')
					sound = serv('SoundService')
					db = serv('Debris')
					rs = serv('ReplicatedStorage')
					rf = serv('ReplicatedFirst')
					ss = serv('ServerStorage')
					sss = serv('ServerScriptService')
					as = serv('ContextActionService')
					rt = serv('RunService')
					uis = serv('UserInputService')
					ts = serv('TweenService')

					Animator = {}
					Animator.__index = Animator
					function Animator:NewRig(Model)

						local Rig = {} do
							local Loader = ffcoc(Model, 'AnimationController') or ffcoc(Model, 'Humanoid')
							Rig.AnimationFolder = nil
							Rig.Animations = {}

							function Rig:Animate(anim, animFolder)
								animFolder = Rig.Animations or animFolder or Model
								Anim = Loader:LoadAnimation(animFolder[anim])
								Anim:Play()
								Rig.Animations[#Rig.Animations+1] = anim
								return Anim, Rig.Animations
							end

							function Rig:StopAnimations()
								for _, Anim in pairs(Rig.Animations) do
									Anim:Stop()
								end
								return Anim
							end
						end

						return smt(Rig, Animator), Loader
					end

					function twn(o, i, g)
						local t = ts:create(o,i,g)
						t:play()
						return t
					end

					VectorToUDim = function(vector2,conversionType)

						if conversionType == 'Scale' or 'scale' or 's' or 'S' then
							return UDim2.new(vector2.x,0,vector2.y,0)
						else
							return UDim2.new(0,vector2.x,0,vector2.y,0)
						end

					end

					Rotation = {

						new = function(rx,ry,rz)
							assert(type(rx) and type(ry) and type(rz) == 'number', 'Invalid parameters.')
							return CFrame.Angles(math.rad(ry),math.rad(rz),math.rad(rx))
						end,

						rad = function(rot)
							local i = type(rot)
							assert(rot~=nil and i ~= 'string' and i ~= 'function', 'Invalid rotation CFrame provided.')
							return CFrame.Angles(math.deg(rot.x),math.deg(rot.y),math.deg(rot.z))
						end

					}

					Spring = {
						new = function(self, mass, force, damping, speed, itr)
							local ITERATION	= itr or 8
							local spring	= {
								Target		= Vector3.new();
								Position	= Vector3.new();
								Velocity	= Vector3.new();
								
								Mass		= mass or 5;
								Force		= force or 50;
								Damping		= damping or 4;
								Speed		= speed  or 4;
							}
							
							function spring.shove(self, force)
								local x, y, z	= force.X, force.Y, force.Z
								if x ~= x or x == math.huge or x == -math.huge then
									x	= 0
								end
								if y ~= y or y == math.huge or y == -math.huge then
									y	= 0
								end
								if z ~= z or z == math.huge or z == -math.huge then
									z	= 0
								end
								self.Velocity	= self.Velocity + Vector3.new(x, y, z)
							end
							
							function spring.update(self, dt)
								local scaledDeltaTime = math.min(dt,1) * self.Speed / ITERATIONS
								
								for i = 1, ITERATIONS do
									local force			= self.Target - self.Position
									local acceleration	= (force * self.Force) / self.Mass
									
									acceleration		= acceleration - self.Velocity * self.Damping
									
									self.Velocity	= self.Velocity + acceleration * scaledDeltaTime
									self.Position	= self.Position + self.Velocity * scaledDeltaTime
								end
								
								return self.Position
							end
							return spring
						end
					}

					setTime = function(time)

						local clockDigits = {1,2,3,4,5,6,7,8,9,10,11,12}
						
						if not time then time = 'nil' end
						local times = string.split(tostring(time), ':')
						if times[1] == nil then times[1] = '12' end
						if times[2] == nil then times[2] = '00' end
						if times[3] == nil then times[3] = '00' end

						light.TimeOfDay = times[1]..':'..times[2]..':'..time[3]
					end

					v3 = Vector3.new
					cf = CFrame.new
					ang = CFrame.Angles
					v2 = Vector2.new
					ud = VectorToUDim
					twninf = TweenInfo.new

					explode = function(part, blastPressure, radius)

						local explosion = Instance.new('Explosion')
						local p0 = part
						local p1 = part:clone()
						p1.Transparency = 1
						p1.CanCollide = false
						explosion.BlastPressure = blastPressure or explosion.BlastPressure
						explosion.Radius = radius or explosion.Radius
						explosion.Parent = p1
						destroy(p0)
						yield(explosion == nil)
						destroy(p1)

					end

				elseif pkgName == 'crystal+' then

					if not crystal.findpkg('string') then import('string') end

					local accepted_authors = {

						Runic = true,
						Ruunic = true,
						RUNIC = true,
						RUUNIC = true,
						['Riley Peel'] = true

					}

					crystal.verify = function()
						local hits, misses = 0, 0
						local prev
						for v, _ in pairs(accepted_authors) do
							for _, split in pairs(string.split(v, ' ')) do
								if s.find(crystal.author, split) then
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

					module = {

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

					_C = {

						[1] = crystal.packages,
						[2] = settings,
						[3] = mt,

						dump = function()
							local cleared = #_C
							for i = 1,#_C do
								if not i == 'dump' then
									--print('removed '..tostring(_C[i]))
									t.remove(_C,i)
								end
							end
							if settings.displayStats then
								print('\nCleared '..cleared..' items from Crystal cache. Memory now: '..m.floor(collectgarbage('count')+crystal.memory/1.1)..' KB\n')
							end
						end

					} --crystal cache

				end
			end
    end

		if settings.displayStats then

			local s = ''
			local count = 0

			for i,v in pairs(packages) do
				count = count + 1
				local lastPkg = packages[#packages];
				if v == lastPkg then
					s = s..v
				else
					s = s..v..', '
				end
			end

			local mem = math.floor( collectgarbage('count') );
			print(count..' packages imported from Crystal. \n[ '..s..' ]')

			if crystal.findpkg('crystal+') then
				local v
				local ver = crystal.verified
				if ver then
					v = 'yes'
				else
					v = 'no'
				end
				print(m.floor(crystal.memory+mem)..' KB'..' '..crystal.version..' by Runic | Verified: '..v..'\n')
			else
				print(m.floor(crystal.memory+mem)..' KB'..' '..crystal.version..'\n')
			end

		end

  end
	
  crystal.packages = packages;

  return mt, crystal.packages;
end