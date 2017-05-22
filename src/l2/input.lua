input = {}

input.map = {}
input.pressed = {}

input.mousePosition = {
	x = 0,
	y = 0
}

input.mouseVelocity = {
	x = 0,
	y = 0
}

local function mouseButtonToKey(btn)
	return "mouse:" .. btn
end

function input.register(id, keys)
	if type(id) == "table" then
		for k, v in pairs(id) do
			input.register(k, v)
		end
	else
		input.map[id] = lume.clone(keys)
	end
end

function input.onKeyPress(k)
	input.pressed[k] = true
end

function input.onMousePress(x, y, btn)
	input.pressed[mouseButtonToKey(btn)] = true
end

function input.update(dt)
	local x, y = camera.mapMousePosition()
	x, y = x + camera.x, y + camera.y

	input.mouseVelocity.x = x - input.mousePosition.x
	input.mouseVelocity.y = y - input.mousePosition.y
	input.mousePosition.x = x
	input.mousePosition.y = y
end

function input.reset(dt)
	lume.clear(input.pressed)
end

function input.isDown(id)
	local t = input.map[id]

	assert(t, "bad id " .. id)

	for i, v in ipairs(t) do
		local x, d = v:match("(mouse):(%d+)")
		if x and love.mouse.isDown(d) then
			return true
		end
	end

	return love.keyboard.isDown(unpack(t))
end

function input.wasPressed(id)
	assert(input.map[id], "bad id")

	return lume.any(input.map[id], function(k)
		return input.pressed[k]
	end)
end

function input.mapMousePosition()
	return input.mousePosition.x, input.mousePosition.y
end