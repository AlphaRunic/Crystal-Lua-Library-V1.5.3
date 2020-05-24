local m,s,t,smt = math,string,table,setmetatable

function mod()

  local packages = { };

  local accepted = {math = 'math', string = 'string', table = 'table',spring = 'spring',rotation = 'rotation',random = 'random',class = 'class',['crystal+'] = 'crystal+'}

  import = function(...)
  
    local pkgList = { ... };
    assert(pkgList~=nil and #pkgList >= 1 and type(pkgList) == 'table','Provided package list is not a table.');
    local lastPkg = pkgList[#pkgList];
    
    for i,pkgName in pairs(pkgList) do

      packages[pkgName] = pkgName;
      assert(pkgName~=nil and type(pkgName) == 'string' and accepted[pkgName] ~= nil, 'Package name '..pkgName..' invalid. ');

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
          display = function(t) for i,v in pairs(t) do if i == nil then i = 'nil' elseif v == nil then v = 'nil' end print(tostring(i)..' : '..tostring(v)) end end,
          removeall = function(t) for i = 1,#t do t.remove(t,i) end end,

        }

      elseif pkgName == 'string' then

        string = {

          byte = s.byte,
          char = s.char,
          find = s.find,
          format = s.format,
          match = s.match,
          len = s.len,
          sub = s.sub,
          gsub = s.gsub,
          split = s.split,
          lower = s.lower,
          upper = s.upper,
          reverse = s.reverse,
          rep = s.rep,

        }

      elseif pkgName == 'spring' then

        local Spring = {}
        local ITERATIONS	= 8

        function Spring.new(self, mass, force, damping, speed)
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

      elseif pkgName == 'rotation' then

        Rotation = {
          new = function(rx,ry,rz)
            assert(type(rx) and type(ry) and type(rz) == 'number', 'Invalid parameters.')
            return CFrame.Angles(math.rad(ry),math.rad(rz),math.rad(rx))
          end,
          deg = function(rot)
            assert(rot~=nil, 'Invalid rotation CFrame provided.')
            return CFrame.Angles(math.deg(rot.x),math.deg(rot.y),math.deg(rot.z))
          end
        }

      elseif pkgName == 'random' then

        Random = {
          new = function(seed)
            local self = {}
            if seed then
              math.randomseed(seed)
            end
            self.next = function(n0,n1)
              return math.random(n0,n1)
            end
            return smt(self,Random)
          end,
          percent = function(perc)
            perc = perc or 1
            m.randomseed(os.time())
            min,max = 1,perc
            local r = m.random(min,max)
            return r > perc/2
          end,
        }

      elseif pkgName == 'class' then

        Class = {
          new = function(name,info)
            local newClass = {}
            assert(info ~= nil and type(info) == 'table','Invalid info table.')
            newClass.Name = name or 'NewClass'
            newClass.Info = info
            for i,v in pairs(newClass.Info) do
              newClass[i] = v
            end
            newClass.edit = function(new_mtd)
              assert(type(new_mtd) == 'table' and new_mtd ~= nil, 'Invalid info table.')
              newClass.Info = new_mtd;
            end
            return smt(newClass,Class)
          end
        };

      elseif pkgName == 'crystal+' then

        _CAUTHOR = "Ruunic"

        _CVERIFY = function()
          if _CAUTHOR == "Ruunic" then
            return true
          end
          return false,error('Verification failed: Author modified')
        end
        _CVERIFY()

        _C = {} --crystal cache
        function _C.dump()
          for i = 1,#_C do
            if type(t[i]) == 'function' then return end
            table.remove(t,i)
          end
        end

      end
    end

    local s = ""
    for _,v in pairs(packages) do
      if v == lastPkg then
        s = s..packages[v]
      else
        s = s..packages[v]..', '
      end
    end
    print('Packages [ '..s..' ] imported from Crystal.')
    if s.find(s,'crystal+') then
      _CVERIFY()
      print(memory..' KB',_CVERSION..' by '.._CAUTHOR)
    else
      print(memory..' KB',_CVERSION)
    end
  end
  crystal.packages = packages;
end

return mod