playstate = {}

-- lib
local Camera = require "lib.hump.camera"
local bump = require "lib.bump"

-- entities
local UIText = require "src.entities.UIText"
local Player = require "src.entities.Player"
local Enemy = require "src.entities.Enemy"
local Bullet = require "src.entities.Bullet"

local player
local uiScore
local score = 0

function playstate:init()
	self.bumpWorld = bump.newWorld(10)

	uiScore = UIText(score, 20, 20, nil, "left", 12)
	player = Player()
	camera = Camera(player.pos.x, player.pos.y)

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(50,50,50),
		require("src.systems.UpdateSystem")(),
		require("src.systems.CollisionSystem")(self.bumpWorld),
		require("src.systems.ShooterSystem")(),
		require("src.systems.MoveTowardsAngleSystem")(),
		require("src.systems.MoveTowardsTargetSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.PlayerInputSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.RotatableSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		uiScore,
		player
		-- Enemy(20, 20)
	)

	world = self.world
end

function love.keypressed(k)
	if k == 'space' then
		screen:setShake(8)
		screen:setRotation(.2)
	elseif k == 's' then
		screen:setShake(70)
	end
end

function getPlayer()
	return player
end

return playstate