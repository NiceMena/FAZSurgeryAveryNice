-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
--
-- Created by: Nice Mena
--
-- Date: April 26, 2018
--
-- Description: This is the splash screen of the game. It displays the 
-- company logo that fades in, flys across the screen spinning and plays sound.
-- Their is also text that fades in at the top saying FAZ Games.
-----------------------------------------------------------------------------------------

-- hide the status bar
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

local companyLogo
local areaText
local scrollXSpeed = 8
local scrollYSpeed = 0


------------------------------------------------------------------------------------------------------------------
--sounds
-----------------------------------------------------------------------------------------------------------------------

local fazSounds

-- background sound
local fazSounds = audio.loadSound("Sounds/FAZGamesEdited.wav")
local fazSoundsChannel



--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the company logo across the screen
local function movecompanyLogo()
    companyLogo.x = companyLogo.x + scrollXSpeed
    companyLogo.y = companyLogo.y + scrollYSpeed
end

local function MainMenuTransition ()
    -- Go to the intro screen
    composer.gotoScene( "main_menu" )
end 

local function MovedFazText(event)
      --add the scroll speed to the x-value of text
      FazText.x = FazText.x + scrollSpeed
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    -- Insert the company logo image
    companyLogo = display.newImageRect("Images/CompanyLogoAvery.png", 200, 200)

    -- set the initial x and y position of the company logo
    companyLogo.x = 100
    companyLogo.y = display.contentHeight/2
---------------------------------------------------------------------------------------------
--TEXT
----------------------------------------------------------------------------------------------------------
 --Display phrase on the screen
    FazText = display.newText("FAZ GAMES", 250, 100, Georgia, 100)
    FazText.x = 500
    FazText.y = 150
    scrollSpeed = 0
    --set the text color
    FazText:setTextColor(143/255, 105/255, 18/255)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(companyLogo)
    sceneGroup:insert(FazText)

end -- function scene:create( event )

---- The function called when the scene is issued to appear on screen
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
        -- Call the company logo function as soon as we enter the frame.
        -- Movetext will be called over and over again
        Runtime:addEventListener("enterFrame", MovedFazText)
        Runtime:addEventListener("enterFrame", movecompanyLogo)

        fazSoundsChannel = audio.play(fazSounds) 

        timer.performWithDelay(3000, MainMenuTransition)
        
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


return scene
