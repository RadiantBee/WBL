local Button = require("src/ui/button")
local entry = require("src/ui/entry")

function EmptyDiaolgWindow(x, y, width, height)
	local emptyDiaolgWindow = {}
	emptyDiaolgWindow.x = x or 0
	emptyDiaolgWindow.y = y or 0
	emptyDiaolgWindow.width = width or 200
	emptyDiaolgWindow.height = height or 100
	emptyDiaolgWindow.title = "No Title"
	emptyDiaolgWindow.titleHeight = 20

	emptyDiaolgWindow.active = false

	emptyDiaolgWindow.exitButton = Button("X", function(self)
		self.active = false
	end, emptyDiaolgWindow, nil, nil, 20, 20)

	emptyDiaolgWindow.toggleActive = function(self)
		self.active = not self.active
	end

	emptyDiaolgWindow.onClick = function(self, mouseX, mouseY)
		if self.active then
			self.exitButton:onClick(mouseX, mouseY)
		end
	end

	emptyDiaolgWindow.checkMouseMove = function(self, mouseX, mouseY, mouseState)
		if self.active then
			if (mouseX > self.x) and (mouseX < self.x + self.width - self.exitButton.width) then
				if (mouseY > self.y) and (mouseY < self.y + self.titleHeight) then
					if mouseState == 1 then
						self.x = mouseX - self.width / 2
						self.y = mouseY - self.titleHeight / 2
						return true
					end
				end
			end
		end
		return false
	end

	emptyDiaolgWindow.bodyDraw = function(self, mouseX, mouseY)
		-- IMPORTANT: don't forget to check if popup is active before rendering
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", self.x, self.y, self.width, self.height + self.titleHeight)
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.height + self.titleHeight)

		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", self.x, self.y, self.width, self.titleHeight)
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.titleHeight)

		love.graphics.print(self.title, self.x + 3, self.y + 3)

		self.exitButton:draw(self.x + self.width - self.exitButton.width, self.y, mouseX, mouseY, 5, 3)
	end
	return emptyDiaolgWindow
end

function CreateInfoWindow(x, y, width, info)
	local infoWindow = EmptyDiaolgWindow(x, y, width, #info * 15 + 10)
	infoWindow.title = "Info"
	infoWindow.info = ""
	for _, infoLine in pairs(info) do
		infoWindow.info = infoWindow.info .. infoLine .. "\n"
	end
	infoWindow.draw = function(self, mouseX, mouseY)
		if not self.active then
			return
		end
		self:bodyDraw(mouseX, mouseY)
		love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
	end
	return infoWindow
end

function CreateNewFileWindow(x, y)
	local window = EmptyDiaolgWindow(x, y, 200, 100)
	window.title = "New Project"
	window.info = ""
	window.draw = function(self, mouseX, mouseY)
		if not self.active then
			return
		end
		self:bodyDraw(mouseX, mouseY)
		love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
	end
	return window
end

function CreateOpenFileWindow(x, y)
	local window = EmptyDiaolgWindow(x, y, 200, 100)
	window.title = "Open Project"
	window.info = ""
	window.draw = function(self, mouseX, mouseY)
		if not self.active then
			return
		end
		self:bodyDraw(mouseX, mouseY)
		love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
	end
	return window
end

function CreateBuildWindow(x, y)
	local window = EmptyDiaolgWindow(x, y, 200, 100)
	window.title = "Build Control"
	window.info = ""
	window.draw = function(self, mouseX, mouseY)
		if not self.active then
			return
		end
		self:bodyDraw(mouseX, mouseY)
		love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
	end
	return window
end

function CreatePagesWindow(x, y)
	local window = EmptyDiaolgWindow(x, y, 300, 200)
	window.title = "Pages"
	window.info = ""
	window.draw = function(self, mouseX, mouseY)
		if not self.active then
			return
		end
		self:bodyDraw(mouseX, mouseY)
		love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
	end
	return window
end

function CreateResourcesWindow(x, y)
	local window = EmptyDiaolgWindow(x, y, 300, 200)
	window.title = "Resources"
	window.info = ""
	window.draw = function(self, mouseX, mouseY)
		if not self.active then
			return
		end
		self:bodyDraw(mouseX, mouseY)
		love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
	end
	return window
end

function CreateGitWindow(x, y)
	local window = EmptyDiaolgWindow(x, y, 300, 200)
	window.title = "Git Control"
	window.info = ""
	window.draw = function(self, mouseX, mouseY)
		if not self.active then
			return
		end
		self:bodyDraw(mouseX, mouseY)
		love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
	end
	return window
end

function CreateNewElementWindow(x, y)
	local window = EmptyDiaolgWindow(x, y, 300, 200)
	window.title = "New Element"
	window.info = ""
	window.draw = function(self, mouseX, mouseY)
		if not self.active then
			return
		end
		self:bodyDraw(mouseX, mouseY)
		love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
	end
	return window
end

function CreateBackgroundSettings(x, y)
	local window = EmptyDiaolgWindow(x, y, 300, 200)
	window.title = "Background"
	window.info = ""
	window.draw = function(self, mouseX, mouseY)
		if not self.active then
			return
		end
		self:bodyDraw(mouseX, mouseY)
		love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
	end
	return window
end
