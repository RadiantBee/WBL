require("src/ui/dialogWindow")
local Button = require("src/ui/button")

local info = {}
info[1] = "Info text"

local toolbar = {}

toolbar.options = {}
toolbar.height = 20
toolbar.width = 100
toolbar.margin = 20

toolbar.popups = {}
toolbar.popups[1] = CreateInfoWindow(100, 100, 100, info)
toolbar.popups[2] = CreateBuildWindow(400, 100)
toolbar.popups[3] = CreatePagesWindow(700, 100)
toolbar.popups[4] = CreateResourcesWindow(100, 500)
toolbar.popups[5] = CreateGitWindow(500, 500)

toolbar.options[1] = Button("File", function() end, nil, 0, 0, toolbar.width, toolbar.height)
toolbar.options[2] = Button("Save", nil, nil, 0, 0, toolbar.width, toolbar.height)
toolbar.options[3] =
	Button("Build", toolbar.popups[2].toggleActive, toolbar.popups[2], 0, 0, toolbar.width, toolbar.height)
toolbar.options[4] =
	Button("Pages", toolbar.popups[3].toggleActive, toolbar.popups[3], 0, 0, toolbar.width, toolbar.height)
toolbar.options[5] =
	Button("Resources", toolbar.popups[4].toggleActive, toolbar.popups[4], 0, 0, toolbar.width, toolbar.height)
toolbar.options[6] =
	Button("Git", toolbar.popups[5].toggleActive, toolbar.popups[5], 0, 0, toolbar.width, toolbar.height)
toolbar.options[7] =
	Button("HELP ME", toolbar.popups[1].toggleActive, toolbar.popups[1], 0, 0, toolbar.width, toolbar.height)

toolbar.keypressed = function(self, key) end

toolbar.load = function(self, fileManager)
	self.options[2].func = function(bundle)
		if bundle[1]:save() then
			bundle[2].colorIdle = { 0, 0.5, 0 }
			bundle[2].modeIdle = "fill"
		else
			bundle[2].colorIdle = { 0.5, 0, 0 }
			bundle[2].modeIdle = "fill"
		end
	end
	self.options[2].funcArgs = { fileManager, self.options[2] }
	self.options[2].onClick = function(self, mouseX, mouseY)
		if (mouseX > self.x) and (mouseX < self.x + self.width) then
			if (mouseY > self.y) and (mouseY < self.y + self.height) then
				self:activate()
				return
			end
		end
		self.colorIdle = { 1, 1, 1 }
		self.modeIdle = "line"
	end
end

toolbar.draw = function(self, mouseX, mouseY)
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), self.height)
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("line", 0, 0, love.graphics.getWidth(), self.height)

	for index, option in ipairs(self.options) do
		option:draw((index - 1) * self.width + (index - 1) * self.margin, 0, mouseX, mouseY, 2, 2)
	end

	for _, popup in ipairs(self.popups) do
		popup:draw(mouseX, mouseY)
	end
end

toolbar.update = function(self, mouseX, mouseY, mouseState)
	for _, popup in ipairs(self.popups) do
		if popup:checkMouseMove(mouseX, mouseY, mouseState) then
			break
		end
	end
end

toolbar.onClick = function(self, mouseX, mouseY)
	for _, option in ipairs(self.options) do
		option:onClick(mouseX, mouseY)
	end

	for _, popup in ipairs(self.popups) do
		popup:onClick(mouseX, mouseY)
	end
end
return toolbar
