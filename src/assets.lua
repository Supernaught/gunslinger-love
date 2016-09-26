local assets = {}

love.graphics.setDefaultFilter("nearest", "nearest")

-- Images
assets.player = love.graphics.newImage("assets/player.png")
assets.bullet = love.graphics.newImage("assets/bullet.png")
assets.enemy = love.graphics.newImage("assets/enemy.png")

-- Fonts
-- assets.fnt_reallysmallhud = love.graphics.newFont("assets/font.ttf", 24)

return assets
