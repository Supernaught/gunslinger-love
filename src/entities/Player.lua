local Player = Object:extend()
local assets =  require "src.assets"

function Player:new()
	self.isPlayer = true

	self.sprite = assets.player
	self.pos = { x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2 }
	self.scale = {}
	self.rot = 0
	self.offset = { x = self.sprite:getWidth() / 2, y = self.sprite:getHeight() / 2 }

	-- rotatable component
	self.rotatable = {
		speed = 10,
		velocity = 0,
		acceleration = 0,
		drag = 30,
		maxVelocity = 12
	}

	-- shooter component
	self.shooter = true
	self.atkDelay = 0.2
	-- self.canAtk

	return self
end

function Player:update(dt)
end

return Player