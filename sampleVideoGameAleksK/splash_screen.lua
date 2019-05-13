-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------
--hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local scrollXSpeed = 4
local scrollXSpeed2 = 3

local bkg
local car
local smoke
local RMgames

----------------------------------------------------------------------------------------
-- LOCAL SOUND
-----------------------------------------------------------------------------------------

local carSounds = audio.loadSound("Sounds/BMW.mp3")
local carSoundsChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------


-- The function that moves the car, smoke and text across the screen
local function moveCar()
    car.x = car.x + scrollXSpeed
end

local function moveSmoke()
   smoke.x = smoke.x + scrollXSpeed
end


local function MoveText()
    -- add scroll speed
    RMgames.x = RMgames.x + scrollXSpeed2
end
-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Create the objects here
    bkg = display.newImageRect ("Images/racetrack.jpg", display.contentWidth, display.contentHeight)
    bkg.anchorX = 0
    bkg.anchorY = 0
    bkg.x = 0
    bkg.y = 0

    car = display.newImageRect("Images/CompanyLogoAleksK.png", 500, 300)
    car.x = 500
    car.y = display.contentHeight/2

    smoke = display.newImageRect("Images/smoke.png", 300, 200)
    smoke.x = 110
    smoke.y = 450

    RMgames = display.newText("RM Games", -250, display.contentHeight/2, nil, 80) 
    RMgames:setTextColor(50/255, 50/255, 255/255)



    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg )
    sceneGroup:insert( car )
    sceneGroup:insert( smoke )
    sceneGroup:insert( RMgames )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        carSoundsChannel = audio.play(carSounds )
            
        --Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveCar)

        Runtime:addEventListener("enterFrame", moveSmoke)

        Runtime:addEventListener("enterFrame", MoveText)
        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 4500, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(carSoundsChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
