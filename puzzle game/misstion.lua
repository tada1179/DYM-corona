local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay = display.newGroup()
local previous_scene_name = storyboard.getPrevious()
---------------------------------

function scene:createScene( event )
    print("---- misstion ----")
    local group = self.view

    local img_text =  "img/text/MISSION_SELECT.png"
    local user_id = event.params.user_id
    local chapter_id =  event.params.chapter_id
    local map_id =  event.params.map_id
    print("user_id,chapter_id,map_id,mission_id :",user_id,chapter_id,map_id)

    local background = display.newImageRect("img_back", system.DocumentsDirectory,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    gdisplay:insert(background)

    local titleText = display.newImageRect(img_text,screenW/2.65,screenH/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH /3.1
    gdisplay:insert(titleText)

    local function onBtnReleasechapter(event)
        menu_barLight = nil
        display.remove(background)
        background = nil

        display.remove(titleText)
        titleText = nil

        for i = gdisplay.numChildren,1,-1 do
            local child = gdisplay[i]
            child.parent:remove( child )
            child = nil
        end
        display.remove(gdisplay)
        gdisplay = nil

        local option = {
            effect = "fade",
            time = 100,
            params =
            {
                map_id = map_id,
                user_id = user_id
            }
        }
            storyboard.gotoScene( "map_substate" ,option )

        return true
    end
    local imageBack = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
        default = imageBack,
        over = imageBack,
        width=screenW*.1, height=screenH*.05,
        onRelease = onBtnReleasechapter	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW *.15
    backButton.y = screenH *.3


    gdisplay:insert(require("misstion_scroll").new{user_id=user_id, chapter_id=chapter_id, map_id=map_id})
    gdisplay:insert(menu_barLight.newMenubutton())
    gdisplay:insert(backButton)
    group:insert(gdisplay)
    menu_barLight.checkMemory()
    ------------- other scene ---------------
    --storyboard.removeScene ("map_substate")
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    menu_barLight = nil

    display.remove(gdisplay)
    gdisplay = nil

    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view
    menu_barLight = nil

    display.remove(gdisplay)
    gdisplay = nil

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene


