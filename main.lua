local ui = require("src/ui/ui")

function love.load()
	ui:load()
end

function love.mousepressed(x, y, mouseButton)
	ui:mousepressed(x, y, mouseButton)
end

function love.mousereleased(x, y, mouseButton)
	ui:mousereleased(x, y, mouseButton)
end

function love.update()
	ui:update(love.mouse.getPosition())
end

function love.draw()
	ui:draw()
end
