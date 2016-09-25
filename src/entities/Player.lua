local Player = Object:extend()
local assets =  require "src.assets"

function Player:new()
	self.name = "Player"	
	self.isPlayer = true

	-- transform
	self.pos = { x = push:getWidth() / 2, y = push:getHeight() / 2 }
	self.scale = {}
	self.angle = 0 -- in radians

	-- sprite component
	self.sprite = assets.player
	self.offset = { x = self.sprite:getWidth() / 2, y = self.sprite:getHeight() / 2 }

	-- rotatable component
	self.rotatable = {
		velocity = 0,
		acceleration = 0,
		drag = 30,
		maxVelocity = 8 -- rotate speed
	}

	-- movable component
	self.speed = 0
	self.movable = {
		velocity = { x = 0, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = 0, y = 0 },
		maxVelocity = { x = 0, y = 0 },
	}

	-- shooter component
	self.shooter = {
		atkDelay = 0.1,
		canAtk = true,
		shoot = false -- if shoot input is pressed
	}

	-- collider component
	-- self.collider = {
	-- 	w = self.sprite:getWidth(),
	-- 	h = self.sprite:getHeight(),
	-- 	isSolid = true
	-- }

	return self
end

function Player:update(dt)
end

return Player