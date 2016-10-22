local menustate = {}

local flux = require "lib.flux"
local UIText = require "src.entities.UIText"
local assets =  require "src.assets"

local title, pressToPlay
local dir = 1

function menustate:enter()
	timer.clear()
	
	local titleImage = UIText("GUNSLINGER", 0, 60, push:getWidth())
	-- titleImage.shakyX = 0.7
	-- titleImage.shakyY = 0.7

	local pressStart = UIText("Press SPACE to start", 0, push:getHeight() - 50, push:getWidth(), nil, 10)

	self.world = tiny.world(
		require("src.systems.ShakySystem")(),
		require("src.systems.BGColorSystem")(0,0,10),
		require("src.systems.DrawUISystem")("hudForeground"),
		titleImage,
		pressStart
	)

	-- flux.to(titleImage.pos, 0.5, {y = 60})

	world = self.world
end

function menustate:update(dt)
	flux.update(dt)
end

function menustate:keypressed(k)
	if k == 'space' or k == 'return' then
		Gamestate.switch(playstate)
	end
end

function menustate:draw()
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()) .. "\nEntities: " .. world:getEntityCount())
end

return menustate