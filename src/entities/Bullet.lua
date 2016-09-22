local Bullet = Object:extend()
local assets =  require "src.assets"
local vector = require "lib.hump.vector"
-- local playstate = require "playstate"

function Bullet:new(x, y, angle, speed)

	self.isBullet = true

	self.pos = { x = x or 0, y = y or 0 }
	self.scale = {}
	self.angle = angle or 0
	self.offset = { x = 0, y = 0 }

	-- Bullet
	self.sprite = assets.player
	self.offset = { x = self.sprite:getWidth() / 2, y = self.sprite:getHeight() / 2 }
	self.speed = speed or 400

	-- MoveTowardsAngle component
	self.moveTowardsAngle = true

	-- movable component
	self.movable = {
		velocity = { x = 0, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = 0, y = 0 },
		maxVelocity = { x = 0, y = 0 },
	}

	-- rotatable component
	self.rotatable = {
		speed = 10,
		velocity = 0,
		acceleration = 0,
		drag = 30,
		maxVelocity = 12
	}

	self.pos.x = self.pos.x + (self.pos.x * math.cos(self.angle) * 0.1)
	self.pos.y = self.pos.y + (self.pos.y * math.sin(self.angle) * 0.1)

	return self
end

function Bullet:update(dt)
	-- self:setVelocityFromAngle()
end

return Bullet