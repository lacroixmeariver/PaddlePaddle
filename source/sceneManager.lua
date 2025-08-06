import "gameObjects/Paddle"
import "gameObjects/EnemyPaddle"
import "gameObjects/ball"


local pd <const> = playdate
local gfx <const> = playdate.graphics

WINNING_SCORE = 10


class("SceneManager").extends()

--startGame = false


local menuItems = {"Start Game", "Settings", "Exit"}
local selectedOption = 1
local arrowImage = gfx.image.new("assets/arrow")
local arrowSprite = gfx.sprite.new(arrowImage)
arrowSprite:setImage(arrowImage)

function SceneManager:initGame()
--self.endGame = false
--self.gameState = true
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
    --gfx.clear()
    --gfx.sprite.removeAll()
    gfx.drawTextAligned("Press Ⓐ to start!", screenWidth / 2, screenHeight / 2 - 27, kTextAlignment.center)
    gfx.drawTextAligned("First player to reach 10 wins!", screenWidth / 2, screenHeight / 2 - 2, kTextAlignment.center)
    if pd.buttonIsPressed(pd.kButtonA) then 
        --startGame = true
        gfx.clear()
        gfx.sprite.removeAll()
        GAME_STATE = GAME_STATE_TAGS.RUNNING
        self:startGame()
    end 
   
end

function SceneManager:startGame()
    gfx.clear()
    gfx.sprite.removeAll()
    self:initGame()
end 

function SceneManager:gameOverScreen()
    gfx.sprite.removeAll()
    gfx.clear()
    gfx.drawTextAligned("Game over!", screenWidth / 2, screenHeight / 2 - 25, kTextAlignment.center)
    gfx.drawTextAligned("Press Ⓐ to play again!", screenWidth / 2, screenHeight / 2 - 5, kTextAlignment.center)

    if pd.buttonJustPressed(pd.kButtonA) then 
        --self:initGame()
        GAME_STATE = GAME_STATE_TAGS.START
    end 
end

function SceneManager:isGameOver()
    if leftPaddle >= WINNING_SCORE or rightPaddle >= WINNING_SCORE then 
        --self.endGame = true
        GAME_STATE = GAME_STATE_TAGS.END
    end 
    
    return self.endGame
end

function SceneManager:menuScreen()
    -- gfx.drawTextAligned("Menu screen", screenWidth / 2, screenHeight / 2 - 27, kTextAlignment.center)
    -- gfx.drawTextAligned("Press Ⓐ to start", screenWidth / 2, screenHeight / 2 - 5, kTextAlignment.center)
    
    
    for i, item in ipairs(menuItems) do 
        local y = 80 + (i-1) * 20
        gfx.drawText(item, 100, y) -- menu options 
        if i == selectedOption then 
            arrowSprite:moveTo(85, y + 7)
        end 
        arrowSprite:add()
    end 


    -- if pd.buttonJustPressed(pd.kButtonA) then 
    --     gfx.sprite.removeAll()
    --     gfx.clear()
    --     GAME_STATE = GAME_STATE_TAGS.START
    --     --self:startScreen()

    -- end
    --gfx.clear()
end

function playdate.upButtonDown()
    selectedOption -= 1
    if selectedOption < 1 then selectedOption = #menuItems
    end 
    
end

function playdate.downButtonDown()
    selectedOption += 1
    if selectedOption > #menuItems then selectedOption = 1 end 
    
end


function pd:AButtonDown()
    --local menu = self:menuScreen()
    if GAME_STATE == GAME_STATE_TAGS.TITLE then 
        local selection = menuItems[selectedOption]
        if selection == "Start Game" then 
            GAME_STATE = GAME_STATE_TAGS.START
            return 
        end
    end 
end

function SceneManager:update()  
    
    if GAME_STATE == GAME_STATE_TAGS.TITLE then 
        self:menuScreen()
        return
    end
    if GAME_STATE == GAME_STATE_TAGS.START then 
        self:startScreen()
        return
    end
    if GAME_STATE == GAME_STATE_TAGS.END then 
        self:gameOverScreen()
        return
    end
    if GAME_STATE == GAME_STATE_TAGS.RUNNING then 
        gfx.drawTextAligned(leftPaddle .. " : " .. rightPaddle, screenWidth / 2, 5, kTextAlignment.center)
    end
    self:isGameOver()
    arrowSprite:remove()
end 

