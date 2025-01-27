local function button(
	text,
	func,
	funcArgs,
	x,
	y,
	width,
	height,
	colorIdle,
	colorTextIdle,
	modeIdle,
	colorHighlighted,
	colorTextHighlighted,
	modeHighlighted,
	colorActive,
	colorTextActive,
	modeActive
)
	return {
		text = text or "Empty",
		func = func or function()
			print("no funcion in the button")
		end,
		funcArgs = funcArgs,

		x = x or 0,
		y = y or 0,
		width = width or 100,
		height = height or 100,

		textX = 0,
		textY = 0,

		colorCurrent = colorIdle or { 1, 1, 1 },
		colorTextCurrent = colorTextIdle or { 1, 1, 1 },
		modeCurrent = modeIdle or "line",

		colorIdle = colorIdle or { 1, 1, 1 },
		colorTextIdle = colorTextIdle or { 1, 1, 1 },
		modeIdle = modeIdle or "line",

		colorHighlighted = colorHighlighted or { 0.4, 0.4, 0.4 },
		colorTextHighlighted = colorTextHighlighted or { 1, 1, 1 },
		modeHighlighted = modeHighlighted or "fill",

		colorActive = colorActive or { 1, 1, 1 },
		colorTextActive = colorTextActive or { 0, 0, 0 },
		modeActive = modeActive or "fill",

		activate = function(self)
			if self.funcArgs then
				self.func(self.funcArgs)
			else
				self.func()
			end
		end,

		checkHighlighted = function(self, mouseX, mouseY)
			if (mouseX > self.x) and (mouseX < self.x + self.width) then
				if (mouseY > self.y) and (mouseY < self.y + self.height) then
					return true
				end
			end
			return false
		end,

		onClick = function(self, mouseX, mouseY)
			if (mouseX > self.x) and (mouseX < self.x + self.width) then
				if (mouseY > self.y) and (mouseY < self.y + self.height) then
					self:activate()
				end
			end
		end,

		draw = function(self, x, y, mouseX, mouseY, textX, textY)
			self.x = x or self.x
			self.y = y or self.y

			if textX then
				self.textX = textX + self.x
			else
				self.textX = self.x
			end

			if textY then
				self.textY = textY + self.y
			else
				self.textY = self.y
			end

			if not self:checkHighlighted(mouseX, mouseY) then
				self.colorCurrent = self.colorIdle
				self.colorTextCurrent = self.colorTextIdle
				self.modeCurrent = self.modeIdle
			else
				if not love.mouse.isDown(1) then
					self.colorCurrent = self.colorHighlighted
					self.colorTextCurrent = self.colorTextHighlighted
					self.modeCurrent = self.modeHighlighted
				else
					self.colorCurrent = self.colorActive
					self.colorTextCurrent = self.colorTextActive
					self.modeCurrent = self.modeActive
				end
			end

			love.graphics.setColor(self.colorCurrent)
			love.graphics.rectangle(self.modeCurrent, self.x, self.y, self.width, self.height)
			love.graphics.setColor(self.colorTextCurrent)
			love.graphics.print(self.text, self.textX, self.textY)
			love.graphics.setColor(self.colorIdle)
			love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
			love.graphics.setColor(1, 1, 1)
		end,
	}
end

return button
