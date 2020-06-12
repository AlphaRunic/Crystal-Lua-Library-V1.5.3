local crys_mt = {};
crys_mt.__index = crys_mt

local m,t,s,smt = math,table,string,setmetatable

return function(environment) --initiate

  crystal = {
		packages = { },
		version = 'Crystal v.1.6.8 Alpha'
	}; --crystal.packages

  local importerMem = require('Crystal.importer')(enviroment); --global import(...) function

  getseed = function() --used for math.randomseed() and Random.new()
    return os.time() * 2
  end

  randomize = function()
    return math.randomseed(getseed())
  end

  sleep = function(n) --delays for n seconds and returns delta time 
    if not n then n = 0 end
    local beforeWait = os.time()
    os.execute('sleep '..tonumber(n))
    local dt = (os.time()-beforeWait)-n
    return dt
  end

  yield = function(condition) --stops script until condition is met (infinite yield possible)
    repeat sleep() until condition
  end

  scope = function(fn,dlt) --pcalls fn with delay time dlt (or 0) within a new scope
    if not dlt then dlt = 0 end
    local s do
      sleep(dlt)
      s=coroutine.wrap(fn)
    end
    return s
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
  end

  crystal.memory = math.floor(  collectgarbage('count') + importerMem  ); --crystal memory
	crystal.recheckMemory = function()
		return math.floor(collectgarbage('count'))-importerMem
	end

  return setmetatable(crystal, crys_mt)
end