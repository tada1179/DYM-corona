
local storyboard = require("storyboard")
--storyboard.purgeOnSceneChange = true
--storyboard.isDebug = true
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local widget = require "widget"
local loadImageSprite = require ("downloadData").loadImageSprite_Upgrade_Animation1()
-- ------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local groupView

local btnBox
local btnTeam

local image_text = "img/text/UNIT.png"
local titleText
local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
-------------------------------------
local function onRelistMenu(event)
    menu_barLight.SEtouchButton()
    display.remove(btnBox)
    btnBox = nil
    display.remove(btnTeam)
    btnTeam = nil
    display.remove(titleText)
    titleText = nil

    for i= groupView.numChildren,1,-1 do
        local child = groupView[i]
        child.parent:remove( child )
        child = nil
        groupView[i] = nil
    end
    display.remove(groupView)
    groupView = nil

    if event.target.id == "BOX" then
       storyboard.gotoScene( "unit_box", "fade", 100 )

    elseif event.target.id == 1 then
        storyboard.gotoScene( "team_main", "fade", 100 )

    elseif event.target.id == 2 then
        storyboard.gotoScene( "characterAll", "fade", 100 )

    elseif event.target.id == 3 then
        storyboard.gotoScene( "upgrade_main", "fade", 100 )

    elseif event.target.id == 4 then
        storyboard.gotoScene( "discharge_main", "fade", 100 )

    end
    --menu_barLight.checkMemory()
end
local function listMenu()
    local img_team = "img/background/iconbox.png"
    local img_box = "img/background/button/BOX.png"

    local textmyFriend
    local countlist = 4
    local pointY = screenH *.4
    local idtext
    for i=1,countlist,1 do

        if i==1 then
             text = "TEAM SETTING"

        elseif i==2 then
            text = "POWER UP"

        elseif i==3 then
            text = "UPGRADE"

        elseif i==4 then
            text = "DISCHARGE"

        else

        end

        btnTeam = widget.newButton{
            defaultFile= img_team,
            overFile = img_team,
            width = screenW*.62, height= screenH*.08,
            onRelease = onRelistMenu,	-- event listener function
            label = text  ,
            labelColor = {
                default = { 255, 255, 255, 255},
                over = { 255, 255, 255, 255 },
            }         ,
            font = typeFont,
            fontSize = sizetextName,
        }
        btnTeam.id= i
        btnTeam:setReferencePoint( display.CenterReferencePoint )
        btnTeam.x = screenW *.5
        btnTeam.y = pointY
        groupView:insert(btnTeam)

        pointY = pointY + screenH*.1
    end

    btnBox = widget.newButton{
        defaultFile=img_box,
        overFile=img_box,
        width=screenW/8.5, height=screenH/22.5,
        onRelease = onRelistMenu	-- event listener function
    }
    btnBox.id="BOX"
    btnBox:setReferencePoint( display.TopLeftReferencePoint )
    btnBox.x = screenW *.7
    btnBox.y = screenH *.31
    groupView:insert(btnBox)

end
function scene:createScene( event )
    native.setActivityIndicator( false )
    local group = self.view
    groupView = display.newGroup()
    groupView:insert(background)

    titleText = display.newImageRect(image_text,screenW*.15,screenH*.027)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH/3.15

    groupView:insert(titleText)
    groupView:insert(menu_barLight.newMenubutton())
    listMenu()
    group:insert(groupView)
    menu_barLight.checkMemory()
    --------------------------
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
    display.remove(btnBox)
    btnBox = nil
    display.remove(btnTeam)
    btnTeam = nil

    display.remove(titleText)
    titleText = nil

--    for i= groupView.numChildren,1,-1 do
--        local child = groupView[i]
--        child.parent:remove( child )
--        child = nil
--    end
    display.remove(groupView)
    groupView = nil
    --storyboard:removeScene("unit_main")
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene