local assets = {}

love.graphics.setDefaultFilter("nearest", "nearest")

-- Images
assets.player = love.graphics.newImage("assets/player.png")
assets.playerEye = love.graphics.newImage("assets/unit/player_eye.png")
assets.playerSpriteSheet = love.graphics.newImage("assets/unit/player_model_1.png")
assets.bullet = love.graphics.newImage("assets/bullet.png")
assets.coin = love.graphics.newImage("assets/coin.png")

	-- enemies
	assets.enemy = love.graphics.newImage("assets/enemy.png")
	assets.enemyBig = love.graphics.newImage("assets/enemy_big.png")

-- Fonts
-- assets.fnt_reallysmallhud = love.graphics.newFont("assets/font.ttf", 24)

-- Shaders
assets.sparkShader = love.graphics.newShader("assets/shaders/spark.fs")

return assets
