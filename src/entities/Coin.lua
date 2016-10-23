local flux = require "lib.flux"

local GameObject = require "src.entities.GameObject"

local Coin = GameObject:extend()
local assets = require "src.assets"

local defaultMoveTargetSpeed = 150

function Coin:new(x, y)
	Coin.super.new(self, x, y)
	self.name = "Coin"
	self.isCoin = true

	-- move to player
	self.moveTowardsTarget = true
	local player = PlayState.getPlayer()
	self.targetPos = { x = player.pos.x, y = player.pos.y }
	self.moveTargetSpeed = 0

	-- sprite/animation components
	self.sprite = assets.coin
	self.gridSize = {x = 12, y= 12}
	self.offset = { x = self.gridSize.x/2, y = self.gridSize.y/2 }
	local g = anim8.newGrid(self.gridSize.x, self.gridSize.y, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-4',1), 0.09)

	-- movable
	self.movable = {
		velocity = { x = 0, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = 0, y = 0 },
		maxVelocity = { x = 0, y = 0 },
	}

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, self.gridSize.x * 3, self.gridSize.y * 3)
	self.collider['parent'] = self

	self.hp = 1

	flux.to(self, 2, {moveTargetSpeed = 0})

	return self
end

function Coin:arrivedAtTarget()
	if PlayState.getPlayer().isAlive then
		self:pickedUp()
	end
end

function Coin:pickedUp()
	self:die()
end

function Coin:onCollision(other)
	if self.toRemove then
		return
	end

	if other.isPlayer then
		self:pickedUp()
	elseif other.isPlayerBullet then
		self.moveTargetSpeed = defaultMoveTargetSpeed
		flux.to(self, 2, {moveTargetSpeed = 0})
	end
end

function Coin:die()
	self.toRemove = true
end

function Coin:update(dt)
	flux.update(dt)
end

return Coin