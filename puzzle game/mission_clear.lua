local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local alertMSN = require ("alertMassage")
local http = require("socket.http")
local json = require("json")
local util = require("util")
----------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local image_flagtest = "img/background/puzzle/flagtest.png"
local image_btnnext = "img/background/button/Button_NEXT.png"
local image_text = "img/text/MISSION_CLEAR.png"

local typeFont = native.systemFontBold
----------------------
local NumFlag =nil
local mission_id =nil
local mission_exp =nil
local NumCoin =nil
local getCharac_id ={}
--------------------
local backButton
local nextButton

local treasure = {}
local transitionStash = {}

local user_id
local imgFlagBox = {}
local myItem = {}
local allItem
local gdisplay = display.newGroup()
------------------------------------------------------------------------------
------------------------------------------------------------------------------
local function loadCharacter(event)
--    NumFlag = 6
--    getCharac_id = {13,119,82,13,119,82,13}

    local Linkmission = "http://localhost/dym/hold_characterFromList.php"
    local numberHold_character =  Linkmission.."?user_id="..user_id.."&NumFlag="..NumFlag

    for i=1,NumFlag,1 do
        numberHold_character =numberHold_character.."&character_id"..i.."="..getCharac_id[i]
    end


    local numberHold = http.request(numberHold_character)
    local allRow  = json.decode(numberHold)

    allItem = tonumber(allRow.chrAll)
    print("numberHold = ",numberHold)
    print("allItem = ",allItem)

    if allItem == 0 then
        print("No Dice")
    else
        local k = 1
        while(k <= allItem) do
            myItem[k] = {}
            myItem[k].holdcharac_id = allRow.character[k].holdcharac_id
            myItem[k].charac_id = allRow.character[k].charac_id
            myItem[k].charac_name = allRow.character[k].charac_name
            myItem[k].charac_element = tonumber(allRow.character[k].charac_element)
            myItem[k].charac_img_mini = allRow.character[k].charac_img_mini
            k = k + 1

        end
    end

end
local function onBtnonclick(event)
    print( "event: "..event.target.id)
    if event.target.id == "next" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map" ,"fade", 100 )
    else
    local option = {
        effect = "fade",
        time = 100,
        params = {
            character_id = event.target.id,
            user_id = user_id ,
        }

    }
        storyboard.gotoScene( "characterprofile" ,option)
    end
    return true
end
local function createButton()
    local sizeimgW = screenW*.15
    local sizeimgH = screenH*.1
    local pointxFLAGfrm = screenW*.1


    for i = 1, allItem ,1 do
         print(i.."= element",myItem[i].charac_element)

         imgFlagBox[i] = display.newImageRect(image_flagtest,sizeimgW,sizeimgH)
         imgFlagBox[i]:setReferencePoint( display.TopLeftReferencePoint )
         imgFlagBox[i].x = pointxFLAGfrm
         imgFlagBox[i].y = screenH *.69
         gdisplay:insert(imgFlagBox[i])

        pointxFLAGfrm = pointxFLAGfrm + screenW*.13
    end
end
local function onTouchFileScreen()
    --next button
    nextButton = widget.newButton{
        defaultFile= image_btnnext,
        overFile= image_btnnext,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnonclick	-- event listener function
    }
    nextButton.id="next"
    nextButton:setReferencePoint( display.TopLeftReferencePoint )
    nextButton.x = display.contentWidth *.73
    nextButton.y = display.contentHeight - (display.contentHeight *.7)
    gdisplay:insert(nextButton)

      local frame = alertMSN.loadFramElement()
      local sizeimgW = screenW*.12
      local sizeimgH = screenH*.08
      local pointxFLAGfrm = screenW*.1
      local imgCharacter = {}
      local imgfrm = {}


      local i = 1
      local function openPicture(id)
          transitionStash.newTransition = transition.to( imgFlagBox[id], { time=550,delay=0, alpha=0,onComplete = CountPic})

          imgCharacter[i] = widget.newButton{
              defaultFile= myItem[i].charac_img_mini,
              overFile= myItem[i].charac_img_mini,
              width=sizeimgW, height=sizeimgH,
              --onRelease = onBtnonclick	-- event listener function
          }
          imgCharacter[i].id= myItem[i].holdcharac_id
          imgCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
          imgCharacter[i].x = pointxFLAGfrm
          imgCharacter[i].y = screenH *.69
          gdisplay:insert(imgCharacter[i])

          imgfrm[i] = display.newImageRect(frame[myItem[i].charac_element],sizeimgW,sizeimgH)
          imgfrm[i]:setReferencePoint( display.TopLeftReferencePoint )
          imgfrm[i].x = pointxFLAGfrm
          imgfrm[i].y = screenH *.69
          pointxFLAGfrm = pointxFLAGfrm + screenW*.13
          gdisplay:insert(imgfrm[i])
      end
      function CountPic()
          if i<=allItem then
              openPicture(i)
              i = i+1
          end

      end
      CountPic()
end
function scene:createScene( event )
    local group = self.view

    local img_bg = "img/background/background_1.jpg"
    user_id = menu_barLight.user_id()
    local user_lv = menu_barLight.userLevel()
    local mission_name = "mission battle"
    local chapter_name = "Chapter NAme"
    NumCoin = 1000
    mission_exp = 84
    local NumPer = 99
    local mission_expNext = 100
    -----------------------

    user_id = event.params.user_id
    mission_id = event.params.mission_id
    mission_name = event.params.mission_name
    chapter_name = event.params.chapter_name
    NumFlag = event.params.NumFlag
    mission_exp = event.params.mission_exp
    NumCoin = event.params.NumCoin
    getCharac_id = event.params.getCharac_id


    local background1 = display.newImageRect(img_bg,screenW,screenH)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0
    group:insert(background1)
    background1.touch = onTouchFileScreen
    background1:addEventListener( "touch", background1 )

    local titleText = display.newImageRect(image_text,screenW*.356,screenH*.028)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = display.contentWidth*.5
    titleText.y = display.contentHeight*.325
    group:insert(titleText)

    local img_tapLV = "img/background/frame/as_enemy_bar.png"
    local img_tapLV_color = "img/head/blue_colour.png"
    local TapLV = display.newImageRect(img_tapLV,screenW*.6,screenH*.025)--contentWidth contentHeight
    TapLV:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    TapLV.x,TapLV.y = screenW*.5,screenH*.55

    local txt_LV = display.newText("Lv."..user_lv.." ( "..NumPer.."% )", 0, 0, typeFont, 20)
    txt_LV:setReferencePoint(display.TopLeftReferencePoint)
    txt_LV:setTextColor(255, 255, 255)
    txt_LV.x = screenW*.21
    txt_LV.y = screenH*.58
    group:insert(txt_LV)

    local txt_ExpAll = display.newText(mission_exp.."/"..mission_expNext.." Exp", 0, 0, typeFont, 20)
    txt_ExpAll:setReferencePoint(display.TopRightReferencePoint)
    txt_ExpAll:setTextColor(255, 255, 255)
    txt_ExpAll.x = screenW*.8
    txt_ExpAll.y = screenH*.58
    group:insert(txt_ExpAll)

    local TapLVColor = display.newImageRect(img_tapLV_color,screenW*.6,screenH*.025)--contentWidth contentHeight
    TapLVColor:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    TapLVColor.x,TapLVColor.y = screenW*.5,screenH*.55
    group:insert(TapLVColor)
    group:insert(TapLV)

    --text name mission
    local txtNamemission = display.newText(mission_name, 0, 0, typeFont, 23)
    txtNamemission:setTextColor(255, 255, 255)
    txtNamemission.x = screenW*.48
    txtNamemission.y = screenH*.42
    group:insert(txtNamemission)

    local txtNameChapter = display.newText(chapter_name, 0, 0, typeFont, 30)
    txtNameChapter:setTextColor(255, 255, 255)
    txtNameChapter.x = screenW*.48
    txtNameChapter.y = screenH*.38
    group:insert(txtNameChapter)

    local txtExpCoin = util.wrappedText("EXP\nCOIN", screenW*.3, 25,typeFont, {255, 255, 255})
    txtExpCoin:setReferencePoint(display.TopLeftReferencePoint)
    txtExpCoin.x = screenW *.25
    txtExpCoin.y = screenH *.42
    group:insert(txtExpCoin)

    local NumExpCoin = util.wrappedText(mission_exp.."\n"..NumCoin, screenW*.3, 25,typeFont, {255, 255, 255})
    NumExpCoin:setReferencePoint(display.TopLeftReferencePoint)
    NumExpCoin.x = screenW *.65
    NumExpCoin.y = screenH *.42
    group:insert(NumExpCoin)

    local txt_flag = display.newText("FLAG", 0, 0, typeFont, 20)
    txt_flag:setTextColor(255, 255, 255)
    txt_flag.x = screenW*.15
    txt_flag.y = screenH*.67

    loadCharacter()
    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(titleText)
    group:insert(txtNamemission)


    group:insert(txt_flag)

    group:insert(gdisplay)
end
function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )

end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

