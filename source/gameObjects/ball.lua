
local gfx <const> = playdate.graphics

class("Ball").extends(gfx.sprite)

function Ball:init(x, y)
    local ballImage = gfx.image.new("assets/ballImage")
    self.paddleSprite = gfx.sprite.new(ballImage)
    self:setImage(ballImage)
    self:moveTo(x, y)
    self:add()
    self.xVelocity = 3
    self.yVelocity = 2
    self:setCollideRect(4, 4, 8, 8)
    self.direction = 1
    self.interaction = nil
end

function Ball:collisionResponse(other)
    self.interaction = other
    local tag = other:getTag()
    if tag == WALL_TAGS.lowerBound or tag == WALL_TAGS.topBound then 
        print("top or bottom touched")
    end 
    if tag == WALL_TAGS.leftWall then 
        rightPaddle += 1
        print(rightPaddle)
        print("left wall touched")
    end 
    if tag == WALL_TAGS.rightWall then 
        leftPaddle += 1
        print(leftPaddle)
        print("right wall touched")
    end 
    if tag == WALL_TAGS.paddle then 
        print("paddle hit")
    end 
    
    return "bounce"

end 


function Ball:update()


    local newX = self.x + self.xVelocity
    local newY = self.y + self.yVelocity
   

    local _, _, collisions, count = self:moveWithCollisions(newX + self.xVelocity, newY + self.yVelocity)
    -- collisions are a list of what the ball hit 
    -- count is how many things the ball hit 

    for i = 1, count do
        local col = collisions[i]
        local normal = col.normal

        if normal.x ~= 0 then
            self.xVelocity *= -1
        
        else if normal.y ~= 0 then
            self.yVelocity *= -1
        end
    end 
    end
    
    
  
end 

