menustate = {}

local flux = require "lib.flux"
local UIText = require "src.entities.UIText"
local PlayState = require "src.states.playstate"
local assets =  require "src.assets"

local title, pressToPlay
local dir = 1

function menustate:init()
	local titleImage = UIText("GUNSLINGER", 0, 50, push:getWidth())
	titleImage.shakyX = 0.7
	titleImage.shakyY = 0.7

	local pressStart = UIText("Press SPACE to start", 0, push:getHeight() - 50, push:getWidth(), nil, 10)

	self.world = tiny.world(
		require("src.systems.ShakySystem")(),
		require("src.systems.BGColorSystem")(0,0,10),
		require("src.systems.DrawUISystem")("hudForeground"),
		titleImage,
		pressStart
	)

	world = self.world
end

function menustate:update(dt)
	flux.update(dt)
end

function menustate:keypressed(k)
	if k == 'space' or k == 'return' then
		Gamestate.switch(PlayState)
	end
end

return menustate