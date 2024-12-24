local ctxManager = require("src/ui/ctxmanager")
local toolbar = require("src/ui/toolbar")
local ui = {}

ui.mouseX = 0
ui.mouseY = 0

ui.load = function(self) end

ui.mousepressed = function(self, x, y, mouseButton)
	ctxManager:mousepressed(x, y, mouseButton)
end

ui.mousereleased = function(self, x, y, mouseButton) end

ui.update = function(self, mouseX, mouseY)
	self.mouseX = mouseX
	self.mouseY = mouseY
	ctxManager:manage(self.mouseX, self.mouseY)
end

ui.draw = function(self)
	toolbar:draw(self.mouseX, self.mouseY)
	ctxManager:draw(self.mouseX, self.mouseY)
end

return ui
