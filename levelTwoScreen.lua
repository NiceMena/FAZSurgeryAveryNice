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
sceneName = "levelTwoScreen"

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
local lungs 
local eye 
local intestines

-- the boxes where you drag each image
local lungsBox
local eyeBox
local intestinesBox


-- cat character
local cat

-- Variables containing the user answer and the actual answer
local userAnswer

-- boolean variables telling me which answer box was touched
local lungsAlreadyTouched = false
local lungsBoxAlreadyTouched = false
local eyeBoxAlreadyTouched = false
local intestinesBoxAlreadyTouched = false

-- create variables that will hold the previous x- and y-positions so that 
-- each answer will return back to its previous position after it is moved
local lungsPreviousX
local lungsPreviousY

local eyePreviousX
local eyePreviousY

local intestinesPreviousX
local intestinesPreviousY

-- set the boolean varibales to know if they have already touched an image 
local eyeAlreadyTouched = false 
local lungsAlreadyTouched = false 
local intestineAlreadyTouched = false 
local intestinesAlreadyTouched = false

-- the black box where the user will drag the answer
local lungsBox1
local lungsBox2
local lungsBox3
local lungsBox4
local lungsBox5
local lungsBox6

local eyeBox1
local eyeBox2
local eyeBox3
local eyeBox4
local eyeBox5
local eyeBox6

local intestinesBox1
local intestinesBox2
local intestinesBox3
local intestinesBox4
local intestinesBox5
local intestinesBox6

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

local function DisplaylungsQuestion()

    --change question text in relation to answer
    instructionsText.text = instructionsText .. ""

    -- put the correct answer into the lungs
    lungs.text = correctAnswer

    -- make it possible to click on the answers again
    lungsAlreadyTouched = false
    lungsBoxAlreadyTouched = false 

    eyeAlreadyTouched = false 
    eyeBoxAlreadyTouched = false 
    
    intestinesAlreadyTouched = false 
    intestinesBoxAlreadyTouched = false

end

local function DetermineAlternateAnswers()
   
    -- generate incorrect answer and set it in the textbox
    eyeBox = eye

    -- generate incorrect answer and set it in the textbox
    intestinesBox = intestines

-------------------------------------------------------------------------------------------
-- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
-- placed into the black box)
-----------------------------------------------------------------------------------------
    lungs.x = display.contentWidth * 0.9
    eyeBox.x = display.contentWidth * 0.9
    intestinesBox.x = display.contentWidth * 0.9
end 

local function DisplayeyeQuestion()

    --change question text in relation to answer
    instructionsText.text = instructionsText .. ""

    -- put the correct answer into the lungs
    eye.text = correctAnswer

    -- make it possible to click on the answers again
    lungsAlreadyTouched = false
    lungsBoxAlreadyTouched = false 

    eyeAlreadyTouched = false 
    eyeBoxAlreadyTouched = false 
    
    intestinesAlreadyTouched = false 
    intestinesBoxAlreadyTouched = false

end

local function DetermineAlternateAnswers()
   
    -- generate incorrect answer and set it in the textbox
    lungsBox = lungs

    -- generate incorrect answer and set it in the textbox
    intestinesBox = intestines

-------------------------------------------------------------------------------------------
-- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
-- placed into the black box)
-----------------------------------------------------------------------------------------
    lungs.x = display.contentWidth * 0.9
    eyeBox.x = display.contentWidth * 0.9
    intestinesBox.x = display.contentWidth * 0.9
end 

local function DisplayintestinesQuestion()

    --change question text in relation to answer
    instructionsText.text = instructionsText .. ""

    -- put the correct answer into the lungs
    intestines.text = correctAnswer

    -- make it possible to click on the answers again
    lungsAlreadyTouched = false
    lungsBoxAlreadyTouched = false 

    eyeAlreadyTouched = false 
    eyeBoxAlreadyTouched = false 
    
    intestinesAlreadyTouched = false 
    intestinesBoxAlreadyTouched = false

end

local function DetermineAlternateAnswers()
   
    -- generate incorrect answer and set it in the textbox
    lungsBox = lungs

    -- generate incorrect answer and set it in the textbox
    eyeBox = eye

-------------------------------------------------------------------------------------------
-- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
-- placed into the black box)
-----------------------------------------------------------------------------------------
    lungs.x = display.contentWidth * 0.9
    eyeBox.x = display.contentWidth * 0.9
    intestinesBox.x = display.contentWidth * 0.9

end 


-- Function to Check User Input
local function CheckUserAnswerInput()

    if (userAnswer == correctAnswer) then
        points = points + 1 
        pointsObject.text = points .. ""
        correctSoundChannel = audio.play(correctSound)
    else
        incorrect = incorrect + 1
        incorrectObject.text = " incorrect answer = " .. incorrect
        incorrectSoundChannel = audio.play (incorrectSound)
    end 


    if (incorrect == 3) then 
        composer.gotoScene("you_lose", {effect = "fade", time = 500})
        pointsObject.isVisible = false
    else 
        timer.performWithDelay(1600, RestartLevel1) 

    end


    if (points == 3) then
        composer.gotoScene("levelThreeScreen", {effect = "fade", time = 300})
        pointsObject.isVisible = false
    else
        timer.performWithDelay(1600, RestartLevel1) 

    end
end





-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "levelSelectScreen", {effect = "fade", time = 500})
    -- generate answer and set it in the textbox
    lungsBox = lungs
    -- generate answer and set it in the textbox
    eyeBox = eye
    -- generate answer and set it in the textbox
    intestinesBox = intestines
end

-- Creating Transitioning Function to pause screen 
local function PauseTransition( )
    composer.gotoScene( "PauseScreenTwo", {effect = "slideDown", time = 500})
end


local function TouchListenerlungs(touch)
    --only work if none of the other boxes have been touched
    if (eyeAlreadyTouched == false) and 
        (intestineAlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            lungsAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            lungs.x = touch.x
            lungs.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            lungsAlreadyTouched = false

              -- if the number is dragged into the userlungs, place it in the center of it
            if (((lungsBox.x - lungsBox.width/2) < lungs.x ) and
                ((lungsBox.x + lungsBox.width/2) > lungs.x ) and 
                ((lungsBox.y - lungsBox.height/2) < lungs.y ) and 
                ((lungsBox.y + lungsBox.height/2) > lungs.y ) ) then

                -- setting the position of the lungs to be in the center of the box
                lungs.x = lungsBox.x
                lungs.y = lungsBox.y

                points = points + 1 
                pointsObject.text = points .. ""
                correctSoundChannel = audio.play(correctSound)
               
                CheckUserAnswerInput()


           elseif (((intestinesBox.x - intestinesBox.width/2) < lungs.x ) and
                ((intestinesBox.x + intestinesBox.width/2) > lungs.x ) and 
                ((intestinesBox.y - intestinesBox.height/2) < lungs.y ) and 
                ((intestinesBox.y + intestinesBox.height/2) > lungs.y ) ) then

                lungs.x = intestinesBox.x
                lungs.y = intestinesBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)
                lungs.x = lungsPreviousX
                lungs.y = lungsPreviousY

                CheckUserAnswerInput()

            elseif (((eyeBox.x - eyeBox.width/2) < lungs.x ) and
                ((eyeBox.x + eyeBox.width/2) > lungs.x ) and 
                ((eyeBox.y - eyeBox.height/2) < lungs.y ) and 
                ((eyeBox.y + eyeBox.height/2) > lungs.y ) ) then


                lungs.x = eyeBox.x
                lungs.y = eyeBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)
                lungs.x = lungsPreviousX
                lungs.y = lungsPreviousY

                CheckUserAnswerInput()

                
            end
        end
    end                
end 


local function TouchListenereye(touch)
    --only work if none of the other boxes have been touched
    if (lungsAlreadyTouched == false) and 
        (intestinesAlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            eyeAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            eye.x = touch.x
            eye.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            eyeAlreadyTouched = false

              -- if the number is dragged into the userlungs, place it in the center of it
            if (((eyeBox.x - eyeBox.width/2) < eye.x ) and
                ((eyeBox.x + eyeBox.width/2) > eye.x ) and 
                ((eyeBox.y - eyeBox.height/2) < eye.y ) and 
                ((eyeBox.y + eyeBox.height/2) > eye.y ) ) then

                -- setting the position of the number to be in the center of the box
                eye.x = eyeBox.x
                eye.y = eyeBox.y

                points = points + 1 
                pointsObject.text = points .. ""
                correctSoundChannel = audio.play(correctSound)
               
                CheckUserAnswerInput()


             elseif (((intestinesBox.x - intestinesBox.width/2) < eye.x ) and
                ((intestinesBox.x + intestinesBox.width/2) > eye.x ) and 
                ((intestinesBox.y - intestinesBox.height/2) < eye.y ) and 
                ((intestinesBox.y + intestinesBox.height/2) > eye.y ) ) then

                eye.x = intestinesBox.x
                eye.y = intestinesBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)


                eye.x = eyePreviousX
                eye.y = eyePreviousY

                CheckUserAnswerInput()

            elseif (((lungsBox.x - lungsBox.width/2) < eye.x ) and
                ((lungsBox.x + lungsBox.width/2) > eye.x ) and 
                ((lungsBox.y - lungsBox.height/2) < eye.y ) and 
                ((lungsBox.y + lungsBox.height/2) > eye.y ) ) then


                eye.x = lungsBox.x
                eye.y = lungsBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)

                eye.x = eyePreviousX
                eye.y = eyePreviousY

                CheckUserAnswerInput()

            elseif (((lungsBox.x - lungsBox.width/2) < eye.x ) and
                ((lungsBox.x + lungsBox.width/2) > eye.x ) and 
                ((lungsBox.y - lungsBox.height/2) < eye.y ) and 
                ((lungsBox.y + lungsBox.height/2) > eye.y ) ) then


                eye.x = lungsBox.x
                eye.y = lungsBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)
                eye.x = eyePreviousX
                eye.y = eyePreviousY

                CheckUserAnswerInput()

            end
        end
    end                
end 


local function TouchListenerintestines(touch)
    --only work if none of the other boxes have been touched
    if (lungsAlreadyTouched == false) and 
        (eyeAlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            intestinesAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            intestines.x = touch.x
            intestines.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            intestinesAlreadyTouched = false

              -- if the number is dragged into the userlungs, place it in the center of it
            if (((intestinesBox.x - intestinesBox.width/2) < intestines.x ) and
                ((intestinesBox.x + intestinesBox.width/2) > intestines.x ) and 
                ((intestinesBox.y - intestinesBox.height/2) < intestines.y ) and 
                ((intestinesBox.y + intestinesBox.height/2) > intestines.y ) ) then

                -- setting the position of the number to be in the center of the box
                intestines.x = intestinesBox.x
                intestines.y = intestinesBox.y

                points = points + 1 
                pointsObject.text = points .. ""
                correctSoundChannel = audio.play(correctSound)
            
               
                CheckUserAnswerInput()


            
            elseif (((eyeBox.x - eyeBox.width/2) < intestines.x ) and
                ((eyeBox.x + eyeBox.width/2) > intestines.x ) and 
                ((eyeBox.y - eyeBox.height/2) < intestines.y ) and 
                ((eyeBox.y + eyeBox.height/2) > intestines.y ) ) then

                intestines.x = eyeBox.x
                intestines.y = eyeBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)

                intestines.x = intestinesPreviousX
                intestines.y = intestinesPreviousY

                CheckUserAnswerInput()

            elseif (((lungsBox.x - lungsBox.width/2) < intestines.x ) and
                ((lungsBox.x + lungsBox.width/2) > intestines.x ) and 
                ((lungsBox.y - lungsBox.height/2) < intestines.y ) and 
                ((lungsBox.y + lungsBox.height/2) > intestines.y ) ) then


                intestines.x = lungsBox.x
                intestines.y = lungsBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)

                intestines.x = intestinesPreviousX
                intestines.y = intestinesPreviousY

                CheckUserAnswerInput()

            elseif (((lungsBox.x - lungsBox.width/2) < intestines.x ) and
                ((lungsBox.x + lungsBox.width/2) > intestines.x ) and 
                ((lungsBox.y - lungsBox.height/2) < intestines.y ) and 
                ((lungsBox.y + lungsBox.height/2) > intestines.y ) ) then


                intestines.x = lungsBox.x
                intestines.y = lungsBox.y

                incorrect = incorrect + 1
                incorrectObject.text = " incorrect answers = " .. incorrect
                incorrectSoundChannel = audio.play (incorrectSound)
                intestines.x = intestinesPreviousX
                intestines.y = intestinesPreviousY

                CheckUserAnswerInput()

                
            end
        end
    end                
end 




local function AddOrganListeners ()
    lungs:addEventListener("touch", TouchListenerlungs)
    eye:addEventListener("touch", TouchListenereye)
    intestines:addEventListener("touch", TouchListenerintestines)
    
end

local function RemoveOrganListeners ()
    lungs:removeEventListener("touch", TouchListenerlungs)
    eye:removeEventListener("touch", TouchListenereye)
    intestines:removeEventListener("touch", TouchListenerintestines)
end

local function ResetOrganPosition()
    lungs.x = display.contentWidth * 8.5 / 10
    lungs.y = display.contentHeight * 3.55 / 10

    intestines.x = display.contentWidth * 8.4 / 10
    intestines.y = display.contentHeight * 8.1 / 10

    eye.x = display.contentWidth * 8.5 / 10
    eye.y = display.contentHeight * 5.7 / 10

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
    bkg_image = display.newImageRect("Images/LevelTwoScreen@2x.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY  

    -- the text that displays the lungs question
    instructionsText = display.newText( "Drag the organs into the correct place." , 0, 0, nil, 40)
    instructionsText.x = display.contentWidth * 0.35
    instructionsText.y = display.contentHeight * 0.95
    instructionsText:setTextColor(0, 0, 0)



    -- put the cat on the screen 
    cat = display.newImageRect("Images/CatCharacterAvery.png", 400, 500)
    cat.x = display.contentWidth * 1.4/4
    cat.y = display.contentHeight/2


    -- create the images 
    lungs = display.newImageRect("Images/lungs.png", 100, 100)
    lungs.x = display.contentWidth * 8.5 / 10
    lungs.y = display.contentHeight * 3.55 / 10
    lungs.myName = "lungs"

    -- get the initial location of the lungs
    lungsPreviousX = lungs.x
    lungsPreviousY = lungs.y

    
    -- create the images 
    intestines = display.newImageRect("Images/intestines.png", 100, 100)
    intestines.x = display.contentWidth * 8.4 / 10
    intestines.y = display.contentHeight * 8.1 / 10
    intestines.myName = "intestines"

    -- get the initial location of the intestines
    intestinesPreviousX = intestines.x
    intestinesPreviousY = intestines.y


    -- create the images 
    eye = display.newImageRect("Images/eye.png", 100, 100)
    eye.x = display.contentWidth * 8.5 / 10
    eye.y = display.contentHeight * 5.7 / 10
    eye.myName = "eye"

    -- get the initial location of the eye
    eyePreviousX = eye.x
    eyePreviousY = eye.y
    
    -- insert the boxes that will hold each of the organs
    lungsBox = display.newImageRect("Images/lungsBox.png", 120, 120)
    lungsBox.x = display.contentWidth * 2.6/8
    lungsBox.y = display.contentHeight *1/2

    eyeBox = display.newImageRect("Images/eyeBox.png", 120, 120)
    eyeBox.x = display.contentWidth * 2.6/8
    eyeBox.y = display.contentHeight *0.6/2

    intestinesBox = display.newImageRect("Images/intestineBox.png", 120, 120)
    intestinesBox.x = display.contentWidth * 2.6/8
    intestinesBox.y = display.contentHeight *1.4/2

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
    sceneGroup:insert( lungs )
    sceneGroup:insert( lungsBox )
    sceneGroup:insert( eye )
    sceneGroup:insert( eyeBox )
    sceneGroup:insert( intestines )
    sceneGroup:insert( intestinesBox )
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
