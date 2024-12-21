local Button = require("src/ui/button")
local ctxManager = {}

local function templateCtxMenu(optionWidth, optionHeight)
	local ctxm = {}
	ctxm.x = 0
	ctxm.y = 0
	ctxm.optionWidth = optionWidth
	ctxm.optionHeight = optionHeight
	ctxm.active = false
	ctxm.options = {}

	for i = 1, 5, 1 do
		ctxm.options[i] = Button("test " .. i, nil, nil, 0, 0, optionWidth, optionHeight)
	end

	ctxm.invoke = function(self, mouseX, mouseY)
		self.x = mouseX
		self.y = mouseY
		self.active = true
	end
	ctxm.mousepressed = function(self, mouseX, mouseY, mouseButton)
		if self.active then
			if mouseButton == 1 then
				for _, option in ipairs(self.options) do
					if option:checkHighlighted(mouseX, mouseY) then
						option:activate()
					end
				end
			end
		else
			if mouseButton == 2 then
				self:invoke(mouseX, mouseY)
			end
		end
	end

	ctxm.draw = function(self, mouseX, mouseY)
		if self.active then
			for i, option in ipairs(self.options) do
				option:draw(self.x, self.y + (self.optionHeight * (i - 1)), mouseX, mouseY, 2, 2)
			end
		end
	end

	ctxm.manage = function(self, mouseX, mouseY)
		if self.active then
			if
				mouseX < self.x
				or mouseX > self.x + self.optionWidth
				or mouseY < self.y
				or mouseY > self.y + self.optionHeight * #self.options
			then
				self.active = false
			end
		end
	end
	return ctxm
end

ctxManager[1] = templateCtxMenu(100, 20)

return ctxManager
