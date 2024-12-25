require("src/ui/ctxmenu")

local ctxManager = {}

ctxManager[1] = FileToolbarMenu()
ctxManager[2] = BGCtxMenu()

ctxManager.active = nil

ctxManager.manage = function(self, mouseX, mouseY)
	if self.active and self[self.active]:outOfBounds(mouseX, mouseY) then
		self.active = nil
	end
end

ctxManager.mousepressed = function(self, x, y, mousebutton)
	if self.active then
		self[self.active]:mousepressed(x, y, mousebutton)
	else -- TODO: additional conditions for creating active ctx menus
		if self[1]:invoke(x, y, mousebutton) then
			self.active = 1
		elseif self[2]:invoke(x, y, mousebutton) then
			self.active = 2
		end
	end
end

ctxManager.draw = function(self, mouseX, mouseY)
	if self.active then
		self[self.active]:draw(mouseX, mouseY)
	end
end

return ctxManager
