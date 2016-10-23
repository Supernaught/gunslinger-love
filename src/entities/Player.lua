--libs
local flux = require "lib.flux"

-- requires
local GameObject = require "src.entities.GameObject"
local Bullet = require "src.entities.Bullet"

local Player = GameObject:extend()
local assets =  require "src.assets"

function Player:new(x, y)
	Player.super.new(self, x or push:getWidth()/2, y or push:getHeight()/2)
	self.name = "Player"	
	self.isPlayer = true
	self:setDrawLayer("player")

	self.origPos = {x = self.pos.x, y = self.pos.y}

	-- sprite component
	self.sprite = assets.playerSpriteSheet
	self.flippedH = false
	self.gridSize = {x = 50, y = 50}
	self.offset = { x = 25, y = 25 }
	local g = anim8.newGrid(self.gridSize.x, self.gridSize.y, self.sprite:getWidth(), self.sprite:getHeight(), 0, 50)
	self.animation = anim8.newAnimation(g('1-4',1), 0.15)

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, self.gridSize.x, self.gridSize.y)
	self.collider['parent'] = self

	-- rotatable component
	-- self.rotatable = {
	-- 	velocity = 0,
	-- 	acceleration = 0,
	-- 	drag = 30,
	-- 	defaultSpeed = 10,
	-- 	speed = 10,
	-- 	maxVelocity = nil -- rotate speed
	-- }

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
		shoot = false, -- if shoot input is pressed

		-- custom shooter fields
		shootAngle = 0,
		defaultRotateSpeed = 10,
		rotateSpeed = 10
	}

	-- OTHER PROPERTIES
	-- tween back to orig pos
	self.tweenToOrigPos = flux.to(self.pos, 1, {x = self.origPos.x})

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
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.shooter.shootAngle, nil, "playerBullet"))
	end

	-- Machinegun
	self.weaponShoots.machineGun = self.weaponShoots.pistol

	-- Dual pistol
	self.weaponShoots.dualPistol = function(self)
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.shooter.shootAngle, nil, "playerBullet"))
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.shooter.shootAngle + math.rad(180), nil, "playerBullet"))
	end

	-- Shotgun
	self.weaponShoots.shotgun = function(self)
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.shooter.shootAngle + math.rad(7)), nil, "playerBullet")
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.shooter.shootAngle + math.rad(-7)), nil, "playerBullet")
		world:addEntity(Bullet(self.pos.x, self.pos.y, self.shooter.shootAngle), nil, "playerBullet")
	end
end

function Player:equipWeapon(weapon)
	self.weapon = weapon
	self.shooter.atkDelay = reg.weaponStats[weapon].atkDelay
	self.shooter.rotateSpeed = reg.weaponStats[weapon].rotateSpeed or self.shooter.defaultRotateSpeed
end

function Player:die()
	love.graphics.setLineStyle('rough')
	love.graphics.circle("fill", self.pos.x, self.pos.y, 30, 100)

	screen:setShake(40)
	self.isAlive = true
	self.toRemove = true
end

function Player:update(dt)
	flux.update(dt)
	self:updateAnimations()
end

function Player:updateAnimations()
	local tweenTarget = {x = self.pos.x, y = self.pos.y }
	self.flippedH = (math.deg(self.shooter.shootAngle) % 360) > 180

	if self.shooter.shoot then
		tweenTarget.x = self.origPos.x + (self.origPos.x * math.cos(self.shooter.shootAngle - math.rad(90)) * 0.03)
		tweenTarget.y = self.origPos.y + (self.origPos.y * math.sin(self.shooter.shootAngle - math.rad(90)) * 0.03)
		flux.to(self.pos, 0.1, {x = tweenTarget.x, y = tweenTarget.y})
	else
		tweenTarget = {x = self.origPos.x, y = self.origPos.y}
		flux.to(self.pos, 1, {x = tweenTarget.x, y = tweenTarget.y})
	end

end

function Player:onCollision()
end

return Player