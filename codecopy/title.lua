local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )

local screenW = display.contentWidth
local screenH = display.contentHeight
local button1 ={}
local gdisplay
---------------------------------------------
local function handleButtonEvent(event)
    display.remove(gdisplay)
    gdisplay = nil
    local options =
    {
        effect = "zoomInOutFade",
        time = 100,
        params = { var1 = "custom", myVar = "another" }
    }
    print("id = ",event.target.id)
    if event.target.id == 1 then
        storyboard.gotoScene("info",options)
    elseif event.target.id == 2 then

    elseif event.target.id == 3 then
        storyboard.gotoScene("setting",options)
    end


end
function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()
    local newRect = display.newRect(0,0,screenW,screenH)
    --    newRect.strokeWidth = 3
    newRect:setFillColor( 0.5 )
    newRect:setStrokeColor( 1, 1, 1 ,0.5)
    newRect.anchorX = 0
    newRect.anchorY = 0
    gdisplay:insert(newRect)
    local textFont = {
        "PLAY",
        "SHOP",
        "SETTING",
    }
    local scrY = screenH*.5
    for i = 1,#textFont, 1 do
        button1[i] = widget.newButton
            {
                left = screenW*.5,
                top = scrY,
                id = i,
                label = textFont[i],
                fontSize = 60,
                font = "CooperBlackMS",
                labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
                onEvent = handleButtonEvent
            }
        button1[i].font = native.newFont("CooperBlackMS",50)
        button1[i].anchorX = 1
        gdisplay:insert(button1[i])
        scrY = scrY + (screenH*.1)
    end

    group:insert(gdisplay)

end

function scene:enterScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view

    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene