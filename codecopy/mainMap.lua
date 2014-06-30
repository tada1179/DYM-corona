local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )

local screenW = display.contentWidth
local screenH = display.contentHeight
local gdisplay
local loadData = {}
local loadMap = {}
local map_id = {}
local playCount = 0
local playCount2 = 0
local isTouch = true
local isTouchEnd = true

---------------------------------------
local function onTouchMap()

    storyboard.gotoScene( "map", "zoomInOutFade", 400 )

end
local function ontouchMission(event)
    print("event.target.id = ",event.target.id)
    if event.phase == "ended" then
        display.remove(gdisplay)
        gdisplay = nil

        local option = {
            effect = "zoomInOutFade",
            time = 300,
            params = {
                map_id = event.target.id  ,
                map_name = event.target.map_name
            }
        }
        if event.target.id == "Close" then
            storyboard.gotoScene("mainMenu",option )
        else
            storyboard.gotoScene( "map", option )
        end
    end

--    if event.phase == "began" and isTouch == true and isTouchEnd == true  then
--        isTouch = false
--        isTouchEnd = true
--    end
--    if event.phase == "ended" and isTouch == false and isTouchEnd == true  then
--        isTouch = true
--        isTouchEnd = false
--
--        if event.target.id == 1 then
--            require( "info").SELECTMODE(0,"close")
--        elseif event.target.id == 2 then
--            require( "info").customizeTMODE(0,"close")
--        elseif event.target.id == 3 then
--            require( "info").ShopMode()
--        end
--        timer.performWithDelay ( 1000,function()
--            isTouch = true
--            isTouchEnd = true
--        end)
--    end
    return true
end
function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()
    playCount = 0
    playCount2 = 0
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )
    for missiondata in db:nrows ("SELECT * FROM playMission;") do
        if tonumber(missiondata.status) > -1 then

            playCount = playCount +1
            loadData[playCount] = {}
            loadData[playCount].map_id = tonumber(missiondata.map_id)

        end
    end
    for dataMap in db:nrows ("SELECT * FROM map WHERE map_id = '"..loadData[playCount].map_id.."';") do
        playCount2 = playCount2 +1
        loadMap[playCount2] = {}
        loadMap[playCount2].map_id = tonumber(dataMap.map_id)
        loadMap[playCount2].map_name = dataMap.map_name
    end

--    local img = "img/mainMap.png"
    local img = "img/world.png"
    local background = display.newImageRect(img,screenW,screenH)
    background.x = 0
    background.y = 0
    background.anchorX = 0
    background.anchorY = 0
--    background.touch = onTouchMap
--    background:addEventListener( "touch", onTouchMap )
    gdisplay:insert(background)

    require("top_name").alphaDisplay(1)
    local textMap = display.newText( loadMap[playCount2].map_name ,screenW*.5,screenH*.95,native.systemFont,20)
    local tapmissionName = display.newImage("img/middle_frame/ast_scorebar.png")
    tapmissionName.x = screenW*.5
    tapmissionName.y = screenH*.95
    tapmissionName.anchorX = 0.5
    tapmissionName.anchorY = 0
    gdisplay:insert(tapmissionName)

    textMap.anchorX = 0.5
    textMap.anchorY = 0
    gdisplay:insert(textMap)

    local buttonClose = widget.newButton
        {
            left = screenW*.85,
            top = screenH*.93,
            defaultFile = "img/universal/btt_cancel.png",
            overFile = "img/universal/btt_cancel.png",
            onEvent = ontouchMission
        }
    buttonClose.id = "Close"
    buttonClose.anchorX = 0.5
    gdisplay:insert(buttonClose)

    local btnOK = {}
    local pintX = screenW*.5
    local pintY = screenH*.35
    local imgbutton = {"img/frameNo/1.png","img/frameNo/2.png","img/frameNo/3.png","img/frameNo/4.png","img/frameNo/5.png","img/frameNo/6.png","img/frameNo/7.png" }
    local pintX = {300,500,510,320,100,300,450}
    local pintY = {700,650,500,510,480,330,330 }

    for i = 1,#imgbutton,1 do


        if i == loadData[playCount].map_id  then
            btnOK[i] = widget.newButton{
                defaultFile = "img/pin.png",
                overFile = "img/pin.png",
                onEvent = ontouchMission	-- event listener function
            }
            btnOK[i].id = i
            btnOK[i].y = pintY[i]
            btnOK[i].x = pintX[i]
            btnOK[i]:setEnabled(true)
            gdisplay:insert(btnOK[i])

            local timerText2 = function()
                transition.to(btnOK[i], { time=500,xScale = 1,yScale = 1, alpha=.8} )
            end
            local timerText = function()
                transition.to(btnOK[i], { time=500,xScale = 1.5,yScale = 1.5, alpha=1,onComplete = timerText2} )
            end

            timer.performWithDelay(1000, timerText, 0)

        elseif i < loadData[playCount].map_id  then
            btnOK[i] = widget.newButton{
                defaultFile = "img/pin.png",
                overFile = "img/pin.png",
                onEvent = ontouchMission	-- event listener function
            }
            btnOK[i].id = i
            btnOK[i].y = pintY[i]
            btnOK[i].x = pintX[i]
            btnOK[i]:setEnabled(true)
            gdisplay:insert(btnOK[i])

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