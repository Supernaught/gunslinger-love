GameObject = require "src.entities.GameObject"
Explosion = require "src.entities.Explosion"
Enemy = require "src.entities.Enemy"
lume = require "lib.lume"

local EnemyBasicWalker = Enemy:extend()
local assets =  require "src.assets"

function EnemyBasicWalker:new()
	EnemyBasicWalker.super.new(self, 0, 0)
	self.name = "EnemyBasicWalker"
	self.isEnemyBasicWalker = true

	-- sprite/animation component
	self.sprite = assets.enemy
	self.offset = { x = 6, y = 6 }

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, 8, 8)
	self.collider['parent'] = self

	self:setupBehavior()

	return self
end

function EnemyBasicWalker:setupBehavior()
	spawnOnSide = lume.randomchoice({0,1})
	spawnPos = {x = 0, y = 0}

	local xVel, yVel = 0, 0

	local mainSpeed = math.random(50,70)
	local randomSpeed = 10

	if spawnOnSide == 0 then
		spawnPos.x = lume.randomchoice({0,push:getWidth()})
		spawnPos.y = math.random(0,push:getHeight())
		if spawnPos.x == 0 then
			xVel = mainSpeed
		else
			xVel = -mainSpeed
		end

		yVel = math.random(-randomSpeed,randomSpeed)
	else
		spawnPos.x = math.random(0,push:getWidth())
		spawnPos.y = lume.randomchoice({0,push:getHeight()})
		if spawnPos.y == 0 then
			yVel = mainSpeed
		else
			yVel = -mainSpeed
		end
		xVel = math.random(-randomSpeed,randomSpeed)
	end

	self.pos.x = spawnPos.x
	self.pos.y = spawnPos.y

	self.movable.velocity.x = xVel
	self.movable.velocity.y = yVel

	if xVel < 0 then
		self.flippedH = true
	end

end

function EnemyBasicWalker:update(dt)
end

function EnemyBasicWalker:draw()
	EnemyBasicWalker.super.draw(self)
end

function EnemyBasicWalker:die()
	EnemyBasicWalker.super.die(self)
end

return EnemyBasicWalker
