local GameObject = require "src.entities.GameObject"

local Bullet = GameObject:extend()
local assets =  require "src.assets"
local vector = require "lib.hump.vector"
local lume = require "lib.lume"
-- local playstate = require "playstate"

function Bullet:new(x, y, angle, speed, drawLayer)
	Bullet.super.new(self, x, y)

	if drawLayer then
		self:setDrawLayer(drawLayer)
	end

	-- entity
	self.name = "Bullet"
	self.isBullet = true

	-- Bullet
	self.sprite = assets.bullet
	self.offset = { x = self.sprite:getWidth() / 2, y = self.sprite:getHeight() / 2 }

	-- MoveTowardsAngle component
	self.moveTowardsAngle = true

	-- movable component
	self.speed = speed or 300
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

	-- randomize a bit
	-- self.pos.x = self.pos.x + lume.random(5,10)
	-- self.pos.y = self.pos.y + lume.random(5,10)
	self.angle = angle + lume.random(-0.05,0.05)

	-- add small padding in front of shooter
	self.pos.x = self.pos.x + (self.pos.x * math.cos(self.angle - math.rad(90)) * 0.2)
	self.pos.y = self.pos.y + (self.pos.y * math.sin(self.angle - math.rad(90)) * 0.2)

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, self.sprite:getWidth(), self.sprite:getHeight())
	self.collider['parent'] = self

	-- destroy if out of screen
	self.destroyOffScreen = true

	return self
end

function Bullet:update(dt)
end

function Bullet:moveRelativeToAngleAndPosition(x, y)
end

function Bullet:onCollision(other, delta)
end

function Bullet:die()
	self.toRemove = true
end

return Bullet