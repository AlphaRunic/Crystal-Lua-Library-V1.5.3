local m,s,t,smt = math,string,table,setmetatable
if not crystal.findpkg('string') then import('string') end
				
					_G['Tokens'] = {};

return {

						add = function(phrase, tokenname)
							tokenname = tostring(tokenname)
							local Token = {phrase = phrase, name = tokenname}
							Tokens[tokenname] = phrase
							return smt(Token, Tokenizer)
						end,
						remove = function(tokenname)
							if Tokens[tokenname] ~= nil then
								Tokens[tokenname] = nil
							end
						end,
						sfind = function(text, token, split)
							assert(text ~= nil and token ~= nil and type(text) == 'string' and type(token) == 'string', 'Text or token not found or invalid.')
							local amount = 0
							if split then
								for _, char in pairs(string.separate(Tokens[token])) do
									for tokenFound in s.gmatch(text, char) do
										amount = amount + 1
									end
								end
							else
								for tokenFound in s.gmatch(text, Tokens[token]) do
									amount = amount + 1
								end
							end
							return amount
						end

					}