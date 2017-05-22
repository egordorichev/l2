entity = rect:extend()

function entity:new(options)
    entity.super.new(self)

    self.name = "entity"

    self.respawnable = false
    self.hurtable = true
    self.last = rect()
    self.velocity = vector()
    self.maxVelocity = vector(1000, 1000)
    self.accel = vector()
    self.dynamic = true
    self.touching = {}
    self.bounce = 0
    self.angle = 0
    self.angularVelocity = 0
    self.health = 3
    self.dead = false
    self.flip = false
    self.autoFlip = false
    self.solid = true
    self.room = nil
    self.flashColor = { 255, 255, 255 }
    self.flashTimer = 0
    self.flickerTimer = 0
    self.zIndex = 0
    self.origin = vector()
    self.frameSize = rect()
    self.scale = vector(1, 1)
    self.offset = vector(0, 0)
    self.frames = {}
    self.frame = 1
    self.color = nil
    self.shader = nil
    self.blend = nil
    self.alpha = 1

    self.animations = {}
    self.animation = nil

    self.tween = flux.group()
    self.timer = tick.group()
    self.task = coil.group()

    if options ~= nil then
        for k, v in pairs(opt) do
            self[k] = v
        end
    end
end

function entity:warp(x, y)
	assert(type(x) == "number" and type(y) == "number", "expected two numbers")

	self.x, self.y = x, y
	rect.copy(self, self.last)

	if self.room then
		self.room.shash:update(self, self.x, self.y)
	end
end

function entity:separate(e, axis)
	if e == self or not self:overlaps(e) then
		return
	end

	local separateX = false

	if axis then
		separateX = (axis == "x")
	else
		if self.last:overlapsY(e.last) then
			if self.last:overlapsX(e.last) then
				local distX = self:getMiddleX() < e:getMiddleX() and
						e:left() - self:left() or
						self:right() - e:right()

				local distY = self:getMiddleY() < e:getMiddleY() and
						e:top() - self:top() or
						self:bottom() - e:bottom()

				separateX = distX > distY
			else
				separateX = true
			end
		end
	end

	if not self.dynamic or not e.dynamic then
		if not self.dynamic and not e.dynamic then
			return
		end

		if not self.dynamic then
			return e:separate(self)
		end

		local sides = e.collidable

		if sides then
			if self.last:overlaps(e.last) then
				return
			end

			if separateX then
				if self.last.x < e.last.x then
					if not sides.left then return end
				else
					if not sides.right then return end
				end
			else
				if self.last.y < e.last.y then
					if not sides.top then return end
				else
					if not sides.bottom then return end
				end
			end
		end

		if separateX then
			local z = self.last.x < e.last.x

			if z then
				self:right(e:left())
				self.touching.right = true
				e.touching.left = true
			else
				self:left(e:right())
				self.touching.left = true
				e.touching.right = true
			end

			if z == (self.velocity.x > 0) then
				self.velocity.x = -self.velocity.x * self.bounce
			end
		else
			local z = self.last.y < e.last.y

			if z then
				self:bottom(e:top())
				self.touching.bottom = true
				e.touching.top = true
			else
				self:top(e:bottom())
				self.touching.top = true
				e.touching.bottom = true
			end

			if z == (self.velocity.y > 0) then
				self.velocity.y = -self.velocity.y * self.bounce
			end
		end
		return
	end

	if separateX then
		local z = self.last.x < e.last.x

		local mid = self:getMiddleX() < e:getMiddleX() and
				(self:right() + e:left()) / 2 or
				(self:left() + e:right()) / 2

		if z then
			self:right(mid)
			e:left(mid)
			self.touching.right = true
			e.touching.left = true
		else
			self:left(mid)
			e:right(mid)
			self.touching.left = true
			e.touching.right = true
		end

		if z == (self.velocity.x > 0) then
			self.velocity.x = -self.velocity.x * self.bounce
		end

		if z == (e.velocity.x < 0) then
			e.velocity.x = -e.velocity.x * e.bounce
		end
	else
		local z = self.last.y < e.last.y
		local mid = self:getMiddleY() < e:getMiddleY() and
				(self:bottom() + e:top()) / 2 or
				(self:top() + e:bottom()) / 2

		if z then
			self:bottom(mid)
			e:top(mid)
			self.touching.bottom = true
			e.touching.top = true
		else
			self:top(mid)
			e:bottom(mid)
			e.touching.bottom = true
			self.touching.top = true
		end

		if z == (self.velocity.y > 0) then
			self.velocity.y = -self.velocity.y * self.bounce
		end

		if z == (e.velocity.y < 0) then
			e.velocity.y = -e.velocity.y * e.bounce
		end
	end
end

function entity:onOverlap(e)
	if self.solid and e.solid then
		self:separate(e)
	end
end

function entity:onAdd()

end

function entity:onRemove()

end

function entity:hurt(amount)
	if not self.hurtable then
		return
	end

	self.hurtable = false

	tick.delay(lume.fn(self.setHurtable, self), 0.5)

	amount = amount or 1
	self.health = math.max(0, self.health - amount)

	self:flicker()

	if self.health == 0 and not self.dead then
		self:kill()
	end
end

function entity:setHurtable(h)
	self.hurtable = h or true
end

function entity:play(name, reset)
	local last = self.animation
	self.animation = self.animations[name]

	if reset or self.animation ~= last then
		self.animationTimer = self.animation.period
		self.animationFrame = 1
		self.frame = lume.first(self.animation.frames)
	end
end

function entity:stop()
	self.animation = nil
end

function entity:addAnimation(name, frames, fps, loop)
	self.animations[name] = {
		frames = lume.clone(frames),
		period = (fps ~= 0) and (1 / math.abs(fps)) or 1,
		loop   = (loop == nil) and true or loop,
	}
end

function entity:kill()
	self.dead = true
end

function entity:flicker(t)
	self.flickerTimer = t or 0.5
end

function entity:flash(t, r, g, b)
	t = t or .1
	r = r or 255
	g = g or 255
	b = b or 255

	self.flashTimer = t
	self.flashColor[1] = r
	self.flashColor[2] = g
	self.flashColor[3] = b
end

function entity:getDistanceTo(e)
	return lume.distance(self:getMiddleX(), self:getMiddleY(), e:getMiddleX(), e:getMiddleY())
end

function entity:getBoundingBox(expand)
	if expand then
		return self.x - expand, self.y - expand, self.w + expand * 2, self.h + expand * 2
	end

	return self.x, self.y, self.w, self.h
end

function entity:loadImage(filename, width, height)
	if type(filename) == "userdata" then
		self.image = filename
	else
		self.image = assets.load(filename)
	end

	self.image:setFilter("nearest")

	width = width or self.image:getWidth()
	height = height or self.image:getHeight()

	self.frames = {}
	self.frameSize:set(0, 0, width, height)

	for y = 0, self.image:getHeight() / height - 1 do
		for x = 0, self.image:getWidth() / width - 1 do
			local q = love.graphics.newQuad(x * width, y * height, width, height, self.image:getDimensions())

			table.insert(self.frames, q)
		end
	end

	self.w = self.w ~= 0 and self.w or width
	self.h = self.h ~= 0 and self.h or height

	self:centerOrigin()

	return self
end

function entity:centerOrigin()
	local x = self.frameSize.w / 2
	local y = self.frameSize.h / 2

	self.origin.x = lume.round(x)
	self.origin.y = lume.round(y)
end

function entity:getDrawColorArgs()
	local r = 255
	local g = 255
	local b = 255

	if self.color then
		r, g, b = unpack(self.color)
	end

	return r, g, b, self.alpha * 255
end

function entity:getScreenX()
	local camera = game:getCamera()
	return math.floor(self.x - lume.round(camera.x))
end

function entity:getScreenY()
	local camera = game:getCamera()
	return math.floor(self.y - lume.round(camera.y))
end

function entity:getDrawArgs()
	return self.frames[self.frame],
	self:getScreenX() + self.offset.x + self.origin.x,
	self:getScreenY() + self.offset.y + self.origin.y,
	math.rad(self.angle),
	self.flip and -self.scale.x or self.scale.x,
	self.scale.y,
	self.origin.x, self.origin.y
end

function entity:draw()
	local colorSet = false

	if not self.image then
		return
	end

	if self.flickerTimer > 0 and self.flickerTimer % .06 < .03 then
		return
	end

	if self.color or self.alpha ~= 1 then
		love.graphics.setColor(self:getDrawColorArgs())
		colorSet = true
	end

	local blend = self.blend or "alpha"

	if blend ~= lastBlendMode then
		love.graphics.setBlendMode(blend)
		lastBlendMode = blend
	end

	local shader = self.shader

	if self.flashTimer > 0 then
		love.graphics.setColor(unpack(self.flashColor))

		shader = flashShader
		colorSet = true
	end

	-- if shader ~= lastShader then
	--	love.graphics.setShader(shader)
	--	lastShader = shader
	--end

	love.graphics.draw(self.image, self:getDrawArgs())
	-- love.graphics.setShader(lastShader)

	if colorSet then
		love.graphics.setColor(255, 255, 255)
	end
end

function entity:updateMovement(dt)
	if dt == 0 then
		return
	end

	self.last = self:copy()

	if self.dynamic then
		self.velocity.y = self.velocity.y + 20
	end

	self.velocity.x = self.velocity.x + self.accel.x * dt
	self.velocity.y = self.velocity.y + self.accel.y * dt

	if math.abs(self.velocity.x) > self.maxVelocity.x then
		self.velocity.x = self.maxVelocity.x * lume.sign(self.velocity.x)
	end

	if math.abs(self.velocity.y) > self.maxVelocity.y then
		self.velocity.y = self.maxVelocity.y * lume.sign(self.velocity.y)
	end

	self.accel.x = 0
	self.accel.y = self.accel.y * 0.85 -- fixme

	self.velocity:multiply(0.95)

	self.x = self.x + self.velocity.x * dt
	self.y = self.y + self.velocity.y * dt

	self.angle = self.angle + self.angularVelocity * dt
end

function entity:updateAutoFlip()
	if self.accel.x ~= 0 then
		self.flip = (self.accel.x < 0)
	end
end

function entity:updateAnimation(dt)
	local a = self.animation

	if not a then
		return
	end

	self.animationTimer = self.animationTimer - dt

	if self.animationTimer <= 0 then
		self.animationFrame = self.animationFrame + 1

		if self.animationFrame > #a.frames then
			if a.loop == true then
				self.animationFrame = 1
			else
				self:stop()

				if type(a.loop) == "function" then
					a.loop()
				end

				return
			end
		end

		self.animationTimer = self.animationTimer + a.period
		self.frame = a.frames[self.animationFrame]
	end
end

function entity:updatePathFollow(dt)
	local p = self.path

	if not p then
		return
	end

	if p.timer <= 0 then
		p.idx = p.idx + 2
		if p.idx >= #p.points - 2 then
			if p.loop then
				p.idx = 1
			else
				self.path = nil
				return
			end
		end

		local a = p.points
		local d = lume.distance(a[p.idx], a[p.idx + 1], a[p.idx + 2], a[p.idx + 3])
		local t = d / p.speed

		p.tween = self.tween:to(self, t, { x = a[p.idx + 2], y = a[p.idx + 3] }):ease("linear")
		p.timer = t
	else
		p.timer = p.timer - dt
	end
end

function entity:updateTouching(dt)
	if dt == 0 then
		return
	end

	lume.clear(self.touching)
end

function entity:updateTimers(dt)
	self.flashTimer = self.flashTimer - dt
	self.flickerTimer = self.flickerTimer - dt
end

function entity:update(dt)
	if self.dynamic then
		self:updateMovement(dt)
	end

	if self.path then
		self:updatePathFollow(dt)
	end

	if self.autoFlip then
		self:updateAutoFlip(dt)
	end

	if self.animation then
		self:updateAnimation(dt)
	end

	self:updateTouching(dt)
	self:updateTimers(dt)

	self.tween:update(dt)
	self.timer:update(dt)
	self.task:update(dt)
end

function entity:getNearbyEntities(maxDistance, filter)
	local s = game.room
	maxDistance = maxDistance + math.min(self.w, self.h)
	local x, y = self:getMiddleX(), self:getMiddleY()

	return s:getEntitiesWithinRadius(x, y, maxDistance, self, filter)
end