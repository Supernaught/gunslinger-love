local playstate = {}

-- lib
local Camera = require "lib.hump.camera"
local HClib = require "lib.hc"

-- entities
local UIText = require "src.entities.UIText"
local Player = require "src.entities.Player"
local Enemy = require "src.entities.Enemy"
local EnemyBasicWalker = require "src.entities.enemies.EnemyBasicWalker"
local Bullet = require "src.entities.Bullet"
local Spawner = require "src.entities.Spawner"

local player
local uiScore
local score = 0

world = nil
HC = nil

function playstate:enter()
	timer.clear()
	HC = HClib.new(150)

	score = 0
	
	uiScore = UIText(score, 0, 20, push:getWidth(), "center", 12)
	player = Player()
	camera = Camera(player.pos.x, player.pos.y)


	self.world = tiny.world(
		require("src.systems.BGColorSystem")(50,50,50),
		require("src.systems.DestroyOffScreenSystem")(),
		require("src.systems.UpdateSystem")(),
		require("src.systems.CollisionSystem")(),
		require("src.systems.ShooterSystem")(),
		require("src.systems.MoveTowardsAngleSystem")(),
		require("src.systems.MoveTowardsTargetSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.SpriteSystem")("player"),
		require("src.systems.SpriteSystem")("playerBullet"),
		require("src.systems.PlayerInputSystem")(),
		require("src.systems.MovableSystem")(),
		-- require("src.systems.RotatableSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		uiScore,
		-- EnemyBasicWalker(0, 0),
		-- Enemy(180, 200),
		-- Enemy(0, 100),
		-- Enemy(20,20)
		player
	)

	world = self.world
	-- world:add(Spawner())
end

function playstate:keypressed(k)
	if k == 'space' then
		screen:setShake(8)
		-- screen:setRotation(.2)
	elseif k == 's' then
		screen:setShake(70)
	elseif k == 'q' then
		Gamestate.switch(MenuState)
	elseif k == 'r' then
		Gamestate.switch(PlayState)
	end

	if k == '1' then
		player:equipWeapon("pistol")
	elseif k == '2' then
		player:equipWeapon("machineGun")
	elseif k == '3' then
		player:equipWeapon("dualPistol")
	elseif k == '4' then
		player:equipWeapon("shotgun")
	end
end

function playstate:update(dt)
	-- print(world:getEntityCount())
end

function playstate:draw()
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()) .. "\nEntities: " .. world:getEntityCount())
end

function playstate.getPlayer()
	return player
end

function playstate.gameOver()
	timer.after(2, function() Gamestate.switch(MenuState) end)
	player:die()
end

function playstate.addScore(scoreToAdd)
	score = score + (scoreToAdd or 1)
	uiScore.text = score
end

return playstate