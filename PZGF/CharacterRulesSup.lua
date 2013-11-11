
local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.isDebug = true
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local util = require ("util")
local widget = require "widget"
-- ------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local groupView

local btnBox
local btnTeam
local btnPower
local btnUpgrade
local btnDischarge

local btnBack
local btnGallery
local btnAnnouncement
local btnEditname
local btnGameCenter
local btnContactUs

local image_text = "img/setting/OTHER.png"
local titleText
local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local fontsize = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead

local prevTime = 0
local pointListY =0
local listener
local scrollView
-------------------------------------
local function onBtnRelease(event)

    if(event.target.id == "back")then
        menu_barLight.SEtouchButtonBack()
        storyboard.gotoScene( "CharacterRules", "fade", 100 )
    end

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
    groupView:insert(backButton)
end

function scene:createScene( event )
    groupView = display.newGroup()
    local group = self.view
    local num = event.params.num
    local textHead = event.params.text
    local text =
        {
            "     The ally is a monster which you can select \nfrom you friends or adventurers to help you \nin each battle.Except for adventurers,ally has \nthe ability to use leader skill.\n    You can earn 10 friend points if you select \na friend and 5 if you select an adventurer.\n   Also,at the header square above the world \nmap, you can assing a suitable monster from \nthe inventory as your friends'ally.",
            "     Level up and evole are 2 ways to strengthen \nyour character. Level Up - merge 2 or more \ncharacters. Evole - when character has \nreached maximum level, he or she can be \nevoled with required elements",
            "     Every character has own unique active skill.\nThe higher level of active skill, player \ncan active the activate skill in shorter turn. \n    Player can gain Exp and increase level of \nactive skill by finishing battles.  ",
            "     Characters can earns more Exp if they \nlevel up with same element characters.",
        }
    groupView:insert(background)

    titleText  = display.newText(textHead, 0, screenH*.30,typeFont, fontsizeHead)
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.5
    titleText:setTextColor(255, 255, 255)


    local SmachText_s = util.wrappedText(text[num], screenW*.28, fontsize,typeFont, {200, 200, 200})
    SmachText_s.x = screenW*.1
    SmachText_s.y = screenH*.38
    createBackButton()
    groupView:insert(SmachText_s)
    groupView:insert(titleText)
    groupView:insert(menu_barLight.newMenubutton())


    group:insert(groupView)
    menu_barLight.checkMemory()
    --------------------------
end
function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "CharacterRules" )
    storyboard.purgeAll()
    storyboard.removeAll ()
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
    display.remove(btnPower)
    btnPower = nil
    display.remove(btnUpgrade)
    btnUpgrade = nil
    display.remove(btnDischarge)
    btnDischarge = nil

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
