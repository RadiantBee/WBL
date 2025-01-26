local fileManager = {}

fileManager.workDir = nil
fileManager.gitURL = nil
fileManager.mainWBLI = nil
--[[
-- NOTE: ssh url?
-- For newProject (if url was given):
-- git clone *url* .
--
-- 
--]]

fileManager.createProject = function(self, name, path)
	self.workDir = path .. "/" .. name
	self.mainWBLI = self.workDir .. "/WBLI-" .. name .. ".AT"
	love.window.setTitle(self.workDir)
	os.execute("mkdir " .. self.workDir)
	local file = io.open(self.mainWBLI, "w")
	if not file then
		error("ERROR: Cannot create the project file: " .. self.mainWBLI .. "\n")
	end
	file:close()
	os.execute("mkdir " .. self.workDir .. "/pages")
	os.execute("mkdir " .. self.workDir .. "/styles")
	os.execute("mkdir " .. self.workDir .. "/images")
	os.execute("mkdir " .. self.workDir .. "/videos")
	os.execute("mkdir " .. self.workDir .. "/audio")
	os.execute("mkdir " .. self.workDir .. "/scripts")
	return true
end

fileManager.openProject = function(self, projFile)
	local file = io.open(projFile, "r")
	if not file then
		error("ERROR: Cannot access the project file: " .. projFile .. "\n")
	end
	file:close()
end

fileManager.save = function(self) end

fileManager.build = function() end

fileManager.gitDeploy = function() end

return fileManager
