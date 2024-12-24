local Button = require("src/ui/button")

local toolbar = {}

toolbar.options = {}
toolbar.height = 20
toolbar.width = 100
toolbar.margin = 20

toolbar.options[1] = Button("File", nil, nil, 0, 0, toolbar.width, toolbar.height)
toolbar.options[2] = Button("Save", nil, nil, 0, 0, toolbar.width, toolbar.height)
toolbar.options[3] = Button("Build", nil, nil, 0, 0, toolbar.width, toolbar.height)
toolbar.options[4] = Button("Pages", nil, nil, 0, 0, toolbar.width, toolbar.height)
toolbar.options[5] = Button("Resources", nil, nil, 0, 0, toolbar.width, toolbar.height)
toolbar.options[6] = Button("HELP ME", nil, nil, 0, 0, toolbar.width, toolbar.height)
toolbar.draw = function(self, mouseX, mouseY)
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), self.height)
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("line", 0, 0, love.graphics.getWidth(), self.height)

	for index, option in ipairs(self.options) do
		option:draw((index - 1) * self.width + (index - 1) * self.margin, 0, mouseX, mouseY, 2, 2)
	end
end
return toolbar
