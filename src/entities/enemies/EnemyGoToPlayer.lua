local Explosion = require "src.entities.Explosion"
local Enemy = require "src.entities.Enemy"

local EnemyGoToPlayer = Enemy:extend()
local assets =  require "src.assets"

function EnemyGoToPlayer:new(x, y)
	EnemyGoToPlayer.super.new(self, x, y)
	self.name = "EnemyGoToPlayer"
	self.isEnemyGoToPlayer = true

	-- sprite component
	-- self.sprite = assets.enemy

	-- move to player
	self.moveTowardsTarget = true
	self.targetPos = { x = playstate.getPlayer().pos.x, y = playstate.getPlayer().pos.y }
	self.moveTargetSpeed = 100

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, self.gridSize.x, self.gridSize.y)
	self.collider['parent'] = self

	-- setmetatable(self, { __index = collider })

	return self
end

function EnemyGoToPlayer:update(dt)
	-- self.collider:rotate(self.angle)
end

function EnemyGoToPlayer:onCollision(other)
	if other.isBullet and self.isAlive and other.isAlive then
		self:die()
	end
end

function EnemyGoToPlayer:hit(damage)
end

function EnemyGoToPlayer:die()
	EnemyGoToPlayer.super.die(self)
end

function EnemyGoToPlayer:arrivedAtTarget()
	playstate.gameOver()
end

return EnemyGoToPlayer