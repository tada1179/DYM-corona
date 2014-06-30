local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )

local screenW = display.contentWidth
local screenH = display.contentHeight
local gdisplay
local isTouch = true
local isTouchEnd = true
local loadData = {}
local loadMap = {}
---------------------------------------
local function ontouchMission(event)
    print("event.phase = ",event.phase)
    if event.phase == "began" and isTouch == true and isTouchEnd == true  then
        isTouch = false
        isTouchEnd = true
    end
    if event.phase == "ended" and isTouch == false and isTouchEnd == true  then
        isTouch = true
        isTouchEnd = false

         if event.target.id == 1 then
             require( "info").SELECTMODE(0,"close")
         elseif event.target.id == 2 then
             require( "info").customizeTMODE(0,"close")
         elseif event.target.id == 3 then
             --require( "info").ShopMode()
         end
         timer.performWithDelay ( 1000,function()
             isTouch = true
             isTouchEnd = true
         end)
    end
    return true
end
function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()

    local img = "img/universal/ast_bg01.png"
    local background = display.newImageRect(img,screenW,screenH)
    background.x = 0
    background.y = 0
    background.anchorX = 0
    background.anchorY = 0
    --    topImg.touch = onTouchMap
    --    topImg:addEventListener( "touch", topImg )
    gdisplay:insert(background)
    require("top_name").alphaDisplay(1)


    local btnOK = {}
    local pintX = screenW*.5
    local pintY = screenH*.35
    local imgbutton = {"img/main_menu/btt_pzzlmode.png","img/main_menu/btt_customize.png","img/main_menu/btt_shop.png"}
    for i = 1,#imgbutton,1 do
        btnOK[i] = widget.newButton{
            defaultFile = imgbutton[i],
            overFile = imgbutton[i],
            onEvent = ontouchMission	-- event listener function
        }
        btnOK[i].id = i
        btnOK[i].y = pintY
        btnOK[i].x = pintX

        pintY = pintY + screenH*.23
        gdisplay:insert(btnOK[i])

        if i == 3  then
            btnOK[i]:setFillColor(0.5,0.5,0.5,1)
        end

    end
    gdisplay:addEventListener( "touch", gdisplay )
    group:insert(gdisplay)
end

function scene:enterScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
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