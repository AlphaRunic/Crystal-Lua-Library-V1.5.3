local crys_mt = {};
crys_mt.__index = crys_mt

local m,t,s,smt = math,table,string,setmetatable

function module() --init

  crystal = { packages = { } }; --crystal.packages

  _CVERSION = 'Crystal v.1.5.3 Alpha'

  require'Crystal/importer'(); --global import(...) function

  getseed = function() --used for math.randomseed() and Random.new()
    return math.random(99999999,os.time())
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
      pcall(fn)
    end
    return s
  end

  sequence = function(func,iterations,waitTime) --loops func iterations (or inf) times while waiting waitTime every iteration
    if iterations < math.huge then
      for i = 1,iterations do
        pcall(func)
        if waitTime then
          sleep(waitTime)
        end
        return i
      end
    else
      while true do
        pcall(func)
        if waitTime then
          sleep(waitTime)
        end
      end
    end
  end

  memory = math.floor (  collectgarbage('count')  ); --crystal memory

  return setmetatable(crystal,crys_mt)
end

return module