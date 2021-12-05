Block = {}
Block.__index = Block

function Block.new (color, parent)
  local instance = setmetatable({}, Block)
  instance.x = 0;
  instance.y = 0;
  instance.parent = parent;
  instance.graphic = love.graphics.newImage("Assets/block_blue.png")
  return instance
end

function Block:move(direction)
    if directon == "left" then
      self:setPosition(self.x-1, self.y);
    elseif direction == "right" then
      self:setPosition(self.x+1, self.y);
    elseif direction == "down" then
      self:setPosition(self.x, self.y+1);
    else 
      print(direction .. " is not a valid direction to move the block")
    end
end

function Block:setPosition(x, y) 
    --print(y)
    self.x = x;
    self.y = y;
end

function Block:onDraw() 
    love.graphics.draw(self.graphic, self.x * 50, self.y * 50 )
end

