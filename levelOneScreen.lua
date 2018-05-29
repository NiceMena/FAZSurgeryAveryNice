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
sceneName = "levelOneScreen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local backButton
local pauseButton

local correctAnswer

-- the organs
local heart 
local brain 
local stomach

-- the boxes where you drag each image
local heartBox
local brainBox
local stomachBox


-- cat character
local cat

-- Variables containing the user answer and the actual answer
local userAnswer

-- boolean variables telling me which answer box was touched
local heartAlreadyTouched = false
local heartBoxAlreadyTouched = false
local brainBoxAlreadyTouched = false
local stomachBoxAlreadyTouched = false

-- create variables that will hold the previous x- and y-positions so that 
-- each answer will return back to its previous position after it is moved
local heartPreviousX
local heartPreviousY

local brainPreviousX
local brainPreviousY

local stomachPreviousX
local stomachPreviousY

-- set the boolean varibales to know if they have already touched an image 
local brainAlreadyTouched = false 
local heartAlreadyTouched = false 
local intestineAlreadyTouched = false 
local stomachAlreadyTouched = false

-- the black box where the user will drag the answer
local heartBox1
local heartBox2
local heartBox3
local heartBox4
local heartBox5
local heartBox6

local brainBox1
local brainBox2
local brainBox3
local brainBox4
local brainBox5
local brainBox6

local stomachBox1
local stomachBox2
local stomachBox3
local stomachBox4
local stomachBox5
local stomachBox6

-- incorrect answer 
local incorrect = 0
local incorrectObject

-- incorrect sound
local incorrectSound = audio.loadSound("Sounds/incorrect.mp3")
local incorrectSoundChannel

-- points
local points = 0
local pointsObject

-- french text
local french
local frenchObject

-- correctSound
local correctSound = audio.loadSound("Sounds/correct.mp3")
local correctSoundChannel

-- the instructions
local instructionsText

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function DisplayHeartQuestion()

    --change question text in relation to answer
    instructionsText.text = instructionsText .. ""

    -- put the correct answer into the heart
    heart.text = correctAnswer

    -- make it possible to click on the answers again
    heartAlreadyTouched = false
    heartBoxAlreadyTouched = false 

    brainAlreadyTouched = false 
    brainBoxAlreadyTouched = false 
    
    stomachAlreadyTouched = false 
    stomachBoxAlreadyTouched = false

end

local function DetermineAlternateAnswers()
   
    -- generate incorrect answer and set it in the textbox
    brainBox = brain

    -- generate incorrect answer and set it in the textbox
    stomachBox = stomach

-------------------------------------------------------------------------------------------
-- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
-- placed into the black box)
-----------------------------------------------------------------------------------------
    heart.x = display.contentWidth * 0.9
    brainBox.x = display.contentWidth * 0.9
    stomachBox.x = display.contentWidth * 0.9
end 

local function DisplayBrainQuestion()

    --change question text in relation to answer
    instructionsText.text = instructionsText .. ""

    -- put the correct answer into the heart
    brain.text = correctAnswer

    -- make it possible to click on the answers again
    heartAlreadyTouched = false
    heartBoxAlreadyTouched = false 

    brainAlreadyTouched = false 
    brainBoxAlreadyTouched = false 
    
    stomachAlreadyTouched = false 
    stomachBoxAlreadyTouched = false

end

local function DetermineAlternateAnswers()
   
    -- generate incorrect answer and set it in the textbox
    heartBox = heart

    -- generate incorrect answer and set it in the textbox
    stomachBox = stomach

-------------------------------------------------------------------------------------------
-- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
-- placed into the black box)
-----------------------------------------------------------------------------------------
    heart.x = display.contentWidth * 0.9
    brainBox.x = display.contentWidth * 0.9
    stomachBox.x = display.contentWidth * 0.9
end 

local function DisplayStomachQuestion()

    --change question text in relation to answer
    instructionsText.text = instructionsText .. ""

    -- put the correct answer into the heart
    stomach.text = correctAnswer

    -- make it possible to click on the answers again
    heartAlreadyTouched = false
    heartBoxAlreadyTouched = false 

    brainAlreadyTouched = false 
    brainBoxAlreadyTouched = false 
    
    stomachAlreadyTouched = false 
    stomachBoxAlreadyTouched = false

end

local function DetermineAlternateAnswers()
   
    -- generate incorrect answer and set it in the textbox
    heartBox = heart

    -- generate incorrect answer and set it in the textbox
    brainBox = brain

-------------------------------------------------------------------------------------------
-- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
-- placed into the black box)
-----------------------------------------------------------------------------------------
    heart.x = display.contentWidth * 0.9
    brainBox.x = display.contentWidth * 0.9
    stomachBox.x = display.contentWidth * 0.9

end 


-- Function to Check User Input
local function CheckUserAnswerInput()
--[[
    if (userAnswer == correctAnswer) then
        points = points + 1 
        pointsObject.text = points .. ""
        correctSoundChannel = audio.play(correctSound)
    else
        incorrect = incorrect + 1
        incorrectObject.text = " incorrect answer = " .. incorrect
        incorrectSoundChannel = audio.play (incorrectSound)
    end 
]]--

    if (incorrect == 3) then 
        composer.gotoScene("you_lose", {effect = "fade", time = 500})
        pointsObject.isVisible = false
    else 
        timer.performWithDelay(1600, RestartLevel1) 

    end


    if (points == 3) then
        composer.gotoScene("bravoScreenOne", {effect = "fade", time = 300})
        pointsObject.isVisible = false
    else
        timer.performWithDelay(1600, RestartLevel1) 

    end
end





-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "levelSelectScreen", {effect = "fade", time = 500})
    -- generate answer and set it in the textbox
    heartBox = heart
    -- generate answer and set it in the textbox
    brainBox = brain
    -- generate answer and set it in the textbox
    stomachBox = stomach
end

-- Creating Transitioning Function to pause screen 
local function PauseTransition( )
    composer.gotoScene( "PauseScreen", {effect = "slideDown", time = 500})
end


local function TouchListenerHeart(touch)
    --only work if none of the other boxes have been touched
    if (brainAlreadyTouched == false) and 
        (intestineAlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            heartAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            heart.x = touch.x
            heart.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            heartAlreadyTouched = false

              -- if the number is dragged into the userheart, place it in the center of it
            if (((heartBox.x - heartBox.width/2) < heart.x ) and
                ((heartBox.x + heartBox.width/2) > heart.x ) and 
                ((heartBox.y - heartBox.height/2) < heart.y ) and 
                ((heartBox.y + heartBox.height/2) > heart.y ) ) then

                -- setting the position of the heart to be in the center of the box
                heart.x = heartBox.x
                heart.y = heartBox.y

                points = points + 1 
                pointsObject.text = points .. ""
                correctSoundChannel = audio.play(correctSound)
               
                CheckUserAnswerInput()


           elseif (((stomachBox.x - stomachBox.width/2) < heart.x ) and
                ((stomachBox.x + stomachBox.width/2) > heart.x ) and 
                ((stomachBox.y - stomachBox.height/2) < heart.y ) and 
                ((stomachBox.y + stomachBox.height/2) > heart.y ) ) then

                heart.x = stomachBox.x
                heart.y = stomachBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)
                heart.x = heartPreviousX
                heart.y = heartPreviousY

                CheckUserAnswerInput()

            elseif (((brainBox.x - brainBox.width/2) < heart.x ) and
                ((brainBox.x + brainBox.width/2) > heart.x ) and 
                ((brainBox.y - brainBox.height/2) < heart.y ) and 
                ((brainBox.y + brainBox.height/2) > heart.y ) ) then


                heart.x = brainBox.x
                heart.y = brainBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)
                heart.x = heartPreviousX
                heart.y = heartPreviousY

                CheckUserAnswerInput()

                
            end
        end
    end                
end 


local function TouchListenerBrain(touch)
    --only work if none of the other boxes have been touched
    if (heartAlreadyTouched == false) and 
        (stomachAlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            brainAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            brain.x = touch.x
            brain.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            brainAlreadyTouched = false

              -- if the number is dragged into the userheart, place it in the center of it
            if (((brainBox.x - brainBox.width/2) < brain.x ) and
                ((brainBox.x + brainBox.width/2) > brain.x ) and 
                ((brainBox.y - brainBox.height/2) < brain.y ) and 
                ((brainBox.y + brainBox.height/2) > brain.y ) ) then

                -- setting the position of the number to be in the center of the box
                brain.x = brainBox.x
                brain.y = brainBox.y

                points = points + 1 
                pointsObject.text = points .. ""
                correctSoundChannel = audio.play(correctSound)
               
                CheckUserAnswerInput()


             elseif (((stomachBox.x - stomachBox.width/2) < brain.x ) and
                ((stomachBox.x + stomachBox.width/2) > brain.x ) and 
                ((stomachBox.y - stomachBox.height/2) < brain.y ) and 
                ((stomachBox.y + stomachBox.height/2) > brain.y ) ) then

                brain.x = stomachBox.x
                brain.y = stomachBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)


                brain.x = brainPreviousX
                brain.y = brainPreviousY

                CheckUserAnswerInput()

            elseif (((heartBox.x - heartBox.width/2) < brain.x ) and
                ((heartBox.x + heartBox.width/2) > brain.x ) and 
                ((heartBox.y - heartBox.height/2) < brain.y ) and 
                ((heartBox.y + heartBox.height/2) > brain.y ) ) then


                brain.x = heartBox.x
                brain.y = heartBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)

                brain.x = brainPreviousX
                brain.y = brainPreviousY

                CheckUserAnswerInput()

            elseif (((heartBox.x - heartBox.width/2) < brain.x ) and
                ((heartBox.x + heartBox.width/2) > brain.x ) and 
                ((heartBox.y - heartBox.height/2) < brain.y ) and 
                ((heartBox.y + heartBox.height/2) > brain.y ) ) then


                brain.x = heartBox.x
                brain.y = heartBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)
                brain.x = brainPreviousX
                brain.y = brainPreviousY

                CheckUserAnswerInput()

            end
        end
    end                
end 


local function TouchListenerStomach(touch)
    --only work if none of the other boxes have been touched
    if (heartAlreadyTouched == false) and 
        (brainAlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            stomachAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            stomach.x = touch.x
            stomach.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            stomachAlreadyTouched = false

              -- if the number is dragged into the userheart, place it in the center of it
            if (((stomachBox.x - stomachBox.width/2) < stomach.x ) and
                ((stomachBox.x + stomachBox.width/2) > stomach.x ) and 
                ((stomachBox.y - stomachBox.height/2) < stomach.y ) and 
                ((stomachBox.y + stomachBox.height/2) > stomach.y ) ) then

                -- setting the position of the number to be in the center of the box
                stomach.x = stomachBox.x
                stomach.y = stomachBox.y

                points = points + 1 
                pointsObject.text = points .. ""
                correctSoundChannel = audio.play(correctSound)
            
               
                CheckUserAnswerInput()


            
            elseif (((brainBox.x - brainBox.width/2) < stomach.x ) and
                ((brainBox.x + brainBox.width/2) > stomach.x ) and 
                ((brainBox.y - brainBox.height/2) < stomach.y ) and 
                ((brainBox.y + brainBox.height/2) > stomach.y ) ) then

                stomach.x = brainBox.x
                stomach.y = brainBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)

                stomach.x = stomachPreviousX
                stomach.y = stomachPreviousY

                CheckUserAnswerInput()

            elseif (((heartBox.x - heartBox.width/2) < stomach.x ) and
                ((heartBox.x + heartBox.width/2) > stomach.x ) and 
                ((heartBox.y - heartBox.height/2) < stomach.y ) and 
                ((heartBox.y + heartBox.height/2) > stomach.y ) ) then


                stomach.x = heartBox.x
                stomach.y = heartBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)

                stomach.x = stomachPreviousX
                stomach.y = stomachPreviousY

                CheckUserAnswerInput()

            elseif (((heartBox.x - heartBox.width/2) < stomach.x ) and
                ((heartBox.x + heartBox.width/2) > stomach.x ) and 
                ((heartBox.y - heartBox.height/2) < stomach.y ) and 
                ((heartBox.y + heartBox.height/2) > stomach.y ) ) then


                stomach.x = heartBox.x
                stomach.y = heartBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)
                stomach.x = stomachPreviousX
                stomach.y = stomachPreviousY

                CheckUserAnswerInput()

                
            end
        end
    end                
end 




local function AddOrganListeners ()
    heart:addEventListener("touch", TouchListenerHeart)
    brain:addEventListener("touch", TouchListenerBrain)
    stomach:addEventListener("touch", TouchListenerStomach)
    
end

local function RemoveOrganListeners ()
    heart:removeEventListener("touch", TouchListenerHeart)
    brain:removeEventListener("touch", TouchListenerBrain)
    stomach:removeEventListener("touch", TouchListenerStomach)
end

local function ResetOrganPosition()
    heart.x = display.contentWidth * 8.5 / 10
    heart.y = display.contentHeight * 3.55 / 10

    stomach.x = display.contentWidth * 8.4 / 10
    stomach.y = display.contentHeight * 8.1 / 10

    brain.x = display.contentWidth * 8.5 / 10
    brain.y = display.contentHeight * 5.7 / 10

end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    

    ----------------------------------------------------------------------------------
    --Inserting backgroud image and lives
    ----------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/LevelOneScreen.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY  

    -- the text that displays the heart question
    instructionsText = display.newText( "Drag the organs into the correct place." , 0, 0, nil, 40)
    instructionsText.x = display.contentWidth * 0.35
    instructionsText.y = display.contentHeight * 0.95
    instructionsText:setTextColor(0, 0, 0)


    -- put the cat on the screen 
    cat = display.newImageRect("Images/CatCharacterAvery.png", 400, 500)
    cat.x = display.contentWidth * 1.4/4
    cat.y = display.contentHeight/2


    -- create the images 
    heart = display.newImageRect("Images/heart.png", 100, 100)
    heart.x = display.contentWidth * 8.5 / 10
    heart.y = display.contentHeight * 3.55 / 10
    heart.myName = "heart"

    -- get the initial location of the heart
    heartPreviousX = heart.x
    heartPreviousY = heart.y

    
    -- create the images 
    stomach = display.newImageRect("Images/stomach.png", 100, 100)
    stomach.x = display.contentWidth * 8.4 / 10
    stomach.y = display.contentHeight * 8.1 / 10
    stomach.myName = "stomach"

    -- get the initial location of the stomach
    stomachPreviousX = stomach.x
    stomachPreviousY = stomach.y


    -- create the images 
    brain = display.newImageRect("Images/brain.png", 100, 100)
    brain.x = display.contentWidth * 8.5 / 10
    brain.y = display.contentHeight * 5.7 / 10
    brain.myName = "brain"

    -- get the initial location of the brain
    brainPreviousX = brain.x
    brainPreviousY = brain.y
    
    -- insert the boxes that will hold each of the organs
    heartBox = display.newImageRect("Images/heartBox.png", 120, 120)
    heartBox.x = display.contentWidth * 2.6/8
    heartBox.y = display.contentHeight *1/2

    brainBox = display.newImageRect("Images/brainBox.png", 120, 120)
    brainBox.x = display.contentWidth * 2.6/8
    brainBox.y = display.contentHeight *0.6/2

    stomachBox = display.newImageRect("Images/stomachBox.png", 120, 120)
    stomachBox.x = display.contentWidth * 2.6/8
    stomachBox.y = display.contentHeight *1.4/2

    -- display the points object
    pointsObject = display.newText( "" , 0, 0, nil, 100)
    pointsObject.x = display.contentWidth * 0.5/3
    pointsObject.y = display.contentHeight * 1/8
    pointsObject.isVisible = false 

    -- display the incorrect object
    incorrectObject = display.newText(" incorrect answers = " .. incorrect, 0, 0, nil, 30)
    incorrectObject.x = display.contentWidth * 2.35/3
    incorrectObject.y = display.contentHeight * 1.5/8
    incorrectObject:setTextColor (0,0,0)




    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*1/8,
        y = display.contentHeight*1.5/16,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressed.png",
        overFile = "Images/BackButtonPressed.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    -- Creating pause Button
    pauseButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*7/8,
        y = display.contentHeight*1.5/16,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/PauseButton.png",
        overFile = "Images/PauseButtonPressed.png",

        -- Setting Functional Properties
        onRelease = PauseTransition

    } )

    -- creatind dimensions for the pause button
    pauseButton.width = 100
    pauseButton.height = 100 


    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( bkg_image ) 
    sceneGroup:insert( backButton )
    sceneGroup:insert( instructionsText )
    sceneGroup:insert( cat )
    sceneGroup:insert( heart )
    sceneGroup:insert( heartBox )
    sceneGroup:insert( brain )
    sceneGroup:insert( brainBox )
    sceneGroup:insert( stomach )
    sceneGroup:insert( stomachBox )
    sceneGroup:insert( incorrectObject )
    sceneGroup:insert( pauseButton )

    
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
        AddOrganListeners ()
        ResetOrganPosition()
        points = 0

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

        RemoveOrganListeners()
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
