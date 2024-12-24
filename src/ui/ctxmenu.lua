local Button = require("src/ui/button")

function TemplateCtxMenu(optionWidth, optionHeight)
	local ctx = {}
	ctx.x = 0
	ctx.y = 0
	ctx.optionWidth = optionWidth
	ctx.optionHeight = optionHeight
	ctx.options = {}

	ctx.invoke = function(self, mouseX, mouseY, mouseButton)
		if mouseButton == 2 then
			self.x = mouseX
			self.y = mouseY
			return true
		end
		return false
	end

	ctx.mousepressed = function(self, mouseX, mouseY, mouseButton)
		if mouseButton == 1 then
			for _, option in ipairs(self.options) do
				if option:checkHighlighted(mouseX, mouseY) then
					option:activate()
				end
			end
		end
	end

	ctx.draw = function(self, mouseX, mouseY)
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", self.x, self.y, self.optionWidth, self.optionHeight * #self.options)
		love.graphics.setColor(1, 1, 1)
		for i, option in ipairs(self.options) do
			option:draw(self.x, self.y + (self.optionHeight * (i - 1)), mouseX, mouseY, 2, 2)
		end
	end

	ctx.outOfBounds = function(self, mouseX, mouseY)
		return mouseX < self.x
			or mouseX > self.x + self.optionWidth
			or mouseY < self.y
			or mouseY > self.y + self.optionHeight * #self.options
	end
	return ctx
end

function BGCtxMenu()
	local ctx = TemplateCtxMenu(100, 20)
	ctx.options[1] = Button("Add element", nil, nil, 0, 0, ctx.optionWidth, ctx.optionHeight)
	ctx.options[2] = Button("Background", nil, nil, 0, 0, ctx.optionWidth, ctx.optionHeight)
	return ctx
end

function FileToolbarMenu()
	local ctx = TemplateCtxMenu(100, 20)
	ctx.options[1] = Button("New project", nil, nil, 0, 0, ctx.optionWidth, ctx.optionHeight)
	ctx.options[2] = Button("Open project", nil, nil, 0, 0, ctx.optionWidth, ctx.optionHeight)
	return ctx
end
