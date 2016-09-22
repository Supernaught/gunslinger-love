io.stdout:setvbuf("no")

-- Game libraries
class = require "lib.30log"
tiny = require "lib.tiny"
editgrid = require "lib.editgrid"
Gamestate = require "lib.hump.gamestate"
Object = require "lib.classic"

-- utils
log = require "lib.log"
tlog = require "lib.alfonzm.tlog"
escquit = require "lib.alfonzm.escquit"

-- States
local PlayState = require "playstate"
local MenuState = require "menustate"

-- Declare tiny-ecs world
world = {}
camera = nil

-- canvas
local canvas = love.graphics.newCanvas(480,360)
local scale = 2

function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(PlayState)
end

function love.update(dt)
end

function love.draw()
	love.graphics.setCanvas(canvas)

	-- if camera then camera:attach() end
	
	if world and world.update then
		world:update(love.timer.getDelta())
	end

	-- if camera then camera:detach() end

	love.graphics.setCanvas()
	love.graphics.draw(canvas,0,0,0,scale,scale)
end