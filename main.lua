io.stdout:setvbuf("no")

-- Global libraries
class = require "lib.30log"
tiny = require "lib.tiny"
editgrid = require "lib.editgrid"
log = require "lib.log"
tlog = require "lib.alfonzm.tlog"
Gamestate = require "lib.hump.gamestate"
Object = require "lib.classic"

-- States
local PlayState = require "playstate"
local MenuState = require "menustate"

-- Declare tiny-ecs world
world = {}
camera = nil

function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(PlayState)
end

function love.update(dt)
end

function love.draw()
	if camera then camera:attach() end
	
	if world and world.update then
		world:update(love.timer.getDelta())
	end

	if camera then camera:detach() end
end