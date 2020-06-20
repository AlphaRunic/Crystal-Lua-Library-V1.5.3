local m,s,t,smt = math,string,table,setmetatable

return coroutine.wrap( function ( settings )

	local defsettings = {
		displayStats = true,
		warnings = true;
	};
	
	settings = settings or defsettings;
	if settings == {} then settings = defsettings end;

  local packages = { } ;

  local accepted = {

    math = 'math',
    string = 'string',
    table = 'table',
    random = 'random',
    color = 'color',
    tokenizer = 'tokenizer',
		['lua-py'] = 'lua-py',
		event = 'event',
		form = 'form',
		['crys-sys'] = 'crys-sys',
    ['crystal.rbx'] = 'crystal.rbx',
    ['crystal+'] = 'crystal+'
		
  } --valid packages

	local global_package_variables = {
		math = 'math',
		string = 'string',
		table = 'table',
		random = 'Random',
		color = 'Color',
		tokenizer = 'Tokenizer',
		event = 'Event',
		form = 'Form',
		['crys-sys'] = 'Sys',
		['crystal+'] = 'crystal+'
	}

  import = function(...)
  
    local pkgList = { ... };
    assert(#pkgList >= 1, 'Provided package list is empty.');    local LibsFromModules = 0
			local OtherLibs = 0

    for pkgNum, pkgName in pairs ( pkgList ) do

			local skip
			pkgName = s.lower (pkgName)
			if crystal.findpkg (pkgName) then
				warn('Package "'..pkgName..'" is already installed.')
				pkgList[pkgNum] = nil
				skip = true
			end
			
			if not skip then
				assert(
					accepted[pkgName] ~= nil,
					'Package name "'..pkgName..'" is invalid. '
				);

				packages[pkgNum] = pkgName;

				local ModuleExceptions = {
					['crystal.rbx'] = true,
					['lua-py'] = true
				}

				if ModuleExceptions[pkgName] ~= nil then
					OtherLibs = OtherLibs + 1
					--print('internal: '..pkgName)
					if pkgName == 'crystal.rbx' then
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
									if x ~= x or x == m.huge or x == -m.huge then
										x	= 0
									end
									if y ~= y or y == m.huge or y == -m.huge then
										y	= 0
									end
									if z ~= z or z == m.huge or z == -m.huge then
										z	= 0
									end
									self.Velocity	= self.Velocity + Vector3.new(x, y, z)
								end
								
								function spring.update(self, dt)
									local scaledDeltaTime = m.min(dt,1) * self.Speed / ITERATIONS
									
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
							if not crystal.findpkg('string') then import'string' end

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
					elseif pkgName == 'lua-py' then
						Class = {
							new = function(...)
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
											self[i] = v;
										end
									end
								end
								setChildren();

								return function()
									self.__init__();
									return self;
								end;
							end;
						};

						raise = error;
						reversed = function(t)
							local function rev(tab)
								local reversed = {}
								local count = 1
								for i = -#tab, 0 do
									reversed[count] = tab[-i]
									count = count + 1
								end
								return reversed
							end
							return pairs(rev(t))
						end;
						range = function(n)
							local res = {}
							for i = 1,n do 
								res[i] = i
							end
							return unpack(res)
						end
					end;
				else
					LibsFromModules = LibsFromModules + 1
					--print('module: '..pkgName)
					_G[
						global_package_variables[pkgName]
					] = require('Crystal.libs.'..pkgName)
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
			local imported = count..' packages imported from Crystal. '..LibsFromModules..' from libs, '..OtherLibs..' from internal. \n[ '..s..' ]'

			if crystal.findpkg('crystal+') then
				local v
				local ver = crystal.verified
				if ver then
					v = 'yes'
				else
					v = 'no'
				end
				local title_colors = '93m' --yellow
				local effect = '1' --bold
				os.execute('echo \"\\e\['..effect..';'..title_colors..'\"') --change color
				print(_VERSION..'.5') --lua 5.1.5
				print(crystal.version..' by Runic')
				print(crystal.git, '\n')
				print(imported) --packages
				print('[Crystal Memory] '..m.floor(crystal.memory+memory())..' KB','\n')
				--colorprint(title_colors, true, 'Global Crystal features (imported): '..crystal.global_objs(),'\n') *removed global colorprint
			else
				print(_VERSION..'.5')
				print(crystal.version)
				print(crystal.git)
				print('\n')
				print(imported)
				print('Crystal Memory: '..m.floor(crystal.memory+memory())..' KB')
			end

		end

  end
	
  crystal.packages = packages;

  return mt, crystal.packages;
end)