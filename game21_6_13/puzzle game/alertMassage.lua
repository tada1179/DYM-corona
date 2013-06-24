print("alertMassage.lua")
module(..., package.seeall)
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()

local widget = require "widget"
local http = require("socket.http")
local json = require("json")
local includeFUN = require("includeFunction")

local screenW = display.contentWidth
local screenH = display.contentHeight
-----------------------------------------------

function resetCharacter(id,holddteam_no,team_id,USERID)
    print("function resetCharacter !!")
    local typeFont = native.systemFontBold
    local sizetextName = 20
    local character_id =  id
    local Cholddteam_no =  holddteam_no
    local Cteam_id =  team_id
    local USER_id =  USERID
    local back_while
    local myRectangle
    local btn_cancel
    local btn_OK
    local SmachText

    local options =
    {
        effect = "crossFade",
        time = 100,
        params = {
            character_id =character_id ,
            holddteam_no =  Cholddteam_no,
            team_id =  Cteam_id ,
            user_id = USER_id
        }
    }

    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local groupView = display.newGroup()
    local groupEnd = display.newGroup()

    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        btn_cancel.alpha   = 0
        btn_OK.alpha       = 0
        myRectangle.alpha  = 0
        SmachText.alpha = 0
        back_while.alpha = 0

        print( "infunction reset event: "..event.target.id)

       if event.target.id == "ok" then
           print("reset team_id="..team_id,"user ="..USERID)
           local ulrResetsert = "http://localhost/DYM/resetTeam.php"
           local characResetsert =  ulrResetsert.."?team_no="..team_id.."&user_id="..USERID
           local complte = http.request(characResetsert)

           if complte then
               print("compleate",complte)
               storyboard.gotoScene( "pageWith",options )
               storyboard.removeScene( "team_main" )
               storyboard.gotoScene( "team_main",options )
               storyboard.removeScene( "pageWith" )
           end

        elseif event.target.id == "cancel" then

            storyboard.gotoScene( "team_main" ,options )

       end
    end

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setStrokeColor(255,255,255)
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    SmachText = display.newText("Confirm to Reset your Team?", screenW*.27, screenH *.45,typeFont, sizetextName)
    SmachText:setTextColor(255, 255, 255)
    groupView:insert(SmachText)

    --button cancel profile
    btn_cancel = widget.newButton{
        default=image_cancel,
        over=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.65
    btn_cancel.y = screenH*.55
    groupView:insert(btn_cancel)

    --button ok profile
    btn_OK = widget.newButton{
        default=image_ok,
        over=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)



    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )

    return groupView
end

function confrimDischarge(countCHNo,characterAll,numCoin,user_id)
    print("confrimDischarge:",numCoin)
    print("--* confrimDischarge *--")
    local typeFont = native.systemFontBold
    local sizetext = 16
    local sizetextName = 20
    local sizeleaderW = display.contentWidth*.135
    local sizeleaderH = display.contentWidth*.135

    local back_while
    local myRectangle
    local btn_cancel
    local btn_OK
    local SmachText
    local options
    local Coin = numCoin

    local groupView = display.newGroup()
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local frame = {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }

    options =
    {
        effect = "crossFade",
        time = 100,
        params = {
            countCHNo =countCHNo ,
            numCoin =  numCoin,
            user_id = user_id
        }
    }
    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        local characterChoose = {}
        local LinkDischarge = "http://localhost/DYM/discharge.php"
        local LinkDis_coin = "http://localhost/DYM/discharge_coin.php"
        groupView.alpha = 0
        local complte

        if event.target.id == "ok" then
            options =
            {
                effect = "crossFade",
                time = 100,
                params = {
                    countCHNo =0 ,
                    numCoin =  0,
                    user_id = user_id
                }
            }

            for i = 1,countCHNo,1 do
                characterChoose[i] = characterAll[i]
                local characResetsert =  LinkDischarge.."?character="..characterChoose[i].."&user_id="..user_id
                complte = http.request(characResetsert)

            end
            if complte then
                local DisCoin =  LinkDis_coin.."?coin="..numCoin.."&user_id="..user_id
                local complteDisCoin = http.request(DisCoin)

                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene( "discharge_main" )
                storyboard.gotoScene( "discharge_main",options )
                storyboard.removeScene( "pageWith" )
            end

            return true
        elseif event.target.id == "cancel" then
            storyboard.gotoScene( "discharge_main",options )
            return false
        end
    end
    local characterChoose = {}
    local LinkOneCharac = "http://localhost/DYM/Onecharacter.php"
    local j = 1

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.1, screenH*.35, screenW*.8, screenH*.5,7)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local LeaderpointX = 0
    local LeaderpointY = 0
    local LeaderpointY2 = 0

    local LVpointX = 0
    local LVpointY = 0

    for i = 1,countCHNo,1 do
        characterChoose[i] = characterAll[i]

        if i > 5 then
            LeaderpointY2 = LeaderpointY2 + (screenH *.1 +(j*-.115) )
            LeaderpointX = screenW *.78
            LeaderpointY = LeaderpointY2

            LVpointX =  LeaderpointX + (screenH*.074)
            LVpointY =  LeaderpointY + (screenW*.04)

            j = j + 1
        else
            LeaderpointY = LeaderpointY + (screenH *.1 +(i*-.115) )
            LeaderpointX = screenW *.63

            LVpointX =  LeaderpointX + (screenH*.074)
            LVpointY =  LeaderpointY + (screenW*.04)

        end

        local characterID =  LinkOneCharac.."?character="..characterChoose[i].."&user_id="..user_id
        local characterImg = http.request(characterID)
        local characterSelect
        local character_type
        local character_name
        local character_DEF
        local character_ATK
        local character_HP
        local character_LV
        local FrameCharacter
        local ImageCharacter

        if characterImg == nil then
            print("No Dice")
        else
            characterSelect  = json.decode(characterImg)
            character_type = "smach"
            character_name = characterSelect.chracter[1].charac_name
            character_DEF = characterSelect.chracter[1].charac_def
            character_ATK = characterSelect.chracter[1].charac_atk
            character_HP = characterSelect.chracter[1].charac_hp
            character_LV = characterSelect.chracter[1].charac_lv
            ImageCharacter = characterSelect.chracter[1].charac_img_mini
            FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)

            local framImage = display.newImageRect(frame[FrameCharacter] ,sizeleaderW, sizeleaderH)
            framImage:setReferencePoint( display.TopLeftReferencePoint )
            framImage.x = LeaderpointY
            framImage.y = LeaderpointX

            local characImage = display.newImageRect(ImageCharacter ,sizeleaderW, sizeleaderH)
            characImage:setReferencePoint( display.TopLeftReferencePoint )
            characImage.x = LeaderpointY
            characImage.y = LeaderpointX
            groupView:insert(characImage)
            groupView:insert(framImage)

            local textLV = display.newText("Lv."..character_LV, LVpointY,LVpointX,typeFont, sizetext)
            textLV:setTextColor(255, 255, 255)
            groupView:insert(textLV)

        end


    end

    SmachText = display.newText("Discharge your Character", screenW*.3, screenH *.38,typeFont, sizetextName)
    SmachText:setTextColor(255, 255, 255)
    groupView:insert(SmachText)

    local CoinText = display.newText("Confirm", screenW*.45, screenH *.7,typeFont, sizetextName)
    CoinText.text = string.format("Confirm to Discharge your Character?")
    CoinText:setTextColor(255, 255, 255)
    groupView:insert(CoinText)

    local txtSMS = display.newText("Coin : "..Coin, screenW*.16, screenH *.62,typeFont, sizetextName)
--    txtSMS.text = string.format("Coin :", Coin )
    txtSMS:setTextColor(255, 255, 255)
    groupView:insert(txtSMS)

    --button cancel profile
    btn_cancel = widget.newButton{
        default=image_cancel,
        over=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.65
    btn_cancel.y = screenH*.77
    groupView:insert(btn_cancel)

    --button ok profile
    btn_OK = widget.newButton{
        default=image_ok,
        over=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.77
    groupView:insert(btn_OK)

    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )



    return groupView
end

function confrimSellItem(option)
    local itemNum = nil
    local gdisplay = display.newGroup()
    local typeFont = native.systemFontBold
    local sizeFont =  18
    local NamesizeFont =  25
    local frame =
    {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }
    local image_minus = "img/background/button/as_butt_sell_minus.png"
    local image_plus = "img/background/button/as_butt_sell_plus.png"

    local image_massage = "img/text/CAUTION_ARE_SURE_TO_SELL_THIS_ITEM.png"
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local image_btnsell= "img/background/button/SELL.png"
    local image_btncancel = "img/background/button/as_butt_discharge_cancel.png"

    local backgroundCaution
    local TextMassage
    local ButtonCancel
    local ButtonSell
    local imgPlus
    local imgiMinus

    local oneItem = option.params
    local user_id = oneItem.user_id
    local img_item = oneItem.img_item
    local item_name = oneItem.item_name
    local holditem_id = oneItem.holditem_id --use item id
    local amount = oneItem.amount
    local element_item = oneItem.element_item
    local coin_item = oneItem.coin_item
    local NumCoin = nil

    print("event holditem_id:",holditem_id)
    --**--
    local imgitemsell = display.newImageRect( img_item, screenW*.18,screenH*.13 )
    imgitemsell:setReferencePoint( display.CenterReferencePoint )
    imgitemsell.x = screenW *.3
    imgitemsell.y = screenH*.55
    imgitemsell.alpha = 1

    local frmitemsell = display.newImageRect( frame[element_item], screenW*.18,screenH*.13 )
    frmitemsell:setReferencePoint( display.CenterReferencePoint )
    frmitemsell.x = screenW *.3
    frmitemsell.y = screenH*.55
    frmitemsell.alpha = 1

    local NameItem = display.newText(item_name, screenW*.44, screenH*.49, typeFont, NamesizeFont)
    NameItem:setTextColor(218, 165, 32)
    NameItem.text =  string.format(item_name)
    NameItem.alpha = 1

    local CoinItem = display.newText(coin_item, screenW*.29, screenH*.68, typeFont, sizeFont)
    CoinItem:setTextColor(218, 165, 32)
    CoinItem.text =  string.format("COIN : "..coin_item)
    CoinItem.alpha = 1

    local amountItem = display.newText(amount, screenW*.52, screenH*.54, typeFont, sizeFont)
    amountItem:setTextColor(255, 255, 255)
    amountItem.text =  string.format("AMOUNT : "..amount)
    amountItem.alpha = 1

    local txtSELL = display.newText("ITEM SELL", screenW*.25, screenH*.632, typeFont, sizeFont)
    txtSELL:setTextColor(255, 255, 255)
    txtSELL.text =  string.format("ITEM SELL : ")
    txtSELL.alpha = 1

    itemNum = 1
    local ItemNumSELL = display.newText(itemNum, screenW*.59, screenH*.625, typeFont, NamesizeFont)
    ItemNumSELL:setTextColor(255, 0, 255)
    ItemNumSELL.text =  string.format(itemNum)
    ItemNumSELL.alpha = 1
    --**--
    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then


            return true
        end
    end

    local function onbtnPlusItem(event)

        if event.target.id == "plus" then
            if itemNum < amount then
                itemNum = itemNum + 1
                NumCoin = coin_item * itemNum
                ItemNumSELL.text =  string.format(itemNum)
                CoinItem.text =  string.format("COIN : "..NumCoin)
            end

        elseif event.target.id == "minus" then
            if itemNum > 1  then
                itemNum = itemNum - 1
                NumCoin = coin_item * itemNum
                ItemNumSELL.text =  string.format(itemNum)
                CoinItem.text =  string.format("COIN : "..NumCoin)
            end
        end

    end

    local function onBtncharacter(event)
        backgroundCaution.alpha       = 0
        TextMassage.alpha  = 0
        ButtonCancel.alpha = 0
        ButtonSell.alpha = 0
        imgitemsell.alpha = 0
        frmitemsell.alpha = 0
        CoinItem.alpha = 0
        amountItem.alpha = 0
        txtSELL.alpha = 0
        NameItem.alpha = 0
        imgiMinus.alpha = 0
        imgPlus.alpha = 0
        ItemNumSELL.alpha = 0


        local options =
        {
                effect = "crossFade",
                time = 100,
                params = {
                    user_id = user_id
                }
        }

        if event.target.id == "sellItem" then
            print("holditem_id:",holditem_id)
            local ulrResetsert = "http://localhost/DYM/sell_item.php"
            local characResetsert =  ulrResetsert.."?holditem="..holditem_id.."&user_id="..user_id.."&numDeleteItem="..itemNum
            local complte = http.request(characResetsert)

            if complte then
                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene(  "sell_item" )
                storyboard.removeScene(  "item_setting" )
                storyboard.gotoScene(  "sell_item",options )
                storyboard.removeScene( "pageWith" )
            end

        elseif event.target.id == "cancel" then

            storyboard.gotoScene( "sell_item" ,options )

        end
    end
    backgroundCaution = display.newImageRect( image_Caution, screenW*.95,screenH*.7 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = screenW *.5
    backgroundCaution.y = screenH*.55
    backgroundCaution.alpha = .9

    TextMassage =  display.newImageRect( image_massage, screenW*.35,screenH*.13 )
    TextMassage:setReferencePoint( display.CenterReferencePoint )
    TextMassage.x = screenW *.5
    TextMassage.y = screenH*.4
    TextMassage.alpha = 1

    -- -- -- -- -  -- --
    imgPlus = widget.newButton{
        default= image_plus,
        over=  image_plus,
        width= screenW*.06, height= screenH*.04,
        onRelease = onbtnPlusItem	-- event listener function
    }
    imgPlus.id="plus"
    imgPlus:setReferencePoint( display.TopLeftReferencePoint )
    imgPlus.x = screenW * .68
    imgPlus.y = screenH *.625
    imgPlus.alpha = 1

    imgiMinus = widget.newButton{
        default= image_minus,
        over=  image_minus,
        width= screenW*.06, height= screenH*.04,
        onRelease = onbtnPlusItem	-- event listener function
    }
    imgiMinus.id="minus"
    imgiMinus:setReferencePoint( display.TopLeftReferencePoint )
    imgiMinus.x = screenW * .48
    imgiMinus.y = screenH *.625
    imgiMinus.alpha = 1



    -- ******** - -
    ButtonSell = widget.newButton{
        default= image_btnsell,
        over=  image_btnsell,
        width= screenW*.26, height= screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonSell.id="sellItem"
    ButtonSell:setReferencePoint( display.TopLeftReferencePoint )
    ButtonSell.x = screenW * .2
    ButtonSell.y = screenH *.75
    ButtonSell.alpha = 1

    -- ******** - -
    ButtonCancel = widget.newButton{
        default= image_btncancel,
        over=  image_btncancel,
        width= screenW*.24, height= screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonCancel.id="cancel"
    ButtonCancel:setReferencePoint( display.TopLeftReferencePoint )
    ButtonCancel.x = screenW * .55
    ButtonCancel.y = screenH *.75
    ButtonCancel.alpha = 1
   ---------------------------------------------

    gdisplay:insert(backgroundCaution)
    gdisplay:insert(ButtonSell)
    gdisplay:insert(ButtonCancel)
    gdisplay:insert(TextMassage)

    gdisplay:insert(ItemNumSELL)
    gdisplay:insert(imgiMinus)
    gdisplay:insert(imgPlus)
    gdisplay:insert(NameItem)
    gdisplay:insert(imgitemsell)
    gdisplay:insert(frmitemsell)
    gdisplay:insert(CoinItem)
    gdisplay:insert(amountItem)
    gdisplay:insert(txtSELL)

    gdisplay.touch = onTouchGameOverScreen
    gdisplay:addEventListener( "touch", gdisplay )
end

function requestFriend()
    local typeFont = native.systemFontBold
    local sizetextName = 25
    local image_ok = "img/background/button/OK_button.png"
    local groupView = display.newGroup()
    local  myRectangle
    local SmachText

    local function onBtncharacter(event)
        groupView.alpha = 0
        myRectangle.alpha = 0
        SmachText.alpha = 0

        print("event.target.id == ",event.target.id)
        if event.target.id == "ok" then
            storyboard.gotoScene( "player_list",  "fade", 50 )
        end
    end
    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )
            return true
        end
    end
     myRectangle = display.newRoundedRect(screenW*.1, screenH*.4, screenW*.8, screenH*.35,7)
     myRectangle.strokeWidth = 2
     myRectangle.alpha = .9
     myRectangle:setFillColor(0, 0, 0)
     groupView:insert(myRectangle)

    SmachText = display.newText("!!Can't request friend id = your id", screenW*.18, screenH *.45,typeFont, sizetextName)
    SmachText:setTextColor(0, 200, 0)
    groupView:insert(SmachText)

    local  btn_OK = widget.newButton{
        default=image_ok,
        over=image_ok,
        width=screenW*.3, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.5
    btn_OK.y = screenH*.65
    groupView:insert(btn_OK)

    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )

end

function resetItem(user_id)
    print("function resetItem !!")
    local typeFont = native.systemFontBold
    local sizetextName = 20
    local user_id =  user_id
    local back_while
    local myRectangle
    local btn_cancel
    local btn_OK
    local SmachText

    local options =
    {
        effect = "crossFade",
        time = 100,
        params = {
            user_id = user_id
        }
    }

    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local groupView = display.newGroup()
    local groupEnd = display.newGroup()

    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        btn_cancel.alpha   = 0
        btn_OK.alpha       = 0
        myRectangle.alpha  = 0
        SmachText.alpha = 0
        back_while.alpha = 0

        print( "infunction reset event: "..event.target.id)

        if event.target.id == "ok" then
            local ulrResetsert = "http://localhost/DYM/reset_item.php"
            local characResetsert =  ulrResetsert.."?user_id="..user_id
            local complte = http.request(characResetsert)

            if complte then
                print("compleate",complte)
                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene( "item_setting" )
                storyboard.gotoScene( "item_setting",options )
                storyboard.removeScene( "pageWith" )
            end

        elseif event.target.id == "cancel" then

            storyboard.gotoScene( "item_setting" ,options )

        end
    end

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    SmachText = display.newText("Confirm to Reset your Item?", screenW*.27, screenH *.45,typeFont, sizetextName)
    SmachText:setTextColor(255, 255, 255)
    groupView:insert(SmachText)

    --button cancel profile
    btn_cancel = widget.newButton{
        default=image_cancel,
        over=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.65
    btn_cancel.y = screenH*.55
    groupView:insert(btn_cancel)

    --button ok profile
    btn_OK = widget.newButton{
        default=image_ok,
        over=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)



    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )

    return groupView
end

function accepFriend(option)
    print("FN accepFriend")
    local itemNum = nil
    local GaccepFriend = display.newGroup()
    local typeFont = native.systemFontBold
    local sizeFont =  20
    local NamesizeFont =  25
    local frame =
    {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local image_btnACCEPT= "img/background/button/ACCEPT.png"
    local image_btnIGNORE= "img/background/button/IGNORE.png"
    local image_btncancel = "img/background/button/as_butt_discharge_cancel.png"

    local ButtonCancel
    local ButtonIgnore
    local ButtonAccep
    local imgPlus
    local imgiMinus

    local onefriend = option.params

    local user_id = onefriend.user_id
    local charac_id = onefriend.charac_id
    local friend_id = onefriend.friend_id
    local friend_name = onefriend.friend_name
    local charac_img = onefriend.charac_img
    local dateModify = onefriend.dateModify
    local element = onefriend.element
    local charac_lv = onefriend.charac_lv
    local friend_lv = onefriend.friend_lv

    local NumCoin = nil

    print("friend_id:"..friend_id,"::=> user_id:"..user_id)
    --**--
    local backgroundCaution = display.newImageRect( image_Caution, screenW*.95,screenH*.6 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = screenW *.5
    backgroundCaution.y = screenH*.5
    backgroundCaution.alpha = .9
    GaccepFriend:insert(backgroundCaution)

    local textMSN = "You want to respond to a friend."
    local TextMassage = display.newText(textMSN, screenW*.18, screenH*.4, typeFont, NamesizeFont)
    TextMassage:setTextColor(255, 255, 255)
    TextMassage.text =  string.format(textMSN)
    TextMassage.alpha = 1
    GaccepFriend:insert(TextMassage)

    local imgFriend = display.newImageRect( charac_img, screenW*.18,screenH*.13 )
    imgFriend:setReferencePoint( display.CenterReferencePoint )
    imgFriend.x = screenW *.3
    imgFriend.y = screenH*.55
    imgFriend.alpha = 1
    GaccepFriend:insert(imgFriend)

    local frmFriend = display.newImageRect( frame[element], screenW*.18,screenH*.13 )
    frmFriend:setReferencePoint( display.CenterReferencePoint )
    frmFriend.x = screenW *.3
    frmFriend.y = screenH*.55
    frmFriend.alpha = 1
    GaccepFriend:insert(frmFriend)

    local LVCharacter = display.newText(charac_lv, screenW*.7, screenH*.49, typeFont, NamesizeFont)
    LVCharacter:setTextColor(200, 200, 200)
    LVCharacter.text =  string.format("Lv."..charac_lv)
    LVCharacter.alpha = 1
    GaccepFriend:insert(LVCharacter)

    local NameFriend = display.newText(friend_name, screenW*.44, screenH*.49, typeFont, NamesizeFont)
    NameFriend:setTextColor(218, 165, 32)
    NameFriend.text =  string.format(friend_name)
    NameFriend.alpha = 1
    GaccepFriend:insert(NameFriend)

    local LVFriend = display.newText(friend_lv, screenW*.29, screenH*.6, typeFont, sizeFont)
    LVFriend:setTextColor(200, 0, 200)
    LVFriend.text =  string.format("Lv."..friend_lv)
    LVFriend.alpha = 1
    GaccepFriend:insert(LVFriend)

    local dateTime = display.newText(dateModify, screenW*.45, screenH*.55, typeFont, sizeFont)
    dateTime:setTextColor(200, 100, 200)
    dateTime.text =  string.format(dateModify)
    dateTime.alpha = 1
    GaccepFriend:insert(dateTime)
    --**--
    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then


            return true
        end
    end

    local function onBtncharacter(event)
        backgroundCaution.alpha = 0
        TextMassage.alpha       = 0
        ButtonCancel.alpha      = 0
        imgFriend.alpha         = 0
        frmFriend.alpha         = 0
        ButtonAccep.alpha       = 0
        ButtonIgnore.alpha      = 0

        NameFriend.alpha        = 0
        dateTime.alpha          = 0
        LVFriend.alpha          = 0
        LVCharacter.alpha       = 0


        local options =
        {
            effect = "crossFade",
            time = 100,
            params = {
                user_id = user_id
            }
        }


        local ulrResetsert = "http://localhost/DYM/accepFriend.php"
        print(event.target.id)

        if event.target.id == "ACCEPT" then

            local characResetsert =  ulrResetsert.."?user_id="..user_id.."&friend="..friend_id.."&respont=1"
            local numberHold = http.request(characResetsert)
            local allRow  = json.decode(numberHold)
            if allRow then
                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene(  "request_list" )
                storyboard.gotoScene(  "request_list",options )
                storyboard.removeScene( "pageWith" )
            end
        elseif event.target.id == "IGNORE" then

            local characResetsert =  ulrResetsert.."?user_id="..user_id.."&friend="..friend_id.."&respont=2"
            local complte = http.request(characResetsert)

            if complte then
                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene(  "request_list" )
                storyboard.gotoScene(  "request_list",options )
                storyboard.removeScene( "pageWith" )
            end

        elseif event.target.id == "cancel" then

            storyboard.gotoScene( "request_list" ,options )

        end
    end


    -- ******** - -
    ButtonAccep = widget.newButton{
        default= image_btnACCEPT,
        over=  image_btnACCEPT,
        width= screenW*.2, height= screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonAccep.id="ACCEPT"
    ButtonAccep:setReferencePoint( display.TopLeftReferencePoint )
    ButtonAccep.x = screenW * .15
    ButtonAccep.y = screenH *.65
    ButtonAccep.alpha = 1
    GaccepFriend:insert(ButtonAccep)

    -- ******** - -
    ButtonIgnore = widget.newButton{
        default= image_btnIGNORE,
        over=  image_btnIGNORE,
        width= screenW*.2, height= screenH*.045,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonIgnore.id="IGNORE"
    ButtonIgnore:setReferencePoint( display.TopLeftReferencePoint )
    ButtonIgnore.x = screenW * .38
    ButtonIgnore.y = screenH *.655
    ButtonIgnore.alpha = 1
    GaccepFriend:insert(ButtonIgnore)

    -- ******** - -
    ButtonCancel = widget.newButton{
        default= image_btncancel,
        over=  image_btncancel,
        width= screenW*.2, height= screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonCancel.id="cancel"
    ButtonCancel:setReferencePoint( display.TopLeftReferencePoint )
    ButtonCancel.x = screenW * .6
    ButtonCancel.y = screenH *.65
    ButtonCancel.alpha = 1
    GaccepFriend:insert(ButtonCancel)
    ---------------------------------------------

    GaccepFriend.touch = onTouchGameOverScreen
    GaccepFriend:addEventListener( "touch", GaccepFriend )
end

function NoDataInList()
    print("function resetItem !!")
    local typeFont = native.systemFontBold
    local sizetextName = 20
    local back_while
    local myRectangle
    local btn_OK
    local SmachText

    local options =
    {
        effect = "zoomOutInFade",
        time = 200,
    }

    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local groupView = display.newGroup()
    local groupEnd = display.newGroup()

    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        btn_OK.alpha       = 0
        myRectangle.alpha  = 0
        SmachText.alpha = 0
        back_while.alpha = 0

        print( "infunction reset event: "..event.target.id)

        if event.target.id == "ok" then
                storyboard.gotoScene( "commu_main",options )
                storyboard.removeScene( "request_list",options )
        end
    end

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    SmachText = display.newText("No Friend Request", screenW*.35, screenH *.45,typeFont, sizetextName)
    SmachText:setTextColor(255, 255, 255)
    groupView:insert(SmachText)

    --button ok profile
    btn_OK = widget.newButton{
        default=image_ok,
        over=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.5
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)



    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )

    return groupView
end

function showFriendRequest(option)
    local itemNum = nil
    local gdisplay = display.newGroup()
    local typeFont = native.systemFontBold
    local sizeFont =  20
    local NamesizeFont =  23
    local frame =
    {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local image_btnOK= "img/background/button/OK_button.png"
    local image_btncancel = "img/background/button/as_butt_discharge_cancel.png"

    local backgroundCaution
    local ButtonCancel
    local ButtonOK
    local txtMSN

    local oneItem = option.params
    local user_id = oneItem.user_id
    local friend_id = oneItem.friend_id
    local Friend_Lv = oneItem.Friend_Lv
    local Friend_name = oneItem.Friend_name
    local Friend_date = oneItem.Friend_date
    local charac_img = oneItem.charac_img
    local charac_id = oneItem.charac_id
    local charac_element = tonumber(oneItem.charac_element)
    local charac_Lv = oneItem.charac_Lv
    local friend_respont = oneItem.friend_respont

    local textMSN
    if friend_respont == 0 then
        textMSN = "Confirm to send Friend Request?"
    else
        textMSN = "This user is already on your friends list."
    end


    --**--
    local imgCharacter = display.newImageRect(charac_img, screenW*.18,screenH*.13 )
    imgCharacter:setReferencePoint( display.CenterReferencePoint )
    imgCharacter.x = screenW *.3
    imgCharacter.y = screenH*.55
    imgCharacter.alpha = 1

    local frmCharacter = display.newImageRect( frame[charac_element], screenW*.18,screenH*.13 )
    frmCharacter:setReferencePoint( display.CenterReferencePoint )
    frmCharacter.x = screenW *.3
    frmCharacter.y = screenH*.55
    frmCharacter.alpha = 1

    local NameCharacter = display.newText(Friend_name, screenW*.45, screenH*.49, typeFont, NamesizeFont)
    NameCharacter:setTextColor(218, 165, 32)
    NameCharacter.text =  string.format(Friend_name)
    NameCharacter.alpha = 1

    local LvCharacter = display.newText(charac_Lv, screenW*.28, screenH*.6, typeFont, sizeFont)
    LvCharacter:setTextColor(255, 255, 255)
    LvCharacter.text =  string.format("Lv."..charac_Lv)
    LvCharacter.alpha = 1

    local LvFriend = display.newText(Friend_Lv, screenW*.7, screenH*.49, typeFont, NamesizeFont)
    LvFriend:setTextColor(255, 255, 255)
    LvFriend.text =  string.format("Lv."..Friend_Lv)
    LvFriend.alpha = 1

    local DateLogin = display.newText(Friend_date, screenW*.45, screenH*.55, typeFont, sizeFont)
    DateLogin:setTextColor(255, 0, 255)
    DateLogin.text =  string.format(Friend_date)
    DateLogin.alpha = 1
    --**--
    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then


            return true
        end
    end


    local function onBtncharacter(event)
        backgroundCaution.alpha   = 0
        imgCharacter.alpha   = 0
        frmCharacter.alpha   = 0
        NameCharacter.alpha   = 0
        LvCharacter.alpha   = 0
        LvFriend.alpha   = 0
        DateLogin.alpha   = 0

        ButtonCancel.alpha = 0
        ButtonOK.alpha = 0
        txtMSN.alpha = 0


        local options =
        {
            effect = "crossFade",
            time = 100,
            params = {
                user_id = user_id
            }
        }
        local respont = 0 --add friend
        if event.target.id == "OK" then
            local ulrResetsert = "http://localhost/DYM/accepFriend.php"
            local characResetsert =  ulrResetsert.."?user_id="..user_id.."&friend="..friend_id.."&respont="..respont
            local complte = http.request(characResetsert)
            local allRow  = json.decode(complte)

            if complte then

                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene( "player_list" )
                storyboard.gotoScene( "player_list",options )
                storyboard.removeScene( "pageWith" )
            end

        elseif event.target.id == "OKBACk" then

            storyboard.gotoScene( "player_list" ,options )

        elseif event.target.id == "cancel" then

            storyboard.gotoScene( "player_list" ,options )
        end
    end
    backgroundCaution = display.newImageRect( image_Caution, screenW*.95,screenH*.6 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = screenW *.5
    backgroundCaution.y = screenH*.55
    backgroundCaution.alpha = .9
    gdisplay:insert(backgroundCaution)

    txtMSN = display.newText("MSN", screenW*.45, screenH*.4, typeFont, NamesizeFont)
    txtMSN:setTextColor(255, 255, 255)
    txtMSN.text =  string.format(textMSN)
    txtMSN.alpha = 1
    gdisplay:insert(txtMSN)

    if friend_respont == 0  then
        ButtonOK = widget.newButton{
            default= image_btnOK,
            over=  image_btnOK,
            width= screenW*.26, height= screenH*.06,
            onRelease = onBtncharacter	-- event listener function
        }
        ButtonOK.id="OK"
        ButtonOK:setReferencePoint( display.TopLeftReferencePoint )
        ButtonOK.x = screenW * .2
        ButtonOK.y = screenH *.68
        ButtonOK.alpha = 1
        gdisplay:insert(ButtonOK)
        -- ******** - -
        ButtonCancel = widget.newButton{
            default= image_btncancel,
            over=  image_btncancel,
            width= screenW*.24, height= screenH*.06,
            onRelease = onBtncharacter	-- event listener function
        }
        ButtonCancel.id="cancel"
        ButtonCancel:setReferencePoint( display.TopLeftReferencePoint )
        ButtonCancel.x = screenW * .55
        ButtonCancel.y = screenH *.68
        ButtonCancel.alpha = 1
        gdisplay:insert(ButtonCancel)
    else
        ButtonOK = widget.newButton{
            default= image_btnOK,
            over=  image_btnOK,
            width= screenW*.26, height= screenH*.06,
            onRelease = onBtncharacter	-- event listener function
        }
        ButtonOK.id="OKBACk"
        ButtonOK:setReferencePoint( display.TopLeftReferencePoint )
        ButtonOK.x = screenW * .38
        ButtonOK.y = screenH *.68
        ButtonOK.alpha = 1
        gdisplay:insert(ButtonOK)

        ButtonCancel = widget.newButton{
            default= image_btncancel,
            over=  image_btncancel,
            width= screenW*.24, height= screenH*.06,
            onRelease = onBtncharacter	-- event listener function
        }
        ButtonCancel.id="cancel"
        ButtonCancel:setReferencePoint( display.TopLeftReferencePoint )
        ButtonCancel.x = screenW * .55
        ButtonCancel.y = screenH *.68
        ButtonCancel.alpha = 0
        gdisplay:insert(ButtonCancel)
    end

    gdisplay.touch = onTouchGameOverScreen
    gdisplay:addEventListener( "touch", gdisplay )
end

function confrimLeaveTicket(option)
    local params = option.params

    local useTicket = params.useTicket
    local NumDiamond = params.NumDiamond
    local NumCoin = params.NumCoin
    local NumEXP = params.NumEXP
    local NumFlag = params.NumFlag
    local user_id = params.user_id


    local typeFont = native.systemFontBold
    local sizetext = 30
    local groupView = display.newGroup()
    local function ButtouRelease (event)
        if event.target.id == "OK" then
            print("OK")
            groupView.alpha = 0

            if useTicket == 1 then      -- 1 :Use ,0:No use
                local LinkURL = "http://localhost/DYM/leaveTicket.php"
                local characResetsert =  LinkURL.."?user_id="..user_id.."&NumFlag="..NumFlag.."&NumDiamond="..NumDiamond.."&NumCoin="..NumCoin.."&NumEXP="..NumEXP
                local complte = http.request(characResetsert)
                    print("compleate",complte)
                    storyboard.gotoScene( "pageWith")
                    storyboard.removeScene( "game-scene" )
                    storyboard.gotoScene( "map","fade",100 )
                    storyboard.removeScene( "pageWith" )
            else
                --storyboard.removeScene( "game-scene")
                storyboard.gotoScene( "map","fade",100)
            end

        elseif event.target.id == "cancel" then
            groupView.alpha = 0
        end

    end

    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while.alpha = .8
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    --local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local backcolor =  display.newRoundedRect(screenW*.1, screenH*.4, screenW*.8, screenH*.3,7)
    backcolor.strokeWidth = 2
    backcolor:setStrokeColor(255,255,255)
    backcolor.alpha = 1
    backcolor:setFillColor(200, 150, 0)
    groupView:insert(backcolor)

    local txtMSN = display.newText("EXP", screenW*.45, screenH*.45, typeFont, sizetext)
    txtMSN:setTextColor(0, 200, 0)
    txtMSN.text =  string.format("Comfrim You Retreat?")
    txtMSN.alpha = 1
    groupView:insert(txtMSN)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        default = img_OK,
        over = img_OK,
        width=screenW*.3, height= screenH*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = screenW*.3
    btnOK.y = screenH*.63
    groupView:insert(btnOK)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btnucancel = widget.newButton{
        default = img_cancel,
        over = img_cancel,
        width=screenW*.3, height= screenH*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnucancel.id = "cancel"
    btnucancel:setReferencePoint( display.CenterReferencePoint )
    btnucancel.alpha = 1
    btnucancel.x = screenW*.68
    btnucancel.y = screenH*.63
    groupView:insert(btnucancel)

    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )

    return groupView

end

function shortProfile(option)
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local imgCharacter = display.newImageRect(image_Caution, screenW*.7,screenH*.2 )
    imgCharacter:setReferencePoint( display.CenterReferencePoint )
    imgCharacter.x = screenW *.5
    imgCharacter.y = screenH*.55
    imgCharacter.alpha = .9
end
