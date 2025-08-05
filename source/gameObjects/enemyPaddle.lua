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
    self.moveSpeed = 5
    self:setCollideRect(0, 0, self:getSize())
    self.ball = ball
end

function math.sign(x)
    if x < 0 then return -1 end 
    if x > 0 then return 1 end
    return 0
end


function EnemyPaddle:update()

    local goalY = 0
   
    local ballIncoming = self.ball.xVelocity > 0
   
    
    if ballIncoming then 
        --print("Incoming") -- debug print 
        -- changed logic for paddle AI in order to make it a tiny bit smarter 
        -- whether or not that worked is none of my business 
        if math.abs(self.ball.y - self.y) > 4 then -- returns absolute value, 4 represents a buffer for less crazy movement overall
            goalY = math.sign(self.ball.y - self.y) * self.moveSpeed 
        end 
    end 
    self:moveWithCollisions(self.x, self.y + goalY)
    

end 