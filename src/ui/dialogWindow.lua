local Button = require("src/button")
local entry = require("src/entry")

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
					end
				end
			end
		end
	end

	emptyDiaolgWindow.bodyDraw = function(self, mouseX, mouseY)
		if self.active then
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
		self:bodyDraw(mouseX, mouseY)
		if self.active then
			love.graphics.print(self.info, self.x + 5, self.y + self.titleHeight + 5)
		end
	end
	return infoWindow
end

function CreateDialogWindowNewTask(x, y, width, height, taskList)
	local newTaskDialogWindow = EmptyDiaolgWindow(x, y, width, height)
	newTaskDialogWindow.height = height or 180
	newTaskDialogWindow.title = "Create new task"

	newTaskDialogWindow.saveButton = Button("Create", function(args)
		args[2]:addTask({
			args[1].entryTitle.text,
			args[1].entryDescription1.text,
			args[1].entryDescription2.text,
			args[1].entryDescription3.text,
			args[1].entryDescription4.text,
			args[1].entryType.text,
		})
	end, { newTaskDialogWindow, taskList }, nil, nil, 50, 20)

	newTaskDialogWindow.entryDescription4 = entry(nil, nil, nil, nil, function(dialog)
		dialog.entryDescription4.active = false
		dialog.saveButton:activate()
	end, newTaskDialogWindow)

	newTaskDialogWindow.entryDescription3 = entry(nil, nil, nil, nil, function(dialog)
		dialog.entryDescription3.active = false
		dialog.entryDescription4.active = true
	end, newTaskDialogWindow)

	newTaskDialogWindow.entryDescription2 = entry(nil, nil, nil, nil, function(dialog)
		dialog.entryDescription2.active = false
		dialog.entryDescription3.active = true
	end, newTaskDialogWindow)

	newTaskDialogWindow.entryDescription1 = entry(nil, nil, nil, nil, function(dialog)
		dialog.entryDescription1.active = false
		dialog.entryDescription2.active = true
	end, newTaskDialogWindow)

	newTaskDialogWindow.entryType = entry(nil, nil, nil, nil, function(dialog)
		dialog.entryType.active = false
		dialog.entryDescription1.active = true
	end, newTaskDialogWindow)

	newTaskDialogWindow.entryTitle = entry(nil, nil, nil, nil, function(dialog)
		dialog.entryTitle.active = false
		dialog.entryType.active = true
	end, newTaskDialogWindow)

	newTaskDialogWindow.entryClear = function(self)
		self.entryTitle.text = ""
		self.entryType.text = ""
		self.entryDescription1.text = ""
		self.entryDescription2.text = ""
		self.entryDescription3.text = ""
		self.entryDescription4.text = ""
	end

	newTaskDialogWindow.exitButton.func = function(self)
		self:entryClear()
		self.active = false
	end

	newTaskDialogWindow.onClick = function(self, mouseX, mouseY)
		if self.active then
			self.exitButton:onClick(mouseX, mouseY)
			self.saveButton:onClick(mouseX, mouseY)

			self.entryTitle:onClick(mouseX, mouseY)
			self.entryDescription1:onClick(mouseX, mouseY)
			self.entryDescription2:onClick(mouseX, mouseY)
			self.entryDescription3:onClick(mouseX, mouseY)
			self.entryDescription4:onClick(mouseX, mouseY)
			self.entryType:onClick(mouseX, mouseY)
		end
	end

	newTaskDialogWindow.onKeyboardPress = function(self, key)
		if self.active then
			self.entryDescription4:onKeyboardPress(key)
			self.entryDescription3:onKeyboardPress(key)
			self.entryDescription2:onKeyboardPress(key)
			self.entryDescription1:onKeyboardPress(key)
			self.entryType:onKeyboardPress(key)
			self.entryTitle:onKeyboardPress(key)
		end
	end

	newTaskDialogWindow.draw = function(self, mouseX, mouseY)
		self:bodyDraw(mouseX, mouseY)
		if self.active then
			love.graphics.print("Enter title:", self.x + 10, self.y + self.titleHeight + 12)
			love.graphics.print("Enter type:", self.x + 10, self.y + self.titleHeight + 37)
			love.graphics.print("Enter desc:", self.x + 10, self.y + self.titleHeight + 62)

			self.entryTitle:draw(self.x + 90, self.y + self.titleHeight + 10, 2, 2)
			self.entryType:draw(self.x + 90, self.y + self.titleHeight + 35, 2, 2)
			self.entryDescription1:draw(self.x + 90, self.y + self.titleHeight + 60, 2, 2)
			self.entryDescription2:draw(self.x + 90, self.y + self.titleHeight + 80, 2, 2)
			self.entryDescription3:draw(self.x + 90, self.y + self.titleHeight + 100, 2, 2)
			self.entryDescription4:draw(self.x + 90, self.y + self.titleHeight + 120, 2, 2)

			self.saveButton:draw(
				self.x + self.width / 2 - self.saveButton.width / 2,
				self.y + self.height + self.titleHeight - self.saveButton.height - 10,
				mouseX,
				mouseY,
				5,
				3
			)
		end
	end

	return newTaskDialogWindow
end

function CreateDialogEditTask(x, y, width, height, task, taskList)
	local editDialog = CreateDialogWindowNewTask(x, y, width, height, taskList)
	editDialog.title = "Edit task"
	editDialog.saveButton.text = "Save"
	editDialog.task = task
	editDialog.saveButton.funcArgs = { editDialog, taskList }
	editDialog.saveButton.func = function(args)
		args[1].task.title = args[1].entryTitle.text
		args[1].task.description1 = args[1].entryDescription1.text
		args[1].task.description2 = args[1].entryDescription2.text
		args[1].task.description3 = args[1].entryDescription3.text
		args[1].task.description4 = args[1].entryDescription4.text
		args[1].task.type = args[1].entryType.text
		args[2]:saveToFile()
	end
	return editDialog
end
