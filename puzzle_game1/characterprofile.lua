
-----------------------------------------------------------------------------------------
--
-- team_main.lua
--
-- ##ref
--
-- Map
-----------------------------------------------------------------------------------------
print("characterprofile.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")

--local image_background = "img/background/background_1.png"
local image_background = "img/background/pageBackground_JPG/characterNmae.jpg"
local image_background2 = "img/background/background_2.png"
local image_text = "img/text/CHARACTER_NAME.png"
local image_character = "img/character/tgr_chfb-v201.png"
local image_btnback = "img/background/button/Button_BACK.png"
local image_layer = "img/background/character/FRAME_LAYOUT.png"
local image_profile = "img/character/tgr_chfb-i201.png"

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

--------- icon event -------------
local imageprofile
local imageFream
local backButton


local sizeImageprofileW =  screenW*.3
local sizeImageprofileH =  screenH*.25


local function onBtnRelease(event)
   if event.target.id == "back" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_item" ,"fade", 100 )

        -- back image profile
    elseif event.target.id == "imageprofile" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_item" ,"fade", 100 )
    end
    return true
end
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end

local function createButton()
    --button BACK
    backButton = widget.newButton{
        default = image_btnback,
        over= image_btnback,
        width=screenW*.1, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)

    --button image profile
    imageFream = widget.newButton{
        default=image_layer,
        over=image_layer,
        width=viewableScreenW/4.3, height=viewableScreenH/5.75,
        onRelease = onBtnRelease	-- event listener function
    }
    imageFream.id="imageprofile"
    imageFream.x = viewableScreenW/4.2
    imageFream.y = viewableScreenH/1.68

    imageprofile = display.newImageRect(image_profile,screenW*.16,screenH*.13)
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x =  imageFream.x
    imageprofile.y =  viewableScreenH/1.67

end



function scene:createScene( event )
    print("--------------characterprofile----------------")
    local group = self.view
    checkMemory()
    local gdisplay = display.newGroup()

   -- local background = display.newImageRect( "img/background/character/characterNmae.jpg", display.contentWidth, display.contentHeight )
    local background = display.newImageRect(image_background, display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local background2 = display.newImageRect(image_background2, display.contentWidth, display.contentHeight )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local titleText = display.newImageRect(image_text, display.contentWidth/2.35, display.contentHeight/33 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /5

    local charaterImage = display.newImageRect(image_character,sizeImageprofileW , sizeImageprofileH)
    charaterImage:setReferencePoint( display.CenterReferencePoint )
    charaterImage.x = screenW*.5
    charaterImage.y = screenH *.45

    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background)
    group:insert(imageprofile)
    group:insert(imageFream)
    group:insert(backButton)
    group:insert(charaterImage)
    group:insert(titleText)
    group:insert(background2)
    group:insert(gdisplay)


    ------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "commu_main" )
end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
