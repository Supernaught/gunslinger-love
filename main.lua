io.stdout:setvbuf("no")

-- Game libraries
class = require "lib.30log"
tiny = require "lib.tiny"
editgrid = require "lib.editgrid"
Gamestate = require "lib.hump.gamestate"
Object = require "lib.classic"
timer = require "lib.hump.timer"
anim8 = require "lib.anim8"

-- Ulydev camera options
screen = require "lib.shack"
push = require "lib.push"

-- utils
log = require "lib.log"
tlog = require "lib.alfonzm.tlog"
escquit = require "lib.alfonzm.escquit"

-- States
MenuState = require "src.states.menustate"
PlayState = require "src.states.playstate"

-- Game settings
local scale = 3 -- should be the same as in conf

local assets =  require "src.assets"
reg = require "src.reg"

-- Declare tiny-ecs world
world = {}
camera = nil

function love.load()
	setupPushScreen()

	Gamestate.registerEvents()
	-- Gamestate.switch(PlayState)
	Gamestate.switch(MenuState)
end

function love.update(dt)
	screen:update(dt)
	timer.update(dt)
end

function love.draw()
	push:apply("start")
	screen:apply()
	
	if world and world.update then
		world:update(love.timer.getDelta())
	end

	push:apply("end")
end

function love.keypressed(k)
	if k == '`' then
		reg.DEBUG_COLLIDERS = not reg.DEBUG_COLLIDERS
	end

	escquit:update(k)
end

function setupPushScreen()
	-- setup push screen
	local windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()
	local gameWidth, gameHeight = windowWidth / scale, windowHeight / scale
	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false})
	screen:setDimensions(push:getDimensions())
end