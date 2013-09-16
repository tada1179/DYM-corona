
print("title_page.lua")
local menu_barLight = require ("menu_barLight")
local screenW, screenH = display.contentWidth, display.contentHeight
-----------------------------------------------------------------------------------------


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


function scene:createScene( event )
    print("--------------title----------------")
    local group = self.view
    local user_id = menu_barLight.user_id()

    local image_background1 = "img/background/TITLE.png"
    local background = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    group:insert(background)


    local function onStartTouch(event)
        if user_id ~= nil then
            storyboard.gotoScene( "map", "crossFade", 200 )
        else
            storyboard.gotoScene( "register", "crossFade", 100 )
        end


        return true
    end
    group:addEventListener( "touch", onStartTouch ) -- touch togo mainpage

    ------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "team_main" )
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




--timer.performWithDelay( 5000, function()
--        storyboard.reloadScene()
--    end, 1 )
















