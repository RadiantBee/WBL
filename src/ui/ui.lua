local ctxList = require("src/ui/ctxmenu")
local Button = require("src/ui/button")
local ui = {}

ui.mouseX = 0
ui.mouseY = 0

ui.load = function(self) end

ui.mousepressed = function(self, x, y, mouseButton)
	ctxList[1]:mousepressed(x, y, mouseButton)
end

ui.mousereleased = function(self, x, y, mouseButton) end

ui.update = function(self, mouseX, mouseY)
	self.mouseX = mouseX
	self.mouseY = mouseY
	for _, ctxMenu in ipairs(ctxList) do
		ctxMenu:manage(mouseX, mouseY)
	end
end

ui.draw = function(self)
	for _, ctxMenu in ipairs(ctxList) do
		ctxMenu:draw(self.mouseX, self.mouseY)
	end
end

return ui
