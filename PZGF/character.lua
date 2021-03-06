
print("--- character.lua ---")
module(..., package.seeall)
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-----------------------------------------------------------------------------------------

local image_background = "img/background/background_1.png"
--local image_background = "img/background/character/character.jpg"
local image_text = "img/text/CHARACTER.png"
local image_anyfun = "img/background/character/Any_functions.png"
local image_viewpro = "img/background/character/View_profile.png"
local image_cancel = "img/background/button/as_butt_discharge_cancel.png"

local image_profile = "img/framCharacterIcon/as_cha_frm01.png"
--local image_profile = "img/background/character/FRAME_LAYOUT.png"


local image_btnback = "img/background/button/Button_BACK.png"


local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

--------- icon event -------------
local imageprofile
local backButton
local btn_cancel
local btn_anyfunction
local btn_view

local function onBtncharacter(event)
   if event.target.id == "back" then
       menu_barLight.SEtouchButtonBack()
        storyboard.gotoScene( "team_item" ,"fade", 100 )

    -- back image profile
    elseif event.target.id == "imageprofile" then
       menu_barLight.SEtouchButton()
        storyboard.gotoScene( "characterprofile" ,"fade", 100 )

   elseif event.target.id == "anyfunction" then
       menu_barLight.SEtouchButton()
       storyboard.gotoScene( "characterprofile" ,"fade", 100 )

   elseif event.target.id == "viewprofile" then
       menu_barLight.SEtouchButton()
       storyboard.gotoScene( "characterprofile" ,"fade", 100 )

   elseif event.target.id == "cancel" then
       menu_barLight.SEtouchButton()
       storyboard.gotoScene( "team_item" ,"fade", 100 )
    end
    return true
end
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end

local function characterButton()
    backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtncharacter	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)

    --button image profile
    imageprofile = widget.newButton{
        default= image_profile,
        over= image_profile,
        width=viewableScreenW/4, height=viewableScreenH/5.3,
        onRelease = onBtncharacter	-- event listener function
    }
    imageprofile.id="imageprofile"
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x = viewableScreenW/2.65
    imageprofile.y = viewableScreenH/2.24

    --button cancel profile
    btn_cancel = widget.newButton{
        default=image_cancel,
        over=image_cancel,
        width=screenW*.23, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =display.contentWidth /2
    btn_cancel.y = display.contentHeight *.78

    --button anyfunction
    btn_anyfunction = widget.newButton{
        default= image_anyfun,
        over= image_anyfun,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_anyfunction.id="anyfunction"
    btn_anyfunction:setReferencePoint( display.CenterReferencePoint )
    btn_anyfunction.x =screenW *.5
    btn_anyfunction.y = screenH *.6

    --button btn_view
    btn_view = widget.newButton{
        default= image_viewpro,
        over= image_viewpro,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_view.id="viewprofile"
    btn_view:setReferencePoint( display.CenterReferencePoint )
    btn_view.x = screenW *.5
    btn_view.y = screenH *.69

end



function scene:createScene( event )
    local group = self.view

    local gdisplay = display.newGroup()

    local background = display.newRect(0, 0, screenW, screenH)
    background.strokeWidth = 3
    background.alpha = .1
    background:setFillColor(0, 0, 0)
    group:insert(background)


    local titleText = display.newImageRect( image_text, display.contentWidth/3.5, display.contentHeight/33 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1


    characterButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)


    group:insert(background)
    group:insert(imageprofile)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(btn_cancel)
    group:insert(btn_anyfunction)
    group:insert(btn_view)
    group:insert(gdisplay)
    checkMemory()
    ------------- other scene ---------------
    storyboard.removeAll ()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "team_item" )
    storyboard.purgeScene( "characterprofile" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
