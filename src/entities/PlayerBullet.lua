local Bullet = require "src.entities.Bullet"

local PlayerBullet = Bullet:extend()

function PlayerBullet:new(x, y, angle, speed)
	PlayerBullet.super.new(self, x, y, angle, speed)
	self.name = "PlayerBullet"
	self.isPlayerBullet = true

	self:setDrawLayer("playerBullet")

	return self
end

function Bullet:onCollision(other, delta)
	if not self.toRemove and other.isEnemy and other.isAlive and not other.toRemove then
		self:die()
	end
end

return PlayerBullet