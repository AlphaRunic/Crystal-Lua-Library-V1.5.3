--#  1409 lines of code as of right now

local CRYS_VERSION = '1.5.2';
local CRYS_STAGE = 'Beta Testing';

__ = {};

local crys_mt = {__index = __};
local crys_env = getfenv();

local m,t,s,smt = math,table,string,setmetatable;

__._VERSION = 'Crystal.Lua v'..CRYS_VERSION..' '..CRYS_STAGE;
__._GIT = 'https://github.com/AlphaRunic/Crystal.Lua';
__._DESCRIPTION = 'A feature-rich modified version of Lua with a package manager.';

return coroutine.wrap( function ( settings ) --initiate

  _G['crystal'] = {
		packages = { },
		version = __._VERSION,
		author = 'Riley "Runic" Peel',
		git = __._GIT,
		settings = settings,
		findpkg = function(pkg)
			local found_pkg = false
			for i,v in pairs ( crystal.packages ) do 
				if i == pkg or v == pkg then found_pkg = true break end
			end return found_pkg
		end;
	};

  local imported = require('Crystal.importer') ( settings ); --global import(...) function with all library data

	function rand(x,r)
		return m.random(x,r)
	end

	warn = function(msg)
		if settings.warnings then
			assert(type(msg) == 'string', 'Message is not a string.')
			print('[Crystal Warning]  ::  '..msg)
		else
			error('Warnings are disabled.')
		end
	end

	now = os.time

  getseed = function() --used for math.randomseed and Random.new
    return now() ^ 2
  end

	vardump = function(v)
		return {
			type=type(v),
			value=v
		}
	end

  randomize = function()
    return m.randomseed(getseed())
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

  scope = function(fn,dlt) --wraps fn with coroutine with a delay time dlt (or 0) within a new scope
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

	pcall = function(fn)
		return pcall(fn), debug.traceback()
	end

	gencode = function(len, characters)
		randomize()
		characters = characters or 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890'
		len = len or 6
		if not crystal.findpkg('string') then import('string') end
		local allchars = string.separate(characters)
		local result = ''
		for i = 1,len do
			result = result..allchars[m.random(1,#allchars)]
		end
		randomize()
		return result
	end

	new = function ( instance )
		assert(
			type(instance) == 'table',
			'cannot create new object with type \"'..type(instance)..'\".'
		);
		return instance.new;
	end

	memory = function()
		return m.floor( collectgarbage('count') + .5 * 102.4 );
	end
  crystal.memory = memory() --crystal memory
	crystal.recheckMemory = memory

  return smt(crystal, crys_mt)
end), crys_mt