local fileManager = {}

fileManager.workDir = nil
fileManager.gitURL = nil
--[[
-- NOTE: ssh url?
-- For newProject (if url was given):
-- git clone *url* .
--
-- 
--]]

fileManager.createProject = function() end

fileManager.openProject = function() end

fileManager.save = function() end

fileManager.build = function() end

fileManager.gitDeploy = function() end

return fileManager
