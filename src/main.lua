RELEASE = (arg[2] == nil)
DEBUG = not RELEASE

require "l2.error"
libs = require "l2.libs"

local paths = love.filesystem.getRequirePath()
love.filesystem.setRequirePath(paths .. ";l2/?.lua;l2/?/init.lua;")

for i, m in ipairs(require "require") do
	local succes, message = pcall(require, m)

	if not succes then
		if message:match("not found:") then
			print(message)
			requireDir("l2/" .. m)
		else
			error(message)
		end
	end
end

if DEBUG then
	print("Running debug version...")
	require "debug_version"
elseif RELEASE then
	print("Running release version...")
	require "release_version"
end