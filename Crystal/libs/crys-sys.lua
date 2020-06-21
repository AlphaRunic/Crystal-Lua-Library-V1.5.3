local m,s,t,smt = math,string,table,setmetatable;
local _cmd_ = require('Crystal.libs.cmds');

--# Sys.execute command handler;
local function read_line(text)
	if not crystal.findpkg 'string' then import 'string' end;
	local cmd_n_params = string.split(text, ' ')

	local cmd = cmd_n_params[1]
	t.remove(cmd_n_params, 1)
	local args = cmd_n_params
	--print('CMD: '..cmd..' | ARGS: '..t.concat(args))

	_cmd_.read(cmd, args)
end

Sys = {
	exit = false,
	execute = function(...)
		local commands = { ... }
		for _, command in pairs(commands) do
			read_line(command)
		end
	end,
	read_input = function()
		if not crystal.findpkg 'string' then import 'string' end;
		local inp = s.lower(io.read())
		local sep = string.separate(inp)
		local function ignore_blank()
			inp = s.lower(io.read())
			sep = string.separate(inp)
			if #sep == 0 then ignore_blank() end
		end
		if #sep == 0 then ignore_blank() end
		read_line(inp)
	end,
	cmd_console = function()
		local function get_cmds()
			if not crystal.findpkg 'string' then import 'string' end;
			local inp = s.lower(io.read())
			local sep = string.separate(inp)
			local function ignore_blank()
				inp = s.lower(io.read())
				sep = string.separate(inp)
				if #sep == 0 then ignore_blank() end
			end
			if #sep == 0 then ignore_blank() end
			read_line(inp)
			if not Sys.exit then
				get_cmds()
			end
		end
		get_cmds()
	end,
	clean = function()
		Sys.execute('clean')
	end
}

return Sys