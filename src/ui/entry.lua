local function entry(x, y, width, height, onEnterFunc, onEnterFuncArgs)
	return {
		text = "",
		active = false,

		x = x or 0,
		y = y or 0,
		width = width or 100,
		height = height or 20,

		onEnterFunc = onEnterFunc or function()
			print("No onEnter function")
		end,

		onEnterFuncArgs = onEnterFuncArgs,

		textX = 0,
		textY = 0,

		colorActive = { 1, 1, 1 },
		colorPassive = { 0, 0, 0 },

		colorTextCurrent = { 1, 1, 1 },
		colorCurrent = { 0, 0, 0 },

		onClick = function(self, mouseX, mouseY)
			if (mouseX > self.x) and (mouseX < self.x + self.width) then
				if (mouseY > self.y) and (mouseY < self.y + self.height) then
					self.active = not self.active
					return
				end
			end
			self.active = false
		end,

		onKeyboardPress = function(self, key)
			if self.active then
				if key:len() == 1 then
					if love.keyboard.isDown("lctrl") then
						if key == "c" then
							love.system.setClipboardText(self.text)
						elseif key == "v" then
							self.text = self.text .. love.system.getClipboardText()
						end
					elseif love.keyboard.isDown("lshift") then
						self.text = self.text .. string.upper(key)
					else
						self.text = self.text .. key
					end
				elseif key == "space" then
					self.text = self.text .. " "
				elseif key == "backspace" then
					self.text = self.text:sub(1, -2)
				elseif key == "lalt" then
					self.text = ""
				elseif key == "return" then
					if self.onEnterFuncArgs then
						self.onEnterFunc(self.onEnterFuncArgs)
					else
						self.onEnterFunc()
					end
				end
			end
		end,

		draw = function(self, x, y, textX, textY)
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

			if self.active then
				self.colorCurrent = self.colorActive
				self.colorTextCurrent = self.colorPassive
			else
				self.colorCurrent = self.colorPassive
				self.colorTextCurrent = self.colorActive
			end

			love.graphics.setColor(self.colorCurrent)

			love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

			love.graphics.setColor(self.colorTextCurrent)

			if self.active then
				love.graphics.print(self.text .. "|", self.textX, self.textY)
			else
				love.graphics.print(self.text, self.textX, self.textY)
			end

			love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

			love.graphics.setColor(1, 1, 1)
		end,
	}
end

return entry
