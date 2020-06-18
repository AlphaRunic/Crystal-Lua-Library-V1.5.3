print(_VERSION..'.5')
local crys_mt = {};
crys_mt.__index = crys_mt

local m,t,s,smt = math,table,string,setmetatable

return coroutine.wrap(function(settings) --initiate

  crystal = {
		packages = { },
		version = 'Crystal v.1.9.4 Alpha',
		author = 'Riley "Runic" Peel',
		settings = settings,
		findpkg = function(pkg)
			local found_pkg = false
			for i,v in pairs(crystal.packages) do
				if i == pkg or v == pkg then found_pkg = true break end
			end
			return found_pkg
		end
	}; --crystal.packages

  local imported = require('Crystal.importer')(settings); --global import(...) function

	warn = function(msg)
		assert(type(msg) == 'string', 'Message is not a string.')
		print('[Crystal Warning]  ::  '..msg)
	end

	now = os.time

  getseed = function() --used for math.randomseed and Random.new
    return now() * 2
  end

  randomize = function()
    return math.randomseed(getseed())
  end

  sleep = function(n) --delays for n seconds and returns delta time 
    if not n then n = 0 end
    local beforeWait = now()
    os.execute('sleep '..tonumber(n))
    local dt = (now()-beforeWait)-n
    return n, dt
  end

  yield = function(condition) --stops script until condition is met (infinite yield possible)
    repeat sleep() until condition
		return condition
  end

  scope = function(fn,dlt) --pcalls fn with delay time dlt (or 0) within a new scope
    if not dlt then dlt = 0 end
    local s do
      sleep(dlt)
      s=coroutine.wrap(fn)
    end
    return s, dlt
  end

  sequence = function(func,iterations,waitTime) --loops func iterations (or inf) times while waiting waitTime every iteration
    if iterations < math.huge then
      for i = 1,iterations do
        coroutine.wrap(func)
        if waitTime then
          sleep(waitTime)
        end
      end
    elseif iterations == math.huge or iterations == 0 then
      while true do
        coroutine.wrap(func)
        if waitTime then
          sleep(waitTime)
        end
      end
    end
		return 
  end

	local function getMemory()
		return math.floor( collectgarbage('count') );
	end
  crystal.memory = getMemory() --crystal memory
	crystal.recheckMemory = getMemory

	local mt = setmetatable(crystal, crys_mt)

  return mt
end), crys_mt