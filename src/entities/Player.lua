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
		defaultSpeed = 10,
		speed = 10,
		maxVelocity = nil -- rotate speed
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

	-- OTHER PROPERTIES

	self.weapon = nil
	self:equipWeapon("pistol")

	self.weaponShoots = {}
	self:setupWeaponShoots()

	return self
end

function Player:shoot()
	self.weaponShoots[self.weapon](self)
	-- screen:setShake(2)
	-- screen:setRotation(0.05)
end

function Player:setupWeaponShoots()
	-- Pistol
	self.weaponShoots.pistol = function(self)
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.angle))
	end

	-- Machinegun
	self.weaponShoots.machineGun = self.weaponShoots.pistol

	-- Dual pistol
	self.weaponShoots.dualPistol = function(self)
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.angle))
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.angle + math.rad(180)))
	end

	-- Shotgun
	self.weaponShoots.shotgun = function(self)
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.angle + math.rad(7)))
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.angle + math.rad(-7)))
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.angle))
	end
end

function Player:equipWeapon(weapon)
	self.weapon = weapon
	self.shooter.atkDelay = reg.weaponStats[weapon].atkDelay
	self.rotatable.speed = reg.weaponStats[weapon].rotateSpeed or self.rotatable.defaultSpeed
end

function Player:die()
	love.graphics.setLineStyle('rough')
	love.graphics.circle("fill", self.pos.x, self.pos.y, 30, 100)

	screen:setShake(40)
	self.isAlive = true
	self.toRemove = true
end

function Player:update(dt)
end

return Player