local m,s,t,smt = math,string,table,setmetatable

function mod(enviroment)

  local packages = { };

  local accepted = {math = 'math', string = 'string', table = 'table',spring = 'spring',rotation = 'rotation',random = 'random',class = 'class', color = 'color', ['crystal+'] = 'crystal+'} --valid packages

  import = function(...)
  
    local pkgList = { ... };
    assert(pkgList~=nil and #pkgList >= 1 and type(pkgList) == 'table','Provided package list is not a table or is empty.');
    local lastPkg = pkgList[#pkgList];
    
    for i,pkgName in pairs(pkgList) do

      packages[pkgName] = pkgName;
      assert(pkgName~=nil and type(pkgName) == 'string' and accepted[pkgName] ~= nil, 'Package name '..pkgName..' is invalid. ');

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
            if s.find("", delimiter, 1) then -- this would result in endless loops
                error("Delimiter is empty string! Use string.separate.")
            end
            while 1 do
                local first, last = strfind(text, delimiter, pos)
                if first then -- found?
                  tinsert(list, strsub(text, pos, first-1))
                  pos = last+1
                else
                  tinsert(list, strsub(text, pos))
                  break
                end
            end
            return list
          end,
          separate = function(s)
            local result = {};
            for match in s:gmatch("%S") do
                table.insert(result, match);
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
                local s,e = strfind(str, sep, init, true)
                if not s then
                  break
                end
                r[#r+1] = strsub(str, init, s - 1)
                init = e + 1
                n = n + 1
                if n == limit - 1 then
                  break
                end
            end

            if init <= strlen(str) then
                r[#r+1] = strsub(str, init)
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
          lower = s.lower,
          upper = s.upper,
          reverse = s.reverse,
          rep = s.rep,

        }

      elseif pkgName == 'spring' then

        Spring = {}
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
              randomize()
            end

            self.next = function(n0,n1)
              return m.random(n0, n1)
            end
            self.percent = function(perc)
              perc = perc or 1
              local r = m.random(0, perc)
              return r <= perc
            end

            return smt(self, Random)
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

      elseif pkgName == 'color' then

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
            local split = string.split(hex, '')
            local newColor = {
              byte1 = split[2]..split[3],
              byte2 = split[4]..split[5],
              byte3 = split[6]..split[7]
            }
            return setmetatable(newColor, COlor)
          end,
        }

      elseif pkgName == 'crystal+' then

        crystal.author = "Ruunic"

        crystal.verify = function()
          if crystal.author == "Ruunic" or "ruunic" or "runic" or "Runic" or "RUUNIC" or "RUNIC" then
            return true
          end
          return false, error('Verification failed: Author modified')
        end
        crystal.verified = crystal.verify()

        module = {
            new = function(name,source)
              local self = {}
              self.name = name
              self.source = source
              self.execute = function(...)
                source(...)
              end
              return smt(self,module)
            end
          }

        _C = {} --crystal cache
        t.insert(_C,#_C+1,crystal.packages);
        t.insert(_C,#_C+1,getmetatable(crystal));
        function _C.dump()
          for i = 1,#_C do
            if i == 'dump' then return end
            t.remove(t,i)
          end
          print('\nCleared '..tostring(#_C)..' items from Crystal cache. Memory now: '..tostring(crystal.memory)..' KB\n')
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
    if crystal.packages['crystal+'] then
      print(crystal.memory..' KB'..' '..crystal.version..' by '..crystal.author..' | Verified: '..tostring(crystal.verified))
      print('\n')
    else
      print(crystal.memory..' KB'..' '..crystal.version)
      print('\n')
    end
  end
  crystal.packages = packages;

  return math.floor( collectgarbage('count') );
end

return mod