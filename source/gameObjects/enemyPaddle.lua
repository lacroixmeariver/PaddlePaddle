import "gameObjects/ball"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class("EnemyPaddle").extends("Paddle")

function EnemyPaddle:init(x, y, ball)
    local paddleImage = gfx.image.new("assets/paddleImage")
    self.paddleSprite = gfx.sprite.new(paddleImage)
    self:setImage(paddleImage)
    self:moveTo(x, y)
    self:add()
    self.moveSpeed = 2.5
    self:setCollideRect(0, 0, self:getSize())
    self.ball = ball
end



function EnemyPaddle:update()

    -- this movement was written with the intention of a 2 player game and then i remembered how small the playdate is 
    local goalY = 0
    -- if pd.buttonIsPressed(pd.kButtonDown) then 
    --     goalY += self.moveSpeed
    -- end
    -- if pd.buttonIsPressed(pd.kButtonUp) then 
    --     goalY -= self.moveSpeed
    -- end
    -- self:moveWithCollisions(self.x + goalX, self.y + goalY)

    
    if self.ball.y > 120 then
        goalY += self.moveSpeed
    else if self.ball.y < 120 then 
        goalY -= self.moveSpeed
    end
end 

    self:moveWithCollisions(self.x, self.y + goalY)

end 