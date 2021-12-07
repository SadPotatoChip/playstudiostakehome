require("block")
require("tetriminos")
require("spriteLoader")
require("playArea")

local currentTetrimino
local time = 0

function love.load()
  loadSprites()
  currentTetrimino = TetriminoO.new()
  initializePlayArea()
end

function love.update(dt)
  time = time + dt
  if time >= 0.1 then
    time = 0
    if false == currentTetrimino:tryMove("down") then
      onTetriminoLanded(currentTetrimino)
      currentTetrimino = TetriminoL.new()
    end    
  end  
end

function love.keypressed(key, scancode, isrepeat)
   if key == "a" or key == "left" then
      currentTetrimino:tryMove("left")
   end
   if key == "d" or key == "right" then
      currentTetrimino:tryMove("right")
   end
   if key == "s" or key == "down" then
      currentTetrimino:drop()
   end
   if key == "space" or key == "w" or key == "r" then
      currentTetrimino:tryRotate()
   end

end

function love.draw()
  currentTetrimino:onDraw()
  onDrawPlayArea()
end