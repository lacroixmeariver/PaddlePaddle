import "Corelibs/object"
import "Corelibs/graphics"
import "Corelibs/timer"
import "Corelibs/sprites"
import "gameObjects/Paddle"
import "gameObjects/EnemyPaddle"
import "SceneManager"


local pd <const> = playdate
local gfx <const> = playdate.graphics
-- some global measurements of the screen width and height to make my life easier 
screenWidth = pd.display.getWidth()
screenHeight = pd.display.getHeight()

WALL_TAGS = {
    leftWall = 100,
    rightWall = 001,
    topBound = 000,
    lowerBound = 999,
    paddle = 111

}

GAME_STATE_TAGS = {
    TITLE = 1000,
    START = 2000,
    RUNNING = 2200,
    PAUSE = 2500,
    END = 0000,
    SETTINGS = 1111
}

GAME_STATE = GAME_STATE_TAGS.TITLE -- setting the initial game state as the title screen 

SCENEMANAGER = SceneManager()
SCENEMANAGER:menuScreen()



function playdate.update()
    
    gfx.sprite.update()
    SCENEMANAGER:update()

    
    
end 