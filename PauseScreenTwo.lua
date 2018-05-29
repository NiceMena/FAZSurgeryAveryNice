-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Avery Mack
-- Date: April 10, 2018
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "PauseScreenTwo"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image
local resumeButton
local mainMenuButton
local levelsButton

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function to resume the game
local function ResumeTransition( )
    composer.gotoScene( "levelTwoScreen", {effect = "slideUp", time = 500})
end

-- Creating Transitioning Function to main menu
local function mainMenuTransition( )
    composer.gotoScene( "main_menu", {effect = "slideLeft", time = 500})
end

-- Creating Transitioning Function to levels screen 
local function levelsTransition( )
    composer.gotoScene( "levelSelectScreen", {effect = "slideRight", time = 500})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/PauseScreenAveryM.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )   

    -- Creating resume Button
    resumeButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*2.8/5,
        y = display.contentHeight*3.5/16,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/ResumeButton.png",
        overFile = "Images/ResumeButton.png",

        -- Setting Functional Properties
        onRelease = ResumeTransition

    } )

    -- creating dimensions for the resume button
    resumeButton.width = 75
    resumeButton.height = 75

    -- Creating main menu  Button
    mainMenuButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*2.8/5,
        y = display.contentHeight*6.5/16,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/mainMenuButton.png",
        overFile = "Images/mainMenuButton.png",

        -- Setting Functional Properties
        onRelease = mainMenuTransition

    } )

    -- creating dimensions for the main menu button
    mainMenuButton.width = 75
    mainMenuButton.height = 75

    -- Creating levels Button
    levelsButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*2.8/5,
        y = display.contentHeight*9.5/16,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/LevelsButton.png",
        overFile = "Images/LevelsButton.png",

        -- Setting Functional Properties
        onRelease = levelsTransition

    } )

    -- creating dimensions for the levles button button
    levelsButton.width = 75
    levelsButton.height = 75

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( resumeButton )
    sceneGroup:insert( mainMenuButton )
    sceneGroup:insert( levelsButton)
    
end --function scene:create( event ) 

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear onscreen 
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
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
