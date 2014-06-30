local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )

local screenW = display.contentWidth
local screenH = display.contentHeight
local user_name = nil
local user_name_ch = nil
local gdisplay
local requestID
local tapdisplay
local button1 = {}
local detailColor = {}
---------------------------------------
local function handleButtonEvent( page )
    display.remove(gdisplay)
    gdisplay = nil

    local options =
    {
        effect = "zoomInOutFade",
        time = 100,
        params = {
            mode = page
        }
    }
    local function gotoPage()
        if page == 1 then
            storyboard.gotoScene("classic",options)
        elseif page == 2 then
            storyboard.gotoScene("timeAttack",options)
        elseif page == 3 then
            storyboard.gotoScene("mission",options)
        end
    end
    timer.performWithDelay ( 100,gotoPage)
end
local function OverCancelRelease(event,self)
    if event.target.id == "SEND" and user_name ~= "" and user_name ~= nil then -- back button
        local path = system.pathForFile("datas.db", system.DocumentsDirectory)
        db = sqlite3.open( path )

        local tablefill ="INSERT INTO user VALUES ('1','"..requestID.text.."','1','1','0','0','0','1','1');"
        db:exec( tablefill )--insert user name

        db:close()

        local option ={
            params = {
                map_id = 1,
                map_name = "map 1",
            }
        }
        storyboard.gotoScene( "mainMenu" ,option )
    end
end

local function textListener(event)
    if event.phase == "began" then
        if user_name_ch then
            native.setKeyboardFocus( requestID )
        end
    elseif event.phase == "ended" or event.phase == "submitted" then
        user_name = event.target.text
        user_name_ch = nil
    elseif event.phase == "editing" then
        if event.startPosition > 15  then
            native.setKeyboardFocus( requestID )
        end
    end

end

local function menuMode(event)
    local page = event.target.id
    transition.to( tapdisplay, { time=200, y=tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
    return true
end
function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()
    tapdisplay = display.newGroup()

    local img = "img/universal/ast_bg01.png"
    local background = display.newImageRect(img,screenW,screenH)
    background.x = 0
    background.y = 0
    background.anchorX = 0
    background.anchorY = 0
    gdisplay:insert(background)

    timer.performWithDelay ( 500,function()
        local BGMenuMode = display.newImage("img/small_frame/frm_s_popup.png")
        BGMenuMode.x = screenW*.5
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0
        tapdisplay:insert(BGMenuMode)
        local text = display.newText("REGISTER",screenW*.5,screenH*.08,"CooperBlackMS",45)
        text.anchorX = 0.5
        text.anchorY = 1
        tapdisplay:insert(text)
        requestID = native.newTextField( 0,0, screenW*.65, 50 )
        requestID.x = screenW*.5
        requestID.y =  screenH*.15
        requestID.font = native.newFont( "Helvetica-Light", 18 )
        requestID.inputType = "default"
        requestID.align = "center"

        requestID:addEventListener( "userInput", textListener )
        tapdisplay:insert(requestID)
        local img_OK = "img/small_frame/btt_yes.png"
        local btnOK = widget.newButton{
            defaultFile = img_OK,
            overFile = img_OK,
            width=screenW*.3, height= screenH*.07,
            onRelease = OverCancelRelease	-- event listener function
        }
        btnOK.id = "SEND"
        btnOK.x = screenW*.5
        btnOK.y = screenH*.23
        tapdisplay:insert(btnOK)

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )
--    local imgTop = "img/fill_bkg.png"
--    local topImg = display.newImageRect(imgTop,screenW,screenH*.2)
--    topImg.x = screenW*.5
--    topImg.y = 0
--    topImg.anchorX = 0.5
--    topImg.anchorY = 0
--    gdisplay:insert(topImg)

    group:insert(gdisplay)
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