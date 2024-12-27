local ctxManager = require("src/ui/ctxmanager")
local toolbar = require("src/ui/toolbar")
local ui = {}

ui.mouseX = 0
ui.mouseY = 0
ui.mouseState = 0

ui.load = function(self) end

ui.mousepressed = function(self, x, y, mouseButton)
	ctxManager:mousepressed(x, y, mouseButton)
	toolbar:onClick(x, y)
	self.mouseState = mouseButton
end

ui.mousereleased = function(self, x, y, mouseButton)
	self.mouseState = 0
end

ui.update = function(self, mouseX, mouseY)
	self.mouseX = mouseX
	self.mouseY = mouseY
	ctxManager:manage(mouseX, mouseY)
	toolbar:update(mouseX, mouseY, self.mouseState)
end

ui.draw = function(self)
	toolbar:draw(self.mouseX, self.mouseY)
	ctxManager:draw(self.mouseX, self.mouseY)
end

return ui
