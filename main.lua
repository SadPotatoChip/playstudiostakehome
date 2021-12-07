require("block")
require("tetriminos")
require("spriteLoader")
require("playArea")

local currentTetrimino
local dropIndicator
local isGamePlaying
local time = 0
local timeBetweenGameTicks = 1
local isLastGameWon = nil
rowsDeleted = 0
rowsRequiredToWin = 1

function love.load()
  loadSprites()
  isGamePlaying = false
end

function initializeNewGame()
  currentTetrimino = Tetrimino.getRandomTetrimino()
  dropIndicator =  DropIndicator.new()
  initializePlayArea()
  updateIndicatorPosition(currentTetrimino, dropIndicator)
  rowsDeleted = 0
  isGamePlaying = true
end

function love.update(dt)
  if isGamePlaying then
    time = time + dt
    
    if time >= timeBetweenGameTicks then
      time = 0
      if false == currentTetrimino:tryMove("down") then
        local nOfDestroyedRows = onTetriminoLanded(currentTetrimino)
        if -1 ~= nOfDestroyedRows then
          currentTetrimino = Tetrimino.getRandomTetrimino()
          updateIndicatorPosition(currentTetrimino, dropIndicator)
          rowsDeleted = rowsDeleted + nOfDestroyedRows
          if rowsDeleted >= rowsRequiredToWin then
            isLastGameWon = true
            isGamePlaying = false
          end
        else
          isLastGameWon = false
          isGamePlaying = false
        end
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
  else
    if key == "1" or key == "2" or key == "3" then
      local playerInput = tonumber(key)
      timeBetweenGameTicks = 0.65 - playerInput * 0.2
      rowsRequiredToWin = 2 * playerInput
      initializeNewGame()
      isInputValid = true
    end  
  end  
end

function love.draw()
  if isGamePlaying then
    dropIndicator:onDraw()
    currentTetrimino:onDraw()  
    onDrawPlayArea()
    love.graphics.print("Destroyed rows to win: " .. rowsDeleted .. "/" .. rowsRequiredToWin)
  else
    love.graphics.print("Press a keyboard key to select difficulty\n1)Easy\n2)Medium\n3)Super Hard")
    if isLastGameWon ~= nil then
      if isLastGameWon then
        love.graphics.print("You Win!", 180, 350)
      else
        love.graphics.print("You Lose..", 180, 350)
      end
    end
    
  end
  
end
