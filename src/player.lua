Player = Entity:extend()

function Player:new()
	Player.super.new(self)

	self:loadImage("data/images/player.png")
end

player = Player()