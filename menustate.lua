menustate = {}
local UIText = require "src.entities.UIText"
local PlayState = require "playstate"

local title, pressToPlay
local dir = 1

function menustate:init()
	title = UIText("GUNSLINGER", 0, 150, nil, nil, 60)
	pressToPlay = UIText("Press [SPACE] to play", 0, love.graphics.getHeight() - 150, nil, nil, 16)

	title.shakyX = 2
	title.shakyY = 2

	pressToPlay.shakyX = 2
	pressToPlay.shakyY = 1

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(5,15,10),
		require("src.systems.DrawUISystem")("hudForeground"),
		require("src.systems.ShakySystem")(),
		title,
		pressToPlay
	)

	world = self.world
end

function menustate:update(dt)
	if love.keyboard.isDown("space") then
		Gamestate.switch(PlayState)
	end
end

function menustate:draw()
end

return menustate