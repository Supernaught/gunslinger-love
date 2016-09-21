local Bullet = Object:extend()
local assets =  require "src.assets"
local vector = require "lib.hump.vector"

function Bullet:new(x, y)

	self.isBullet = true

	self.pos = { x = x or 0, y = y or 0, z = { asd = 1 } }
	tlog.print(self.pos)
	self.scale = {}
	self.rot = 0
	self.offset = { x = 0, y = 0 }

	-- movable component
	self.movable = {
		velocity = { x = 0, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = 0, y = 0 },
		maxVelocity = { x = 0, y = 0 },
		speed = { x = 0, y = 0 } -- used to assign to acceleration
	}

	-- rotatable component
	self.rotatable = {
		speed = 10,
		velocity = 0,
		acceleration = 0,
		drag = 30,
		maxVelocity = 12
	}

	return self
end

function Bullet:update(dt)
end

return Bullet