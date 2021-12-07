require("block")
require("playArea")

Tetrimino = {}
Tetrimino.__index = Tetrimino

local tetriminoSpawnXCoordinate = 4;

function Tetrimino:tryMove(direction)
  
  --check if the space we are tryin to move to is available and valid
  for i = 0, #self.blocks do
    if false == canBlockMoveInDirection(self.blocks[i], direction) then
      return false
    end
  end
  
  for i = 0, #self.blocks do
      self.blocks[i]:move(direction);
  end
  return true;
end

function Tetrimino:drop()
  local canDrop = true
  while canDrop do
    canDrop = self:tryMove("down")
  end
end

function Tetrimino:tryRotate() 
  
  --handle O tetrimino
  if #self.rotations == 0 then
    return true
  end

  local targetRotationIndex = self.currentRotation + 1
  if targetRotationIndex > #self.rotations then
    targetRotationIndex = 1
  end

  local targetRotation = self.rotations[targetRotationIndex]
  local newBlockLocations = {}    

  for i = 1, 4 do
    --print("old " .. self.blocks[i-1].x .. ", " .. self.blocks[i-1].y)
    local newLocation = {targetRotation[i][1] + self.blocks[i-1].x, targetRotation[i][2] + self.blocks[i-1].y}
    --print("new " .. newLocation[1] .. ", " .. newLocation[2])
    if areCoordinatesUnoccupied(newLocation[1], newLocation[2]) then
      newBlockLocations[i] = newLocation
    else
      print("rotate location: (" .. newLocation[1] .. ", " .. newLocation[2] .. ") is invalid")
      return false;
    end
  end

  self.currentRotation = targetRotationIndex
  for i = 1, 4 do
    --print("from " .. self.blocks[i-1].x .. ", " .. self.blocks[i-1].y)
    --print("to " .. newBlockLocations[i][1] .. ", " .. newBlockLocations[i][2])
    self.blocks[i-1]:setPosition(newBlockLocations[i][1],newBlockLocations[i][2])
  end
  return true
end

function Tetrimino.getRandomTetrimino()
  local r = love.math.random(7)
end
  

function Tetrimino:onDraw()     
    for i = 0, #self.blocks do
        self.blocks[i]:onDraw();
    end
end

TetriminoO = {}
TetriminoO.__index = Tetrimino

function TetriminoO.new ()
  local instance = setmetatable({}, Tetrimino)
  instance.blocks = {}
  for i = 0, 3 do
    instance.blocks[i] = Block.new("red", instance)
  end
  
  instance.blocks[0]:setPosition(tetriminoSpawnXCoordinate, 0)
  instance.blocks[1]:setPosition(tetriminoSpawnXCoordinate + 1, 0)
  instance.blocks[2]:setPosition(tetriminoSpawnXCoordinate, 1)
  instance.blocks[3]:setPosition(tetriminoSpawnXCoordinate + 1, 1)
  
  instance.rotations = {}
  instance.currentRotation = 1
  return instance
end

TetriminoL = {}
TetriminoL.__index = Tetrimino

function TetriminoL.new ()
  local instance = setmetatable({}, Tetrimino)
  instance.blocks = {}
  for i = 0, 3 do
    instance.blocks[i] = Block.new("orange", instance)
  end
  
  instance.blocks[0]:setPosition(tetriminoSpawnXCoordinate -1, 0)
  instance.blocks[1]:setPosition(tetriminoSpawnXCoordinate, 0)
  instance.blocks[2]:setPosition(tetriminoSpawnXCoordinate , 1)
  instance.blocks[3]:setPosition(tetriminoSpawnXCoordinate, 2)
  
  instance.rotations = {
      {{0, 0},{0,0},{-1,1},{1,1}},
      {{2, 0},{-1,1},{0,0},{1,-1}},
      {{-2,0},{0,0},{-1,1},{-1,1}},
      {{0,0},{1,-1},{2,-2},{-1,-1}}
    }
    
  instance.currentRotation = 1
  return instance
end

