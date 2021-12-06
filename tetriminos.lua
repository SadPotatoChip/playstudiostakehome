require("block")

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

function Tetrimino:onDraw()     
    for i = 0, #self.blocks do
        self.blocks[i]:onDraw();
    end
end

--Square Tetrimino
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
  instance.currentRotation = 0
  return instance
end

