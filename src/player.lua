Player = Entity:extend()

function Player:new()
	Player.super.new(self)

	self:loadImage("data/images/player.png", 8, 8)
	self:addAnimation("idle", { 1, 2 }, 1)
	self:playAnimation("idle")

	self.id = "player"
end

function Player:onClick()
	print("click!")
end

player = Player()