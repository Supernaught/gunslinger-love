playstate = {}

local UIText = require "src.entities.UIText"
local Player = require "src.entities.Player"
local Bullet = require "src.entities.Bullet"
local Camera = require "lib.hump.camera"

local player
local uiScore
local score = 0

function playstate:init()
	uiScore = UIText(score, 20, 20, nil, "left", 20)
	player = Player()
	camera = Camera(player.pos.x, player.pos.y,3)

	self.world = tiny.world(
		require("src.systems.UpdateSystem")(),
		require("src.systems.BGColorSystem")(5,5,30),
		require("src.systems.SpriteSystem")(),
		require("src.systems.PlayerInputSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.RotatableSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		uiScore,
		player,
		Bullet(10,10)
	)

	world = self.world
end

function playstate:update(dt)
end

function playstate:draw()
end

return playstate