local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )
local screenW = display.contentWidth
local screenH = display.contentHeight


local dataTeam = {}
local playCount
local options
local GotoPage = nil
local dataEXPupPin = {}
local dataEXPupPin2 = {}
---------------------------------------
local function menuMode(event)

    options =    {
        effect = "zoomInOutFade",
        time = 200,
        params = {
            dataEXPupPin = dataEXPupPin,
            dataEXPupPin2 = dataEXPupPin2,
        },
    }

    if event.target.id == 1 then
        if GotoPage ~= nil  then
            storyboard.gotoScene(GotoPage,options)

        else
            storyboard.gotoScene("mainMap",options)

        end
    end

end
function scene:createScene( event )
    local group = self.view
    local tapdisplay = display.newGroup()
    local countColor = event.params.countColor
    local mission_exp = event.params.mission_exp
    local team_no = event.params.team_no
    local map_id = event.params.map_id


    playCount = 0
    local scorePin ={}

    local rowPin = 0
    local EXPupPin = 0

    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    for missiondata in db:nrows ("SELECT * FROM team WHERE team_no = '"..team_no.."';") do
        playCount = playCount +1
        dataTeam[playCount] = {}
        dataTeam[playCount].pin_id =  tonumber(missiondata.pin_id)
        dataTeam[playCount].pin_expmax =  tonumber(missiondata.pin_expmax)
        for pinData in db:nrows ("SELECT * FROM pin WHERE pin_id = '"..dataTeam[playCount].pin_id.."';") do
            rowPin = rowPin + 1
            local pin_exp = tonumber(pinData.pin_exp)
            local pin_generate = tonumber(pinData.pin_generate)
            local pin_expmax = tonumber(pinData.pin_expmax)

            for i = 1 ,#countColor ,1 do
                scorePin[i] = tonumber(countColor[i])
                if rowPin == i then
                    dataTeam[playCount].pin_exp = tonumber((scorePin[i]*mission_exp) + pin_exp)

                    if dataTeam[playCount].pin_exp >= pin_expmax then

                        dataTeam[playCount].pin_exp = pin_expmax

                        if pin_generate ~= nil then
                            EXPupPin = EXPupPin + 1
                            local updateplayMission ="update pin set pin_status = '1' where pin_id = '"..pin_generate.."';"
                            db:exec(updateplayMission)

                            local updateplayMission ="update team set pin_id = '"..pin_generate.."' where team_no = '"..team_no.."' and  pin_id = '"..dataTeam[playCount].pin_id.."';"
                            db:exec(updateplayMission)

                            dataEXPupPin2[EXPupPin] = pin_generate -- item last
                            dataEXPupPin[EXPupPin] = dataTeam[playCount].pin_id -- item last
                            GotoPage = "ExpUp"
                        end

                    end

                end
            end

            local updateplayMission ="update pin set pin_exp='"..dataTeam[playCount].pin_exp.."' where pin_id = '"..dataTeam[playCount].pin_id.."';"
            db:exec(updateplayMission)
        end
    end


    ----------------------------------------------------
    local img = "img/universal/ast_bg01.png"
    local background = display.newImageRect(img,screenW,screenH)
    background.x = 0
    background.y = 0
    background.anchorX = 0
    background.anchorY = 0
    --    topImg.touch = onTouchMap
    --    topImg:addEventListener( "touch", topImg )
    tapdisplay:insert(background)


    for i = 1 ,#countColor ,1 do
        scorePin[i] = countColor[i]
    end

--    local scorePin = {100000,20,30,400,500,6000}

    local img_txt_youwin = "img/middle_frame/txt_youwin.png"
    local txt_youwin = display.newImage(img_txt_youwin)
    txt_youwin.x = screenW*.5
    txt_youwin.y = screenH*.22
    txt_youwin.anchorX = 0.5
    txt_youwin.anchorY = 0

    local img_scorebar = "img/large_frame/ast_expbar.png"
    local BGMenuMode = display.newImage(img_scorebar)
    BGMenuMode.x = screenW*.5
    BGMenuMode.y = screenH*.31
    BGMenuMode.anchorX = 0.5
    BGMenuMode.anchorY = 0

    local img_txt_youwin = "img/large_frame/frm_l_win02.png"
    local display_youwin = display.newImage(img_txt_youwin)
    display_youwin.x = screenW*.5
    display_youwin.y = screenH*.15
    display_youwin.anchorX = 0.5
    display_youwin.anchorY = 0
    tapdisplay:insert(display_youwin)
    tapdisplay:insert(txt_youwin)
    tapdisplay:insert(BGMenuMode)

    local pointTextScore = screenH*.348
    local pointTextExp = screenH*.375
    for i = 1,#scorePin,1 do
        local textscorePin = display.newText(scorePin[i],screenW*.5,pointTextScore,"CooperBlackMS",30)
        textscorePin.anchorX = 0
        textscorePin.anchorY = 1
        pointTextScore = pointTextScore + screenH*.079
        tapdisplay:insert(textscorePin)

        local textExp = display.newText(tonumber(scorePin[i]*mission_exp),screenW*.7,pointTextExp,"CooperBlackMS",30)
        textExp.anchorX = 1
        textExp.anchorY = 1
        pointTextExp = pointTextExp + screenH*.079
        tapdisplay:insert(textExp)

    end


    local img = "img/middle_frame/btt_next02.png"
    local BTNext = widget.newButton
        {
            left = screenW*.5,
            top = screenH*.79,
            id = 1,
            defaultFile = img,
            overFile = img,
            onEvent = menuMode
        }
    BTNext.anchorX = 1
    tapdisplay:insert(BTNext)


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