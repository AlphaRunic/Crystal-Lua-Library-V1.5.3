if not crystal.findpkg('string') then import 'string' end

return		 {

						fromRGB = function(r, g, b)
							local newColor = {
								r = r,
								g = g,
								b = b
							}
							return setmetatable(newColor, Color)
						end,

						fromHex = function(hex)
							local split = string.separate(hex)
							local newColor = {
								byte1 = split[2]..split[3],
								byte2 = split[4]..split[5],
								byte3 = split[6]..split[7]
							}
							return setmetatable(newColor, COlor)
						end,

					}