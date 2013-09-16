-----------------------------------------------------------------------------------------
--
-- test.lua
--
-- ##ref
--
-- test puzzle play
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mRandom = math.random

local gemsTable = {}
local picture = { "img/element/red.png",        --- 1
    "img/element/green.png",    ---2
    "img/element/blue.png",      ---3
    "img/element/purple.png",   ---4
    "img/element/pink.png",      ---5
    "img/element/yellow.png" }  ---6
local onGemTouch
local sizeGem = 96
local widthGem = 106
local gemX, gemY = 6, 5
local stTableX, enTableX = 3, 636

local limitCountGemSlide = 4    ---- chk amount gems
local limitCountGem = 3    ---- chk amount gems
local groupGem = { 0, 0, 0, 0, 0, 0 }
local groupGemChk = { 0, 0, 0, 0, 0, 0 }
local gemToBeDestroyed
local isGemTouchEnabled = true
local countSlide = 0

local channelX = {   54,   --1
    160,  --2
    266,  --3
    372,  --4
    478,  --5
    584   --6
}
local channelY ={   479,  --1
    585,  --2
    691,  --3
    797,  --4
    903,  --5
}

--local amountPlayer = 5 -- simple for test card input to mission
local state_main -- state
local teamPlayer = {}  --- pic, element, hp, protect, lv, power special, leader, power special
local playerDB  ={}  -- data for player
local teamComm={}
local commDB  ={}  -- data for computer
local posXch={10,115,220,325,430,535} ---- à¸£à¸°à¸¢à¸°à¸«à¹à¸²à¸

-------------------------- HP value -------------------------
local number ={}
local hpPlayer = nil
local hpFull = nil
local fullLineHP = 576
local lifeline_sh
local lifeline
--------------------------

local TimersST= {}
local transitionStash = {}
local FlagPNG = {}

storyboard.purgeOnSceneChange = true
--** add function ---------------
local widget = require "widget"
local alertMSN = require("alertMassage")
local menu_barLight = require("menu_barLight")
local http = require("socket.http")
local json = require("json")
local util = require("util")
local physics = require( "physics" )
physics.start()
--physics.setGravity (0, 0)
--physics.setDrawMode ("hybrid")
--**-----------------------------

local _W = display.contentWidth
local _H = display.contentHeight
local background -- background
-- tada1179.w@gmail.com -------------------------------------------------

local user_id
local backButton
local bntItem
local characImage ={}
local Enemy_HP ={}
local Enemy_bar ={}
local TextCD ={}
local battleall = nil
local CountCharacterInBattle = nil
local point = nil
local damage = nil
local NN = 0
local pointStartEnemy_HP = {}
local pointStart
local lineFULLHP = 100

-- game option
-- 1 : ON
-- 2 : OFF
local character_numAll
local image_char = {}

---------------option-------------------------
local BGM = 1
local SFX = 1
local SKL = 1
local BTN = 1
local sumHP = 0
local sumATK = 0
local sumDEF = 0
local textHP
local countCombo = 0
local E = nil

local battle = 1
local mission = nil

local checkOption = 1

----------------------------------------

local colercharacter
local maxIcon = 5
local myAnimation
local BGsprite
local image_sheet
local BGAnimation
local Warning
local datacharcter = {}
local rowCharac = 0
local myAnimationSheet
local timerIMG

------TEXT title

local textFlagImg
local textCoinImg

local NumExp = 0
local NumCoin = 0
local NumDiamond = 0
local NumFlag = 0
local flagimg

local myNumber = {}
local myCount = {0,0,0,0,0,0}
local myPink = {}

--Enemy
local hold_atk
local cd = {0,1}
----------------
--BG
local BGdropPuzzle


local friend = 0
local map_id = nil
local chapter_id = nil
local chapter_name = nil
local mission_id = nil
local mission_name = nil
local mission_exp = nil
local Olddiamond = nil
local mission_coin = nil
local RandomDrop = {}
-----------------
local Gdisplay = display.newGroup()
--  tada1179.w@gmail.com ---------------------------------------------------
local   picture = {"img/element/red.png","img/element/green.png","img/element/blue.png","img/element/purple.png","img/element/pink.png","img/element/yellow.png"}

---------------------------------------------------------------------------------------------------
-----***** MENU ITEM & Setting *****------
--  tada1179.w@gmail.com -------------------------------
local myItem = {}
local rowItem
local img_blockPUZ
local TouchCount = 0
local getCharac_id = {}
----------------------------------------//
local function SaveMissionClear()
    cancelAllTimers()
    cancelAllTransitions()
    display.remove(groupGem)
    groupGem = nil
    display.remove(groupGemChk)
    groupGemChk = nil
    display.remove(Gdisplay)
    Gdisplay = nil
    display.remove(groupGameLayer)
    groupGameLayer = nil

    local LinkOneCharac = "http://localhost/DYM/missionClear.php"
    local characterID =  LinkOneCharac.."?user_id="..user_id.."&mission_exp="..mission_exp.."&chapter_id="..chapter_id.."&mission_id="..mission_id
    characterID = characterID.."&friend="..friend.."&NumCoin="..NumCoin.."&NumFlag="..NumFlag.."&diamond="..Olddiamond
    for i=1,NumFlag,1 do
        characterID = characterID.."&getCharac_id"..i.."="..getCharac_id[i]
    end

    local characterImg = http.request(characterID)
    local characterSelect
    local character_exp
   -- storyboard.gotoScene( "menu-scene", "fade", 400  )
    local option = {
        effect = "fade",
        time = 100,
        params = {
            user_id = user_id,
            mission_id = mission_id,
            mission_name = mission_name,
            mission_exp = mission_exp,
            chapter_name = chapter_name,
            NumCoin = NumCoin,
            NumFlag = NumFlag,
            getCharac_id = getCharac_id,
        }
    }
   storyboard.gotoScene("mission_clear",option)

end

local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "in puzzle TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
local function clearmyAnimationSheet()
    display.remove(myAnimationSheet)
    myAnimationSheet = nil
end

local function onTouchGameoverFileScreen ( self, event )

    if event.phase == "began" then


        return true
    end
end
local function gameoverFile_Cancel()
    local typeFont = native.systemFontBold
    local groupViewgameoverFile_Cancel = display.newGroup()
    local option = {
        effect = "crossFade",
        time = 100,
        params = {
            map_id = map_id ,
            user_id = user_id
        }
    }
    local function overFileCancelRelease(event)
        if event.target.id == "overFilecancel" then
            display.remove(groupViewgameoverFile_Cancel)
            groupViewgameoverFile_Cancel = nil

            gameoverFile()
        elseif event.target.id == "overFileOK" then
            storyboard.gotoScene("map_substate",option)
        end
        return true
    end
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupViewgameoverFile_Cancel:insert(myRectangle)
    groupViewgameoverFile_Cancel.touch = onTouchGameoverFileScreen
    groupViewgameoverFile_Cancel:addEventListener( "touch", groupViewgameoverFile_Cancel )

    local img_gameoverFile = "img/background/puzzle/game_over.png"
    local textimg_gameoverFile = display.newImageRect( img_gameoverFile, _W*.8,_H*.3 )
    textimg_gameoverFile:setReferencePoint( display.CenterReferencePoint )
    textimg_gameoverFile.x = _W*.5
    textimg_gameoverFile.y = _H*.2
    textimg_gameoverFile.alpha = .9
    groupViewgameoverFile_Cancel:insert(textimg_gameoverFile)

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, _W*.95,_H*.55 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = _W*.5
    bckCaution.y = _H*.6
    bckCaution.alpha = .9
    groupViewgameoverFile_Cancel:insert(bckCaution)

    if Olddiamond >0 then
        local img_OK = "img/background/button/OK_button.png"
        local btnOK = widget.newButton{
            defaultFile = img_OK,
            overFile = img_OK,
            width=_W*.3, height= _H*.07,
            onRelease = overFileCancelRelease	-- event listener function
        }
        btnOK.id = "overFileOK"
        btnOK:setReferencePoint( display.CenterReferencePoint )
        btnOK.alpha = 1
        btnOK.x = _W*.3
        btnOK.y = _H*.73
        groupViewgameoverFile_Cancel:insert(btnOK)

        local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
        local btncancel = widget.newButton{
            defaultFile = img_cancel,
            overFile = img_cancel,
            width=_W*.3, height= _H*.07,
            onRelease = overFileCancelRelease	-- event listener function
        }
        btncancel.id = "overFilecancel"
        btncancel:setReferencePoint( display.TopLeftReferencePoint )
        btncancel.alpha = 1
        btncancel.x = _W*.55
        btncancel.y = _H*.7
        groupViewgameoverFile_Cancel:insert(btncancel)
    else
        local img_OK = "img/background/button/OK_button.png"
        local btnOK = widget.newButton{
            defaultFile = img_OK,
            overFile = img_OK,
            width=_W*.3, height= _H*.07,
            onRelease = overFileCancelRelease	-- event listener function
        }
        btnOK.id = "overFileOK"
        btnOK:setReferencePoint( display.CenterReferencePoint )
        btnOK.alpha = 1
        btnOK.x = _W*.5
        btnOK.y = _H*.73
        groupViewgameoverFile_Cancel:insert(btnOK)
    end



    local SmachText_s = util.wrappedText("All prizes will be lost \nif you leave stamina used \nwill not be restored.", _W*.3, 30,typeFont, {255, 255, 255})
    SmachText_s.x = _W*.17
    SmachText_s.y = _H*.45
    groupViewgameoverFile_Cancel:insert(SmachText_s)


    groupGameTop:insert(groupViewgameoverFile_Cancel)

    checkMemory()

end
function gameoverFile()
 if Olddiamond > 0 then
    local groupViewgameoverFile = display.newGroup()
    local option = {
        effect = "crossFade",
        time = 100,
        params = {
            map_id = map_id,
            mission_id = mission_id,
            user_id = user_id  ,
            Olddiamond =Olddiamond
        }
    }
    local function overFileRelease(event)
         if event.target.id == "overFilecancel" then
             gameoverFile_Cancel()

             display.remove(groupViewgameoverFile)
             groupViewgameoverFile = nil

         elseif event.target.id == "overFileOK" then
             Olddiamond = Olddiamond - 1
             display.remove(groupViewgameoverFile)
             groupViewgameoverFile = nil

             hpPlayer = sumHP
             lifeline_sh.width =  fullLineHP
             lifeline_sh:setReferencePoint( display.TopLeftReferencePoint )
             lifeline_sh.x = pointStart

             textHP.text = string.format(hpPlayer.."/"..hpFull )
             textHP:setReferencePoint( display.TopRightReferencePoint )
             textHP.x = _W*.95
             isGemTouchEnabled = true

             scene:addEventListener( "createScene", scene )
         end
        return true
    end

    local typeFont = native.systemFontBold


    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupViewgameoverFile:insert(myRectangle)
    groupViewgameoverFile.touch = onTouchGameoverFileScreen
    groupViewgameoverFile:addEventListener( "touch", groupViewgameoverFile )

    local img_gameoverFile = "img/background/puzzle/game_over.png"
    local textimg_gameoverFile = display.newImageRect( img_gameoverFile, _W*.8,_H*.3 )
    textimg_gameoverFile:setReferencePoint( display.CenterReferencePoint )
    textimg_gameoverFile.x = _W*.5
    textimg_gameoverFile.y = _H*.2
    textimg_gameoverFile.alpha = .9
    groupViewgameoverFile:insert(textimg_gameoverFile)

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, _W*.95,_H*.55 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = _W*.5
    bckCaution.y = _H*.6
    bckCaution.alpha = .9
    groupViewgameoverFile:insert(bckCaution)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        defaultFile = img_OK,
        overFile = img_OK,
        width=_W*.3, height= _H*.07,
        onRelease = overFileRelease	-- event listener function
    }
    btnOK.id = "overFileOK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = _W*.3
    btnOK.y = _H*.73
    groupViewgameoverFile:insert(btnOK)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btncancel = widget.newButton{
        defaultFile = img_cancel,
        overFile = img_cancel,
        width=_W*.3, height= _H*.07,
        onRelease = overFileRelease	-- event listener function
    }
    btncancel.id = "overFilecancel"
    btncancel:setReferencePoint( display.TopLeftReferencePoint )
    btncancel.alpha = 1
    btncancel.x = _W*.55
    btncancel.y = _H*.7
    groupViewgameoverFile:insert(btncancel)

    local SmachText_s = util.wrappedText("   Game overFile\nDo you want to retry \nwith 1 diamond?\nYou have "..Olddiamond .." diamonds now.", _W*.3, 30,typeFont, {255, 255, 255})
    SmachText_s.x = _W*.17
    SmachText_s.y = _H*.45
    groupViewgameoverFile:insert(SmachText_s)


    groupGameTop:insert(groupViewgameoverFile)

    display.remove(BGdropPuzzle)
    BGdropPuzzle = nil

    cancelAllTimers()
    cancelAllTransitions()
    clearmyAnimationSheet()
    checkMemory()
 else
     gameoverFile_Cancel()
 end


end
local function enableGemTouch()
    isGemTouchEnabled = true

end
local function enablePuzzleTouch(obj)
    local groupView = display.newGroup()
    if obj == 1 then
        BGdropPuzzle = display.newRoundedRect(0, _H*.45, _W, _H*.55,0)
        BGdropPuzzle.strokeWidth = 0
        BGdropPuzzle.alpha = .8
        BGdropPuzzle:setFillColor(156 ,156 ,156)
        groupView:insert(BGdropPuzzle)
        groupView.touch = onTouchGameoverFileScreen
        groupView:addEventListener( "touch", groupView )
    else
        display.remove(BGdropPuzzle)
        BGdropPuzzle = nil
    end



end
local function damageAttackEnemy()
    enablePuzzleTouch(2)--clear battle befor
    local  battleIconcolor
    local clearbattleIconcolor = function (obj)
         transition.cancel( transitionStash.newTransition )
         transitionStash.newTransition = nil

         display.remove(obj)
         obj = nil

         transitionStash.newTransition = transition.to( lifeline, { time=100, xScale=2, yScale=2,x= lifeline.x+10,y=lifeline.y-10, alpha=1})
         transitionStash.newTransition = transition.to( lifeline, { time=150,delay=50, xScale=1,x= lifeline.x,y=lifeline.y, yScale=1, alpha=1})

         if BGdropPuzzle ~= nil then
             transitionStash.newTransition = transition.to( BGdropPuzzle, { time=500,x= BGdropPuzzle.x+10,y=BGdropPuzzle.y-10, alpha=0.8})
             transitionStash.newTransition = transition.to( BGdropPuzzle, { time=550,delay=50, xScale=1,x= BGdropPuzzle.x,y=BGdropPuzzle.y, yScale=1, alpha=0.8})

         end
         if hpPlayer <= 0 then
             TimersST.myTimer = timer.performWithDelay(300,gameoverFile )
             return true
         end

     end
    local n = 1
     for i=1,CountCharacterInBattle,1 do

         getCharacterCoin(i)

         if characImage[i].hold_countD <= 0 and characImage[i].hold_atk > 0 then
             if n == 1 then
                 enablePuzzleTouch(n) --set block puzzle
             end
             n = n + 1

             local C = 50
             local E = 1
             local R = 0
             local r = 0
             local defense = math.ceil(characImage[i].atk + (characImage[i].atk *(C/200))) /(E+R+r)

             hpPlayer = hpPlayer - defense
             local x = math.ceil((fullLineHP *hpPlayer)/hpFull )

             if hpPlayer <= 0 then
                 --gameoverFile()

                 lifeline_sh.width =  1
                 hpPlayer = 0
             else
                 lifeline_sh.width =  x

             end
             characImage[i].hold_countD = characImage[i].countD
             TextCD[i].text = string.format("CD:"..characImage[i].hold_countD)

             lifeline_sh:setReferencePoint( display.TopLeftReferencePoint )
             lifeline_sh.x = pointStart

             textHP.text = string.format(hpPlayer.."/"..hpFull )
             textHP:setReferencePoint( display.TopRightReferencePoint )
             textHP.x = _W*.95

             local img =  "img/element/object.png"
             battleIconcolor = display.newImageRect( img, 64, 64 )
             battleIconcolor.x, battleIconcolor.y = characImage[i].x, _H*.2
             physics.addBody( battleIconcolor, { bounce=0.5, density=1.0 ,friction = 0, radius=10 } )
            local vx, vy = -20, 100
            --all icon element in puzzle   vy = -400,transition.to (time = 300)
            battleIconcolor.isBullet = true
            battleIconcolor.isSleepingAllowed = true
            battleIconcolor:setLinearVelocity( vx*500,vy*500 )
            groupGameTop:insert(battleIconcolor)
            transitionStash.newTransition = transition.to( battleIconcolor, { time=200, xScale=2, yScale=2, alpha=0,onComplete =clearbattleIconcolor  })

           end
     end


     local wait = function()
         enablePuzzleTouch(2)  --clear battle befor
     end

    TimersST.myTimer = timer.performWithDelay(1000,wait )

    checkMemory()
end
---clear object-------------------------------------//

local function cleanDisplay(object)

    if object ~= nil then
        display.remove( object )
        object = nil
    end

end

local function cleanListeners(object)

    if object._functionListeners ~= nil then
        object._functionListeners = nil
    end
    if object._tableListeners ~= nil then
        object._tableListeners = nil
    end

end

function cleanTimers(timerStash)
    if timerStash.myTimer ~= nil then
        timer.cancel( timerStash.myTimer )
    end

end

local function cleanTransitions(timerStash)
    if timerStash.newTransition ~= nil then
        transition.cancel( timerStash.newTransition )
    end

end
--------------------------------------------------------
local function battle_Animation(timebattle,all,battleimg)
    enablePuzzleTouch(0)--clear battle befor

    if img_blockPUZ~= nil then
        display.remove(img_blockPUZ)
        img_blockPUZ = nil
    end

    local start = function()
        local groupView = display.newGroup()
        local myRectangle = display.newRoundedRect(0, _H*.45, _W, _H*.55,0)
        myRectangle.strokeWidth = 2
        myRectangle.alpha = .8
        myRectangle:setFillColor(0, 0, 0)
        groupView:insert(myRectangle)
        groupView.touch = onTouchGameoverFileScreen
        groupView:addEventListener( "touch", groupView )

        local square =  display.newImage( "img/Battle_Animation/background.png")
        square:setReferencePoint( display.LeftReferencePoint )
        square.x, square.y = 0, _H*.2
        local w,h = _W, _H

        local picBattle = "img/Battle_Animation/"..all.."/"..battleimg..".png"
        local NumberBattle =  display.newImage( picBattle)
        NumberBattle:setReferencePoint( display.RightReferencePoint )
        NumberBattle.x, NumberBattle.y = _W, _H*.2

        local A,B  = 0, 0


        local listener1 = function( obj )

        end

        local listener2 = function( obj )

        end
        local listener3 = function( obj )
            display.remove(obj)
            obj = nil
            isGemTouchEnabled = true
            display.remove(myRectangle)
            myRectangle = nil
        end

        -- (1) move square to bottom right corner; subtract half side-length
        --     b/c the local origin is at the square's center; fade out square
        transitionStash.newTransition = transition.to( square, { time=500, delay=500 ,alpha=1, x=(w-300), onComplete=listener1 } )
        transitionStash.newTransition = transition.to( NumberBattle, { time=500 , delay=500, alpha=1, x=(A+300), onComplete=listener1 } )

        -- (2) fade square back in after 2.5 seconds
        transitionStash.newTransition = transition.to( square, { time=500, delay=2500, alpha=1.0, onComplete=listener2 } )
        transitionStash.newTransition = transition.to( NumberBattle, { time=500, delay=2500, alpha=1.0, onComplete=listener2 } )

        transitionStash.newTransition = transition.to( square, { time=500, delay=2500,alpha=0, onComplete=listener3 } )
        transitionStash.newTransition = transition.to( NumberBattle, { time=500, delay=2500,alpha=0, onComplete=listener3 } )


    end
    TimersST.myTimer = timer.performWithDelay( timebattle, start )

end
local function characterBattle()
    local i = battle
    while i <= battle do
        CountCharacterInBattle = tonumber(image_char[i].characAll)

        for k=1,image_char[i].characAll,1  do
            print("------- img error = ", image_char[i][k].charac_img)
            local imgCharacter = image_char[i][k].charac_img
            characImage[k] = display.newImage(imgCharacter,true)


            if characImage[k].width ~= 1024 or characImage[k].height ~= 1024 then
                if characImage[k].width > characImage[k].height then
                    characImage[k].height = math.floor(characImage[k].height / (characImage[k].width/1024))
                    characImage[k].width = 1024
                else
                    characImage[k].width = math.floor(characImage[k].width / (characImage[k].height/1024))
                    characImage[k].height = 1024
                end
            end
            characImage[k].width = math.floor(characImage[k].width/image_char[i][k].charac_sph)
            characImage[k].height =  math.floor(characImage[k].height/image_char[i][k].charac_sph)

            characImage[k]:setReferencePoint( display.BottomCenterReferencePoint)
            characImage[k].x = (_W/(image_char[i].characAll+1))*k
            characImage[k].y = _H*.27
            characImage[k].id =k
            characImage[k].charac_id = image_char[i][k].charac_id
            characImage[k].hold_atk = tonumber(image_char[i][k].charac_atk)
            characImage[k].atk = tonumber(image_char[i][k].charac_atk)
            characImage[k].color = tonumber(image_char[i][k].charac_element)
            characImage[k].countD = tonumber(image_char[i][k].charac_countD)
            characImage[k].hold_countD = tonumber(image_char[i][k].charac_countD)
            characImage[k].coin = tonumber(image_char[i][k].charac_coin)
            groupGameTop:insert(characImage[k])
            physics.addBody( characImage[k],"static", { density = 1.0, friction = 0, bounce = 0.2, radius = 20 } )

            local hpLine = (lineFULLHP*characImage[k].hold_atk)/characImage[k].atk

            Enemy_HP[k] = display.newImageRect( "img/background/frame/as_enemy_hp.png", 0, 15 )
            Enemy_HP[k].width =  hpLine
            Enemy_HP[k]:setReferencePoint( display.TopLeftReferencePoint)

            pointStartEnemy_HP[k]= math.ceil(_W/(image_char[i].characAll+1))*k -50
            Enemy_HP[k].x, Enemy_HP[k].y = pointStartEnemy_HP[k],_H*.27

            if image_char[i][k].charac_element == 1 then --red
                Enemy_HP[k]:setFillColor(255, 0 ,0)
            elseif image_char[i][k].charac_element == 2 then   --green
                Enemy_HP[k]:setFillColor(0 ,139, 0)
            elseif image_char[i][k].charac_element == 3 then   --blue
                Enemy_HP[k]:setFillColor( 	 0, 191, 255)
            elseif image_char[i][k].charac_element == 4 then   --purple
                Enemy_HP[k]:setFillColor(139, 71 ,137)
            elseif image_char[i][k].charac_element == 5 then  --yellow
                Enemy_HP[k]:setFillColor( 255 ,215, 0)
            end
            local imgbar =  "img/background/frame/as_enemy_bar.png"
            Enemy_bar[k] = display.newImageRect(imgbar, 120, 16 )
            Enemy_bar[k]:setReferencePoint( display.TopCenterReferencePoint)
            Enemy_bar[k].x, Enemy_bar[k].y = (_W/(image_char[i].characAll+1))*k,_H*.27
            groupGameTop:insert(Enemy_HP[k])
            groupGameTop:insert(Enemy_bar[k])


            TextCD[k] = display.newText("CD:"..characImage[k].countD,0 , 0,native.systemFontBold,25)
            TextCD[k]:setReferencePoint( display.CenterReferencePoint )
            TextCD[k].x = (_W/(image_char[i].characAll+1))*k,_H*.27
            TextCD[k].y = _H*.05
            TextCD[k]:setTextColor(47 ,79 ,79)
            groupGameTop:insert(TextCD[k])



        end
        i = i+1

    end



end
local function createItem()

    local Linkmission = "http://localhost/dym/item.php"
    local numberHold_character =  Linkmission.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)


    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        rowItem = allRow.All

        local k = 1
        while(k <= rowItem) do
            myItem[k] = {}
            myItem[k].item_id = allRow.chracter[k].item_id
            myItem[k].element = tonumber(allRow.chracter[k].element)
            myItem[k].img = allRow.chracter[k].img
            myItem[k].holditem_id = allRow.chracter[k].holditem_id
            myItem[k].status = 1
            k = k +1
        end
    end
end
local function Victory_Animation_aura()

    BGdropPuzzle = display.newRoundedRect(0, 0, _W, _H,0)
    BGdropPuzzle.strokeWidth = 0
    BGdropPuzzle.alpha = .8
    BGdropPuzzle:setFillColor(0 ,0 ,0)
    groupGameLayer:insert(BGdropPuzzle)
    groupGameLayer.touch = onTouchGameoverFileScreen
    groupGameLayer:addEventListener( "touch", groupGameLayer )

    local sheetdata_light = {width = _W, height = 425,numFrames = 75, sheetContentWidth = 3200 ,sheetContentHeight = 6375 }
    local image_sheet = {
        "img/sprite/Victory_Animation/aura.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=5500, loopCount=1 }

    local Victory_aura = display.newSprite( sheet_light, sequenceData )
    Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura.x = 0
    Victory_aura.y = 0
    local function FNVictory_aura()
        Victory_aura:setSequence( "lightaura" )
        Victory_aura:play()
    end
    groupGameLayer:insert(Victory_aura)
    TimersST.myTimer = timer.performWithDelay(0,FNVictory_aura )

    return true

end
local function Victory_Animation_font()
    local sheetdata_light = {width = _W, height = 425,numFrames = 75, sheetContentWidth = 3200 ,sheetContentHeight = 6375 }
    local image_sheet = {
        "img/sprite/Victory_Animation/font.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=5000, loopCount=1 }

    local Victory_aura = display.newSprite( sheet_light, sequenceData )
    Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura.x = 0
    Victory_aura.y = 0
    local function FNVictory_font()
        Victory_aura:setSequence( "lightaura" )
        Victory_aura:play()
    end
    groupGameLayer:insert(Victory_aura)
    TimersST.myTimer = timer.performWithDelay(100,FNVictory_font )
    TimersST.myTimer = timer.performWithDelay(5000,SaveMissionClear )

   -------save mission clear -------
end
local function swapSheetBackground()
    local IMGtimer
    --    local myAnimation = display.newImageRect( image_sheet[BGsprite] , display.contentWidth, 425 )
    local myAnimation = display.newImageRect( image_sheet , display.contentWidth, 425 )
    myAnimation:setReferencePoint( display.CenterReferencePoint )
    myAnimation.x, myAnimation.y = _W*.5, _H*.2
    groupGameTop1:insert(myAnimation)
    local k = 1
    local i = 0
    local j = 0
    local function finish()
        display.remove(myAnimation)
        myAnimation = nil

        IMGtimer = nil
    end
    local function scalTran4()
        k = k - 0.05
        j = j + 0.05
        if k < 0.05 then
            k = 0
            j = 1
        end
        myAnimation.y = myAnimation.y - math.random(1,3)
        myAnimation.x = myAnimation.x - math.random(1,3)
        transitionStash.newTransition = transition.to( myAnimation, { time=200, xScale=1.1+i, yScale=1.1+i, alpha=k,y = myAnimation.y ,x = myAnimation.x} )
        if k == 0 then
            finish()
        end
        BGAnimation.alpha = j
        i = i +0.01

    end
    local function scalTran3()
        k = k - 0.05
        j = j + 0.05
        myAnimation.y = myAnimation.y + math.random(1,2)
        myAnimation.x = myAnimation.x + math.random(1,2)
        transitionStash.newTransition = transition.to( myAnimation, { time=200, xScale=1.1+i, yScale=1.1+i, alpha=k,y = myAnimation.y ,x = myAnimation.x} )
        TimersST.myTimer =  timer.performWithDelay(200, scalTran4)
        i = i +0.01
        BGAnimation.alpha = j
    end
    local function scalTran2()
        k = k - 0.05
        j = j + 0.05
        myAnimation.y = myAnimation.y - math.random(1,4)
        myAnimation.x = myAnimation.x - math.random(1,4)
        transitionStash.newTransition = transition.to( myAnimation, { time=200, xScale=1.1+i, yScale=1.1+i, alpha=k,y = myAnimation.y ,x = myAnimation.x} )
        TimersST.myTimer   = timer.performWithDelay(200, scalTran3)
        i = i +0.01
        BGAnimation.alpha = j
    end
    local function scalTran()
        k = k - 0.05
        j = j + 0.05
        myAnimation.y = myAnimation.y + math.random(1,2)
        myAnimation.x = myAnimation.x + math.random(1,2)
        transitionStash.newTransition = transition.to( myAnimation, { time=200, xScale=1.1+i, yScale=1.1+i, alpha=k,y = myAnimation.y ,x = myAnimation.x} )
        TimersST.myTimer = timer.performWithDelay( 200, scalTran2 )
        i = i +0.01
        BGAnimation.alpha = j
    end

    TimersST.myTimer =  timer.performWithDelay( 0, scalTran )
    TimersST.myTimer =  timer.performWithDelay( 1000, scalTran )
    TimersST.myTimer =  timer.performWithDelay( 2000, scalTran )
    TimersST.myTimer =  timer.performWithDelay( 3000, scalTran )
    TimersST.myTimer =  timer.performWithDelay( 4000, scalTran )
   checkMemory()

end

local function BossSprite()
--    print("BOSS BOSS")
    local function flash()
        local sheetdata_light = {width = 640, height = 425,numFrames = 40, sheetContentWidth = 3200 ,sheetContentHeight = 3400 }
        local image_sheet = {
            "img/sprite/Boss_Effect/1flash.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2500, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = _W*.5
        CoinSheet.y = _H*.35

        local function clearSheet()
            isGemTouchEnabled = true
            display.remove(CoinSheet)
            CoinSheet = nil
         end
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
            timerIMG = nil

        end
        TimersST.myTimer =  timer.performWithDelay( 1000, swapSheet )
        transitionStash.newTransition = transition.to( CoinSheet, { time=3500,  alpha=1,onComplete = clearSheet} )

    end
    local function thunder()
        local sheetdata_light = {width = 640, height = 425,numFrames = 30, sheetContentWidth = 3200 ,sheetContentHeight = 2550 }
        local image_sheet = {
            "img/sprite/Boss_Effect/2thunder.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = _W*.5
        CoinSheet.y = _H*.35

        local function clearSheet()
            display.remove(CoinSheet)
            CoinSheet = nil
            IMGtransition = nil
        end
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
            timerIMG = nil

        end
        TimersST.myTimer =  timer.performWithDelay( 1000, swapSheet )
        transitionStash.newTransition = transition.to( CoinSheet, { time=3000,  alpha=1,onComplete = clearSheet} )

    end
    local function groundcrack()
        local sheetdata_light = {width = 640, height = 425,numFrames = 40, sheetContentWidth = 3200 ,sheetContentHeight = 3400 }
        local image_sheet = {
            "img/sprite/Boss_Effect/3groundcrack.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = _W*.5
        CoinSheet.y = _H*.35

        local function clearSheet()
            display.remove(CoinSheet)
            CoinSheet = nil

        end
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
            timerIMG = nil

        end
        TimersST.myTimer = timer.performWithDelay( 1000, swapSheet )
        transitionStash.newTransition = transition.to( CoinSheet, { time=3000,  alpha=1,onComplete = clearSheet} )

    end

    TimersST.myTimer = timer.performWithDelay( 0, flash )
    TimersST.myTimer.myTimer = timer.performWithDelay( 500, thunder )
    TimersST.myTimer = timer.performWithDelay( 500, groundcrack )
    TimersST.myTimer = timer.performWithDelay( 3000, characterBattle )
   checkMemory()
end
local function Warning_Animation()

    local groupView = display.newGroup()
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)
    groupView.touch = onTouchGameoverFileScreen
    groupView:addEventListener( "touch", groupView )

    local sheetdata_light = {width = _W, height = 225,numFrames = 40, sheetContentWidth = 3200 ,sheetContentHeight = 1800 }
    local image_sheet = {
        "img/sprite/Warning_Animation/spritesheet.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=5400, loopCount=1 }

    Warning = display.newSprite( sheet_light, sequenceData )
    Warning:setReferencePoint( display.TopLeftReferencePoint)
    Warning.x = 0
    Warning.y = 0
    local function FNWarning_Animation()
        Warning:setSequence( "lightaura" )
        Warning:play()
    end

    local function callBoss()
        display.remove(Warning)
        Warning = nil

        display.remove(myRectangle)
        myRectangle = nil

        display.remove(groupView)
        groupView = nil


        BossSprite()
    end
--    groupGameLayer:insert(Warning)
    groupView:insert(Warning)
    TimersST.myTimer = timer.performWithDelay(0,FNWarning_Animation )
    transitionStash.newTransition = transition.to( Warning, { time=4000 , alpha=0,  onComplete=callBoss } )


    return true

end
---- button setting -------------
local function LeaveOption(event)
    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25


    local function ButtouRelease(event)
        display.remove(groupView)
        groupView = nil
        local alertMSN =  require( "alertMassage" )
        if event.target.id == "OK" then
            display.remove(groupView)
            groupView = nil

            local useTicket = 0 --0:No use ticket
            local optionBonus = {
                params = {
                    useTicket = useTicket,
                    NumDiamond = 0 ,
                    NumCoin = NumCoin ,
                    NumEXP = mission_exp,
                    NumFlag = NumFlag,
                    user_id = user_id
                }
            }
            alertMSN.confrimLeaveTicket(optionBonus)

        elseif event.target.id =="cancel"  then
            MenuInPuzzle()
        elseif event.target.id =="useticket"  then
            local useTicket = 1 --1:Yes use ticket
            local optionBonus = {
                params = {
                    useTicket = useTicket,
                    NumDiamond = NumDiamond ,
                    NumCoin = NumCoin ,
                    NumEXP = mission_exp,
                    NumFlag = NumFlag,
                    user_id = user_id
                }
            }
            alertMSN.confrimLeaveTicket(optionBonus)

        end

        return true
    end
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local pointimg = _W*.25
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, _W*.95,_H*.8 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = _W*.5
    bckCaution.y = _H*.5
    bckCaution.alpha = .8
    groupView:insert(bckCaution)
    if Olddiamond > 0 then

        local image_GAME_OPTION = "img/background/button/RETREAT.png"
        local btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
        btnGameop:setReferencePoint( display.CenterReferencePoint )
        btnGameop.x = _W *.5
        btnGameop.y = _H*.28
        btnGameop.alpha = 1
        groupView:insert(btnGameop)

        local util = require("util")
        local txtMSN = "USE 1 TICKET\n RETREAT FROM BATTLE BUT\n RECIEVE ALL BONUS WHICH\n GOT FROM THE BATTLE\n\n\n\nRETREAT\n RETREAT FROM THE BATTLE\n WITH NO BOUNS WHICH\n GOT FROM THE BATTLE"
        local lotsOfTextObject = util.wrappedText( txtMSN, 30, sizetext, native.systemFont, {0,200,0} )
        lotsOfTextObject.x = _W*.15
        lotsOfTextObject.y = _H*.31
        groupView:insert(lotsOfTextObject)

        local img_useticket = "img/background/button/OK_button.png"
        local btnuseticket = widget.newButton{
            defaultFile = img_useticket,
            overFile = img_useticket,
            width=_W*.3, height= _H*.07,
            onRelease = ButtouRelease	-- event listener function
        }
        btnuseticket.id = "useticket"
        btnuseticket:setReferencePoint( display.CenterReferencePoint )
        btnuseticket.alpha = 1
        btnuseticket.x = _W*.5
        btnuseticket.y = _H*.52
        groupView:insert(btnuseticket)

        local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
        local btnucancel = widget.newButton{
            defaultFile = img_cancel,
            overFile = img_cancel,
            width=_W*.3, height= _H*.07,
            onRelease = ButtouRelease	-- event listener function
        }
        btnucancel.id = "cancel"
        btnucancel:setReferencePoint( display.CenterReferencePoint )
        btnucancel.alpha = 1
        btnucancel.x = _W*.68
        btnucancel.y = _H*.77
        groupView:insert(btnucancel)

        local img_OK = "img/background/button/OK_button.png"
        local btnOK = widget.newButton{
            defaultFile = img_OK,
            overFile = img_OK,
            width=_W*.3, height= _H*.07,
            onRelease = ButtouRelease	-- event listener function
        }
        btnOK.id = "OK"
        btnOK:setReferencePoint( display.CenterReferencePoint )
        btnOK.alpha = 1
        btnOK.x = _W*.3
        btnOK.y = _H*.77
        groupView:insert(btnOK)
    else
        local image_GAME_OPTION = "img/background/button/RETREAT.png"
        local btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
        btnGameop:setReferencePoint( display.CenterReferencePoint )
        btnGameop.x = _W *.5
        btnGameop.y = _H*.28
        btnGameop.alpha = 1
        groupView:insert(btnGameop)

        local util = require("util")
        local txtMSN = " RETREAT FROM THE BATTLE\n WITH NO BOUNS WHICH\n GOT FROM THE BATTLE"
        local lotsOfTextObject = util.wrappedText( txtMSN, 30, sizetext, native.systemFont, {0,200,0} )
        lotsOfTextObject.x = _W*.15
        lotsOfTextObject.y = _H*.35
        groupView:insert(lotsOfTextObject)

        local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
        local btnucancel = widget.newButton{
            defaultFile = img_cancel,
            overFile = img_cancel,
            width=_W*.3, height= _H*.07,
            onRelease = ButtouRelease	-- event listener function
        }
        btnucancel.id = "cancel"
        btnucancel:setReferencePoint( display.CenterReferencePoint )
        btnucancel.alpha = 1
        btnucancel.x = _W*.68
        btnucancel.y = _H*.77
        groupView:insert(btnucancel)

        local img_OK = "img/background/button/OK_button.png"
        local btnOK = widget.newButton{
            defaultFile = img_OK,
            overFile = img_OK,
            width=_W*.3, height= _H*.07,
            onRelease = ButtouRelease	-- event listener function
        }
        btnOK.id = "OK"
        btnOK:setReferencePoint( display.CenterReferencePoint )
        btnOK.alpha = 1
        btnOK.x = _W*.3
        btnOK.y = _H*.77
        groupView:insert(btnOK)
    end



end
local function BonusOption(event)
    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25
    local image_itemBouns = {
        "img/background/misstion/COIN.png", --coin img
        "img/background/misstion/DIAMOND.png",
        "img/background/misstion/FLAG.png",

    }
    local function ButtouRelease(event)
        if event.target.id == "OK" then
            display.remove(groupView)
            groupView = nil

            MenuInPuzzle()
        end

    end

    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local pointimg = _W*.25
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, _W*.95,_H*.8 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = _W*.5
    bckCaution.y = _H*.5
    bckCaution.alpha = .8
    groupView:insert(bckCaution)

    local image_GAME_OPTION = "img/background/button/BONUS_BUTTON.png"
    local btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
    btnGameop:setReferencePoint( display.CenterReferencePoint )
    btnGameop.x = _W *.5
    btnGameop.y = _H*.3
    btnGameop.alpha = 1
    groupView:insert(btnGameop)

    local img_coin = display.newImageRect( image_itemBouns[1], _W*.12,_H*.08 )
    img_coin:setReferencePoint( display.CenterReferencePoint )
    img_coin.x = pointimg
    img_coin.y = _H*.40
    img_coin.alpha = .8
    groupView:insert(img_coin)


    local img_flag = display.newImageRect( image_itemBouns[3],  _W*.12,_H*.08 )
    img_flag:setReferencePoint( display.CenterReferencePoint )
    img_flag.x = pointimg
    img_flag.y = _H*.5
    img_flag.alpha = .8
    groupView:insert(img_flag)

    local txtTest = "200"
    local pointtxt = _W*.35
    local pointnum = _W*.65

    local txtcoin = display.newText("Coin", pointtxt, _H*.40, typeFont, sizetext)
    txtcoin:setTextColor(0, 200, 0)
    txtcoin.text =  string.format("Coin")
    txtcoin.alpha = 1
    groupView:insert(txtcoin)
    local numCoin = display.newText(NumCoin, pointnum, _H*.40, typeFont, sizetext)
    numCoin:setTextColor(0, 200, 0)
    numCoin.text =  string.format(NumCoin)
    numCoin.alpha = 1
    groupView:insert(numCoin)

    local txtflag = display.newText("FLAG", pointtxt, _H*.5, typeFont, sizetext)
    txtflag:setTextColor(0, 200, 0)
    txtflag.text =  string.format("FLAG")
    txtflag.alpha = 1
    groupView:insert(txtflag)
    local numFlag = display.newText(NumFlag, pointnum, _H*.5, typeFont, sizetext)
    numFlag:setTextColor(0, 200, 0)
    numFlag.text =  string.format(NumFlag)
    numFlag.alpha = 1
    groupView:insert(numFlag)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        defaultFile = img_OK,
        overFile = img_OK,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = _W*.5
    btnOK.y = _H*.77
    groupView:insert(btnOK)

end
local function GameOption(option)
    checkOption =  2

    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25

    local backgroundCaution
    local btnGameop
    local btnBGM_ON
    local btnSFX_ON
    local btnSKL_ON
    local btnBTN_ON

    -- 1: on
    -- 2: off
    local img_button = {
        "img/background/button/ON.png",
        "img/background/button/OFF.png"
    }
    local function ButtouON_Off(event)

        if event.target.id == "BGM1" then
            BGM = 2
            btnBGM_ON.alpha = 0
            btnBGM_ON = widget.newButton{
                defaultFile = img_button[BGM],
                overFile = img_button[BGM],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBGM_ON.id = "BGM"..BGM
            btnBGM_ON:setReferencePoint( display.CenterReferencePoint )
            btnBGM_ON.alpha = 1
            btnBGM_ON.x = _W*.7
            btnBGM_ON.y = _H*.42
            groupView:insert(btnBGM_ON)

        elseif event.target.id == "BGM2" then
            BGM = 1
            btnBGM_ON.alpha = 0
            btnBGM_ON = widget.newButton{
                defaultFile = img_button[BGM],
                overFile = img_button[BGM],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBGM_ON.id = "BGM"..BGM
            btnBGM_ON:setReferencePoint( display.CenterReferencePoint )
            btnBGM_ON.alpha = 1
            btnBGM_ON.x = _W*.7
            btnBGM_ON.y = _H*.42
            groupView:insert(btnBGM_ON)

        elseif event.target.id == "SFX1" then
            SFX = 2
            btnSFX_ON.alpha = 0
            btnSFX_ON = widget.newButton{
                defaultFile = img_button[SFX],
                overFile = img_button[SFX],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSFX_ON.id = "SFX"..SFX
            btnSFX_ON:setReferencePoint( display.CenterReferencePoint )
            btnSFX_ON.alpha = 1
            btnSFX_ON.x = _W*.7
            btnSFX_ON.y = _H*.5
            groupView:insert(btnSFX_ON)

        elseif event.target.id == "SFX2" then
            SFX = 1
            btnSFX_ON.alpha = 0
            btnSFX_ON = widget.newButton{
                defaultFile = img_button[SFX],
                overFile = img_button[SFX],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSFX_ON.id = "SFX"..SFX
            btnSFX_ON:setReferencePoint( display.CenterReferencePoint )
            btnSFX_ON.alpha = 1
            btnSFX_ON.x = _W*.7
            btnSFX_ON.y = _H*.5
            groupView:insert(btnSFX_ON)

        elseif event.target.id == "SKL1" then
            SKL = 2
            btnSKL_ON.alpha = 0
            btnSKL_ON = widget.newButton{
                defaultFile = img_button[SKL],
                overFile = img_button[SKL],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSKL_ON.id = "SKL"..SKL
            btnSKL_ON:setReferencePoint( display.CenterReferencePoint )
            btnSKL_ON.alpha = 1
            btnSKL_ON.x = _W*.7
            btnSKL_ON.y = _H*.58
            groupView:insert(btnSKL_ON)

        elseif event.target.id == "SKL2" then
            SKL = 1
            btnSKL_ON.alpha = 0
            btnSKL_ON = widget.newButton{
                defaultFile = img_button[SKL],
                overFile = img_button[SKL],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSKL_ON.id = "SKL"..SKL
            btnSKL_ON:setReferencePoint( display.CenterReferencePoint )
            btnSKL_ON.alpha = 1
            btnSKL_ON.x = _W*.7
            btnSKL_ON.y = _H*.58
            groupView:insert(btnSKL_ON)

        elseif event.target.id == "BTN1" then
            BTN = 2
            btnBTN_ON.alpha = 0
            btnBTN_ON = widget.newButton{
                defaultFile = img_button[BTN],
                overFile = img_button[BTN],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBTN_ON.id = "BTN"..BTN
            btnBTN_ON:setReferencePoint( display.CenterReferencePoint )
            btnBTN_ON.alpha = 1
            btnBTN_ON.x = _W*.7
            btnBTN_ON.y = _H*.66
            groupView:insert(btnBTN_ON)
        elseif event.target.id == "BTN2" then
            BTN = 1
            btnBTN_ON.alpha = 0
            btnBTN_ON = widget.newButton{
                defaultFile = img_button[BTN],
                overFile = img_button[BTN],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBTN_ON.id = "BTN"..BTN
            btnBTN_ON:setReferencePoint( display.CenterReferencePoint )
            btnBTN_ON.alpha = 1
            btnBTN_ON.x = _W*.7
            btnBTN_ON.y = _H*.66
            groupView:insert(btnBTN_ON)

        end


    end
    local function ButtouRelease(event)
        local option = {
            params = {
                BGM = BGM,
                SFX = SFX,
                SKL = SKL,
                BTN = BTN,
                battle = battle,
                mission = mission,
                checkOption = checkOption

            }
        }
        groupView.alpha = 0
        MenuInPuzzle()
    end
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    backgroundCaution = display.newImageRect( image_Caution, _W*.95,_H*.8 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = _W *.5
    backgroundCaution.y = _H*.5
    backgroundCaution.alpha = .8
    groupView:insert(backgroundCaution)

    local image_GAME_OPTION = "img/background/button/GAME_OPTION.png"
    btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
    btnGameop:setReferencePoint( display.CenterReferencePoint )
    btnGameop.x = _W *.5
    btnGameop.y = _H*.31
    btnGameop.alpha = 1
    groupView:insert(btnGameop)

    local image_ON = "img/background/button/ON.png"
    btnBGM_ON = widget.newButton{
        defaultFile = img_button[BGM],
        overFile = img_button[BGM],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnBGM_ON.id = "BGM"..BGM
    btnBGM_ON:setReferencePoint( display.CenterReferencePoint )
    btnBGM_ON.alpha = 1
    btnBGM_ON.x = _W*.7
    btnBGM_ON.y = _H*.42
    groupView:insert(btnBGM_ON)

    btnSFX_ON = widget.newButton{
        defaultFile = img_button[SFX],
        overFile = img_button[SFX],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnSFX_ON.id = "SFX"..SFX
    btnSFX_ON:setReferencePoint( display.CenterReferencePoint )
    btnSFX_ON.alpha = 1
    btnSFX_ON.x = _W*.7
    btnSFX_ON.y = _H*.5
    groupView:insert(btnSFX_ON)

    btnSKL_ON = widget.newButton{
        defaultFile = img_button[SKL],
        overFile = img_button[SKL],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnSKL_ON.id = "SKL"..SKL
    btnSKL_ON:setReferencePoint( display.CenterReferencePoint )
    btnSKL_ON.alpha = 1
    btnSKL_ON.x = _W*.7
    btnSKL_ON.y = _H*.58
    groupView:insert(btnSKL_ON)

    btnBTN_ON = widget.newButton{
        defaultFile = img_button[BTN],
        overFile = img_button[BTN],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnBTN_ON.id = "BTN"..BTN
    btnBTN_ON:setReferencePoint( display.CenterReferencePoint )
    btnBTN_ON.alpha = 1
    btnBTN_ON.x = _W*.7
    btnBTN_ON.y = _H*.66
    groupView:insert(btnBTN_ON)



    local pointtxt = _H*.12
    local txtBGM = display.newText("BGM", pointtxt, _H*.4, typeFont, sizetext)
    txtBGM:setTextColor(0, 200, 0)
    txtBGM.text =  string.format("BGM")
    txtBGM.alpha = 1
    groupView:insert(txtBGM)

    local txtSFx = display.newText("SFx", pointtxt, _H*.48, typeFont, sizetext)
    txtSFx:setTextColor(0, 200, 0)
    txtSFx.text =  string.format("SFx")
    txtSFx.alpha = 1
    groupView:insert(txtSFx)

    local txtSkill = display.newText("Skill Confirmation", pointtxt, _H*.56, typeFont, sizetext)
    txtSkill:setTextColor(0, 200, 0)
    txtSkill.text =  string.format("Skill Confirmation")
    txtSkill.alpha = 1
    groupView:insert(txtSkill)

    local txtBattle = display.newText("Battle Notification", pointtxt, _H*.64, typeFont, sizetext)
    txtBattle:setTextColor(0, 200, 0)
    txtBattle.text =  string.format("Battle Notification")
    txtBattle.alpha = 1
    groupView:insert(txtBattle)


    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        defaultFile = img_OK,
        overFile = img_OK,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = _W*.5
    btnOK.y = _H*.75
    groupView:insert(btnOK)

end
function MenuInPuzzle()
    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25

    --    mission = "ABCDEFGHIJK"
    local strMission = string.len(mission_name)
    local pointMission =  (_W*.5)-(strMission/4)



    local function ButtouRelease(event)
        groupView.alpha = 0
        if event.target.id == "setting" then

            GameOption(option)

        elseif event.target.id == "BONUS" then
            BonusOption(option)

        elseif event.target.id == "LEAVE" then
            LeaveOption(event)

        elseif event.target.id == "cancel" then

        end

    end

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .9
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local backgroundCaution = display.newImageRect( image_Caution, _W*.95,_H*.18 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = _W *.5
    backgroundCaution.y = _H*.4
    backgroundCaution.alpha = 1
    groupView:insert(backgroundCaution)

    local image_power= "img/element/ELEMENTS_CIRCLE.png"
    local imgPower = display.newImageRect( image_power, _W*.5,_H*.33 )
    imgPower:setReferencePoint( display.CenterReferencePoint )
    imgPower.x = _W *.5
    imgPower.y = _H*.2
    imgPower.alpha = 1
    groupView:insert(imgPower)


    local NameMission = display.newText(battle, pointMission, _H*.35, typeFont, sizetext)
    NameMission:setTextColor(0, 200, 0)
    NameMission.text =  string.format(mission_name)
    NameMission.alpha = 1
    groupView:insert(NameMission)

    local  NameBattle = display.newText(battle, _W*.5, _H*.4, typeFont, sizetext)
    NameBattle:setTextColor(200, 200, 200)
    NameBattle.text =  string.format("BATTLE :"..battle.."/"..battleall)
    NameBattle.alpha = 1
    groupView:insert(NameBattle)

    local img_setting = "img/background/button/SETTING.png"
    local setting = widget.newButton{
        defaultFile = img_setting,
        overFile = img_setting,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    setting.id = "setting"
    setting:setReferencePoint( display.TopLeftReferencePoint )
    setting.alpha = 1
    setting.x = _W*.37
    setting.y = _H*.5
    groupView:insert(setting)

    local img_BONUS = "img/background/button/BONUS.png"
    local setBONUS = widget.newButton{
        defaultFile = img_BONUS,
        overFile = img_BONUS,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    setBONUS.id = "BONUS"
    setBONUS:setReferencePoint( display.TopLeftReferencePoint )
    setBONUS.alpha = 1
    setBONUS.x = _W*.37
    setBONUS.y = _H*.6
    groupView:insert(setBONUS)

    local img_LEAVE = "img/background/button/LEAVE.png"
    local setLEAVE = widget.newButton{
        defaultFile = img_LEAVE,
        overFile = img_LEAVE,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    setLEAVE.id = "LEAVE"
    setLEAVE:setReferencePoint( display.TopLeftReferencePoint )
    setLEAVE.alpha = 1
    setLEAVE.x = _W*.37
    setLEAVE.y = _H*.7
    groupView:insert(setLEAVE)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btncancel = widget.newButton{
        defaultFile = img_cancel,
        overFile = img_cancel,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btncancel.id = "cancel"
    btncancel:setReferencePoint( display.TopLeftReferencePoint )
    btncancel.alpha = 1
    btncancel.x = _W*.37
    btncancel.y = _H*.8
    groupView:insert(btncancel)

    groupView.touch = onTouchGameoverFileScreen
    groupView:addEventListener( "touch", groupView )

    return option

end
---------------------------------
local function createCharacter(event)
    local LinkURL = "http://localhost/DYM/character_battle_mission.php"
    local URL =  LinkURL.."?mission_id="..mission_id
    local response = http.request(URL)

    if response == nil then
        print("No Dice")

    else
        local dataTable = json.decode(response)
        character_numAll = dataTable.battleAll
        mission_coin = dataTable.missionCoin
        local m = 1
        while m <= character_numAll do

            image_char[m] = {}
            image_char[m].battle_id = dataTable.one[m].mission.battle_id
            image_char[m].battle = dataTable.one[m].mission.battle
            image_char[m].characAll = tonumber(dataTable.one[m].mission.characAll)

            local k = 1
            while k <= image_char[m].characAll do
                image_char[m][k] = {}
                image_char[m][k].charac_id = dataTable.one[m].mission.charcac[k].charac_id
                image_char[m][k].charac_name = dataTable.one[m].mission.charcac[k].charac_name
                image_char[m][k].charac_img = dataTable.one[m].mission.charcac[k].charac_img
                image_char[m][k].charac_element = tonumber(dataTable.one[m].mission.charcac[k].charac_element)
                image_char[m][k].charac_hp = tonumber(dataTable.one[m].mission.charcac[k].charac_hp)
                image_char[m][k].charac_def = tonumber(dataTable.one[m].mission.charcac[k].charac_def)
                image_char[m][k].charac_atk = tonumber(dataTable.one[m].mission.charcac[k].charac_atk )
                image_char[m][k].charac_def = tonumber(dataTable.one[m].mission.charcac[k].charac_def)
                image_char[m][k].charac_spw = tonumber(dataTable.one[m].mission.charcac[k].charac_spw)
                image_char[m][k].charac_sph = tonumber(dataTable.one[m].mission.charcac[k].charac_sph)
                image_char[m][k].charac_countD = tonumber(dataTable.one[m].mission.charcac[k].charac_countD)
                image_char[m][k].charac_coin = tonumber(dataTable.one[m].mission.charcac[k].charac_coin)
                k = k+1
            end
            m = m + 1
        end
    end

    battle = 1
    battleall = character_numAll
    characterBattle()
end
local function miniIconCharac(event)

    local teamNumber = event.params.team
    local friend_id = event.params.friend_id
--    local friend_id = 1
--    local teamNumber = 1

    local frm_frind = 1
    local img_frind = "img/characterIcon/img/TouTaku-i101.png"

    local FramElement = alertMSN.loadFramElement()
    local characIcon = {}
    local imgcharacIcon = {}
--    local datacharcter = {}
    --local rowCharac

    local LinkURL = "http://localhost/DYM/team_setting.php"
    local URL =  LinkURL.."?user_id="..user_id.."&team_no="..teamNumber
    local response = http.request(URL)
    if response == nil then
        print("No Dice")

    else
        local dataTable = json.decode(response)
        rowCharac = dataTable.chrAll

        local m = 1
        while m <= rowCharac do
            datacharcter[m] = {}
            if dataTable.chracter ~= nil then
                datacharcter[m].imagePicture= dataTable.chracter[m].imgMini
                datacharcter[m].leader_id= dataTable.chracter[m].leader_id
                datacharcter[m].skill_id= dataTable.chracter[m].skill_id
                datacharcter[m].holdcharac_id = tonumber(dataTable.chracter[m].holdcharac_id)
                datacharcter[m].element = tonumber(dataTable.chracter[m].element)
                datacharcter[m].team_no = tonumber(dataTable.chracter[m].team_no)
                datacharcter[m].def = tonumber(dataTable.chracter[m].def)
                datacharcter[m].atk = tonumber(dataTable.chracter[m].atk)
                datacharcter[m].hp = tonumber(dataTable.chracter[m].hp)
--                print("team ,hp,def,atk:",datacharcter[m].holdcharac_id,datacharcter[m].hp,datacharcter[m].def,datacharcter[m].atk)
                sumHP = sumHP + datacharcter[m].hp
                sumATK = sumATK + datacharcter[m].atk
                sumDEF = sumDEF + datacharcter[m].def
            end
            m = m+1
        end

        if m > rowCharac then
            rowCharac = rowCharac + 1
            datacharcter[m] = {}
            local url = "http://localhost/DYM/holdcharacter.php?charac_id="
            local character =   url..friend_id
            local response = http.request(character)
            local Data_character = json.decode(response)
            if Data_character then
                datacharcter[m].holdcharac_id =  Data_character[1].holdcharac_id
                datacharcter[m].leader_id =  Data_character[1].leader_id
                datacharcter[m].skill_id =  Data_character[1].skill_id
                datacharcter[m].imagePicture =  Data_character[1].charac_img_mini
                datacharcter[m].element =  tonumber(Data_character[1].charac_element)
                datacharcter[m].team_no  = 6
                datacharcter[m].def = tonumber(Data_character[1].charac_def)
                datacharcter[m].atk = tonumber(Data_character[1].charac_atk)
                datacharcter[m].hp = tonumber(Data_character[1].charac_hp)
                --print("friend ,hp,def,atk:",datacharcter[m].holdcharac_id,datacharcter[m].hp,datacharcter[m].def,datacharcter[m].atk)
                sumHP = sumHP + datacharcter[m].hp
                sumATK = sumATK + datacharcter[m].atk
                sumDEF = sumDEF + datacharcter[m].def
            end
        end
    end

    local function optionIcon(event)

        alertMSN.NoDataInList()
    end
    --    local pointIconx = -_W*.161
    local pointIconx = _W*.005
    local countChr = 1
    local sizeleaderW = _W*.16
    local sizeleaderH = _H*.106
    for i=1,rowCharac,1 do
        pointIconx = (tonumber(_W*.166)*(datacharcter[i].team_no - 1)) + _W*.005
        imgcharacIcon[i] = display.newImageRect( datacharcter[i].imagePicture , _W*.16, _H*.106 )
        imgcharacIcon[i]:setReferencePoint( display.TopLeftReferencePoint )
        imgcharacIcon[i].x,imgcharacIcon[i].y = pointIconx, _H*.31

        characIcon[i] = widget.newButton{
            defaultFile = FramElement[datacharcter[i].element] ,
            overFile =FramElement[datacharcter[i].element] ,
            width = sizeleaderW ,
            height= sizeleaderH,
            onRelease = optionIcon
        }
        characIcon[i].id= countChr
        characIcon[i]:setReferencePoint( display.TopLeftReferencePoint )
        characIcon[i].x, characIcon[i].y = pointIconx, _H*.31
        datacharcter[i].poinCenter = imgcharacIcon[i].x + (_W*.08)

        groupGameTop:insert(imgcharacIcon[i])
        groupGameTop:insert(characIcon[i])
    end

    textNumber()
end
local function miniIconCharac_frame(event)
    local teamNumber = 1

    local frm_frind = 1
    local img_frind = "img/characterIcon/img/TouTaku-i101.png"

    local FramElement = alertMSN.loadFramElement()
    local characIcon = {}
    local imgcharacIcon = {}
    --local datacharcter = {}
    local rowCharac

    local LinkURL = "http://localhost/DYM/team_setting.php"
    local URL =  LinkURL.."?user_id="..user_id.."&team_no="..teamNumber
    local response = http.request(URL)
    if response == nil then
        print("No Dice")

    else
        local dataTable = json.decode(response)
        rowCharac = dataTable.chrAll

        local m = 1
        while m <= rowCharac do
            datacharcter[m] = {}
            if dataTable.chracter ~= nil then
                datacharcter[m].imagePicture= dataTable.chracter[m].imgMini
                datacharcter[m].holdcharac_id = tonumber(dataTable.chracter[m].holdcharac_id)
                datacharcter[m].element = tonumber(dataTable.chracter[m].element)
                datacharcter[m].team_no = tonumber(dataTable.chracter[m].team_no)
            end
            m = m+1
        end
    end

    local function optionIcon(event)

        alertMSN.NoDataInList()
    end
    --    local pointIconx = -_W*.161
    local pointIconx = _W*.005
    local countChr = 1
    local sizeleaderW = _W*.16
    local sizeleaderH = _H*.106

    for i=1,rowCharac,1 do
        pointIconx = (tonumber(_W*.166)*(datacharcter[i].team_no - 1)) + _W*.005
        characIcon[i] = widget.newButton{
            defaultFile = datacharcter[i].imagePicture,
            overFile = datacharcter[i].imagePicture ,
            width = sizeleaderW ,
            height= sizeleaderH,
            onRelease = optionIcon
        }
        characIcon[i].id= countChr
        characIcon[i]:setReferencePoint( display.TopLeftReferencePoint )
        characIcon[i].x, characIcon[i].y = pointIconx, _H*.31
        groupGameTop:insert(characIcon[i])
    end
    characIcon[rowCharac+1] = widget.newButton{
        defaultFile = img_frind ,
        overFile = img_frind ,
        width = sizeleaderW ,
        height= sizeleaderH,
        onRelease = optionIcon
    }
    characIcon[rowCharac+1].id= countChr
    characIcon[rowCharac+1]:setReferencePoint( display.TopLeftReferencePoint )
    characIcon[rowCharac+1].x, characIcon[rowCharac+1].y = pointIconx, _H*.31
    characIcon[rowCharac+1].x, characIcon[rowCharac+1].y = (tonumber(_W*.166)*5)+_W*.005, _H*.31
    groupGameTop:insert(characIcon[rowCharac+1])

end

local function sprite_sheet(characterAll,num,color,pointX,pointY,numPoint)
    local showTextCoin
    local function Clearlistener()
        --        display.remove(myAnimationSheet)
        --        myAnimationSheet = nil

        display.remove(showTextCoin)
        showTextCoin = nil

        myCount[numPoint] = 0

    end

    local characterAll = characterAll+1
    local sheetdata_light = {
        {width = 512/2, height = 535/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4280/2 }  ,
        {width = 512/1.6, height = 535/1.6,numFrames = 40, sheetContentWidth =2560/1.6 ,sheetContentHeight =4280/1.6 }  ,
        {width = 512/2, height = 578/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4624/2 }  ,
        {width = 512/2, height = 504/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4032/2 }  ,
        {width = 512/2, height = 520/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4160/2 }  ,

    }
    local image_sheet = {
        "img/sprite/element/Fire.png",
        "img/sprite/element/Earth.png",
        "img/sprite/element/Water.png",
        "img/sprite/element/Dark.png",
        "img/sprite/element/Light.png",
    }
    local sheet_light = graphics.newImageSheet( image_sheet[color], sheetdata_light[color] )
    local sequenceData = {
        { name="sheet", sheet=sheet_light, start=1, count=40, time=600, loopCount=1 }
    }
    local poiny = pointY
    display.remove(myAnimationSheet)
    myAnimationSheet = nil

    myAnimationSheet = display.newSprite( sheet_light, sequenceData )
    myAnimationSheet:setReferencePoint( display.BottomCenterReferencePoint)
    myAnimationSheet.x = pointX

    if color == 1 then
        myAnimationSheet.y = poiny + display.contentHeight*.05

    elseif color == 2 then
        myAnimationSheet.y = poiny + display.contentHeight*.065

    elseif color == 3 then
        myAnimationSheet.y = poiny + display.contentHeight*.03

    elseif color == 4 then
        myAnimationSheet.y = poiny

    elseif color == 5 then
        myAnimationSheet.y = poiny+ display.contentHeight*.03
    end

    local function swapSheet()
        myAnimationSheet:setSequence( "sheet" )
        myAnimationSheet:play()
        timerIMG = nil

    end
    TimersST.myTimer = timer.performWithDelay( 50, swapSheet )

    showTextCoin = display.newText(myCount[numPoint],0 , 0,native.systemFontBold,25)
    showTextCoin:setReferencePoint( display.CenterReferencePoint )
    showTextCoin.x = pointX+_W*.05
    showTextCoin.y = display.contentHeight*.25

    if color == 1 then
        showTextCoin:setTextColor(255 ,0 ,0) --red
    elseif color == 2 then
        showTextCoin:setTextColor( 0 ,205 ,0)     --green
    elseif color == 3 then
        showTextCoin:setTextColor( 0 ,191 ,255) --blue
    elseif color == 4 then
        showTextCoin:setTextColor(131 ,111 ,255) --purple
    elseif color == 5 then
        showTextCoin:setTextColor( 255 ,255 ,0) --yellow
    end
    transitionStash.newTransition  = transition.to( showTextCoin, { time=200,delay=500, xScale=2, yScale=2, alpha=1,onComplete = Clearlistener} )

    groupGameTop:insert ( showTextCoin )
   checkMemory()
    return true
end
local function battleIcon(randI,numcharacter,colercharacter,atk,numPoint)  --ตำแหน่งที่บอลออก.-ตำแหน่งที่บอลจะไปยิง.-สี,จำนวน atk
    print("battleIcon numcharacter = ",numcharacter)
    local function  runtime_battleIcon()
    local IMGtransition
    local centerImg = (_W*.16)/2
    local img =  "img/element/object.png"
    local  battleIconcolor = display.newImageRect( img, 64, 64 )
    if colercharacter == 1 then
        battleIconcolor:setFillColor(255 ,0 ,0) --red
    elseif colercharacter == 2 then
        battleIconcolor:setFillColor( 0 ,205 ,0)     --green
    elseif colercharacter == 3 then
        battleIconcolor:setFillColor( 0 ,191 ,255) --blue
    elseif colercharacter == 4 then
        battleIconcolor:setFillColor(131 ,111 ,255) --purple
    elseif colercharacter == 5 then
        battleIconcolor:setFillColor( 255 ,255 ,0) --yellow
    end

    --battleIconcolor:setFillColor(255,0,0)
    physics.addBody( battleIconcolor, { bounce=0.5, density=1.0 ,friction = 0, radius=14 } )


    battleIconcolor.x, battleIconcolor.y = (tonumber(_W*.166)*(randI-1)) + _W*.005 + centerImg, _H*.36
    local vx, vy = characImage[numcharacter].x - battleIconcolor.x, -180
    --all icon element in puzzle   vy = -400,transition.to (time = 300)
    battleIconcolor.isBullet = true
    battleIconcolor.isSleepingAllowed = true
    battleIconcolor:setLinearVelocity( vx*5,vy*5 )
    groupGameTop:insert(battleIconcolor)

    local function listenerSprite_sheet()
        if CountCharacterInBattle >=1 then
            display.remove(battleIconcolor)
            battleIconcolor = nil
            IMGtransition = nil

            local pointX = math.ceil(characImage[numcharacter].x + image_char[battle][numcharacter].charac_spw)
            local pointY = math.ceil(characImage[numcharacter].y)
            sprite_sheet(character_numAll,numcharacter,colercharacter,pointX,pointY,numPoint)
            TimersST.myTimer = timer.performWithDelay( 50)
            if characImage[numcharacter].id == numcharacter then
                local function swapSheet()
                    characImage[numcharacter].x = characImage[numcharacter].x + 5
                end
                local function swapSheet2()
                    characImage[numcharacter].x = characImage[numcharacter].x - 10
                end
                TimersST.myTimer = timer.performWithDelay( 50, swapSheet )
                TimersST.myTimer = timer.performWithDelay( 100, swapSheet2 )
                TimersST.myTimer = timer.performWithDelay( 150, swapSheet )
            end
        end
    end
    if battleIconcolor.isSleepingAllowed == true then
        local m = 2.5
        transitionStash.newTransition = transition.to( battleIconcolor, { time=200, xScale=2, yScale=m-.5, alpha=0,onComplete = listenerSprite_sheet} )
    end
    return true
    end
    checkMemory()
    TimersST.myTimer = timer.performWithDelay( 200, runtime_battleIcon )

    --cancelAllTransitions()
end
function getCharacterCoin(numcharacter)     --ตำแหน่งที่บอลออก.ตำแหน่งที่บอลจะไปยิง.สี,จำนวน atk,ตัวที่
    --battleIcon(team_no,numcharacter,color,damage,k)  --ตำแหน่งที่บอลออก.-ตำแหน่งที่บอลจะไปยิง.-สี,จำนวน atk
    local pointX = math.ceil(characImage[numcharacter].x + image_char[battle][numcharacter].charac_spw)
    local pointY = math.ceil(characImage[numcharacter].y)
    local character_id = characImage[numcharacter].charac_id
    local DropGard
    local function FlagPNGGET()
        NumFlag = NumFlag+1
        textFlagImg.text = NumFlag
        getCharac_id[NumFlag] = character_id

        display.remove(FlagPNG[battle])
        FlagPNG[battle] = nil
    end
    local function getCoin()
        local sheetdata_light = {width = 100, height = 100,numFrames = 40, sheetContentWidth = 500 ,sheetContentHeight = 800 }
        local image_sheet = {
            "img/sprite/Item_Effect/coin.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = pointX
        CoinSheet.y = _H*.27

        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
            timerIMG = nil

        end

        local function countTime()
            if CountCharacterInBattle == 0 and battle < battleall then

                if FlagPNG[battle] then
                    local Nx = flagimg.x
                    local Ny = flagimg.y
                    transitionStash.newTransition = transition.to( FlagPNG[battle], { time=1000,delay = 200, x= Nx - FlagPNG[battle].x,y =  Ny - FlagPNG[battle].y ,alpha=0,onComplete = FlagPNGGET} )
                end

                battle = battle + 1

                TimersST.myTimer = timer.performWithDelay( 1500, swapSheetBackground )
                if battle == battleall  then
                    Warning_Animation()
                else
                local timebattle = 2000
                    battle_Animation( timebattle ,battleall,battle..battleall)
                    TimersST.myTimer = timer.performWithDelay( 4000, characterBattle )
                end

                isGemTouchEnabled = false
            elseif battle == battleall and CountCharacterInBattle == 0 then

                isGemTouchEnabled = false
                if FlagPNG[battle] then
                    local Nx = flagimg.x
                    local Ny = flagimg.y
                    --            transitionStash.newTransition = transition.to( FlagPNG, { time=500, x=Nx - 50,alpha=1,onComplete = FlagPNGGET} )
                    transitionStash.newTransition = transition.to( FlagPNG[battle], { time=1000, x= Nx - FlagPNG[battle].x,y =  Ny - FlagPNG[battle].y ,alpha=0,onComplete = FlagPNGGET} )
                end
                Victory_Animation_aura()
                TimersST.myTimer = timer.performWithDelay( 2000,Victory_Animation_font)

            end

        end
        TimersST.myTimer =  timer.performWithDelay( 100, swapSheet )
        TimersST.myTimer =  timer.performWithDelay( 1000, countTime )

    end
    local function getFlag()
        local sheetdata_light = {width = 100, height = 100,numFrames = 40, sheetContentWidth = 500 ,sheetContentHeight = 800 }
        local image_sheet = {
            "img/sprite/Item_Effect/flag.png"

        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = pointX
        CoinSheet.y = _H*.27
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
        end

        TimersST.myTimer = timer.performWithDelay( 1000, swapSheet )


    end
    local function gettreasure()
        local sheetdata_light = {width = 100, height = 100,numFrames = 40, sheetContentWidth = 500 ,sheetContentHeight = 800 }
        local image_sheet = {
            "img/sprite/Item_Effect/treasure.png"

        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = pointX
        CoinSheet.y = _H*.27
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
        end

        TimersST.myTimer = timer.performWithDelay( 1000, swapSheet )
        NumCoin = NumCoin + mission_coin
        textCoinImg.text = string.format(NumCoin)

    end
    local function clearCharacter()


        pointStartEnemy_HP[numcharacter] = nil
        characImage[numcharacter] = nil
        Enemy_bar[numcharacter] = nil
        Enemy_HP[numcharacter] = nil
        TextCD[numcharacter] = nil
        local wait ={}
        if CountCharacterInBattle>1 then
            for i = numcharacter,CountCharacterInBattle,1 do

                if i < CountCharacterInBattle then
                    wait[i] =  characImage[i+1]
                    characImage[i+1] = characImage[i]
                    characImage[i] = wait[i]

                    wait[i] =  Enemy_bar[i+1]
                    Enemy_bar[i+1] = Enemy_bar[i]
                    Enemy_bar[i] = wait[i]

                    wait[i] =  Enemy_HP[i+1]
                    Enemy_HP[i+1] = Enemy_HP[i]
                    Enemy_HP[i] = wait[i]

                    wait[i] =  pointStartEnemy_HP[i+1]
                    pointStartEnemy_HP[i+1] = pointStartEnemy_HP[i]
                    pointStartEnemy_HP[i] = wait[i]

                    wait[i] =  TextCD[i+1]
                    TextCD[i+1] = TextCD[i]
                    TextCD[i] = wait[i]

                else
                    display.remove(TextCD[CountCharacterInBattle])
                    TextCD[CountCharacterInBattle] = nil

                    display.remove(characImage[CountCharacterInBattle])
                    characImage[CountCharacterInBattle] = nil

                    display.remove(Enemy_bar[CountCharacterInBattle])
                    Enemy_bar[CountCharacterInBattle] = nil

                    display.remove(Enemy_HP[CountCharacterInBattle])
                    Enemy_HP[CountCharacterInBattle] = nil
                end
            end
        end
        --display.remove(characImage[CountCharacterInBattle])
        --display.remove(Enemy_bar[CountCharacterInBattle])
        --display.remove(Enemy_HP[CountCharacterInBattle])
        CountCharacterInBattle = CountCharacterInBattle - 1

        textCoinImg.text = string.format(NumCoin)
        if RandomDrop[battle] ~= 1 then

            DropGard = mRandom(1,3)
            --DropGard = 1
            if DropGard == 1 then
                RandomDrop[battle] = 1
                getFlag ()
                FlagPNG[battle] = display.newImageRect( "img/sprite/Item_Effect/flagtest.png", _W*.15, _H*.1 )
                FlagPNG[battle]:setReferencePoint( display.BottomCenterReferencePoint )
                FlagPNG[battle].x, FlagPNG[battle].y = pointX, _H*.27


            elseif DropGard == 2 then
                RandomDrop[battle] = 1
                gettreasure()
            end
        end

        getCoin()

    end
    --damage = 50
--    hold_atk[numcharacter] = 50
    characImage[numcharacter].hold_atk =  characImage[numcharacter].hold_atk  - hold_atk[numcharacter]
    if characImage[numcharacter].hold_atk <= 0  then
        Enemy_HP[numcharacter].width = 1
        Enemy_HP[numcharacter]:setReferencePoint( display.TopLeftReferencePoint )
        Enemy_HP[numcharacter].x = pointStartEnemy_HP[numcharacter]
        NumCoin = NumCoin+characImage[numcharacter].coin

       transitionStash.newTransition = transition.to(TextCD[numcharacter], { time=1000, alpha=0} )
       transitionStash.newTransition = transition.to(Enemy_HP[numcharacter], { time=1000, alpha=0} )
       transitionStash.newTransition = transition.to(Enemy_bar[numcharacter], { time=1000, alpha=0} )
       transitionStash.newTransition = transition.to(characImage[numcharacter], { time=1000, alpha=0,onComplete = clearCharacter} )

    else

        local hpLine = (lineFULLHP*characImage[numcharacter].hold_atk)/characImage[numcharacter].atk
        Enemy_HP[numcharacter].width =  hpLine
        Enemy_HP[numcharacter]:setReferencePoint( display.TopLeftReferencePoint )
        Enemy_HP[numcharacter].x = pointStartEnemy_HP[numcharacter]

    end
    checkMemory()
end

local function fncallSprite2()

    local sheetdata_light = {width = _W, height = 425,numFrames = 100, sheetContentWidth = _W*10 ,sheetContentHeight = (2125*2) }
    local image_sheet = {
        "img/sprite/BG_Forest/Autumn/sprite_sheet.png"
        ,"img/sprite/BG_Forest/Spring/sprite_sheet.png"
        ,"img/sprite/BG_Forest/Summer/sprite_sheet.png"
        ,"img/sprite/BG_Forest/War/sprite_sheet.png"
        ,"img/sprite/BG_Forest/Winter/sprite_sheet.png"


        ,"img/sprite/BG_Mountain/Autumn/sprite_sheet.png"
        ,"img/sprite/BG_Mountain/Spring/sprite_sheet.png"
        ,"img/sprite/BG_Mountain/Summer/sprite_sheet.png"
        ,"img/sprite/BG_Mountain/War/sprite_sheet.png"
        ,"img/sprite/BG_Mountain/Winter/sprite_sheet.png"

        ,"img/sprite/BG_Water/Autumn/sprite_sheet.png"
        ,"img/sprite/BG_Water/Spring/sprite_sheet.png"
        ,"img/sprite/BG_Water/Spring_blue/sprite_sheet.png"
        ,"img/sprite/BG_Water/Summer/sprite_sheet.png"
        ,"img/sprite/BG_Water/War/sprite_sheet.png"
        ,"img/sprite/BG_Water/Winter/sprite_sheet.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[BGsprite], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= 100, time=4500, loopCount=1 }

    myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    Gdisplay:insert(myAnimation)

end
local function swapSheet2()
    myAnimation:setSequence( "lightaura" )
    myAnimation:play()
end
----------------------------------
local function createBackButton(event)
    local function ButtouMenu(event)
        if (event.phase == "ended" or event.phase == "release") then
            if event.target.id == "Menu"  then
                local option = {
                    params = {
                        mission = mission_name ,
                        battle = battle.."/"..battleall     ,

                        -- 1 : ON
                        -- 2 : OFF
                        BGM = BGM     ,
                        SFX = SFX  ,
                        SKL = SKL  ,
                        BTN = BTN  ,
                        checkOption = checkOption
                    }
                }

                MenuInPuzzle(option)

            elseif event.target.id == "Item" then
                --loadImage()

            end

        end

    end

    local imgMenu ="img/background/button/as_butt_menu.png"
    backButton = widget.newButton{
        defaultFile = imgMenu,
        overFile = imgMenu,
        width=_W*.12, height= _H*.04,
        onRelease = ButtouMenu	-- event listener function
    }
    backButton.id = "Menu"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.alpha = 1
    backButton.x = _W - (_W*.12)
    backButton.y = 0

    --groupGameLayer:insert(backButton)

    flagimg = display.newImageRect( "img/background/puzzle/FLAG.png", _W*.05, _H*.04 )
    flagimg:setReferencePoint( display.TopLeftReferencePoint )
    flagimg.x, flagimg.y = _W*.03, 0
    groupGameTop:insert(flagimg)

    textFlagImg = display.newText(NumFlag,0 , 0,native.systemFontBold,25)
    textFlagImg:setReferencePoint( display.TopRightReferencePoint )
    textFlagImg.x = _W*.15
    textFlagImg:setTextColor(0, 0 ,139)
    groupGameTop:insert ( textFlagImg )


    local CoinImg = display.newImageRect( "img/background/puzzle/COIN.png", _W*.05, _H*.03 )
    CoinImg:setReferencePoint( display.TopLeftReferencePoint )
    CoinImg.x, CoinImg.y = _W*.2, 0
    groupGameTop:insert(CoinImg)

    textCoinImg = display.newText(NumCoin,0 , 0,native.systemFontBold,25)
    textCoinImg:setReferencePoint( display.TopLeftReferencePoint )
    textCoinImg.x = _W*.3
    textCoinImg:setTextColor(139, 35 ,35)
    groupGameTop:insert ( textCoinImg )
--    local imgItem ="img/background/button/as_butt_sell_plus.png"
--    bntItem = widget.newButton{
--        defaultFile = imgItem,
--        overFile = imgItem,
--        width=_W*.12, height= _H*.04,
--        onRelease = ButtouMenu	-- event listener function
--        --        onRelease = loadImage	-- event listener function
--    }
--    bntItem.id = "Item"
--    bntItem:setReferencePoint( display.TopLeftReferencePoint )
--    bntItem.alpha = 1
--    bntItem.x = 0
--    bntItem.y = 0
    --groupGameLayer:insert(bntItem)
end

---- clear list time,trans ------
function cancelAllTimers()
    local k, v
    for k,v in pairs(TimersST) do
        timer.cancel(v )
        v = nil; k = nil
    end


    TimersST = nil
    TimersST = {}
end

function cancelAllTransitions()
    local k, v
    for k,v in pairs(transitionStash) do
        transition.cancel( v )
        v = nil; k = nil
    end

    transitionStash = nil
    transitionStash = {}
end
---------------------------------

local function newGem (i,j)
    local R = mRandom(1,6)
    local newGem

    newGem = display.newImageRect(picture[R],sizeGem,sizeGem)

    newGem.x = i * widthGem - 52
    newGem.y = j * widthGem + 373

    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = false
    newGem.isMarkedToDestroy = false

    newGem.destination_y = j * widthGem + 373 --newGem.y


    newGem.color = R
    if 	(R == 1 ) then
        newGem.gemType = "RED"
    elseif (R == 2 ) then
        newGem.gemType = "GREEN"
    elseif (R == 3 ) then
        newGem.gemType = "BLUE"
    elseif (R == 4 ) then
        newGem.gemType = "PURPLE"
    elseif (R == 5 ) then
        newGem.gemType = "PINK"
    elseif (R == 6 ) then
        newGem.gemType = "YELLOW"
    end

    --new gem falling animation
    transitionStash.newTransition = transition.to( newGem, { time=100, y= newGem.destination_y} )
    groupGameLayer:insert( newGem )


    newGem.touch = onGemTouch
    newGem:addEventListener( "touch", newGem )

    return newGem
end

function copyGem(self,event)
    --    print("copyGem(self,event)  ")
    --    print("pointXY :"..gemsTable[self.i][self.j].i,gemsTable[self.i][self.j].j)
    copyGemXR, copyGemXL, copyGemYU, copyGemYD = {}, {}, {}, {}
    intervalGem = sizeGem + 8
    ------ ---  -- - chk event  -Right  -Left  -Up  -Down----
    rotateR = gemX + 1
    for R = 1, gemX, 1 do
        --        copyGemX[R] = gemsTable[R][self.j].colorR
        --        print("color :"..gemsTable[R][self.j].gemType, copyGemX[R])
        copyGemXR[R] = display.newImageRect(picture[gemsTable[R][self.j].colorR],sizeGem,sizeGem)
        copyGemXR[R].x, copyGemXR[R].y  = enTableX + (intervalGem * R), gemsTable[gemX][self.j].markY

        copyGemXL[R] = display.newImageRect(picture[gemsTable[rotateR - R][self.j].colorR],sizeGem,sizeGem)
        copyGemXL[R].x, copyGemXL[R].y  = stTableX - (intervalGem * R), gemsTable[gemX][self.j].markY

        groupGameLayer:insert( copyGemXR[R] )
        groupGameLayer:insert( copyGemXL[R] )
    end

    stTableY, enTableY = 400, 903
    rotateC = gemY + 1
    for C = 1, gemY, 1 do
        copyGemYU[C] = display.newImageRect(picture[gemsTable[self.i][C].colorR],sizeGem,sizeGem)
        copyGemYU[C].x, copyGemYU[C].y  = gemsTable[self.i][gemY].markX, enTableY + (intervalGem * C)

        copyGemYD[C] = display.newImageRect(picture[gemsTable[self.i][rotateC - C].colorR],sizeGem,sizeGem)
        copyGemYD[C].x, copyGemYD[C].y  = gemsTable[self.i][gemY].markX, stTableY - (intervalGem * C)

        groupGameLayer:insert( copyGemYD[C] )
        groupGameLayer:insert( copyGemYU[C] )
    end
    groupGameLayer:insert(groupGameTop )
end

function pasteGem(self, event)
    if(self.chkFtPosit == "x") then

        positSt = gemsTable[self.i][self.j].i
        positEn = gemsTable[self.i][self.j].x
        slideEvent = (event.x - event.xStart)

        colorTmp ={}
        markY = gemsTable[self.i][self.j].markY
        markJ = gemsTable[self.i][self.j].j
        slideL, slideR = 0, 0

        if ( slideEvent > 60 or slideEvent < -60) then
            countSlide = countSlide +1
        end

        for posX = gemX, 1, -1 do
            colorTmp[posX] = gemsTable[posX][self.j].colorR
            gemsTable[posX][self.j]:removeSelf()
        end

        if(positEn > 533 ) then
            slideL = 0
            slideR = 1
        elseif (positEn > 427 and positEn < 533) then
            slideL = 5
            slideR = 1
        elseif (positEn > 319 and positEn < 427) then
            slideL = 4
            slideR = 2
        elseif (positEn > 216 and positEn < 319) then
            slideL = 3
            slideR = 3
        elseif (positEn > 111 and positEn < 216) then
            slideL = 2
            slideR = 4
        else-- R to L only
            slideL = 1
            slideR = 5
        end
        -- for chk and loop
        --print("slideEvent "..slideEvent," last position "..positEn)
        for posX = gemX, 1, -1 do
            if( posX == gemX) then
                if(positSt > slideL)  then   --- L
                    color = colorTmp[positSt - slideL]
                    maxXTmp = positSt - slideL
                else                        --- R
                    color = colorTmp[positSt + slideR]
                    maxXTmp = positSt + slideR
                end
            else
                if(maxXTmp == 1 ) then
                    maxXTmp = gemX
                    color = colorTmp[maxXTmp]
                else
                    maxXTmp = maxXTmp - 1
                    color = colorTmp[maxXTmp]
                end
            end

            gemsTable[posX][self.j] = display.newImageRect(picture[color],sizeGem,sizeGem)
            groupGameLayer:insert(gemsTable[posX][self.j])
            if 	(color == 1 ) then
                gemsTable[posX][self.j].gemType = "RED"
            elseif (color == 2 ) then
                gemsTable[posX][self.j].gemType = "GREEN"
            elseif (color == 3 ) then
                gemsTable[posX][self.j].gemType = "BLUE"
            elseif (color == 4 ) then
                gemsTable[posX][self.j].gemType = "PURPLE"
            elseif (color == 5 ) then
                gemsTable[posX][self.j].gemType = "PINK"
            elseif (color == 6 ) then
                gemsTable[posX][self.j].gemType = "YELLOW"
            end

            gemsTable[posX][self.j].color = color
            gemsTable[posX][self.j].x = channelX[posX]
            gemsTable[posX][self.j].y = markY
            gemsTable[posX][self.j].i = posX
            gemsTable[posX][self.j].j = markJ

            gemsTable[posX][self.j].destination_y = markY
            gemsTable[posX][self.j].isMarkedToDestroy = false
            gemsTable[posX][self.j].touch = onGemTouch
            gemsTable[posX][self.j]:addEventListener( "touch", gemsTable[posX][self.j] )
        end

    elseif (self.chkFtPosit == "y") then
        positSt = gemsTable[self.i][self.j].j
        positEn = gemsTable[self.i][self.j].y
        slideEvent = (event.y - event.yStart)

        colorTmp = {}
        markX = gemsTable[self.i][self.j].markX
        markI = gemsTable[self.i][self.j].i
        slideU, slideD = 0, 0

        if ( slideEvent > 60 or slideEvent < -60) then
            countSlide = countSlide +1
        end

        for posY = gemY, 1, -1 do
            colorTmp[posY] = gemsTable[self.i][posY].colorR
            gemsTable[self.i][posY]:removeSelf()
        end

        if(positEn > 852 ) then
            slideU = 0
            slideD = 1
        elseif (positEn > 746 and positEn < 852) then
            slideU = 4
            slideD = 1
        elseif (positEn > 640 and positEn < 746) then
            slideU = 3
            slideD = 2
        elseif (positEn > 534 and positEn < 640) then
            slideU = 2
            slideD = 3
        else-- U to D only
            slideU = 1
            slideD = 4
        end

        for posY = gemY, 1, -1 do
            if( posY == gemY) then
                if(positSt > slideU)  then   --- U 
                    color = colorTmp[positSt - slideU]
                    maxYTmp = positSt - slideU
                else                        --- D
                    color = colorTmp[positSt + slideD]
                    maxYTmp = positSt + slideD
                end
            else
                if(maxYTmp == 1 ) then
                    maxYTmp = gemY
                    color = colorTmp[maxYTmp]
                else
                    maxYTmp = maxYTmp - 1
                    color = colorTmp[maxYTmp]
                end
            end

            gemsTable[self.i][posY] = display.newImageRect(picture[color],sizeGem,sizeGem)
            groupGameLayer:insert(gemsTable[self.i][posY])
            if 	(color == 1 ) then
                gemsTable[self.i][posY].gemType = "RED"
            elseif (color == 2 ) then
                gemsTable[self.i][posY].gemType = "GREEN"
            elseif (color == 3 ) then
                gemsTable[self.i][posY].gemType = "BLUE"
            elseif (color == 4 ) then
                gemsTable[self.i][posY].gemType = "PURPLE"
            elseif (color == 5 ) then
                gemsTable[self.i][posY].gemType = "PINK"
            elseif (color == 6 ) then
                gemsTable[self.i][posY].gemType = "YELLOW"
            end

            gemsTable[self.i][posY].color = color
            gemsTable[self.i][posY].x = markX
            gemsTable[self.i][posY].y = channelY[posY]
            gemsTable[self.i][posY].i = markI
            gemsTable[self.i][posY].j = posY

            gemsTable[self.i][posY].destination_y = channelY[posY]
            gemsTable[self.i][posY].isMarkedToDestroy = false
            gemsTable[self.i][posY].touch = onGemTouch
            gemsTable[self.i][posY]:addEventListener( "touch", gemsTable[self.i][posY] )
        end
    else
        --print("just click dont move")
    end

    for R = 1, gemX, 1 do
        copyGemXR[R]:removeSelf()
        copyGemXL[R]:removeSelf()
    end
    for C = 1, gemY, 1 do
        copyGemYU[C]:removeSelf()
        copyGemYD[C]:removeSelf()
    end


    if ( lineY ~=nil) then
        lineY:removeSelf()
        lineY= nil
    end
    if ( lineX ~=nil) then
        lineX:removeSelf()
        lineX= nil
    end

    --      for i = 1, gemX, 1 do --- x
    --        for j = 1, gemY, 1 do --- y
    --            print("à¸¢à¸¢à¸¢à¸¢i"..i.." j"..j.."    dest"..gemsTable[i][j].destination_y )
    --        end
    --    end

end

function slideGem(self,event)
    -- print(self.chkFtPosit)
    if(self.chkFtPosit == "x") then -- -- -- -- -- slide X           
        if ( lineY ~=nil) then
            lineY:removeSelf()
            lineY= nil
        end

        self.slideEvent = (event.x - event.xStart)

        -- gemsTable[][].j :: gemsTable[][].i == point self // gemsTable[self.i][self.j] == data self VIP
        if(gemsTable[self.i][self.j].x <= 20 or gemsTable[self.i][self.j].x >= 620) then     --  jump end dont move                  
            pasteGem(self,event)
        else
            intervalGem = sizeGem + 8
            for posX = 1, gemX, 1 do
                if gemsTable[posX][self.j].i == self.i then     -- self gem pos               
                    gemsTable[posX][self.j].x = self.markX + self.slideEvent
                else
                    gemsTable[posX][self.j].x = gemsTable[posX][self.j].markX + self.slideEvent
                end

                copyGemXR[posX].x = enTableX + gemsTable[posX][self.j].markX + self.slideEvent
                copyGemXL[posX].x = stTableX - gemsTable[posX][self.j].markX + self.slideEvent
            end
        end
    elseif (self.chkFtPosit == "y") then -- ---- -- slide Y      
        if ( lineX ~=nil) then
            lineX:removeSelf()
            lineX= nil
        end

        self.slideEvent = (event.y - event.yStart)

        -- print("JUMP ".. gemsTable[self.i][self.j].y)--
        if(gemsTable[self.i][self.j].y <= 455 or gemsTable[self.i][self.j].y >= 940) then        --  jump end dont move
            pasteGem(self,event)
        else
            intervalGem = sizeGem + 8
            for posY = 1, gemY, 1 do
                if gemsTable[self.i][posY].i == self.y then     -- self gem pos               
                    gemsTable[self.i][posY].y = self.markY + self.slideEvent
                else
                    gemsTable[self.i][posY].y = gemsTable[self.i][posY].markY + self.slideEvent
                end

                stTableY, enTableY = 853, 530
                copyGemYU[posY].x = gemsTable[self.i][posY].markX--
                copyGemYU[posY].y = enTableY + gemsTable[self.i][posY].markY + self.slideEvent

                copyGemYD[posY].x = gemsTable[self.i][posY].markX
                copyGemYD[posY].y = stTableY - gemsTable[self.i][posY].markY + self.slideEvent
            end
        end
    end

end

function textNumber()
    local num = 0
    for k = 1 ,rowCharac,1 do
        myNumber[k] = display.newText(num,0 , _H*.35,native.systemFontBold, 25)
        myNumber[k].x= datacharcter[k].poinCenter
        myNumber[k]:setTextColor(255, 255, 255)
        myNumber[k].alpha = 0
    end

    myPink = display.newText(num,0 , _H*.415,native.systemFontBold, 25)
    myPink.x= _W*.45
    myPink.alpha = 0

end

local function deleteHP_Defense(colercharacter,atk)  --สีของตัวเราที่จะออกไปยิง
    local E = 2
    local setP
    damage = 0
    point = nil
    for i = 1,CountCharacterInBattle ,1 do
        if characImage[i].color == 1 then --red
            if colercharacter == 2 then  --green
                setP = 1.25
            elseif colercharacter == 3 then --blue
                setP = 0.75
            else  --seem
                setP = 1
            end

        elseif characImage[i].color == 2 then --green
            if colercharacter == 1 then  --red
                setP = 0.75
            elseif colercharacter == 3 then --blue
                setP = 1.25
            else  --seem
                setP = 1
            end
        elseif characImage[i].color == 3 then --blue
            if colercharacter == 2 then  --green
                setP = 0.75
            elseif colercharacter == 1 then --red
                setP = 1.25
            else  --seem
                setP = 1
            end
        else--purple --yellow
            setP = 1
        end

        ------------------------------------------
        if setP < E then
            E = setP
            if i >1 then
               if characImage[i].hold_atk > characImage[i-1].hold_atk then
                   point = i
               else
                   point = i-1
               end
            else
                point = i
            end
        end

    end
    S = 1
    R = 0
    --   {[(A * S) + ΣI] / (E - R)] + {[A * (N / 30)] * [(C + 1) / 2]} = H
    damage = (((atk* S) +0  ) /(E - R) ) + ((atk * (NN/30)) *((countCombo +1)/2))
end
local function ClearNumber()
    hold_atk = {0,0,0,0,0}
    local intBG = 0
    local groupView = display.newGroup()
    for k = 1 ,rowCharac,1 do
        if myNumber[k].team_no and TouchCount~=0 then

            if intBG == 0 then
                intBG = intBG + 1
                enablePuzzleTouch(intBG)
            end
            deleteHP_Defense(myNumber[k].color,myCount[k])
            --getCharacterCoin(point,myNumber[k].team_no,myNumber[k].color,damage,k)     --ตำแหน่งที่บอลออก.ตำแหน่งที่บอลจะไปยิง.สี,จำนวน atk,ตัวที่
            hold_atk[point] = hold_atk[point] + damage
            battleIcon(myNumber[k].team_no,point,myNumber[k].color,damage,k)  --ตำแหน่งที่บอลออก.-ตำแหน่งที่บอลจะไปยิง.-สี,จำนวน atk


        end
        display.remove(myNumber[k])
        myNumber[k] = nil
    end
    if TouchCount~=0 then
        TimersST.myTimer = timer.performWithDelay(500,damageAttackEnemy)
    end


    enableGemTouch()

    display.remove(myPink)
    myPink = nil
    textNumber()

end
local function PopNumIconCharacter(color,countColor)
    if NN == 0 then
        NN = countColor
    end
 if   TouchCount~=0 then

    if rowCharac then
        local pointIcon = {
            _W*.075 ,
            _W*.24 ,
            _W*.405 ,
            _W*.57 ,
            _W*.735 ,
            _W*.90 ,
        }

        if color == "PINK" then
            myPink.alpha = 1
            local myCountDEF = math.ceil(sumDEF*(countColor/4)*((countCombo+2)/2) )
            myPink.text = string.format("+"..myCountDEF)
            transitionStash.newTransition = transition.to(myPink, { time=700, alpha=1, xScale=1.5, yScale = 1.5} )
            hpPlayer =  math.ceil(hpPlayer + myCountDEF)
            local x = math.ceil((fullLineHP *hpPlayer)/hpFull )
            if hpPlayer >= hpFull then
                hpPlayer= hpFull
                lifeline_sh.width =  fullLineHP
            else
                lifeline_sh.width =  x
            end

            lifeline_sh:setReferencePoint( display.TopLeftReferencePoint )
            lifeline_sh.x = pointStart

            textHP.text = string.format(hpPlayer.."/"..hpFull )
            textHP:setReferencePoint( display.TopRightReferencePoint )
            textHP.x = _W*.95
        else

        for i = 1 ,rowCharac,1 do
            if datacharcter[i].element == 1 and color == "RED" then --RED
--                print("RED")
                myNumber[i].alpha = 1
                myNumber[i].color = datacharcter[i].element
                myNumber[i].team_no = datacharcter[i].team_no
                myCount[i] = myCount[i] +math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+2)/2))
                myNumber[i].text = string.format(myCount[i] )
                myNumber[i]:setTextColor(255, 0 ,0)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1,  xScale=1.5, yScale = 1.5} )

                countCombo = countCombo + 1
            elseif datacharcter[i].element == 2 and color == "GREEN" then --GREEN
--                print("GREEN")
                myNumber[i].alpha = 1
                myNumber[i].color = datacharcter[i].element
                myNumber[i].team_no = datacharcter[i].team_no
                myCount[i] = myCount[i] + math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+2)/2))
                myNumber[i].text = string.format(myCount[i] )
                myNumber[i]:setTextColor( 0 ,255, 0)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1,  xScale=1.5, yScale = 1.5} )

                countCombo = countCombo + 1
            elseif datacharcter[i].element == 3 and color == "BLUE" then --BLUE
--                print("BLUE")
                myNumber[i].alpha = 1
                myNumber[i].color = datacharcter[i].element
                myNumber[i].team_no = datacharcter[i].team_no
                myCount[i] = myCount[i] +math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+2)/2))
                myNumber[i].text = string.format(myCount[i] )
--                myNumber[i]:setTextColor(30 ,144 ,255)
                myNumber[i]:setTextColor(152 ,245, 255)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1, xScale=1.5, yScale = 1.5} )

                countCombo = countCombo + 1
            elseif datacharcter[i].element == 4 and color == "PURPLE" then --PURPLE
--                print("PURPLE")
                myNumber[i].alpha = 1
                myNumber[i].color = datacharcter[i].element
                myNumber[i].team_no = datacharcter[i].team_no
                myCount[i] = myCount[i] + math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+2)/2))
                myNumber[i].text = string.format(myCount[i] )
                myNumber[i]:setTextColor(255 ,0 ,255)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1,  xScale=1.5, yScale = 1.5} )

                countCombo = countCombo + 1
            elseif datacharcter[i].element == 5 and color == "YELLOW" then --YELLOW
--                print("YELLOW")
                myNumber[i].alpha = 1
                myNumber[i].color = datacharcter[i].element
                myNumber[i].team_no = datacharcter[i].team_no
                myCount[i] = myCount[i] +math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+2)/2))
                myNumber[i].text = string.format(myCount[i] )
                myNumber[i]:setTextColor(255, 255, 0)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1,  xScale=1.5, yScale = 1.5} )

                countCombo = countCombo + 1
            end

        end
      end

    end
 end

    checkMemory()


end
local function shiftGems ()
--    print ("Shifting Gems")

    for i = 1, gemX, 1 do
        if gemsTable[i][1].isMarkedToDestroy then
            gemToBeDestroyed = gemsTable[i][1]

            gemsTable[i][1] = newGem(i,1)
            groupGameLayer:insert ( gemsTable[i][1] )
            gemToBeDestroyed:removeSelf()
            gemToBeDestroyed = nil
        end
    end
    -- rest of the rows
    for j = 2, gemY, 1 do  -- j = row number - need to do like this it needs to be checked row by row
        for i = 1, gemX, 1 do
            if gemsTable[i][j].isMarkedToDestroy then --if you find and empty hole then shift down all gems in column
                gemToBeDestroyed = gemsTable[i][j]
                for k = j, 2, -1 do -- starting from bottom - finishing at the second row
                    gemsTable[i][k] = gemsTable[i][k-1]
                    gemsTable[i][k].destination_y = gemsTable[i][k].destination_y + 106
                    transitionStash.newTransition = transition.to( gemsTable[i][k], { time=100, y= gemsTable[i][k].destination_y} )

                    gemsTable[i][k].j = gemsTable[i][k].j + 1
                end

                gemsTable[i][1] = newGem(i,1)

                groupGameLayer:insert ( gemsTable[i][1] )
                gemToBeDestroyed:removeSelf()
                gemToBeDestroyed = nil
            end
        end
    end
    groupGameLayer:insert(groupGameTop )
    TimersST.myTimer = timer.performWithDelay( 0, checkdoubleAll )
end --shiftGems()
local function destroyGems()
--    print("destroyGems")
    lockGemMutiChk = true
    local color
    local countColor = 0
    for i = 1, gemX, 1 do
        for j = 1, gemY, 1 do

            if gemsTable[i][j].isMarkedToDestroy  then
                color = gemsTable[i][j].gemType
                countColor = countColor + 1
                --  print("nameType"..nameType)
                gemsTable[i][j]:setStrokeColor(140, 140, 140)
                gemsTable[i][j].strokeWidth = 7
                gemsTable[i][j]:setFillColor(150)

                isGemTouchEnabled = false
                -- transitionStash.newTransition = transition.to( gemsTable[i][j], { time=300, alpha=0.1, xScale=2, yScale = 2} )
            end
        end
    end
    PopNumIconCharacter(color,countColor)
    TimersST.myTimer = timer.performWithDelay( 1000, shiftGems ) -- 3 sce

    for  pt = 1 , 6 , 1 do
        groupGem[pt] =0
    end

    lockGemMuti = 0
    --checkMemory()
end

local numcolor = {0,0,0,0,0,0 }

local function cleanUpGems()
--    print("Cleaning Up Gems")

    for i = 1, gemX, 1 do
        for j = 1, gemY, 1 do
            -- show that there is not enough
            if gemsTable[i][j].isMarkedToDestroy then
                transitionStash.newTransition = transition.to( gemsTable[i][j], { time=100, xScale=1.2, yScale = 1.2 } )
                transitionStash.newTransition = transition.to( gemsTable[i][j], { time=100, delay=100, xScale=1.0, yScale = 1.0} )
            end

            gemsTable[i][j].isMarkedToDestroy = false
        end
    end

    for  pt = 1, table.getn(picture), 1 do
        groupGem[pt] =0
    end


end
local function markPreDestory (i,j,chkMuti)
    --print("=== > MarkPreDestory :color [i][j]",gemsTable[i][j].gemType,i,j)
    if (gemsTable[i][j].gemType == "RED") then
        if (chkMuti == 0) then
            groupGemChk[1] = groupGemChk[1] + 1
        else
            groupGemChk[1] = 0
        end
        --print("RED groupGemChk[1] = ",groupGemChk[1])
    elseif (gemsTable[i][j].gemType == "GREEN") then
        if (chkMuti == 0) then
            groupGemChk[2] = groupGemChk[2] + 1
        else
            groupGemChk[2] = 0
        end
        --print("GREEN groupGemChk[2] = ",groupGemChk[2])
    elseif (gemsTable[i][j].gemType == "BLUE") then
        if (chkMuti == 0) then
            groupGemChk[3] = groupGemChk[3] + 1
        else
            groupGemChk[3] = 0
        end
        --print("BLUE groupGemChk[3] = ",groupGemChk[3])
    elseif (gemsTable[i][j].gemType == "PURPLE") then
        if (chkMuti == 0) then
            groupGemChk[4] = groupGemChk[4] + 1
        else
            groupGemChk[4] = 0
        end
        --print("PURPLE groupGemChk[4] = ",groupGemChk[4])
    elseif (gemsTable[i][j].gemType == "PINK") then
        if (chkMuti == 0) then
            groupGemChk[5] = groupGemChk[5] + 1
        else
            groupGemChk[5] = 0
        end
        --print("PINK groupGemChk[5] = ",groupGemChk[5])
    elseif (gemsTable[i][j].gemType == "YELLOW") then
        if (chkMuti == 0) then
            groupGemChk[6] = groupGemChk[6] + 1
        else
            groupGemChk[6] =0
        end
        --print("YELLOW groupGemChk[6] = ",groupGemChk[6])
    end

    gemsTable[i][j].isMarkedToDestroy = true
end

local function markToDestroy(self, chkMuti)
    self.isMarkedToDestroy = true
   -- print("----** MarkToDestroy color[i][j]",self.gemType,self.i,self.j)

    if self.i>1 then -- LEFT
       -- print("LEFt .isMarkedToDestroy = ",gemsTable[self.i-1][self.j].isMarkedToDestroy )
        if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == false then
            if (gemsTable[self.i-1][self.j]).gemType == self.gemType then
                markPreDestory (self.i-1,self.j,chkMuti)
                markToDestroy( gemsTable[self.i-1][self.j],chkMuti)
            end
        end
    end

    if self.i<gemX then -- RIGHT
       -- print("RIGHT .isMarkedToDestroy = ",gemsTable[self.i+1][self.j].isMarkedToDestroy )
        if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == false  then
            if (gemsTable[self.i+1][self.j]).gemType == self.gemType then
                markPreDestory (self.i+1,self.j,chkMuti)
                markToDestroy( gemsTable[self.i+1][self.j],chkMuti )
            end
        end
    end

    if self.j>1 then -- UP
       -- print("UP .isMarkedToDestroy = ",gemsTable[self.i][self.j-1].isMarkedToDestroy )
        if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == false  then
            if (gemsTable[self.i][self.j-1]).gemType == self.gemType then
                markPreDestory (self.i,self.j-1,chkMuti)
                markToDestroy( gemsTable[self.i][self.j-1] ,chkMuti)
            end
        end
    end

    if self.j<gemY then -- DOWN
       -- print("DOWN .isMarkedToDestroy = ",gemsTable[self.i][self.j+1].isMarkedToDestroy )
        if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== false then
            if (gemsTable[self.i][self.j+1]).gemType == self.gemType then
                markPreDestory (self.i,self.j+1,chkMuti)
                markToDestroy( gemsTable[self.i][self.j+1] ,chkMuti)
            end
        end
    end



end
local function doubleToDestroy( chkMuti)
    --self.isMarkedToDestroy = true
    --print("self.gemType",self.gemType)
for i = 1, gemX, 1 do --6
    for j = 1, gemY, 1 do  --5
    --print("i:j",i,j)
    if i>1 then
        if (gemsTable[i-1][j]).isMarkedToDestroy == false then
            if (gemsTable[i-1][j]).gemType == (gemsTable[i][j]).gemType then
                markPreDestory (i-1,j,chkMuti)
                --print("i:j",i,j,"i-1:j",i-1,j)
            end
        end
    end

    if i<gemX then
        if (gemsTable[i+1][j]).isMarkedToDestroy == false  then
            if (gemsTable[i+1][j]).gemType == (gemsTable[i][j]).gemType then
                markPreDestory (i+1,j,chkMuti)
                --print("i:j",i,j,"i+1:j",i+1,j)
            end
        end
    end

    if j>1 then
        if (gemsTable[i][j-1]).isMarkedToDestroy == false  then
            if (gemsTable[i][j-1]).gemType == (gemsTable[i][j]).gemType then
                markPreDestory (i,j-1,chkMuti)
                --print("i:j",i,j,"i:j-1",i,j-1)
            end
        end
    end

    if j<gemY then
        if (gemsTable[i][j+1]).isMarkedToDestroy== false then
            if (gemsTable[i][j+1]).gemType == (gemsTable[i][j]).gemType then
                markPreDestory (i,j+1,chkMuti)
                --print("i:j",i,j,"i:j+1",i,j+1)
            end
        end
    end

    end
end

end

function chkGruopDel (self,chkMuti)
    self.isMarkedToDestroy = false


    --print("DELETE ==== >i,j",self.i,self.j)
    if self.i>1 then
        if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == true and  gemsTable[self.i-1][self.j].gemType == self.gemType then
            markPreDestory (self.i-1,self.j,chkMuti)
            chkGruopDel( gemsTable[self.i-1][self.j] ,chkMuti)
        end
    end

    if self.i<gemX then
        if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == true  and gemsTable[self.i+1][self.j].gemType == self.gemType then
            markPreDestory (self.i+1,self.j,chkMuti)
            chkGruopDel( gemsTable[self.i+1][self.j],chkMuti )
        end
    end

    if self.j>1 then
        if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == true and gemsTable[self.i][self.j-1].gemType == self.gemType then
            markPreDestory (self.i,self.j-1,chkMuti)
            chkGruopDel( gemsTable[self.i][self.j-1] ,chkMuti)
        end
    end

    if self.j<gemY then
        if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== true and gemsTable[self.i][self.j+1].gemType == self.gemType then
            markPreDestory (self.i,self.j+1,chkMuti)
            chkGruopDel( gemsTable[self.i][self.j+1] ,chkMuti)
        end
    end
end

function chkGruopGem(self,kk)
    --print("CHKGROUP GEM :[kk][color]",kk,self.gemType)

    if (self.gemType == "RED") then
           --print("RED =[groupGemChk][groupGem][kk]",groupGemChk[1],groupGem[1],kk)
        if groupGemChk[1]  >= limitCountGemSlide then
            if (kk ~= "RED") then
                groupGem[1]= groupGem[1]+groupGemChk[1]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[1] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[1] = 0
    elseif (self.gemType == "GREEN") then
           --print("GREEN = [groupGemChk][groupGem][kk]",groupGemChk[2],groupGem[2],kk)
        if groupGemChk[2]  >= limitCountGemSlide then
            if (kk ~= "GREEN") then
                groupGem[2]= groupGem[2]+groupGemChk[2]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[2] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[2] = 0
    elseif (self.gemType == "BLUE") then
           --print("BLUE = [groupGemChk][groupGem][kk]",groupGemChk[3],groupGem[3],kk)
        if groupGemChk[3]  >= limitCountGemSlide then
            if ( kk ~= "BLUE") then
                groupGem[3]= groupGem[3]+groupGemChk[3]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[3] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[3] = 0
    elseif (self.gemType == "PURPLE") then
            -- print("PURPLE =[groupGemChk][groupGem][kk]",groupGemChk[4],groupGem[4],kk)
        if groupGemChk[4]  >= limitCountGemSlide then
            if (kk ~= "PURPLE") then
                groupGem[4]= groupGem[4]+groupGemChk[4]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[4] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[4] = 0
    elseif (self.gemType == "PINK") then
         -- print("PINK =[groupGemChk][groupGem][kk]",groupGemChk[5],groupGem[5],kk)
        if groupGemChk[5]  >= limitCountGemSlide then
            if ( kk ~= "PINK") then
                groupGem[5]= groupGem[5]+groupGemChk[5]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[5] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[5] = 0
    elseif (self.gemType == "YELLOW") then
            --   print("YELLOW =[groupGemChk][groupGem][kk]",groupGemChk[6],groupGem[6],kk)
        if groupGemChk[6]  >= limitCountGemSlide then
            if kk ~= "YELLOW" then
                groupGem[6]= groupGem[6]+groupGemChk[6]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[6] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[6] = 0
    end
end
function chkGruopGem2(self)
    --print("chkGruopGem2 color",self.gemType)
    if (self.gemType == "RED") then
        if groupGemChk[1]  >= limitCountGem then
            groupGem[1]= groupGem[1]+groupGemChk[1]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[1] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[1] = 0
    elseif (self.gemType == "GREEN") then
        if groupGemChk[2]  >= limitCountGem then
            groupGem[2]= groupGem[2]+groupGemChk[2]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[2] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[2] = 0
    elseif (self.gemType == "BLUE") then
        if groupGemChk[3]  >= limitCountGem then
           groupGem[3]= groupGem[3]+groupGemChk[3]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[3] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[3] = 0
    elseif (self.gemType == "PURPLE") then
        if groupGemChk[4]  >= limitCountGem then
           groupGem[4]= groupGem[4]+groupGemChk[4]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[4] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[4] = 0
    elseif (self.gemType == "PINK") then
        if groupGemChk[5]  >= limitCountGem then
           groupGem[5]= groupGem[5]+groupGemChk[5]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[5] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[5] = 0
    elseif (self.gemType == "YELLOW") then
        if groupGemChk[6]  >= limitCountGem then
           groupGem[6]= groupGem[6]+groupGemChk[6]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[6] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[6] = 0
    end
end
function chkGruopOnload(self)
    local limitColor = 3
    local just
    if (self.gemType == "RED") then
        if groupGemChk[1]  >= limitColor then
            just = gemsTable[self.i][self.j]
            gemsTable[self.i][self.j] = newGem(self.i,self.j)
            gemsTable[self.i][self.j].markX = just.markX
            gemsTable[self.i][self.j].markY = just.markY
            display.remove(just)
            just = nil
            --groupGem[1]= groupGem[1]+groupGemChk[1]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[1] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[1] = 0
    elseif (self.gemType == "GREEN") then
        if groupGemChk[2]  >= limitColor then
            just = gemsTable[self.i][self.j]
            gemsTable[self.i][self.j] = newGem(self.i,self.j)
            gemsTable[self.i][self.j].markX = just.markX
            gemsTable[self.i][self.j].markY = just.markY
            display.remove(just)
            just = nil
            --groupGem[2]= groupGem[2]+groupGemChk[2]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[2] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[2] = 0
    elseif (self.gemType == "BLUE") then
        if groupGemChk[3]  >= limitColor then
            just = gemsTable[self.i][self.j]
            gemsTable[self.i][self.j] = newGem(self.i,self.j)
            gemsTable[self.i][self.j].markX = just.markX
            gemsTable[self.i][self.j].markY = just.markY
            display.remove(just)
            just = nil
            --groupGem[3]= groupGem[3]+groupGemChk[3]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[3] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[3] = 0
    elseif (self.gemType == "PURPLE") then
        if groupGemChk[4]  >= limitColor then
            just = gemsTable[self.i][self.j]
            gemsTable[self.i][self.j] = newGem(self.i,self.j)
            gemsTable[self.i][self.j].markX = just.markX
            gemsTable[self.i][self.j].markY = just.markY
            display.remove(just)
            just = nil
            --groupGem[4]= groupGem[4]+groupGemChk[4]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[4] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[4] = 0
    elseif (self.gemType == "PINK") then
        if groupGemChk[5]  >= limitColor then
            just = gemsTable[self.i][self.j]
            gemsTable[self.i][self.j] = newGem(self.i,self.j)
            gemsTable[self.i][self.j].markX = just.markX
            gemsTable[self.i][self.j].markY = just.markY
            display.remove(just)
            just = nil
            --groupGem[5]= groupGem[5]+groupGemChk[5]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[5] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[5] = 0
    elseif (self.gemType == "YELLOW") then
        if groupGemChk[6]  >= limitColor then
            just = gemsTable[self.i][self.j]
            gemsTable[self.i][self.j] = newGem(self.i,self.j)
            gemsTable[self.i][self.j].markX = just.markX
            gemsTable[self.i][self.j].markY = just.markY
            display.remove(just)
            just = nil
            --groupGem[6]= groupGem[6]+groupGemChk[6]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[6] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[6] = 0
    end
end
function lockGem(self, event)
    -- print("LockGem"..self.i,self.j)
    if( self.chkFtPosit ~= "" ) then
        if( self.chkFtPosit == "x" ) then
            slideEvent = (event.x - event.xStart)
        else
            slideEvent = (event.y - event.yStart)
        end

        if ( slideEvent > 60 or slideEvent < -60) then
            if( self.chkFtPosit == "x" ) then
                positEn = slideEvent + gemsTable[self.i][self.j].x

                if(positEn > 533 ) then
                    self.i =  6
                elseif (positEn > 427 and positEn < 533) then
                    self.i =  5
                elseif (positEn > 319 and positEn < 427) then
                    self.i =  4
                elseif (positEn > 216 and positEn < 319) then
                    self.i =  3
                elseif (positEn > 111 and positEn < 216) then
                    self.i =  2
                else
                    self.i =  1
                end
            elseif ( self.chkFtPosit == "y" ) then
                positEn = slideEvent + gemsTable[self.i][self.j].y

                if(positEn > 852 ) then
                    self.j = 5
                elseif (positEn > 746 and positEn < 852) then
                    self.j = 4
                elseif (positEn > 640 and positEn < 746) then
                    self.j = 3
                elseif (positEn > 534 and positEn < 640) then
                    self.j = 2
                else
                    self.j = 1
                end
            end

        end

    else
        --print(" self.chkFtPosit")
    end

end

function rndLock2(RC,i,j, event)
    if RC == "x" then

        for stX = 1, gemX, 1 do
            gemsTable[i][j].i = stX
            gemsTable[i][j].gemType=gemsTable[i][j].gemType

            --    print("self.i"..self.i.." self.j"..self.j..self.gemType)
            markToDestroy(gemsTable[i][j],0)

            local kk = stX -1
            if(kk > 0) then
                kk = gemsTable[kk][j].gemType
            else
                kk = "COLOR FT"
            end

            chkGruopGem(gemsTable[i][j], kk)

            --print("xxx".. self.gemType,numberOfMarkedToDestroy )
        end
    else
        for stY = 1, gemY, 1 do
            gemsTable[i][j].j = stY
            gemsTable[i][j].gemType=gemsTable[i][j].gemType

            markToDestroy(gemsTable[i][j],0)

            local kk = stY -1
            if(kk > 0) then
                kk = gemsTable[i][kk].gemType
            else
                kk = "COLOR FT"
            end

            chkGruopGem(gemsTable[i][j],kk)
            -- print("yyy".. self.gemType,numberOfMarkedToDestroy )
        end
    end
end


function rndLock(self, event)
    -- print("gemsTable[self.i][self.j].gemType",gemsTable[self.i][self.j].gemType)

    if (self.chkFtPosit=="x") then
        for stX = 1, gemX, 1 do
            self.i = stX
            self.gemType=gemsTable[self.i][self.j].gemType

            --    print("self.i"..self.i.." self.j"..self.j..self.gemType)
            markToDestroy(self,0)

            local kk = stX -1
            if(kk > 0) then
                kk = gemsTable[kk][self.j].gemType
            else
                kk = "COLOR FT"
            end

            chkGruopGem(self, kk)

            --print("xxx".. self.gemType,numberOfMarkedToDestroy )
        end
    elseif (self.chkFtPosit=="y" ) then
        for stY = 1, gemY, 1 do
            self.j = stY
            self.gemType=gemsTable[self.i][self.j].gemType

            markToDestroy(self,0)

            local kk = stY -1
            if(kk > 0) then
                kk = gemsTable[self.i][kk].gemType
            else
                kk = "COLOR FT"
            end

            chkGruopGem(self,kk)
            -- print("yyy".. self.gemType,numberOfMarkedToDestroy )
        end
    else
        print("not heve self.chkFtPosit")
    end
end
function test(self)
    -- print("65chk "..gemsTable[1][1].i, gemsTable[1][1].j,gemsTable[1][1].color)
    for  i = 1 ,gemX, 1 do
        for  j = 1 , gemY, 1 do
            gemsTable[i][j].colorR = gemsTable[i][j].color   --- - -- - copy gem
            gemsTable[i][j].markX = gemsTable[i][j].x
            gemsTable[i][j].markY = gemsTable[i][j].y
        end
    end
end

local y = 403
local function numberToimg (hp,stHp,si,i)
    number[i] =display.newImageRect("img/other/"..hp..".png",si,25)
    number[i]:setReferencePoint( display.TopLeftReferencePoint )
    number[i].x, number[i].y = stHp, y
    groupGameTop:insert ( number[i] )
end
local function checkdoubleRight(i,j,RC)

    if gemsTable[i][j].gemType == "RED" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[1] = numcolor[1] + 1
    elseif gemsTable[i][j].gemType == "GREEN" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[2] = numcolor[2] + 1
    elseif gemsTable[i][j].gemType == "BLUE" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[3] = numcolor[3] + 1
    elseif gemsTable[i][j].gemType == "PURPLE" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[4] = numcolor[4] + 1
    elseif gemsTable[i][j].gemType == "PINK" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[5] = numcolor[5] + 1
    elseif gemsTable[i][j].gemType == "YELLOW" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[6] = numcolor[6] + 1

    end

    if i < 6 and RC == "right"  then
        if gemsTable[i+1][j].isMarkedToDestroy == false and gemsTable[i][j].gemType == gemsTable[i+1][j].gemType then --right
            --print("==> right i:j",i..":"..j,gemsTable[i+1][j].gemType)
            gemsTable[i+1][j].isMarkedToDestroy = true
            checkdoubleRight(i+1,j,"right")
        else
            if j < 5 then
                checkdoubleRight(i,j,"under")
            end
            if j > 1 then --top
                checkdoubleRight(i,j,"top")
            end
        end
    elseif  j < 5 and RC == "under" then
        if gemsTable[i][j+1].isMarkedToDestroy == false and gemsTable[i][j].gemType == gemsTable[i][j+1].gemType then --under
           -- print("==> under i:j",i..":"..j,gemsTable[i][j+1].gemType)
            gemsTable[i][j+1]:setStrokeColor(140, 140 ,140)
            gemsTable[i][j+1].isMarkedToDestroy = true
            checkdoubleRight(i,j+1,"under")
        end
    elseif  i > 1 and RC == "left" then
        if gemsTable[i-1][j].isMarkedToDestroy == false and gemsTable[i][j].gemType == gemsTable[i-1][j].gemType then --left
           -- print("==> left i:j",i..":"..j,gemsTable[i-1][j].gemType)
            gemsTable[i-1][j].isMarkedToDestroy = true
            checkdoubleRight(i-1,j,"left")
        end
    elseif  j > 1 and RC == "top" then
        if gemsTable[i][j-1].isMarkedToDestroy == false and gemsTable[i][j].gemType == gemsTable[i][j-1].gemType then --top
           -- print("==> top i:j",i..":"..j,gemsTable[i][j-1].gemType)
            gemsTable[i][j-1].isMarkedToDestroy = true
            checkdoubleRight(i,j-1,"top")
        end
    end
end
function checkdoubleAll()
    isGemTouchEnabled = true
    for i = 1, gemX, 1 do --6
        for j = 1, gemY, 1 do  --5
            if gemsTable[i][j].isMarkedToDestroy == false then
                 markToDestroy(gemsTable[i][j], 0)
                 chkGruopGem2(gemsTable[i][j])
            end

        end
    end

    local overFileMin = 0
    for p = 1 , table.getn(picture), 1 do
        if(groupGem[p] >= limitCountGem) then
            overFileMin = limitCountGem
        end

    end
    if overFileMin >= limitCountGem then
        destroyGems()

    else
       transitionStash.newTransition = transition.to( myNumber[1], { time=500, alpha=0, xScale=2, yScale = 2,onComplete = ClearNumber})
       enableGemTouch()

        NN = 0
        countCombo = 0
        cleanUpGems()
    end

end
local function checkdoubleOnload()
    isGemTouchEnabled = true
    for i = 1, gemX, 1 do --6
        for j = 1, gemY, 1 do  --5
            if gemsTable[i][j].isMarkedToDestroy == false then
                markToDestroy(gemsTable[i][j], 0)
                chkGruopOnload(gemsTable[i][j])
            end

        end
    end

    local overFileMin = 0
    for p = 1 , table.getn(picture), 1 do
        if(groupGem[p] >= limitCountGem) then
            overFileMin = limitCountGem
        end

    end
    if overFileMin >= limitCountGem then
        destroyGems()

    else
        transitionStash.newTransition = transition.to( myNumber[1], { time=700, alpha=0, xScale=2, yScale = 2,onComplete = ClearNumber})
        enableGemTouch()

        NN = 0
        countCombo = 0
        cleanUpGems()


    end
    battle_Animation(100,battleall,battle..battleall)
end

function onGemTouch( self, event )	-- was pre-declared
    local stHp, si =590, 20
    --if isGemTouchEnabled == true then


    if event.phase == "began" and isGemTouchEnabled == true and characImage[1].hold_countD >0 and CountCharacterInBattle ~=0 then
     TouchCount = TouchCount + 1
        for  i = 1 ,gemX, 1 do
            for  j = 1 , gemY, 1 do
                gemsTable[i][j].colorR = gemsTable[i][j].color   --- - -- - copy gem
                gemsTable[i][j].markX = gemsTable[i][j].x
                gemsTable[i][j].markY = gemsTable[i][j].y
            end
        end

        display.getCurrentStage():setFocus( self )
        self.isFocus = true

        if(gemsTable[self.i][self.j].isMarkedToDestroy == false ) then
            self:setFillColor(100)
        end

        widhtLineY, widhtLineX = 525, 620
        sizeLineStY, sizeLineStX = 695, 320

        lineY = display.newImageRect("img/other/bar_twin_v.png",100,widhtLineY)
        lineY.x, lineY.y = self.markX, sizeLineStY

        lineX = display.newImageRect("img/other/bar_twin_h.png", widhtLineX, 100)
        lineX.x, lineX.y = sizeLineStX, self.markY
        copyGem(self, event)

        --  local ftCilck = ""
    elseif self.isFocus then
        if event.phase == "moved" then
            local posX = (event.x - event.xStart) + self.markX
            local posY = (event.y - event.yStart) + self.markY

            local pathY = event.y-event.yStart
            local pathX = event.x-event.xStart

            --     print("posX ".. posX.." posY ".. posY.." pathX ".. pathX.." pathY ".. pathY )
            --     print ("event.xStart ".. event.xStart.. " event.x "..event.x.." self.markX ".. self.markX)
            local speedX = posX - self.markX
            if ( (posY == self.markY) or self.chkFtPosit == "x" ) then -- move X
                if(self.chkFtPosit == "y" ) then
                    posX = self.markX
                    posY = event.y

                    self.chkFtPosit ="y"
                else
                    posX = event.x
                    posY = self.markY

                    self.chkFtPosit ="x"
                end
                --       print( "posY == self.markY   moveX")
            elseif ( posX == self.markX or self.chkFtPosit == "y"  ) then -- move Y
                if(self.chkFtPosit == "x") then
                    posX = event.x
                    posY = self.markY

                    self.chkFtPosit ="x"
                else
                    posX = self.markX
                    posY = event.y

                    self.chkFtPosit ="y"
                end
                --          print( "posX == self.markX   moveY")
            else
                if (pathY < pathX  and self.chkFtPosit =="" ) then -- move X
                    posX = event.x
                    posY = self.markY
                    --       print("|xxxx"..pathY,pathX)
                    self.chkFtPosit ="x"
                    --                   local myText = display.newText(pathY.."!"..pathX, 0, 0, native.systemFont, 100)
                    --                    myText:setTextColor(0, 0, 0)

                else--if (pathY > pathX  and self.chkFtPosit =="") then
                    posX = self.markX-- move Y
                    posY = event.y
                    --        print("|yyyy"..pathY,pathX)
                    self.chkFtPosit ="y"
                --else
                    --          print("sssssssss sss sss s ss ")
                end

            end

            self.x, self.y = posX, posY
            --print("x:"..posX.."evX:"..self.x.." y:"..posY.."evY:"..self.y)
            --print("slide "..gemsTable[6][self.j].x)

            slideGem(self,event)  --- old
        elseif event.phase == "ended" or event.phase == "cancelled" then
           -- print("end phase".. self.chkFtPosit)

            pasteGem(self,event)
--            lockGem(self,event)
--            rndLock(self, event)


            self.chkFtPosit =""

            display.getCurrentStage():setFocus( nil )
            self.isFocus = false

            if(gemsTable[self.i][self.j].isMarkedToDestroy == false ) then
                self:setFillColor(255)
            else
                self:setFillColor(150)
            end

            local ch_CD = 0
            for i=1,CountCharacterInBattle,1 do

                characImage[i].hold_countD = characImage[i].hold_countD -1
                TextCD[i].text =  string.format("CD:"..characImage[i].hold_countD)

            end
            checkdoubleAll()

        end
    end
    return true
   -- end
end
local function mission(event)

    local LinkURL = "http://localhost/DYM/mission.php"
    local URL =  LinkURL.."?mission_id="..mission_id
    local response = http.request(URL)
    local dataTable = json.decode(response)

    if dataTable.mission == nil then
        print("No Dice")

    else
        image_sheet = dataTable.mission[1].mission_img
        mission_name = dataTable.mission[1].mission_name
        mission_exp = dataTable.mission[1].mission_exp
        chapter_id = dataTable.mission[1].chapter_id
        chapter_name = dataTable.mission[1].chapter_name
        print("++++++ chapter_name = ",chapter_name)
    end

end
-----------------------clear---------------------------------

function scene:createScene( event )
    --   print("before "..table.getn(playerDB.charac_def))
    ------------------------- connect REST serviced -------------------------
    groupGameLayer = display.newGroup()
    groupGameTop = display.newGroup()
    groupGameTop1 = display.newGroup()
    --gameoverFile()
    local group = self.view
    map_id = event.params.map_id
    mission_id = event.params.mission_id
    chapter_id = event.params.chapter_id

    Olddiamond = menu_barLight.diamond()


    local background = display.newImageRect( "img/background/bg_puzzle_test.tga", _W, _H )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    groupGameLayer:insert ( background )
    groupGameTop:insert ( groupGameTop1 )

    ------------------------- gemsTable -------------------------

    for i = 1, gemX, 1 do --- x
        gemsTable[i] = {}
        for j = 1, gemY, 1 do --- y
            gemsTable[i][j] = newGem(i,j)

        end
    end

    isGemTouchEnabled = false

    user_id = menu_barLight.user_id()
    mission(event)
    BGAnimation = display.newImageRect( image_sheet , display.contentWidth, 425 )
    BGAnimation:setReferencePoint( display.CenterReferencePoint )
    BGAnimation.x, BGAnimation.y = _W*.5, _H*.2
    groupGameTop:insert ( BGAnimation )
    miniIconCharac(event)

    hpPlayer = sumHP
    hpFull =  sumHP

    lifeline_sh = display.newImageRect( "img/other/life_short.png",fullLineHP,20) -- full 550
    lifeline_sh:setReferencePoint( display.TopLeftReferencePoint )
    pointStart = _W*.08
    lifeline_sh.x, lifeline_sh.y =  pointStart, _H*.422

    groupGameTop:insert ( lifeline_sh )

    lifeline = display.newImageRect( "img/other/life_line.png", 600, 30) -- 490
    lifeline:setReferencePoint( display.TopLeftReferencePoint )
    lifeline.x, lifeline.y = _W*.05, _H*.418
    physics.addBody( lifeline,"static", { bounce=0.5, density=1.0 ,friction = 0, shape=5 } )
    groupGameTop:insert ( lifeline )
--
    myPink = display.newText("0",0 , _H*.415,native.systemFontBold, 25)
    myPink.x= _W*.45
    myPink:setTextColor(255,52,179)
    myPink.alpha = 0
                -------------------------- HP value -------------------------

    textHP = display.newText(hpPlayer.."/"..hpFull,0 , _H*.417,native.systemFontBold,24)
    textHP:setReferencePoint( display.TopRightReferencePoint )
    textHP.x = _W*.95
    textHP:setTextColor(0, 255, 255)
    groupGameTop:insert ( textHP )

    createBackButton(event)
    createCharacter(event)



    checkdoubleOnload(event)

    groupGameTop:insert ( backButton )
    groupGameLayer:insert(groupGameTop)
    group:insert(groupGameLayer)


end -- end for scene:createScene

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

  

