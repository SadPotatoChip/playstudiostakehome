require("block")

local testBlock
local time = 0

function love.load()
  testBlock = Block.new("","");
end

function love.update(dt)
  time = time + dt
  if time >= 1 then
    time = 0
    testBlock:move("down")
  end  
end

function love.draw()
  testBlock:onDraw()
end