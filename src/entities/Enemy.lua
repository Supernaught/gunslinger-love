local Enemy = Object:extend()
local assets =  require "src.assets"

function Enemy:new(x, y)
	self.isEnemy = true

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
	self.speed = speed or 100
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

	return self
end

function Enemy:update(dt)
end

return Enemy