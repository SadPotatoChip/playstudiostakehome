grid = {}
gridRows = 19
gridColumns = 10

function initializePlayArea()
for i = 0, gridRows - 1 do
    grid[i] = {}
    for j = 0, gridColumns - 1 do
        grid[i][j] = nil
        end
    end
end

function canBlockMoveInDirection(block, direction)     
  if direction == "left" then
    if block.x <= 0 or grid[block.y][block.x - 1] ~= nil then
      return false
    end
  elseif direction == "right" then
    if block.x >= gridColumns - 1 or grid[block.y][ block.x+1] ~= nil then
      return false
    end
  elseif direction == "down" then
    if block.y >= gridRows - 1 or grid[block.y+1][ block.x] ~= nil then
      return false
    end
  end
  
  return true
end

function onTetriminoLanded(tetrimino)
  
  if false == tryInsertTetriminoIntoGrid(tetrimino) then
    initializePlayArea()
  end
  
  --TODO destroy filled rows
  
end

function tryInsertTetriminoIntoGrid(tetrimino)
  -- check if the game is over
  for i = 0, #tetrimino.blocks do
    if tetrimino.blocks[i].y <= 0 then
      return false
    end
  end
  
  for i = 0, #tetrimino.blocks do
    local block = tetrimino.blocks[i]
    grid[block.y][block.x] = block;
  end  
  
  return true
end

function onDrawPlayArea()
  for i = 0, gridRows - 1 do    
    for j = 0, gridColumns - 1 do
      if grid[i][j] ~= nil then
        grid[i][j]:onDraw()
      end
    end
  end
end




