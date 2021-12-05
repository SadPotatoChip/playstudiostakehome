Tetrimino = {}
Tetrimino.__index = Tetrimino

function Tetrimino.new ()
  local instance = setmetatable({}, Tetrimino)

  return instance
end