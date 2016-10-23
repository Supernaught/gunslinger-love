local EnemyGoToPlayer = require "src.entities.enemies.EnemyGoToPlayer"

local EnemyBigGoToPlayer = Enemy:extend()
local assets =  require "src.assets"

function EnemyBigGoToPlayer:new(x, y)
	EnemyBigGoToPlayer.super.new(self, x, y)
	self.name = "EnemyBigGoToPlayer"
	self.isEnemyBigGoToPlayer = true

	self.hp = 15

	-- move to player
	self.moveTowardsTarget = true
	self.targetPos = { x = PlayState.getPlayer().pos.x, y = PlayState.getPlayer().pos.y }
	self.moveTargetSpeed = 25

	-- sprite
	self.sprite = assets.enemyBig
	self.gridSize = {x = 60, y= 60}
	self.offset = { x = self.gridSize.x/2, y = self.gridSize.y/2 }
	local g = anim8.newGrid(self.gridSize.x, self.gridSize.y, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-3',1), 0.1)

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, self.gridSize.x, self.gridSize.y)
	self.collider['parent'] = self

	return self
end

return EnemyBigGoToPlayer