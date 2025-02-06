local function CreateDiv(name, x, y, width, height, outlineColor)
	local div = {}
	div.contents = {}
	div.name = name or nil
	div.x = x or 0
	div.y = y or 0
	div.width = width or 100
	div.height = height or 100
	div.outlineColor = outlineColor or { 1, 1, 1 }
	div.draw = function(self)
		love.graphics.setColor(self.outlineColor)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
		love.graphics.setColor(1, 1, 1)
		for _, element in ipairs(self.contents) do
			element:draw()
		end
	end
	div.save = function(self) end
	div.load = function(self, data) end
	div.translate = function(self)
		local output = '<div id = "' .. self.name .. '">\n'
		for internalID, element in ipairs(self.contents) do
			output = output .. element:translate(internalID, self.name)
		end
		return (output .. "</div>\n")
	end
	return div
end

return CreateDiv
