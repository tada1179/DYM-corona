local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight

local pointListY
local gdisplay = display.newGroup()
local text_title = "img/text/CHAPTER_SELECT.png"
local backButton
local background
local titleText = display.newImageRect(text_title ,screenW/1.8, screenH/17 )
local dataTable = {}
local maxChapter = nil
local map_id
local user_id
local scrollView
-------------------------------------

local function onBtnRelease(event)
    menu_barLight = nil

    display.remove(backButton)
    backButton = nil

    display.remove(background)
    background = nil

    display.remove(titleText)
    titleText = nil

    display.remove(gdisplay)
    gdisplay = nil


   if event.target.id == "back" then -- back button
        storyboard.gotoScene( "map" ,"fade", 100 )
   else
       local option = {

           effect = "fade",
           time = 100,
           params =
           {
               chapter_id = event.target.id,
               map_id = map_id,
               user_id = user_id

           }
       }
       storyboard.gotoScene( "misstion",option )
   end
    return true	-- indicates successful touch
end
local function loadChapter()
    local URL = "http://localhost/dym/chapter_list.php?user_id="..user_id.."&map_id="..map_id
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        dataTable = json.decode(response)
        maxChapter = dataTable.All
        print("maxChapter = ",maxChapter)
        local m = maxChapter
        while m > 0  do
            dataTable[m] = {}
            dataTable[m].chapter_id = dataTable.chapter[m].chapter_id
            dataTable[m].chapter_name = dataTable.chapter[m].chapter_name
            dataTable[m].ID_status = dataTable.chapter[m].ID_status
            print("ID_status = ",dataTable[m].ID_status)
            m = m -1
        end
    end

end
local function createBackButton()
    local imgBnt = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        defaultFile= imgBnt,
        overFile= imgBnt,
        width=screenW*.1, height=screenH*.05,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW*.15
    backButton.y = screenH*.3
    gdisplay:insert(backButton)
end
local function scrollViewFN()
    scrollView = widget.newScrollView{
        width = screenW *.77,
        height = screenH * .4,
        top = screenH *.35,
        left = screenW *.14,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true ,
        horizontalScrollDisabled = false
    }

    local function onButtonEvent(event)

--        if event.phase == "begen" then
--            event.markX = event.x
--            event.markY = event.y
--        else
        if event.phase == "moved" then
            local dx = math.abs( event.x - event.xStart )
            local dy = math.abs( event.y - event.yStart )
            if  dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif  event.phase == "ended" or event.phase == "release" then
            local option = {

                effect = "fade",
                time = 100,
                params =
                {
                    chapter_id = event.target.id,
                    map_id = map_id,
                    user_id = user_id

                }
            }
            storyboard.gotoScene( "misstion",option )
        end
    end



        local pointName = screenH*.02
        local pointNameX = 0
        local pointBonus = screenH*.11
        pointListY  = 0

        local frmsizsX = screenW*.7
        local frmsizsY = screenH*.1
        local listCharacter = {}
        local txtbattle


        for i = maxChapter,1 , -1 do

--            if true then
            if dataTable[i].ID_status == "clear" then

                local imgBnt = "img/background/misstion/CLEAR_LAYOUT.png"
                backButton = widget.newButton{
                    defaultFile= imgBnt,
                    overFile= imgBnt,
                    top = pointListY,
                    left = pointNameX,
                    width= frmsizsX, height= frmsizsY,
                    onEvent  = onButtonEvent,	-- event listener function
                }
                backButton.id = dataTable[i].chapter_id
                txtbattle = display.newText(dataTable[i].chapter_name, screenW*.1, pointName,native.systemFontBold, 25)
                txtbattle:setTextColor(200, 200, 200)
                scrollView:insert(txtbattle)
            else
                local imgBnt = "img/background/misstion/NEW_LAYOUT.png"
                backButton = widget.newButton{
                    defaultFile= imgBnt,
                    overFile= imgBnt,
                    top = pointListY,
                    left = pointNameX,
                    width= frmsizsX, height= frmsizsY,
                    onEvent  = onButtonEvent,	-- event listener function

                }
                backButton.id=  dataTable[i].chapter_id
                txtbattle = display.newText(dataTable[i].chapter_name, screenW*.1, pointName,native.systemFontBold, 25)
                txtbattle:setTextColor(200, 200, 200)
                scrollView:insert(txtbattle)
            end
            pointName = pointName + (screenH*.11)
            pointListY = pointListY + (screenH*.11)
            scrollView:insert(backButton)
        end
        gdisplay:insert(scrollView)

end
function scene:createScene( event )
    local group = self.view
     map_id = event.params.map_id
     user_id = event.params.user_id

    local image_background = "img/background/background_11.png"
    background = display.newImageRect(image_background,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0,0
    gdisplay:insert(background)


    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.12
    gdisplay:insert(titleText)

    createBackButton()
    loadChapter()
    scrollViewFN()
   gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(gdisplay)

------------- other scene ---------------
    storyboard.purgeAll()
    storyboard.removeAll()
    menu_barLight.checkMemory()
end

function scene:enterScene( event )
    local group = self.view	
end

function scene:exitScene( event )
    local group = self.view
    menu_barLight = nil

    display.remove(backButton)
    backButton = nil

    display.remove(background)
    background = nil

    display.remove(titleText)
    titleText = nil


    display.remove(gdisplay)
    gdisplay = nil

    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view

--    display.remove(gdisplay)
--    gdisplay = nil

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene


