require("src/ui/ctxmenu")
require("src/ui/dialogWindow")

local ctxManager = {}

ctxManager.popups = {}
ctxManager.popups[1] = CreateNewFileWindow(300, 200)
ctxManager.popups[2] = CreateOpenFileWindow(750, 200)
ctxManager.popups[3] = CreateNewElementWindow(0, 300)
ctxManager.popups[4] = CreateBackgroundSettings(0, 400)

ctxManager[1] = FileToolbarMenu()
ctxManager[1].options[1].func = ctxManager.popups[1].toggleActive
ctxManager[1].options[1].funcArgs = ctxManager.popups[1]

ctxManager[1].options[2].func = ctxManager.popups[2].toggleActive
ctxManager[1].options[2].funcArgs = ctxManager.popups[2]

ctxManager[2] = BGCtxMenu()
ctxManager[2].options[1].func = ctxManager.popups[3].toggleActive
ctxManager[2].options[1].funcArgs = ctxManager.popups[3]

ctxManager[2].options[2].func = ctxManager.popups[4].toggleActive
ctxManager[2].options[2].funcArgs = ctxManager.popups[4]

ctxManager.active = nil

ctxManager.load = function(self, filemanager)
	self.popups[1].createButton.funcArgs = { filemanager, self.popups[1] }
	self.popups[2].openButton.funcArgs = { filemanager, self.popups[2] }
end

ctxManager.manage = function(self, mouseX, mouseY, mousebutton)
	if self.active and self[self.active]:outOfBounds(mouseX, mouseY) then
		self.active = nil
	end
	for _, popup in ipairs(self.popups) do
		if popup:checkMouseMove(mouseX, mouseY, mousebutton) then
			break
		end
	end
end

ctxManager.keypressed = function(self, key)
	for _, popup in ipairs(self.popups) do
		popup:keypressed(key)
	end
end

ctxManager.mousepressed = function(self, x, y, mousebutton)
	if self.active then
		self[self.active]:mousepressed(x, y, mousebutton)
	else
		if self[1]:invoke(x, y, mousebutton) then
			self.active = 1
		elseif self[2]:invoke(x, y, mousebutton) then
			self.active = 2
		end
	end

	for _, popup in ipairs(self.popups) do
		popup:onClick(x, y, mousebutton)
	end
end

ctxManager.draw = function(self, mouseX, mouseY)
	if self.active then
		self[self.active]:draw(mouseX, mouseY)
	end

	for _, popup in ipairs(self.popups) do
		popup:draw(mouseX, mouseY)
	end
end

return ctxManager
