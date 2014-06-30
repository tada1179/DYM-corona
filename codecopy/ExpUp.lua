local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )
local screenW = display.contentWidth
local screenH = display.contentHeight


local dataTeam = {}
local CountPin
local playCount
local RowdataAll = 0
local options
local GotoPage = nil
local pin_id = {}
local dataEXPupPin = {}
local tapProfilePin
local groupGameLayer
---------------------------------------
local function Victory_Animation_aura()
    groupGameLayer = display.newGroup()
    local sheetdata_light = {width = 640, height = 425,numFrames = 40, sheetContentWidth = 3200 ,sheetContentHeight = 3400 }
    local sheet_light = graphics.newImageSheet( "img/Effect.png", sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=5500, loopCount=1 }

    local Victory_aura = display.newSprite( sheet_light, sequenceData )
    Victory_aura.anchorX = 0.5
    Victory_aura.x = screenW*.5
    Victory_aura.y = screenH*.5
    local function FNVictory_aura()
        Victory_aura:setSequence( "lightaura" )
        Victory_aura:play()
    end
    groupGameLayer:insert(Victory_aura)
    timer.performWithDelay(300,FNVictory_aura )
    return true

end
local function ProfilePin()
    display.remove(tapProfilePin)
    tapProfilePin = nil

    display.remove(groupGameLayer)
    groupGameLayer = nil

     tapProfilePin = display.newGroup()
    if playCount >0 then

        local IMGcolorBT = {
            "img/ally_frame/asst_ally_f.png",
            "img/ally_frame/asst_ally_wd.png",
            "img/ally_frame/asst_ally_wt.png",
            "img/ally_frame/asst_ally_d.png",
            "img/ally_frame/asst_ally_c.png",
            "img/ally_frame/asst_ally_b.png",
        }

        local img_scorebar = "img/ally_frame/frm_allyinfo.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = screenH*.3
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        BGMenuMode.touch = ProfilePin
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapProfilePin:insert(BGMenuMode)

        local BGIMG = display.newImage(dataTeam[playCount].pin_imgbig)
        BGIMG.x = screenW*.5
        BGIMG.y = screenH*.4
        BGIMG.anchorX = 0.5
        BGIMG.anchorY = 0
        tapProfilePin:insert(BGIMG)

        local IMGcolor = display.newImage(IMGcolorBT[dataTeam[playCount].pin_element])
        IMGcolor.x = screenW*.178
        IMGcolor.y = screenH*.66
        IMGcolor.anchorX = 0.5
        IMGcolor.anchorY = 0
        tapProfilePin:insert(IMGcolor)

        local txtName = display.newText(dataTeam[playCount].pin_name,screenW*.48,screenH*.695,"CooperBlackMS",25)
        txtName:setFillColor(1, 1, 1)
        txtName.anchorX = 0
        txtName.anchorY = 1
        tapProfilePin:insert(txtName)

        local txtNo = display.newText(dataTeam[playCount].pin_no,screenW*.3,screenH*.695,"CooperBlackMS",25)
        txtNo:setFillColor(1, 1, 1)
        txtNo.anchorX = 0
        txtNo.anchorY = 1
        tapProfilePin:insert(txtNo)

        local txtDeteil = display.newText("aaaaaaaaaaaaaaa",screenW*.15,screenH*.73,"CooperBlackMS",25)
        txtDeteil:setFillColor(1, 1, 1)
        txtDeteil.anchorX = 0
        txtDeteil.anchorY = 1
        tapProfilePin:insert(txtDeteil)

        playCount = playCount - 1

        timer.performWithDelay(300,Victory_Animation_aura )
    else
        display.remove(tapProfilePin)
        tapProfilePin = nil

        display.remove(groupGameLayer)
        groupGameLayer = nil

        storyboard.gotoScene("mainMap",options)
    end

end
function scene:createScene( event )
    local group = self.view
    local tapdisplay = display.newGroup()

    local dataEXPupPin = event.params.dataEXPupPin

    playCount = 0
    CountPin = 0

    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    for i = 1,#dataEXPupPin,1 do
        CountPin = CountPin +1
        pin_id[CountPin] =  dataEXPupPin[CountPin]

         print("pin_id[CountPin] = ",pin_id[CountPin])
        for missiondata in db:nrows ("SELECT * FROM pin WHERE pin_id = '"..pin_id[CountPin].."';") do
            playCount = playCount +1
            dataTeam[playCount] = {}
            dataTeam[playCount].pin_id =  tonumber(missiondata.pin_id)
            dataTeam[playCount].pin_expmax =  tonumber(missiondata.pin_expmax)
            dataTeam[playCount].pin_name =  missiondata.pin_name
            dataTeam[playCount].pin_no =  missiondata.pin_no
            dataTeam[playCount].pin_element =  tonumber(missiondata.pin_element)
            dataTeam[playCount].pin_imgbig =  missiondata.pin_imgbig
            print("playCount = ",playCount,"pin_element = ", dataTeam[playCount].pin_element)
            ProfilePin()
        end
    end



    group:insert(tapdisplay)
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