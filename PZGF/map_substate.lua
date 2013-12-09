local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local loadImageSprite = require ("downloadData").loadImageSprite_Boss1()
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay
local text_title = "img/text/CHAPTER_SELECT.png"
local dataTable = {}
local maxChapter = nil
local map_id
local user_id
local scrollView

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local fontsize = FontAndSize.fontSizeHead
-------------------------------------

local function onBtnRelease(event)
    menu_barLight.SEtouchButtonBack()

    gdisplay:removeSelf()
    gdisplay = nil
    native.setActivityIndicator( true )

    if event.target.id == "back" then -- back button
--        storyboard.gotoScene( "map" ,"fade", 100 )
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
    local substates
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )


    local count = 1

    for x in db:nrows("SELECT * FROM MapSubstates WHERE map_id = '"..map_id.."' GROUP BY chapter_id;") do
        maxChapter =  count
        dataTable[count] = {}
        dataTable[count].chapter_mission_run = x.chapter_mission_run
        dataTable[count].chapter_name        = x.chapter_name
        dataTable[count].chapter_id        = x.chapter_id
        dataTable[count].ID_status           = x.ID_status
        count = count + 1
    end

    db:close()

end
local function createBackButton()
    local imgBnt = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
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

            menu_barLight.SEtouchButton()
            storyboard.gotoScene( "misstion",option )
        end
    end



    local pointName = screenH*.02
    local pointNameX = 0
    local pointBonus = screenH*.11
    local pointListY  = 0

    local frmsizsX = screenW*.7
    local frmsizsY = screenH*.1
    local listCharacter = {}
    local txtbattle

    local imgBnt
    for i = maxChapter,1 , -1 do
        --            if true then
        if dataTable[i].ID_status == "clear" then
            imgBnt = "img/background/misstion/CLEAR_LAYOUT.png"
        else
            imgBnt = "img/background/misstion/NEW_LAYOUT.png"
        end

            local backButton = widget.newButton{
                defaultFile= imgBnt,
                overFile= imgBnt,
                top = pointListY,
                left = pointNameX,
                width= frmsizsX, height= frmsizsY,
                onEvent  = onButtonEvent,	-- event listener function

            }
            backButton.id=  dataTable[i].chapter_id
            txtbattle = display.newText(dataTable[i].chapter_name, screenW*.1, pointName,typeFont, fontsize)
            txtbattle:setReferencePoint(display.TopLeftReferencePoint)
            txtbattle:setFillColor(200, 200, 200)
            scrollView:insert(txtbattle)

        pointName = pointName + (screenH*.11)
        pointListY = pointListY + (screenH*.11)
        scrollView:insert(backButton)
    end
    gdisplay:insert(scrollView)

end
function scene:createScene( event )
    native.setActivityIndicator( false )
    local group = self.view
    gdisplay = display.newGroup()

    map_id = event.params.map_id
    user_id = event.params.user_id
    local image_background  = "img/background/background_a1.png"
    gdisplay:insert(background)

    local titleText = display.newImageRect(text_title ,screenW/1.8, screenH/17 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.12
    gdisplay:insert(titleText)

    createBackButton()
    loadChapter()
    scrollViewFN()
    --gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(gdisplay)

    ------------- other scene ---------------
    menu_barLight.checkMemory()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "mission" )
    storyboard.purgeScene( "map" )
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


