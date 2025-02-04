local ui = require("src/ui")
local fileManager = require("src/fileManager")

function love.load()
	love.window.maximize()
	fileManager:init()
	ui:load(fileManager)
	love.graphics.setBackgroundColor(0, 0.5, 0)
end

function love.mousepressed(x, y, mouseButton)
	ui:mousepressed(x, y, mouseButton)
end

function love.mousereleased(x, y, mouseButton)
	ui:mousereleased(x, y, mouseButton)
end
function love.keypressed(key)
	ui:keypressed(key)
end
function love.update()
	ui:update(love.mouse.getPosition())
end

function love.draw()
	ui:draw()
end

function love.quit()
	fileManager:save()
end
