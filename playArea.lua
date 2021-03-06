grid = {}
gridRows = 19
gridColumns = 10

--I feel like this should have somehow been a singleton but I think thats just due to me working in object oriented languages for too long, in any case I am not sure how best to implement this in lua, it seems very messy and it's hard to understand where these functions are coming from in other files.

function initializePlayArea()
  for i = 0, gridRows - 1 do
    grid[i] = {}
    for j = 0, gridColumns - 1 do
      --empty grid location is represented by a nil
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


--returns number of rows destroyed when the tetrimino landed or nil if the location where we are attempting to insert the tetrimino is invalid
function onTetriminoLanded(tetrimino)
  
  if false == tryInsertTetriminoIntoGrid(tetrimino) then
    return nil
  end
    
  return destroyFilledRows()
  
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
    grid[block.y][block.x] = block
  end  
  
  return true
end

function destroyRow(n)
  for  i = 0, gridColumns do
    --I feel as tho I should somehow release this memory even tho the GC will do it :D
    if grid[n][i]~=nil then
      grid[n][i] = nil
    end
  end
  
  --adjust all the blocks in the rows above the one we destroyed
  for i = n, 0, -1 do
    for j = 0, gridColumns do
      if i > 0 then
        grid[i][j] = grid[i-1][j]
        if grid[i][j] ~= nil then
          grid[i][j]:move("down")
        end
        grid[i-1][j] = nil
      end
    end
  end
end


function destroyFilledRows()
    local rowsToDestroy = 0
    for i = 0, gridRows - 1 do
        local isRowFilled = true
        for j = 0, gridColumns - 1 do
          if grid[i][j] == nil then
            isRowFilled = false
            break
          end
        end
        if isRowFilled then
          destroyRow(i)
          rowsToDestroy = rowsToDestroy + 1
        end
    end
    return rowsToDestroy
end

function areCoordinatesUnoccupied(x,y) 
  if x<0 or x >= gridColumns or y<0 or y>=gridRows then
      return false
  end
  return grid[y][x] == nil
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




