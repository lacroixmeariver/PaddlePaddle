
local pd <const> = playdate
local gfx <const> = playdate.graphics

class ("Paddle").extends(gfx.sprite)

function Paddle:init(x, y)
    -- creating the sprite using png 
    local paddleImage = gfx.image.new("assets/paddleImage")
    self.paddleSprite = gfx.sprite.new(paddleImage)
    self:setImage(paddleImage)
    -- moving it to desired location 
    self:moveTo(x, y)
    -- making it show up on the screen 
    self:add()
    self.moveSpeed = 5
    self:setCollideRect(0, 0, self:getSize())
    -- setting a tag to be able to categorize collisions later 
    self:setTag(WALL_TAGS.paddle)
    
end

function Paddle:update()
    local goalX, goalY = 0,0
    local crankPosition = pd:getCrankPosition()
    
    if pd.isCrankDocked() == false then 
        if (crankPosition >= 270 or crankPosition <= 90) then 
            goalY += self.moveSpeed
        else if (crankPosition <= 270 or crankPosition >= 180) then
            goalY -= self.moveSpeed
        end
    end
    end
    self:moveWithCollisions(self.x + goalX, self.y + goalY)
end