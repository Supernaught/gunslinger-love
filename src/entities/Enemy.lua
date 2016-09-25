local Enemy = Object:extend()
local assets =  require "src.assets"

function Enemy:new(x, y)
	self.name = "Enemy"
	self.isEnemy = true

	-- entity
	self.toRemove = false
	self.isAlive = true

	-- transform
	self.pos = { x = x or 20, y = y or 20 }
	self.scale = {}
	self.angle = 0 -- in radians

	-- sprite component
	self.sprite = assets.player
	self.offset = { x = self.sprite:getWidth() / 2, y = self.sprite:getHeight() / 2 }

	-- move to player
	self.moveTowardsTarget = true
	self.targetPos = { x = getPlayer().pos.x, y = getPlayer().pos.y }

	-- movable component
	self.speed = speed or 60
	self.movable = {
		velocity = { x = 0, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = 0, y = 0 },
		maxVelocity = { x = 0, y = 0 },
	}

	-- rotatable component
	self.rotatable = {
		velocity = 0,
		acceleration = 0,
		drag = 30,
		maxVelocity = 12 -- rotate speed
	}

	-- shooter component
	self.shooter = {
		atkDelay = 0.04,
		canAtk = true,
		shoot = false -- if shoot input is pressed
	}

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, self.sprite:getWidth(), self.sprite:getHeight())
	self.collider['parent'] = self

	-- setmetatable(self, { __index = collider })

	return self
end

function Enemy:update(dt)
	self.collider:rotate(self.angle)
end

function Enemy:onCollision(other)
	if other.isBullet and self.isAlive then
		self:die()
	end
end

function Enemy:hit(damage)
end

function Enemy:die()
	self.toRemove = true
	self.isAlive = false
	print("DIE")
end

return Enemy