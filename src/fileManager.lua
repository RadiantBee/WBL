local fileManager = {}

fileManager.workDir = nil
fileManager.gitURL = nil
fileManager.mainWBLI = nil
fileManager.os = nil
fileManager.pathDelimiter = nil

fileManager.init = function(self)
	self.os = love.system.getOS()
	if self.os == "Linux" then
		self.pathDelimiter = "/"
	elseif self.os == "Windows" then
		self.pathDelimiter = "\\"
	end
end

fileManager.createProject = function(self, name, path)
	self.workDir = path .. self.pathDelimiter .. name
	self.mainWBLI = self.workDir .. self.pathDelimiter .. "WBLI-" .. name .. ".AT"
	love.window.setTitle(self.mainWBLI)
	os.execute("mkdir " .. self.workDir)
	local file = io.open(self.mainWBLI, "w")
	if not file then
		error("ERROR: Cannot create the project file: " .. self.mainWBLI .. "\n")
	end
	file:close()
	os.execute("mkdir " .. self.workDir .. self.pathDelimiter .. "pages")
	os.execute("mkdir " .. self.workDir .. self.pathDelimiter .. "styles")
	os.execute("mkdir " .. self.workDir .. self.pathDelimiter .. "images")
	os.execute("mkdir " .. self.workDir .. self.pathDelimiter .. "videos")
	os.execute("mkdir " .. self.workDir .. self.pathDelimiter .. "audio")
	os.execute("mkdir " .. self.workDir .. self.pathDelimiter .. "scripts")
	return true
end

fileManager.openProject = function(self, projFile)
	local file = io.open(projFile, "r")
	if not file then
		error("ERROR: Cannot access the project file: " .. projFile .. "\n")
	end
	self.workDir = file:read()
	file:close()
	self.mainWBLI = projFile
	love.window.setTitle(self.mainWBLI)
	return true
end

fileManager.save = function(self)
	if self.mainWBLI then
		local file = io.open(self.mainWBLI, "w")
		file:write(self.workDir .. "\n")
		file:close()
		print("WBLI was successfuly saved")
		return true
	else
		print("No main WBLI file located")
		return false
	end
end

fileManager.build = function() end

fileManager.gitDeploy = function() end

return fileManager
