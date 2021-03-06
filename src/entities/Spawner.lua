local Spawner = Object:extend()
local vector = require "lib.hump.vector"
local lume = require "lib.lume"
local timer = require "lib.hump.timer"
local Enemy = require "src.entities.Enemy"
local EnemyGoToPlayer = require "src.entities.enemies.EnemyGoToPlayer"
local EnemyBigGoToPlayer = require "src.entities.enemies.EnemyBigGoToPlayer"

local spawnMin = 0.5
local spawnMax = 1

function Spawner:new()
	self.name = "Spawner"
	self.isSpawner = true
	self:spawn()
	-- world:add(EnemyBigGoToPlayer(0,0))
	return self

end

function Spawner:update(dt)
end

function Spawner:spawn()
	spawnOnSide = lume.randomchoice({0,1})
	spawnPos = {x = 0, y = 0}

	if spawnOnSide == 0 then
		spawnPos.x = lume.randomchoice({0,push:getWidth()})
		spawnPos.y = math.random(0,push:getHeight())
	else
		spawnPos.x = math.random(0,push:getWidth())
		spawnPos.y = lume.randomchoice({0,push:getHeight()})
	end

	world:add(EnemyGoToPlayer(spawnPos.x, spawnPos.y))
	timer.after(math.random(spawnMin,spawnMax), function() self:spawn() end)
end

return Spawner