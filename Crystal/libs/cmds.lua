local m,s,t,smt = math,string,table,setmetatable;
local echo_color = ''
local end_quote = ''
local valid_cmds = {
	echo = function(args)
		local str_to_print = '';
		for i, arg in pairs(args) do
			if i == #args then str_to_print = str_to_print..arg else
				str_to_print = str_to_print..arg..' '
			end
		end
		os.execute('echo '..echo_color..str_to_print..end_quote); --turns table args into tuple so it will print all vals in args
	end,
	clean = function(args)
		local mem_before = memory()
		collectgarbage(); --collect
		local mem_now = memory()
		local garbage_collected = mem_before - mem_now
		print('Collected '..m.floor(garbage_collected)..' KB of garbage.');
	end,
	cls = function(args)
		os.execute('clear ');
	end,
	exe = function(args)
		dofile(args[1]);
	end,
	['lua-ex'] = function(args)
		local str_to_load = '';
		for _, arg in pairs(args) do
			str_to_load = str_to_load..arg..' ';
		end
		loadstring(str_to_load)();
	end,
	exit = function(args)
		Sys.exit = true;
	end,
	color = function(args)
		echo_color = '\"\\e\['..args[1]..'m';
		end_quote = '\"'
	end
}

local function read_cmd(command, args)
	if valid_cmds[command] == nil then return false, error('Invalid command! got: '..command) end
	valid_cmds[command](args)
end

local cmd = {
	read = read_cmd;
}

return cmd;