--# lots of these command only have linux/shell support at the moment

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
		os.execute ('echo '..echo_color..str_to_print..end_quote); --turns table args into tuple so it will print all vals in args, linux/shell only
	end,
	clean = function(args)
		local mem_before = memory();
		collectgarbage (); --collect
		local mem_now = memory();
		local garbage_collected = mem_before - mem_now
		print('Collected '..m.floor(garbage_collected)..' KB of garbage.');
	end,
	cls = function(args)
		os.execute ('clear '); --linx/shell only
	end,
	exe = function(args)
		local file = args[1];
		t.remove(args, 1);
		loadfile ( file ) ( unpack (args) );
		print(a,b);
	end,
	['lua-ex'] = function(args)
		local str_to_load = '';
		for _, arg in pairs (args) do
			str_to_load = str_to_load..arg..' ';
		end
		loadstring (str_to_load) ();
	end,
	exit = function(args)
		Sys.exit = true;
	end,
	color = function(args) --linux/shell only
		echo_color = '\"\\e\['..args[1]..'m';
		end_quote = '\"';
	end,
	ip = function(args) --linux/shell only
		os.execute 'ip a show';
	end,
	cd = function(args)
		local dir = args[1];
		os.execute ('cd '..dir) --finally! any os.
	end,

	crystal = function(args)
		local process = args[1];
		t.remove (args, 1);

		--package manager; crystal install string -->> 1 package installed
		if process == 'install' or process == 'import' or process == 'i' then
			local pkgs = unpack (args)
			import (pkgs)
		end
	end,

	git = function(args)
		local str_to_print = '';
		for i, arg in pairs(args) do
			if i == #args then str_to_print = str_to_print..arg else
				str_to_print = str_to_print..arg..' ';
			end
		end
		os.execute('git '..str_to_print);
	end

	
}

local function read_cmd(command, args)
	local success
	if valid_cmds[command] == nil then success = false else success = true end
	if success then success, err = pcall ( function () valid_cmds[command] (args) end) if not success then print (err) end else
		if crystal.settings.warnings then warn ('Invalid command! got: '..command) else
			print ('Invalid command! got: '..command)
		end
	end
end

local cmd = {
	read = read_cmd;
}

return cmd;