local crys_mt = {};
crys_mt.__index = crys_mt

local m,t,s,smt = math,table,string,setmetatable

function module()
  crystal = { packages = { } };

  _CVERSION = 'Crystal v.1.5.3 Alpha'

  require'Crystal/importer'()

  getseed = function()
    return math.random(99999999,os.time())
  end

  randomize = function()
    return math.randomseed(getseed())
  end

  sleep = function(n)
    if not n then n = 0 end
    local beforeWait = os.time()
    os.execute('sleep '..tonumber(n))
    return (os.time()-beforeWait)-n
  end

  yield = function(condition)
    repeat sleep() until condition
  end

  scope = function(fn,dlt)
    if not dlt then dlt = 0 end
    local s do
      sleep(dlt)
      pcall(fn)
    end
  end

  sequence = function(func,iterations,waitTime)
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