playstate = {}

local UIText = require "src.entities.UIText"
local Player = require "src.entities.Player"
local Camera = require "lib.hump.camera"

local player
local uiScore
local score = 0

function playstate:init()
	uiScore = UIText(score, 20, 20, nil, "left", 12)
	player = Player()
	camera = Camera(player.pos.x, player.pos.y,1)

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(5,5,30),
		require("src.systems.UpdateSystem")(),
		require("src.systems.ShooterSystem")(),
		require("src.systems.MoveTowardsAngleSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.PlayerInputSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.RotatableSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		uiScore,
		player
	)

	world = self.world
end

return playstate