RELEASE = (arg[2] == nil)
DEBUG = not RELEASE

libs = require "l2.libs"

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

function love.load()
	game:init()
end

function love.update(dt)
	libs.update()
	game:update(dt)
end

function love.draw()
	game:draw()
end

function love.quit()
	game:save()
end