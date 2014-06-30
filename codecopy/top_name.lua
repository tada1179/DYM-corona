module(..., package.seeall)
local sqlite3 = require( "sqlite3" )
local widget = require( "widget" )
local screenW = display.contentWidth
local screenH = display.contentHeight
local user_name
local user_score
local sound_id
local BGM_id
local btnOK ={}
local eventID
local tapdisplay = display.newGroup()
--------------------------------------------------------------------------------
local path = system.pathForFile("datas.db", system.DocumentsDirectory)
db = sqlite3.open( path )
for rowdata in db:nrows ("SELECT * FROM user;") do
   user_name = rowdata.user_name
   user_score = rowdata.user_score
   sound_id = rowdata.sound_id
   BGM_id = rowdata.BGM_id
end

function setSound(datasound_id,dataBGM_id)
    -- 1 = open
    -- 2 = close

    sound_id = datasound_id
    BGM_id = dataBGM_id

    local updateplayMission ="update user set sound_id = '"..sound_id.."',BGM_id = '"..BGM_id.."' where user_id = '1';"
    db:exec(updateplayMission)

end

function getSound()
    return  sound_id

end

function getBGMSound()
    return BGM_id

end

function setEnabledTouch(touch)
    if touch == 1 then
        btnOK[eventID]:setFillColor( 1 )
        btnOK[eventID]:setEnabled(true)
    else
        btnOK[eventID]:setFillColor( 0.5 )
        btnOK[eventID]:setEnabled(false)
    end

end
function alphaDisplay(num)
    if num == 1 then
        tapdisplay.alpha = 1
    else
        tapdisplay.alpha = 0
    end
end
local function OverCancelRelease(event)
    eventID = event.target.id


    if eventID == 1 and "ended" == event.phase   then
        require( "info").DAILYMODE()
        setEnabledTouch(2)
    elseif eventID == 2 and "ended" == event.phase then
        require( "info").MenuMODE()
    end
    return true
end
local img = "img/universal/frm_player.png"

local topImg = display.newImage(img)
topImg.x = screenW*.5
topImg.y =    0
topImg.anchorX = 0.5
topImg.anchorY = 0
tapdisplay:insert(topImg)

local img = "img/universal/ast_player.png"
local topImg = display.newImage(img)
topImg.x = screenW*.5
topImg.y = screenH*.017
topImg.anchorX = 0.5
topImg.anchorY = 0
tapdisplay:insert(topImg)

local plus = {"img/universal/btt_achieve.png","img/universal/btt_menu.png" }
local pointX = screenW*.1
for i=1,#plus,1 do
    btnOK[i] = widget.newButton{
        defaultFile = plus[i],
        overFile = plus[i],
       -- width=screenW*.13, height= screenH*.07,
        onRelease = OverCancelRelease	-- event listener function
    }
    btnOK[i].id = i
    btnOK[i].x = pointX
    btnOK[i].y = screenH*.06
    tapdisplay:insert(btnOK[i])

    pointX = pointX + screenW*.8
end

local text = display.newText(user_name,screenW*.5,screenH*.085,"CooperBlackMS",45)
text.anchorX = 0.5
text.anchorY = 1
tapdisplay:insert(text)
--db:close()