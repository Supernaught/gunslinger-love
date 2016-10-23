local Enemy = require "src.entities.Enemy"

local EnemyGoToPlayer = Enemy:extend()
local assets =  require "src.assets"

function EnemyGoToPlayer:new(x, y)
	EnemyGoToPlayer.super.new(self, x, y)
	self.name = "EnemyGoToPlayer"
	self.isEnemyGoToPlayer = true

	-- move to player
	self.moveTowardsTarget = true
	self.targetPos = { x = PlayState.getPlayer().pos.x, y = PlayState.getPlayer().pos.y }
	self.moveTargetSpeed = 100

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, self.gridSize.x, self.gridSize.y)
	self.collider['parent'] = self

	-- self.rotatable = {speed = 0, velocity = 5, acceleration = 0, drag = 0, maxVelocity = nil }

	return self
end

function EnemyGoToPlayer:arrivedAtTarget()
	if PlayState.getPlayer().isAlive then
		self:die()
		PlayState.gameOver()
	end
end

return EnemyGoToPlayer