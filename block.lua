require("spriteLoader")

Block = {}
Block.__index = Block
BlockSpriteSize = 42

function Block.new (color, parent)
  local instance = setmetatable({}, Block)
  instance.x = 0
  instance.y = 0
  instance.parent = parent
  instance.color = color 
  return instance
end

function Block:move(direction)
    if direction == "left" then
      self:setPosition(self.x-1, self.y)
    elseif direction == "right" then
      self:setPosition(self.x+1, self.y)
    elseif direction == "down" then
      self:setPosition(self.x, self.y+1)
    else 
      print("(" .. direction .. ") is not a valid direction to move the block")
    end
end

function Block:setPosition(x, y) 
    --print(y)
    self.x = x
    self.y = y
end

function Block:onDraw() 
    love.graphics.draw(loadedSprites[self.color], self.x * BlockSpriteSize, self.y * BlockSpriteSize )
end

