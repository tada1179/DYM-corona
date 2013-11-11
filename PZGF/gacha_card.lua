local storyboard = require( "storyboard" )
local menu_barLight = require("menu_barLight")
local http = require("socket.http")
local json = require("json")
local scene = storyboard.newScene()
local loadImageSprite = require ("downloadData").loadImageSprite_GachaCard()
--------------------------------------
local gdisplay
local TimerCount ={}
local image_sheet = {
    "gacha_card_aura.png",
    "gacha_card_dragon.png",
    "gacha_card_bg_gacha.png",
}
local screenW, screenH = display.contentWidth, display.contentHeight
--------------------------------------
local function lightaura()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = 47, sheetContentWidth =(screenW*5) ,sheetContentHeight = (screenH*10) }

    local sheet_light = graphics.newImageSheet( image_sheet[1],system.DocumentsDirectory, sheetdata_light )
    local sequenceData = { name="sheet", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=3000, loopCount=1 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)

    local function swapSheetlightaura()
        myAnimation.alpha = 1
        myAnimation:setSequence( "sheet" )
        myAnimation:play()
    end
    myAnimation.alpha = 0.1
    TimerCount.myTimer =timer.performWithDelay( 0, swapSheetlightaura )
    menu_barLight.checkMemory()
end
local function darkon()
    local sheetdata_light =  {width = screenW, height = screenH,numFrames = 125, sheetContentWidth =(screenW/2)*10 ,sheetContentHeight =(screenH*12.5)*2 }
    local sheet_light = graphics.newImageSheet( image_sheet[2],system.DocumentsDirectory, sheetdata_light )
    local sequenceData = { name="sheet", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=4000, loopCount=1 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)

    local function swapSheetdarkon()
        myAnimation:setSequence( "sheet" )
        myAnimation:play()

    end
    TimerCount.myTimer =timer.performWithDelay( 0, swapSheetdarkon )
    menu_barLight.checkMemory()
end

local function bg_gacha()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = (((screenW*5)/screenW)+((screenH*15)/screenH)), sheetContentWidth =(screenW*5) ,sheetContentHeight =(screenH*15) }

    local sheet_light = graphics.newImageSheet( image_sheet[3],system.DocumentsDirectory, sheetdata_light )
    local sequenceData = { name="sheet", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=1500, loopCount=1 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)


    local function swapSheetbg_gacha()
        myAnimation:setSequence( "sheet" )
        myAnimation:play()
    end
    TimerCount.myTimer =timer.performWithDelay( 0, swapSheetbg_gacha )
    menu_barLight.checkMemory()
end
function scene:createScene( event )
    require("menu").removeDisplay()
    gdisplay = display.newGroup()
    gdisplay:insert(background)
    local group = self.view
    local USER_id = menu_barLight.user_id()
    local getPoint = event.params.sentoyou
    local changePoint = event.params.changePoint
    menu_barLight.checkMemory()
    TimerCount.myTimer = timer.performWithDelay( 0, bg_gacha )
    TimerCount.myTimer =timer.performWithDelay( 0, darkon )
    TimerCount.myTimer =timer.performWithDelay( 3500, lightaura )


    local function openpage()
        menu_barLight.SEtouchButton()
        local k, v
        for k,v in pairs(TimerCount) do
            timer.cancel(v )
            v = nil; k = nil
        end
        TimerCount = nil
        TimerCount = {}
        gdisplay:removeSelf()
        gdisplay = nil


        local character_id
        local LinkURL = "http://133.242.169.252/DYM/Gacha_character.php?user_id="..USER_id.."&getPoint="..getPoint.."&changePoint="..changePoint
        local response = http.request(LinkURL)
        local dataTable = json.decode(response)

        local path = system.pathForFile("datas.db", system.DocumentsDirectory)
        db = sqlite3.open( path )
        local tablefill ="UPDATE user SET user_FrientPoint = '"..dataTable.FrientPoint.."',user_diamond = '"..dataTable.ticket.."' WHERE user_id = '"..USER_id.."';"
        db:exec( tablefill )
        require("menu").update_user()
        if response == nil then
            print("No Dice")

        else
     --  print("response == ",response)

            character_id = dataTable.character_id
        end
       -- print("character_id == ",character_id)
        local option = {
            effect = "zoomInOutFade",
            time = 200,
            params = {
                character_id =character_id ,
                user_id = USER_id
            }
        }
        storyboard.gotoScene("characterprofile",option)
    end
    TimerCount.myTimer = timer.performWithDelay( 7000, openpage )
    group:insert(gdisplay)
    menu_barLight.checkMemory()
    ------------- other scene ---------------

end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "characterprofile" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
