local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )
local screenW = display.contentWidth
local screenH = display.contentHeight
local gdisplay

local posX,posY
local SizeImgX = 8
local SizeImgY = 2
local myRectangle
local  scrollView
local  NumRow = 0
local  NumColum = 4
local  playCount
local  dataPIN = {}
---------------------------------------
local function ontouchMission(event)
     print("id = ",event.target.id)
    if event.phase == "begen" then
        event.markX = event.x
        event.markY = event.y
    elseif event.phase == "moved" then

        local dy = math.abs( event.y - event.yStart )
        if  dy > 5 then
            scrollView:takeFocus( event )
        end

    elseif  event.phase == "ended" then
        local option = {
            color = 0,
            pin_id = event.target.id
        }
        require( "info").ProfilePin(option)
    end
    return true
end
local function getData()
    playCount = 0
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    for missiondata in db:nrows ("SELECT * FROM pin;") do
        playCount = playCount +1
        dataPIN[playCount] = {}

        dataPIN[playCount].pin_id = tonumber(missiondata.pin_id)
        dataPIN[playCount].pin_name = missiondata.pin_name
        dataPIN[playCount].pin_imgmini = missiondata.pin_imgmini
        dataPIN[playCount].pin_no = missiondata.pin_no
        dataPIN[playCount].pin_status = missiondata.pin_status
    end

    if playCount > 0 then
        NumRow = math.ceil(playCount /NumColum)
        print("NumRow = ",NumRow,"playCount =",playCount)
    end


end
local function menuMode(event)
    if  event.phase == "ended" then
        storyboard.gotoScene( "mainMenu", "fade", 100 )
        require( "info").customizeTMODE(0,"close")
    end
    return true
end
function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()
    getData()
    local img = "img/universal/ast_bg01.png"
    local background = display.newImageRect(img,screenW,screenH)
    background.x = 0
    background.y = 0
    background.anchorX = 0
    background.anchorY = 0
    --    topImg.touch = onTouchMap
    --    topImg:addEventListener( "touch", topImg )
    gdisplay:insert(background)

    local img = "img/clear_frame/frm_c_customize.png"
    local topImg = display.newImage(img,screenW,screenH)
    topImg.x = screenW*.5
    topImg.y = screenH*.15
    topImg.anchorX = 0.5
    topImg.anchorY = 0
    gdisplay:insert(topImg)

    local img_OKTitle = "img/clear_frame/txt_allygallery.png"
    local topImgTitle = display.newImage(img_OKTitle)
    topImgTitle.x = screenW*.42
    topImgTitle.y = screenH*.174
    topImgTitle.anchorX = 0.5
    topImgTitle.anchorY = 0
    gdisplay:insert(topImgTitle)

    local button1 = widget.newButton
        {
            left = screenW*.75,
            top = screenH*.158,
            defaultFile = "img/universal/btt_cancel.png",
            overFile = "img/universal/btt_cancel.png",
            onEvent = menuMode
        }
    button1.anchorX = 0
    gdisplay:insert(button1)

    local pointX = screenW*.11
    local pointY = screenH*.085

    scrollView = widget.newScrollView
        {
            top = screenH*.26,
            left = screenW*.5,
            width = screenW*.88,
            height = screenH*.69,
            scrollBarOptions = {
                sheet = "img/large_frame/ast_scroll.png",  --reference to the image sheet
                topFrame = 10,            --number of the "top" frame
                middleFrame = 10,         --number of the "middle" frame
                bottomFrame = 10          --number of the "bottom" frame
            }  ,
            hideScrollBar = true,
            hideBackground = true,
            horizontalScrollDisabled = true,
            scrollWidth = 600,
            scrollHeight = 800,
        }
    scrollView.anchorX = 1
    scrollView.anchorY = 0.5

    local btnOK = {}
    local count = 0
    local imgIcon
    local img_imgIcon = "img/element/red_1.png"
    local img_OK = "img/clear_frame/frm_allytag.png"

    for i = 1,NumRow,1 do
        btnOK[i] = {}
        for j = 1,NumColum,1 do
            count = count + 1
            if count <= playCount then

                btnOK[i][j] = widget.newButton{
                    defaultFile = img_OK,
                    overFile = img_OK,
                    onEvent = ontouchMission	-- event listener function
                }
                btnOK[i][j].id = count
                btnOK[i][j].x = pointX
                btnOK[i][j].y = pointY

                imgIcon = display.newImageRect(dataPIN[count].pin_imgmini,96,96)
                imgIcon.x = pointX
                imgIcon.y = pointY - 5
                btnOK[i][j]:setEnabled(true)
                scrollView:insert(btnOK[i][j])
                scrollView:insert(imgIcon)

                local textIcon =  display.newText("no."..dataPIN[count].pin_no,pointX ,pointY + 20,native.systemFontBold,25)
                textIcon.x = pointX
                textIcon.y = pointY +60
                scrollView:insert(textIcon)


                if dataPIN[count].pin_status == 0 then    --my pin

                    btnOK[i][j]:setEnabled(false)
                    imgIcon:setFillColor(0,0,0,1)

                end


                pointX = pointX + screenW*.22
            end

        end
        pointX = screenW*.11
        pointY = pointY + screenH*.16
    end

    gdisplay:insert(scrollView)
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