-- requires
local GameObject = require "src.entities.GameObject"
local Bullet = require "src.entities.Bullet"

local Player = GameObject:extend()
local assets =  require "src.assets"

function Player:new(x, y)
	Player.super.new(self, x or push:getWidth()/2, y or push:getHeight()/2)
	self.name = "Player"	
	self.isPlayer = true

	-- sprite component
	self.sprite = assets.player
	self.offset = { x = self.sprite:getWidth() / 2, y = self.sprite:getHeight() / 2 }

	-- rotatable component
	self.rotatable = {
		velocity = 0,
		acceleration = 0,
		drag = 30,
		maxVelocity = 10 -- rotate speed
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
		atkDelay = 0.05,
		canAtk = true,
		shoot = false -- if shoot input is pressed
	}

	return self
end

function Player:shoot()
	world:addEntity(Bullet(self.pos.x, self.pos.y, self.angle))

	-- screen:setShake(2)
	-- screen:setRotation(0.05)
end

function Player:update(dt)
end

return Player