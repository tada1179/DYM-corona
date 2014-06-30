module(..., package.seeall)
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local screenW = display.contentWidth
local screenH = display.contentHeight
local button1 ={}
local eventID
local gdisplay
local textFont = {
    "PLAY",
    "SHOP",
    "SETTING",
}
---------------------------------------------
function menu_setEnabledTouch(touch)

    if touch == 1 then
        print("sssss122121221111111")
        button1[eventID]:setFillColor( 1 )
        button1[eventID]:setEnabled(true)
    end
end

local function handleButtonEvent(event)
    print("event.phase = ",event.phase)
    local options =
    {
        effect = "zoomInOutFade",
        time = 100,
        params = { nameFunction = "menu" }
    }
    eventID = event.target.id
    if "began" == event.phase then
        button1[eventID]:setFillColor( 1, 0, 0, 0.5 )
        menu_setEnabledTouch(2)
        if event.target.id == 1    then
            require( "info").SELECTMODE(0)

        elseif event.target.id == 2 then
            display.remove(gdisplay)
            gdisplay = nil

            storyboard.gotoScene("shop",options)

        elseif event.target.id == 3 then
            display.remove(gdisplay)
            gdisplay = nil

            storyboard.gotoScene("setting_main",options)
        end
    end

    return true
end
function createScene()

    gdisplay = display.newGroup()
    local newRect = display.newRect(0,0,screenW,screenH)
--    newRect.strokeWidth = 3
    newRect:setFillColor( 0.5 )
    newRect:setStrokeColor( 1, 1, 1 ,0.5)
    newRect.anchorX = 0
    newRect.anchorY = 0
    gdisplay:insert(newRect)
    require( "top_name" )
    local btn = "img/hhh.png"
    local scrY = screenH*.5
    for i = 1,#textFont, 1 do
        button1[i] = widget.newButton
            {
                defaultFile = btn,
                left = screenW*.5,
                top = scrY,
                id = i,
                label = textFont[i],
                fontSize = 60,
                font = "CooperBlackMS",
                labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1,} },
                onPress = handleButtonEvent
            }
        button1[i].font = native.newFont("CooperBlackMS",50)
        button1[i].anchorX = 1
        gdisplay:insert(button1[i])
        scrY = scrY + (screenH*.1)
    end

end
function HietcreateScene()
    print("HietcreateScene = ")
    display.remove(gdisplay)
    gdisplay = nil
end

