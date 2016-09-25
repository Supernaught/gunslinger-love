playstate = {}

-- lib
local Camera = require "lib.hump.camera"
local HClib = require "lib.hc"

-- entities
local UIText = require "src.entities.UIText"
local Player = require "src.entities.Player"
local Enemy = require "src.entities.Enemy"
local Bullet = require "src.entities.Bullet"
local Spawner = require "src.entities.Spawner"

local player
local uiScore
local score = 0

world = nil
HC = nil

function playstate:init()
	uiScore = UIText(score, 20, 20, nil, "left", 12)
	player = Player()
	camera = Camera(player.pos.x, player.pos.y)

	HC = HClib.new(150)

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(50,50,50),
		require("src.systems.DestroyOffScreenSystem")(),
		require("src.systems.UpdateSystem")(),
		require("src.systems.CollisionSystem")(),
		require("src.systems.ShooterSystem")(),
		require("src.systems.MoveTowardsAngleSystem")(),
		require("src.systems.MoveTowardsTargetSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.PlayerInputSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.RotatableSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		require("src.systems.SpawnerSystem")(),
		-- uiScore,
		player
		-- Enemy(180, 200),
		-- Enemy(0, 100),
		-- Enemy(20,20)
	)

	world = self.world
	world:add(Spawner())
end

function love.keypressed(k)
	if k == 'space' then
		screen:setShake(8)
		screen:setRotation(.2)
	elseif k == 's' then
		screen:setShake(70)
	end
end

function playstate:update(dt)
	-- print(world:getEntityCount())
	self.FPS = love.timer.getFPS()
end

function playstate:draw()
	love.graphics.print("FPS: " .. tostring(self.FPS) .. "\nEntities: " .. world:getEntityCount())
end

function getPlayer()
	return player
end

return playstate