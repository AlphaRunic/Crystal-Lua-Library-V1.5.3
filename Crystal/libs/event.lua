local m,s,t,smt = math,string,table,setmetatable
return		{
						new = function(name)
							local self = {}
							local Connected = {}
							function self:Fire(...)
								for _, ScriptConnection in pairs(Connected) do
									ScriptConnection(...)
								end
							end
							function self:Connect(fn)
								local ScriptConnection = {}
								local ConnectionNumber = #Connected + 1
								Connected[ConnectionNumber] = fn
								function ScriptConnection:Disconnect()
									Connected[ConnectionNumber] = nil
								end
								return smt(ScriptConnection, Event)
							end 
							return smt(self, Event)
						end
					}