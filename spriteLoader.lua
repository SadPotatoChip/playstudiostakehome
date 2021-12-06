SpriteLoader = {}
SpriteLoader.__index = SpriteLoader

SpriteLoader.loadedSprites = {}

function SpriteLoader.loadSprites()
  SpriteLoader.loadedSprites["blue"] = love.graphics.newImage("Assets/block_blue.png")
  SpriteLoader.loadedSprites["green"] = love.graphics.newImage("Assets/block_green.png")
  SpriteLoader.loadedSprites["light_blue"] = love.graphics.newImage("Assets/block_light_blue.png")
  SpriteLoader.loadedSprites["orange"] = love.graphics.newImage("Assets/block_orange.png")
  SpriteLoader.loadedSprites["red"] = love.graphics.newImage("Assets/block_red.png")
  SpriteLoader.loadedSprites["violet"] = love.graphics.newImage("Assets/block_violet.png")
  SpriteLoader.loadedSprites["yellow"] = love.graphics.newImage("Assets/block_yellow.png")  
end
