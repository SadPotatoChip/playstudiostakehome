require("block")
require("tetriminos")
require("spriteLoader")
require("playArea")

local currentTetrimino
local dropIndicator
local isGamePlaying
local time = 0

function love.load()
  loadSprites()
  currentTetrimino = Tetrimino.getRandomTetrimino()
  dropIndicator =  DropIndicator.new()
  initializePlayArea()
  updateIndicatorPosition(currentTetrimino, dropIndicator)
  isGamePlaying = true
end

function love.update(dt)
  if isGamePlaying then
    time = time + dt
    
    if time >= 0.3 then
      time = 0
      if false == currentTetrimino:tryMove("down") then
        onTetriminoLanded(currentTetrimino)
        currentTetrimino = Tetrimino.getRandomTetrimino()
        updateIndicatorPosition(currentTetrimino, dropIndicator)
      end    
    end  
  end
end

function love.keypressed(key, scancode, isrepeat)
  if isGamePlaying then
    local isInputValid = false
    if key == "a" or key == "left" then
      currentTetrimino:tryMove("left")
      isInputValid = true
    end
    if key == "d" or key == "right" then
      currentTetrimino:tryMove("right")
      isInputValid = true
    end
    if key == "s" or key == "down" then
      currentTetrimino:drop()
      isInputValid = true
    end
    if key == "space" or key == "w" or key == "r" then
      currentTetrimino:tryRotate()
      isInputValid = true
    end  
    if isInputValid then updateIndicatorPosition(currentTetrimino, dropIndicator) end
  end
  
end

function love.draw()
  dropIndicator:onDraw()
  currentTetrimino:onDraw()  
  onDrawPlayArea()
end
