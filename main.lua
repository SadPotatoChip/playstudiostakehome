require("block")
require("tetriminos")
require("spriteLoader")

local currentTetrimino
local time = 0

function love.load()
  loadSprites()
  currentTetrimino = TetriminoO.new();
end

function love.update(dt)
  time = time + dt
  if time >= 1 then
    time = 0
    currentTetrimino:move("down")
  end  
end

function love.keypressed(key, scancode, isrepeat)
   if key == "a" or key == "left" then
      currentTetrimino:move("left")
   end
   if key == "d" or key == "right" then
      currentTetrimino:move("right")
   end
end

function love.draw()
  currentTetrimino:onDraw()
end