import "gameObjects/Paddle"
import "gameObjects/EnemyPaddle"
import "gameObjects/ball"


local pd <const> = playdate
local gfx <const> = playdate.graphics

WINNING_SCORE = 10

class("SceneManager").extends()

startGame = false

function SceneManager:initGame()
self.endGame = false
self.gameState = true
leftPaddle, rightPaddle = 0, 0
-- creating the bounds for the walls 
UpperBound = gfx.sprite.addEmptyCollisionSprite(0, -5, screenWidth, 5)
UpperBound:add()
LowerBound = gfx.sprite.addEmptyCollisionSprite(0, screenHeight, screenWidth, 5)
LowerBound:add()
LeftWall = gfx.sprite.addEmptyCollisionSprite(-5, 0, 5, screenHeight)
LeftWall:add()
LeftWall:setTag(WALL_TAGS.leftWall)
RightWall = gfx.sprite.addEmptyCollisionSprite(screenWidth, 0, 5, screenHeight)
RightWall:add()
RightWall:setTag(WALL_TAGS.rightWall)
Paddle(8, 120)
gameBall = Ball(screenWidth / 2, screenHeight / 2)
EnemyPaddle(392, 120, gameBall)

end

function SceneManager:startScreen()
    gfx.drawTextAligned("Press Ⓐ to start!", screenWidth / 2, screenHeight / 2 - 27, kTextAlignment.center)
    gfx.drawTextAligned("First player to reach 10 wins!", screenWidth / 2, screenHeight / 2 - 2, kTextAlignment.center)
    if pd.buttonIsPressed(pd.kButtonA) then 
        startGame = true
        gfx.clear()
        gfx.sprite.removeAll()

        self:initGame()
    end 
   
end

function SceneManager:gameOverScreen()
    gfx.sprite.removeAll()
    gfx.clear()
    gfx.drawTextAligned("Game over!", screenWidth / 2, screenHeight / 2 - 25, kTextAlignment.center)
    gfx.drawTextAligned("Press Ⓐ to play again!", screenWidth / 2, screenHeight / 2 - 5, kTextAlignment.center)

    if pd.buttonIsPressed(pd.kButtonA) then 
        self:initGame()
    end 
end

function SceneManager:isGameOver()
    if leftPaddle == WINNING_SCORE or rightPaddle == WINNING_SCORE then 
        self.endGame = true
    end 
    
    return self.endGame
end
function SceneManager:update()

    if not startGame and not self.gameState then 
        self:startScreen()
        return 
    end 
    if self:isGameOver() then 
        self:gameOverScreen()
        return
    end 
    gfx.drawTextAligned(leftPaddle .. " : " .. rightPaddle, screenWidth / 2, 5, kTextAlignment.center)
    --gfx.sprite.update()
end 