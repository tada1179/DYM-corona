
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mRandom = math.random
local _W = display.contentWidth
local _H = display.contentHeight

local gemsTable = {}
local onGemTouch
local sizeGemY = _H*.1
local sizeGemX = _W*.15
local widthGemX = _W*.167--106
local widthGemY = _H*.11--106
local gemX, gemY = 6, 5
local stTableX, enTableX = 3, 636

local ballX = _W*.08    --52
local ballY = _H*.39    --373

local limitCountGemSlide = 4    ---- chk amount gems
local limitCountGem = 3    ---- chk amount gems
local groupGem = { 0, 0, 0, 0, 0, 0 }
local groupGemChk = { 0, 0, 0, 0, 0, 0 }
local gemToBeDestroyed
local spriteBeDestroyed
local isGemTouchEnabled = true
local countSlide = 0

--local channelX = {
--    54,   --1
--    160,  --2
--    266,  --3
--    372,  --4
--    478,  --5
--    584   --6
--}
local channelX = {
    1*widthGemX - ballX,   --1
    2*widthGemX - ballX,  --2
    3*widthGemX - ballX,  --3
    4*widthGemX - ballX,  --4
    5*widthGemX - ballX,  --5
    6*widthGemX - ballX   --6
}

--local channelY ={
--    479,  --1
--    585,  --2
--    691,  --3
--    797,  --4
--    903,  --5
--}

local channelY ={
    1*widthGemY + ballY,  --1
    2*widthGemY + ballY,  --2
    3*widthGemY + ballY,  --3
    4*widthGemY + ballY,  --4
    5*widthGemY + ballY,  --5
}


--local amountPlayer = 5 -- simple for test card input to mission
local state_main -- state
local teamPlayer = {}  --- pic, element, hp, protect, lv, power special, leader, power special
local playerDB  ={}  -- data for player
local teamComm={}
local commDB  ={}  -- data for computer
local posXch={10,115,220,325,430,535} ---- ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ£ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ°ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ¢ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ°ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ«ÃÂÃÂ ÃÂÃÂ¹ÃÂÃÂÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ²ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ

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


--** add function ---------------
local widget = require "widget"
local http = require("socket.http")
local json = require("json")
local physics = require( "physics" )
physics.start()
local countTouch = 0
--local background -- background
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
local image_sheetBG
local image_sheet
local BGAnimation
local Warning
local datacharcter = {}
local rowCharac = 0
local myAnimationSheet ={}
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
local mission_stamina = nil
local Maindiamond = nil
local Olddiamond = nil
local mission_coin = nil
local RandomDrop = {}
local teamNumber
-----------------
local Gdisplay = display.newGroup()
--  tada1179.w@gmail.com ---------------------------------------------------
local   picture = {"img/element/red_1.png","img/element/green_1.png","img/element/blue_1.png","img/element/purple.png","img/element/pink.png","img/element/yellow_1.png"}
local   picturePop = {"img/frameNo/1.png","img/frameNo/2.png","img/frameNo/3.png","img/frameNo/4.png","img/frameNo/5.png","img/frameNo/6.png"}

---------------------------------------------------------------------------------------------------
-----***** MENU ITEM & Setting *****------
--  tada1179.w@gmail.com -------------------------------
local myItem = {}
local rowItem
local img_blockPUZ
local TouchCount = 0
local getCharac_id = {}
local mydata = 0
local EFSpriteCount = 1
local tu = 1
local EFSpriteSheetPoint = {}
local gameoverFile_change = 0
----
local sheetdata_light_i = {
    {width = 512/2, height = 535/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4280/2 }  ,
    {width = 512/1.6, height = 535/1.6,numFrames = 40, sheetContentWidth =2560/1.6 ,sheetContentHeight =4280/1.6 }  ,
    {width = 512/2, height = 578/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4624/2 }  ,
    {width = 512/2, height = 504/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4032/2 }  ,
    {width = 512/2, height = 520/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4160/2 }  ,

}
local DeleteNumber =0
----
local defuatValue = function()
     RandomDrop = {}
     gemsTable = {}
     groupGem = { 0, 0, 0, 0, 0, 0 }
     groupGemChk = { 0, 0, 0, 0, 0, 0 }
     user_id  = nil
     backButton = nil
     bntItem   = nil
     characImage ={}
     Enemy_HP ={}
     Enemy_bar ={}
     TextCD ={}
     battleall = nil
     CountCharacterInBattle = nil
     point = nil
     damage = nil
     NN = 0
     pointStartEnemy_HP = {}
     pointStart  = nil
     lineFULLHP = 100

     character_numAll = 0
     image_char = {}

     BGM = 1
     SFX = 1
     SKL = 1
     BTN = 1
     sumHP = 0
     sumATK = 0
     sumDEF = 0
     textHP = nil
     countCombo = 0
     E = nil

     battle = 1
     mission = nil

     checkOption = 1

     colercharacter = nil
     maxIcon = 5
     myAnimation = nil
     BGsprite  = nil
     image_sheetBG = nil
     image_sheet  = nil
     BGAnimation = nil
     Warning  = nil
     datacharcter = {}
     rowCharac = 0
     myAnimationSheet ={}
     timerIMG  = nil

     textFlagImg = nil
     textCoinImg = nil

     NumExp = 0
     NumCoin = 0
     NumDiamond = 0
     NumFlag = 0
     flagimg = nil

     myNumber = {}
     myCount = {0,0,0,0,0,0}
     myPink = {}

    --Enemy
     hold_atk  =0

     BGdropPuzzle = nil
     friend = 0
end
----------------------------------------//
local function enablePuzzleTouch(obj)
    local groupView = display.newGroup()
    if obj == 1 then
        BGdropPuzzle = display.newRoundedRect(0, _H*.45, _W, _H*.55,0)
        BGdropPuzzle:setReferencePoint(display.TopLeftReferencePoint)
        BGdropPuzzle.strokeWidth = 0
        BGdropPuzzle.alpha = .8
        BGdropPuzzle:setFillColor(0 ,0 ,0)
        groupView:insert(BGdropPuzzle)
        groupView.touch = onTouchGameoverFileScreen
        groupView:addEventListener( "touch", groupView )
    else
        display.remove(BGdropPuzzle)
        BGdropPuzzle = nil
    end

end
local function SaveMissionClear()
    local grrop = display.newGroup()
    enablePuzzleTouch(2)
    cancelAllTimers()
    AllclearmyAnimationSheet()
    cancelAllTransitions()
    local netch = 1
    local levelUpChar = nil

    local stopSpin = function()


        if netch == 1 then
            SaveMissionClear()
        else
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
                    levelUpChar = levelUpChar,
                }
            }
            -------------------------------------
            storyboard.gotoScene("welcome3",option)

        end

    end
    local function networkListener(event)
        if ( event.isError ) then
            stopSpin()
        else
            netch = netch + 1
            levelUpChar = event.response
            stopSpin()
        end

    end
    local LinkOneCharac = "http://133.242.169.252/DYM/missionClear.php"
    local characterID =  LinkOneCharac.."?user_id="..user_id.."&mission_exp="..mission_exp.."&chapter_id="..chapter_id.."&mission_id="..mission_id.."&team_no="..teamNumber
    characterID = characterID.."&friend="..friend.."&NumCoin="..NumCoin.."&NumFlag="..NumFlag.."&diamond="..Olddiamond
    for i=1,NumFlag,1 do
        characterID = characterID.."&getCharac_id"..i.."="..getCharac_id[i]
    end
    network.request( characterID, "GET", networkListener )

end

local function clearmyAnimationSheet(myAnimationSheet)
    myAnimationSheet:removeSelf()
    myAnimationSheet = nil
end

function AllclearmyAnimationSheet()
    for a= 1 , 5 ,1 do
        display.remove(myAnimationSheet[a])
        myAnimationSheet[a] = nil
    end


end

local function onTouchGameoverFileScreen ( self, event )
    isGemTouchEnabled = false
    if event.phase == "began" then


        return true
    end
end
local function gameoverFile_Cancel()
    enablePuzzleTouch(2)
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
        gameoverFile_change = 0
        if event.target.id == "overFilecancel" then
            display.remove(groupViewgameoverFile_Cancel)
            groupViewgameoverFile_Cancel = nil

            gameoverFile()
        elseif event.target.id == "overFileOK" then

            cancelAllTimers()
            AllclearmyAnimationSheet()
            cancelAllTransitions()

            if flagimg[battle] then
                display.remove(flagimg[battle])
                flagimg[battle]= nil
            end

            local mmdiamond = Olddiamond - Maindiamond
            mmdiamond = mmdiamond +1
            local LinkURL = "http://133.242.169.252/DYM/leaveTicket.php"
            local characResetsert =  LinkURL.."?user_id="..user_id.."&NumFlag=0&NumDiamond="..mmdiamond.."&NumCoin=0&NumEXP=0"

            local complte = http.request(characResetsert)
            local newDatas = json.decode(complte)

            local path = system.pathForFile("datas.db", system.DocumentsDirectory)
            db = sqlite3.open( path )
            local tablefill ="UPDATE user SET user_diamond = '"..Olddiamond.."' WHERE user_id = '"..user_id.."';"
            db:exec( tablefill )
            require("menu").update_user()
            require("menu").ShowDisplay()
            storyboard.gotoScene("map_substate",option)
        end
        return true
    end
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupViewgameoverFile_Cancel:insert(myRectangle)
    groupViewgameoverFile_Cancel.touch = onTouchGameoverFileScreen
    groupViewgameoverFile_Cancel:addEventListener( "touch", groupViewgameoverFile_Cancel )

    local img_gameoverFile = "img/background/puzzle/game_over.png"
    local textimg_gameoverFile = display.newImageRect( img_gameoverFile, _W*.8,_H*.15 )
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


--    groupGameTop:insert(groupViewgameoverFile_Cancel)
    groupGameLayer:insert(groupViewgameoverFile_Cancel)



end
function gameoverFile()
    enablePuzzleTouch(2)
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
            gameoverFile_change = 0
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
        myRectangle:setReferencePoint(display.TopLeftReferencePoint)
        myRectangle.strokeWidth = 2
        myRectangle.alpha = .8
        myRectangle:setFillColor(0, 0, 0)
        groupViewgameoverFile:insert(myRectangle)
        groupViewgameoverFile.touch = onTouchGameoverFileScreen
        groupViewgameoverFile:addEventListener( "touch", groupViewgameoverFile )

        local img_gameoverFile = "img/background/puzzle/game_over.png"
        local textimg_gameoverFile = display.newImageRect( img_gameoverFile, _W*.8,_H*.15 )
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


        --groupGameTop:insert(groupViewgameoverFile)
        groupGameLayer:insert(groupViewgameoverFile)

        display.remove(BGdropPuzzle)
        BGdropPuzzle = nil

        cancelAllTimers()
        cancelAllTransitions()
        AllclearmyAnimationSheet()
    else
        gameoverFile_Cancel()
    end


end
local function enableGemTouch()
    isGemTouchEnabled = true

end

local function damageAttackEnemy()
    enablePuzzleTouch(2)
    local  battleIconcolor
    local clearbattleIconcolor = function (obj)
        cancelAllTransitions()

        display.remove(obj)
        obj = nil

        transitionStash.newTransition = transition.to( lifeline, { time=100, xScale=2, yScale=2,x= lifeline.x+10,y=lifeline.y-10, alpha=1})
        transitionStash.newTransition = transition.to( lifeline, { time=150,delay=50, xScale=1,x= lifeline.x,y=lifeline.y, yScale=1, alpha=1})

        if BGdropPuzzle ~= nil then
            transitionStash.newTransition = transition.to( BGdropPuzzle, { time=500,x= BGdropPuzzle.x+10,y=BGdropPuzzle.y-10, alpha=0.8})
            transitionStash.newTransition = transition.to( BGdropPuzzle, { time=550,delay=50, xScale=1,x= BGdropPuzzle.x,y=BGdropPuzzle.y, yScale=1, alpha=0.8})

        end
        if hpPlayer <= 0 and gameoverFile_change == 0 then
            gameoverFile_change = 1
            TimersST.myTimer = timer.performWithDelay(300,gameoverFile )
            return true
        end

    end
    local n = 1
    for i=1,CountCharacterInBattle,1 do
      -- getCharacterCoin(i)

        if characImage[i].hold_countD <= 0 and characImage[i].hold_hp > 0 then
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
            battleIconcolor:setReferencePoint(display.TopLeftReferencePoint)
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
end
-------------sprite-------------------------------------------
local function battle_Animation(timebattle,all,battleimg)
    enablePuzzleTouch(2)--clear battle befor

    if img_blockPUZ~= nil then
        display.remove(img_blockPUZ)
        img_blockPUZ = nil
    end

    local start = function()
        local groupView = display.newGroup()
        local myRectangle = display.newRoundedRect(0, _H*.45, _W, _H*.55,0)
        myRectangle:setReferencePoint(display.TopLeftReferencePoint)
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

--    local  myImageSheetFull = graphics.newImageSheet( "img/character/chara_full.png", sheetInfo:getSheet() )


    isGemTouchEnabled = false
    local i = battle
    while i <= battle do
        CountCharacterInBattle = tonumber(image_char[i].characAll)

        for k=1,image_char[i].characAll,1  do
            local imgCharacter = image_char[i][k].charac_img
--            characImage[k] = display.newImage(imgCharacter,true)
            characImage[k] = display.newImage( myImageSheetFull , sheetInfo:getFrameIndex(imgCharacter),true)


            if characImage[k].width ~= 1024 or characImage[k].height ~= 1024 then
                if characImage[k].width > characImage[k].height then
                    characImage[k].height = math.floor(characImage[k].height / (characImage[k].width/1024))
                    characImage[k].width = 1024
                else
                    characImage[k].width = math.floor(characImage[k].width / (characImage[k].height/1024))
                    characImage[k].height = 1024
                end
            end
            characImage[k].width = math.floor(characImage[k].width/image_char[i][k].charac_spw)
            characImage[k].height =  math.floor(characImage[k].height/image_char[i][k].charac_sph)

            characImage[k]:setReferencePoint( display.BottomCenterReferencePoint)
            characImage[k].x = (_W/(image_char[i].characAll+1))*k
            characImage[k].y = _H*.25
            characImage[k].id =k
            characImage[k].charac_id = image_char[i][k].charac_id
            characImage[k].hold_hp = tonumber(image_char[i][k].charac_hp)
            characImage[k].hold_atk = tonumber(image_char[i][k].charac_atk)

            characImage[k].hp = tonumber(image_char[i][k].charac_hp)
            characImage[k].atk = tonumber(image_char[i][k].charac_atk)
            characImage[k].color = tonumber(image_char[i][k].charac_element)
            characImage[k].countD = tonumber(image_char[i][k].charac_countD)
            characImage[k].hold_countD = tonumber(image_char[i][k].charac_countD)
            characImage[k].coin = tonumber(image_char[i][k].charac_coin)
            groupGameTop:insert(characImage[k])
            physics.addBody( characImage[k],"static", { density = 1.0, friction = 0, bounce = 0.2, radius = 20 } )

            local hpLine = (lineFULLHP*characImage[k].hold_hp)/characImage[k].hp

            Enemy_HP[k] = display.newImageRect( "img/background/frame/as_enemy_hp.png", 0, 15 )
            Enemy_HP[k].width =  hpLine
            Enemy_HP[k]:setReferencePoint( display.TopLeftReferencePoint)

            pointStartEnemy_HP[k]= math.ceil(_W/(image_char[i].characAll+1))*k -50
            Enemy_HP[k].x, Enemy_HP[k].y = pointStartEnemy_HP[k],_H*.27

            if image_char[i][k].charac_element == 1 then --red
                Enemy_HP[k]:setFillColor(1, 0 ,0)
            elseif image_char[i][k].charac_element == 2 then   --green
                Enemy_HP[k]:setFillColor(0.14, 0.71 ,0.14)
            elseif image_char[i][k].charac_element == 3 then   --blue
                Enemy_HP[k]:setFillColor( 	 0, 0.19, 1)
            elseif image_char[i][k].charac_element == 4 then   --purple
                Enemy_HP[k]:setFillColor(1 ,0, 1 )
            elseif image_char[i][k].charac_element == 5 then  --yellow
                Enemy_HP[k]:setFillColor( 1 ,0.21, 0)
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
            TextCD[k]:setFillColor(0 ,0.79 ,0.79)
            groupGameTop:insert(TextCD[k])



        end
        i = i+1

    end

    isGemTouchEnabled = true

end
local function createItem()

    local Linkmission = "http://133.242.169.252/DYM/item.php"
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
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 0
    myRectangle.alpha = .8
    myRectangle:setFillColor(0 ,0 ,0)
    groupGameLayer:insert(myRectangle)
    groupGameLayer.touch = onTouchGameoverFileScreen
    groupGameLayer:addEventListener( "touch", groupGameLayer )

    local sheetdata_light = {width = 640, height = 425,numFrames = 75, sheetContentWidth = 3200 ,sheetContentHeight = 6375 }
    local image_sheet = {
        "Victory_Animation_aura.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1],system.DocumentsDirectory, sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=5500, loopCount=1 }

    local Victory_aura = display.newSprite( sheet_light, sequenceData )
    Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura.x = 0
    Victory_aura.y = 0
    local function FNVictory_aura()
        Victory_aura:setSequence( "lightaura" )
        Victory_aura:play()
    end
    local ClearVictory_aura = function()
        if TimersST.myaura then
            timer.cancel(TimersST.myaura)
            TimersST.myaura = nil
        end


        display.remove(myRectangle)
        myRectangle = nil

        display.remove(Victory_aura)
        Victory_aura = nil
    end
    groupGameLayer:insert(Victory_aura)
    TimersST.myaura = timer.performWithDelay(0,FNVictory_aura )
    TimersST.myaura = timer.performWithDelay(5500,ClearVictory_aura )

    return true

end
local function Victory_Animation_font()
    local sheetdata_light = {width = 640, height = 425,numFrames = 75, sheetContentWidth = 3200 ,sheetContentHeight = 6375 }
    local image_sheet = {
        "Victory_Animation_font.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1] ,system.DocumentsDirectory, sheetdata_light )
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
    local myAnimation = display.newImageRect( image_sheetBG , display.contentWidth, _H*.445 )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint )
    myAnimation.x, myAnimation.y = 0,0
    groupGameTop1:insert(myAnimation)
    local k = 1
    local i = 0
    local j = 0
    local function finish()
        display.remove(myAnimation)
        myAnimation = nil

        cancelAllTimers()
        cancelAllTransitions()
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

end

local function BossSprite()
    isGemTouchEnabled = false
    local function flash()
        local sheetdata_light = {width = 640, height = 425,numFrames = 40, sheetContentWidth = 3200 ,sheetContentHeight = 3400 }
        local image_sheet = {
            "Boss_Effect_flash.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1] ,system.DocumentsDirectory, sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2500, loopCount=1 }
        }
        local CoinSheetBoss = display.newSprite( sheet_light, sequenceData )
        CoinSheetBoss:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheetBoss.x = _W*.5
        CoinSheetBoss.y = _H*.35

        local function clearSheetBoss()
            isGemTouchEnabled = true
            display.remove(CoinSheetBoss)
            CoinSheetBoss = nil
        end
        local function swapSheetBoss()
            CoinSheetBoss:setSequence( "sheet" )
            CoinSheetBoss:play()
            timerIMG = nil

        end
        TimersST.myTimer =  timer.performWithDelay( 1000, swapSheetBoss )
        transitionStash.newTransition = transition.to( CoinSheetBoss, { time=3500,  alpha=1,onComplete = clearSheetBoss} )

    end
    local function thunder()
        local sheetdata_light = {width = 640, height = 425,numFrames = 30, sheetContentWidth = 3200 ,sheetContentHeight = 2550 }
        local image_sheet = {
            "Boss_Effect_thunder.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1] ,system.DocumentsDirectory, sheetdata_light )
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
            "Boss_Effect_ground.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1] ,system.DocumentsDirectory, sheetdata_light )
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
end
local function Warning_Animation()
    isGemTouchEnabled = false
    local groupView = display.newGroup()
    local myRectangle = display.newRoundedRect(0, _H*.45, _W, _H*.55,0)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)
    groupView.touch = onTouchGameoverFileScreen
    groupView:addEventListener( "touch", groupView )

    local sheetdata_light = {width = 640, height = 225,numFrames = 40, sheetContentWidth = 3200 ,sheetContentHeight = 1800 }
    local image_sheet = {
        "Warning_Animation_spritesheet.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1],system.DocumentsDirectory, sheetdata_light )
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
    transitionStash.newTransition = transition.to( Warning, { time=4000 , alpha=1,  onComplete=callBoss } )


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
                    user_id = user_id ,
                    getCharac_id = getCharac_id,
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
                    user_id = user_id ,
                    getCharac_id = getCharac_id
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
    txtcoin:setReferencePoint(display.TopLeftReferencePoint)
    txtcoin:setFillColor(0, 1, 0)
    txtcoin.text =  string.format("Coin")
    txtcoin.alpha = 1
    groupView:insert(txtcoin)
    local numCoin = display.newText(NumCoin, pointnum, _H*.40, typeFont, sizetext)
    numCoin:setReferencePoint(display.TopLeftReferencePoint)
    numCoin:setFillColor(0, 1, 0)
    numCoin.text =  string.format(NumCoin)
    numCoin.alpha = 1
    groupView:insert(numCoin)

    local txtflag = display.newText("FLAG", pointtxt, _H*.5, typeFont, sizetext)
    txtflag:setReferencePoint(display.TopLeftReferencePoint)
    txtflag:setFillColor(0, 1, 0)
    txtflag.text =  string.format("FLAG")
    txtflag.alpha = 1
    groupView:insert(txtflag)
    local numFlag = display.newText(NumFlag, pointnum, _H*.5, typeFont, sizetext)
    numFlag:setReferencePoint(display.TopLeftReferencePoint)
    numFlag:setFillColor(0, 1, 0)
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
    txtBGM:setReferencePoint(display.TopLeftReferencePoint)
    txtBGM:setFillColor(0, 0.2, 0)
    txtBGM.text =  string.format("BGM")
    txtBGM.alpha = 1
    groupView:insert(txtBGM)

    local txtSFx = display.newText("SFx", pointtxt, _H*.48, typeFont, sizetext)
    txtSFx:setReferencePoint(display.TopLeftReferencePoint)
    txtSFx:setFillColor(0, 0.2, 0)
    txtSFx.text =  string.format("SFx")
    txtSFx.alpha = 1
    groupView:insert(txtSFx)

    local txtSkill = display.newText("Skill Confirmation", pointtxt, _H*.56, typeFont, sizetext)
    txtSkill:setReferencePoint(display.TopLeftReferencePoint)
    txtSkill:setFillColor(0, 0.2, 0)
    txtSkill.text =  string.format("Skill Confirmation")
    txtSkill.alpha = 1
    groupView:insert(txtSkill)

    local txtBattle = display.newText("Battle Notification", pointtxt, _H*.64, typeFont, sizetext)
    txtBattle:setReferencePoint(display.TopLeftReferencePoint)
    txtBattle:setFillColor(0, 0.2, 0)
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
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
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
    NameMission:setReferencePoint(display.TopLeftReferencePoint)
    NameMission:setFillColor(0, 0.2, 0)
    NameMission.text =  string.format(mission_name)
    NameMission.alpha = 1
    groupView:insert(NameMission)

    local  NameBattle = display.newText(battle, _W*.5, _H*.4, typeFont, sizetext)
    NameBattle:setReferencePoint(display.TopLeftReferencePoint)
    NameBattle:setFillColor(0.2, 0.2, 0.2)
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

    btncancel.alpha = 1
    btncancel.x = _W*.37
    btncancel.y = _H*.8
    groupView:insert(btncancel)

    groupView.touch = onTouchGameoverFileScreen
    groupView:addEventListener( "touch", groupView )

    return option

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
    backButton.alpha = 1
    backButton.x = _W - (_W*.12)
    backButton.y = 0

    --groupGameLayer:insert(backButton)

    flagimg = display.newImageRect( "img/background/puzzle/FLAG.png", _W*.05, _H*.04 )
    flagimg.x, flagimg.y = _W*.03, 0
    groupGameTop:insert(flagimg)

    textFlagImg = display.newText(NumFlag,0 , 0,native.systemFontBold,25)
    textFlagImg.x = _W*.15
    textFlagImg:setFillColor(0, 0 ,1)
    groupGameTop:insert ( textFlagImg )


    local CoinImg = display.newImageRect( "img/background/puzzle/COIN.png", _W*.05, _H*.03 )
    CoinImg.x, CoinImg.y = _W*.2, 0
    groupGameTop:insert(CoinImg)

    textCoinImg = display.newText(NumCoin,0 , 0,native.systemFontBold,25)
    textCoinImg.x = _W*.3
    textCoinImg:setFillColor(0, 0 ,1)
    groupGameTop:insert ( textCoinImg )

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

--    newGem = display.newImageRect(picture[R],sizeGem,sizeGem)
    newGem = display.newImageRect(picture[R],sizeGemX,sizeGemY)

    newGem.x = i * widthGemX - ballX
    newGem.y = j * widthGemY + ballY

    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = false
    newGem.isMarkedToDestroy = false

    newGem.destination_y = j * widthGemY + ballY --newGem.y


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
    if countTouch == 0 then
        newGem.alpha = 0
    end

    newGem.touch = onGemTouch
    newGem:addEventListener( "touch", newGem )

    return newGem
end
local function newGemPop (i,j,num)
    local R = num
    local newGem

    --    newGem = display.newImageRect(picture[R],sizeGem,sizeGem)
    newGem = display.newImageRect(picturePop[R],sizeGemX,sizeGemY)

    newGem.x = i * widthGemX - ballX
    newGem.y = j * widthGemY + ballY

    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = true
    newGem.isMarkedToDestroy = true

    newGem.destination_y = j * widthGemY + ballY --newGem.y


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
    if countTouch == 0 then
        newGem.alpha = 0
    end

    newGem.touch = onGemTouch
    newGem:addEventListener( "touch", newGem )

    return newGem
end

function copyGem(self,event)
    --    print("copyGem(self,event)  ")
    --    print("pointXY :"..gemsTable[self.i][self.j].i,gemsTable[self.i][self.j].j)
    copyGemXR, copyGemXL, copyGemYU, copyGemYD = {}, {}, {}, {}
    intervalGemx = sizeGemX + 8
    intervalGemy = sizeGemY + 8
    ------ ---  -- - chk event  -Right  -Left  -Up  -Down----
    rotateR = gemX + 1
    for R = 1, gemX, 1 do
        --        copyGemX[R] = gemsTable[R][self.j].colorR
        --        print("color :"..gemsTable[R][self.j].gemType, copyGemX[R])
        copyGemXR[R] = display.newImageRect(picture[gemsTable[R][self.j].colorR],sizeGemX,sizeGemY)
        copyGemXR[R].x, copyGemXR[R].y  = enTableX + (intervalGemx * R), gemsTable[gemX][self.j].markY

        copyGemXL[R] = display.newImageRect(picture[gemsTable[rotateR - R][self.j].colorR],sizeGemX,sizeGemY)
        copyGemXL[R].x, copyGemXL[R].y  = stTableX - (intervalGemx * R), gemsTable[gemX][self.j].markY

        groupGameLayer:insert( copyGemXR[R] )
        groupGameLayer:insert( copyGemXL[R] )
    end

    stTableY, enTableY = 400, 903
    stTableY, enTableY =   widthGemY - ballY,  (gemY+1) * widthGemY + ballY --newGem.y
    rotateC = gemY + 1
    for C = 1, gemY, 1 do
        copyGemYU[C] = display.newImageRect(picture[gemsTable[self.i][C].colorR],sizeGemX,sizeGemY)
        copyGemYU[C].x, copyGemYU[C].y  = gemsTable[self.i][gemY].markX, enTableY + (intervalGemy * C)

        copyGemYD[C] = display.newImageRect(picture[gemsTable[self.i][rotateC - C].colorR],sizeGemX,sizeGemY)
        copyGemYD[C].x, copyGemYD[C].y  = gemsTable[self.i][gemY].markX, stTableY - (intervalGemy * C)

        groupGameLayer:insert( copyGemYD[C] )
        groupGameLayer:insert( copyGemYU[C] )

    end

    groupGameLayer:insert( groupGameTop )
end

function pasteGem(self, event)
    isGemTouchEnabled = false
--    print("chkFtPosit:",self.chkFtPosit)
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

        if(positEn > (6 * widthGemX - ballX -ballX) ) then
            slideL = 0
            slideR = 1
        elseif (positEn > (5 * widthGemX - ballX -ballX)  and positEn < (6 * widthGemX - ballX -ballX) ) then
            slideL = 5
            slideR = 1
        elseif (positEn > (4 * widthGemX - ballX -ballX)  and positEn < (5 * widthGemX - ballX -ballX) ) then
            slideL = 4
            slideR = 2
        elseif (positEn > (3 * widthGemX - ballX -ballX)  and positEn < (4 * widthGemX - ballX -ballX) ) then
            slideL = 3
            slideR = 3
        elseif (positEn > (2 * widthGemX - ballX -ballX)  and positEn < (3 * widthGemX - ballX -ballX) ) then
            slideL = 2
            slideR = 4
        else-- R to L only
            slideL = 1
            slideR = 5
        end

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

            gemsTable[posX][self.j] = display.newImageRect(picture[color],sizeGemX,sizeGemY)
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

        if(positEn > (5 * widthGemY + ballY -ballX) ) then
            slideU = 0
            slideD = 1
        elseif (positEn > (4 * widthGemY + ballY -ballX) and positEn < (5 * widthGemY + ballY -ballX)) then
            slideU = 4
            slideD = 1
        elseif (positEn > (3 * widthGemY + ballY -ballX) and positEn < (4 * widthGemY + ballY -ballX)) then
            slideU = 3
            slideD = 2
        elseif (positEn > (2 * widthGemY + ballY -ballX) and positEn < (3 * widthGemY + ballY -ballX)) then
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

            gemsTable[self.i][posY] = display.newImageRect(picture[color],sizeGemX,sizeGemY)
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

end

function slideGem(self,event)

    -- print(self.chkFtPosit)
    event.phase = "move"
    if(self.chkFtPosit == "x") then -- -- -- -- -- slide X           
        if ( lineY ~=nil) then
            lineY:removeSelf()
            lineY= nil
        end

        self.slideEvent = (event.x - event.xStart)

        -- gemsTable[][].j :: gemsTable[][].i == point self // gemsTable[self.i][self.j] == data self VIP
--        if(gemsTable[self.i][self.j].x <=  ((1*widthGemX - ballX ) /2)or gemsTable[self.i][self.j].x >= 620) then     --  jump end dont move
        if(gemsTable[self.i][self.j].x <=  ((1*widthGemX - ballX ) /2)or gemsTable[self.i][self.j].x >= (6*widthGemX - ballX +(sizeGemX/2))) then     --  jump end dont move
            pasteGem(self,event)
            event.phase = "ended"
        else

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
--        if(gemsTable[self.i][self.j].y <= 455 or gemsTable[self.i][self.j].y >= 940) then        --  jump end dont move
--        if(gemsTable[self.i][self.j].y <= _H*.5 or gemsTable[self.i][self.j].y >= _H*.98) then        --  jump end dont move
        if(gemsTable[self.i][self.j].y <= (1 * widthGemY + ballY - (sizeGemY/2)) or gemsTable[self.i][self.j].y >= (5 * widthGemY + ballY + (sizeGemY/2))) then        --  jump end dont move
            pasteGem(self,event)
            event.phase = "ended"
        else

            for posY = 1, gemY, 1 do
                if gemsTable[self.i][posY].i == self.y then     -- self gem pos               
                    gemsTable[self.i][posY].y = self.markY + self.slideEvent
                else
                    gemsTable[self.i][posY].y = gemsTable[self.i][posY].markY + self.slideEvent
                end

                stTableY, enTableY = 853, 530

                stTableY, enTableY =   _H*.89,  _H*.56
                copyGemYU[posY].x = gemsTable[self.i][posY].markX--
                copyGemYU[posY].y = enTableY + gemsTable[self.i][posY].markY + self.slideEvent

                copyGemYD[posY].x = gemsTable[self.i][posY].markX
                copyGemYD[posY].y = stTableY - gemsTable[self.i][posY].markY + self.slideEvent
            end
        end
    end
    return event.phase

end

function textNumber()
    local num = 0
    for k = 1 ,rowCharac,1 do
        myNumber[k] = display.newText(num,0 , _H*.35,native.systemFontBold, 25)
        myNumber[k].x= datacharcter[k].poinCenter
        myNumber[k]:setFillColor(1, 1, 1)
        myNumber[k].alpha = 0
        myNumber[k].team_no = nil
    end

    myPink = display.newText(num,0 , _H*.415,native.systemFontBold, 25)
    myPink.x= _W*.45
    myPink.alpha = 0

--    TimersST.timerCountBoom = timer.performWithDelay(200,enableGemTouch)
   enableGemTouch()
end

local function deleteHP_Defense(colercharacter,atk)  --ÃÂ ÃÂ¸ÃÂªÃÂ ÃÂ¸ÃÂµÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂ­ÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂ±ÃÂ ÃÂ¸ÃÂ§ÃÂ ÃÂ¹ÃÂÃÂ ÃÂ¸ÃÂ£ÃÂ ÃÂ¸ÃÂ²ÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂµÃÂ ÃÂ¹ÃÂÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂ°ÃÂ ÃÂ¸ÃÂ­ÃÂ ÃÂ¸ÃÂ­ÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¹ÃÂÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂ¢ÃÂ ÃÂ¸ÃÂ´ÃÂ ÃÂ¸ÃÂ
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
    damage = (((atk* S) +0  ) /(E - R) ) + ((atk * (NN/30)) *((countCombo +1)/2))
end

local function ClearNumber2()
    isGemTouchEnabled = false
    hold_atk = {0,0,0,0,0 }

    local intBG = 0
    mydata = 0
    EFSpriteCount = 0
    local j = 0

    for k = 1 ,rowCharac,1 do
        if myNumber[k].team_no then
            mydata = mydata + 1
        else

        end

    end
    local function CheckBoom()
        isGemTouchEnabled = false
        local function timerCountBoom()
            if EFSpriteCount < mydata and TouchCount~=0 and CountCharacterInBattle >0 then

                j = j + 1
               if myNumber[j].team_no ~= nil  then
                   EFSpriteCount = EFSpriteCount +1
                   if EFSpriteCount == 1 then
                       isGemTouchEnabled = false
                       enablePuzzleTouch(EFSpriteCount)
                   end

                   deleteHP_Defense(myNumber[j].color,datacharcter[j].atk )
                   hold_atk[point] = hold_atk[point] + damage
                   battleIcon(myNumber[j].team_no,point,myNumber[j].color,damage,j)
                  -- getCharacterCoin(point)

                   if DeleteNumber == 1 then
                       display.remove(TextCD[CountCharacterInBattle+1])
                       TextCD[CountCharacterInBattle+1] = nil

                       display.remove(characImage[CountCharacterInBattle+1])
                       characImage[CountCharacterInBattle+1] = nil

                       display.remove(Enemy_bar[CountCharacterInBattle+1])
                       Enemy_bar[CountCharacterInBattle+1] = nil

                       display.remove(Enemy_HP[CountCharacterInBattle+1])
                       Enemy_HP[CountCharacterInBattle+1] = nil

                       DeleteNumber = 0
                   end


                   display.remove(myNumber[j])
                   myNumber[j] = nil
               else
               end
            elseif EFSpriteCount < mydata and TouchCount~=0 and CountCharacterInBattle == 0 then
                j = j + 1
                if myNumber[j].team_no ~= nil  then
                    display.remove(myNumber[j])
                    myNumber[j] = nil

                    EFSpriteCount = EFSpriteCount +1
                    if EFSpriteCount == 1 then
                        enablePuzzleTouch(intBG)
                    end
                    isGemTouchEnabled = false
                end
            else
                CheckBoom()

            end
        end
        if EFSpriteCount < mydata and TouchCount~=0 and CountCharacterInBattle >0 then
            isGemTouchEnabled = false
            TimersST.timerCountBoom = timer.performWithDelay(200,timerCountBoom,0)
        else
            isGemTouchEnabled = false
            damageAttackEnemy()
            if TimersST.timerCountBoom then
                timer.cancel(TimersST.timerCountBoom)
                TimersST.timerCountBoom = nil

            end

            display.remove(myPink)
            myPink = nil

            textNumber()


            NN = 0
            countCombo = 0
        end
    end

    CheckBoom()
end
local function PopNumIconCharacter(color,countColor)
        NN = countColor
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
                local myCountDEF = math.ceil(sumDEF*(countColor/30)*((countCombo+2)/2) )
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


                lifeline_sh.x = pointStart

                textHP.text = string.format(hpPlayer.."/"..hpFull )
                textHP.x = _W*.95
           else

                for i = 1 ,rowCharac,1 do

                    if datacharcter[i].element == 1 and color == "RED" then --RED
                        --                print("RED")
                        myNumber[i].alpha = 1
                        myNumber[i].color = datacharcter[i].element
                        myNumber[i].team_no = datacharcter[i].team_no
                        myCount[i] = myCount[i] +math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+1)/2))
                        myNumber[i].text = string.format(myCount[i] )
                        myNumber[i]:setFillColor(1, 0 ,0)
                        transitionStash.newTransition = transition.to( myNumber[i], { time=500, alpha=1,  xScale=1.5, yScale = 1.5} )

                    elseif datacharcter[i].element == 2 and color == "GREEN" then --GREEN
                        --                print("GREEN")
                        myNumber[i].alpha = 1
                        myNumber[i].color = datacharcter[i].element
                        myNumber[i].team_no = datacharcter[i].team_no
                        myCount[i] = myCount[i] + math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+1)/2))
                        myNumber[i].text = string.format(myCount[i] )
                        myNumber[i]:setFillColor( 0 ,1, 0)
                        transitionStash.newTransition = transition.to( myNumber[i], { time=500, alpha=1,  xScale=1.5, yScale = 1.5} )

                    elseif datacharcter[i].element == 3 and color == "BLUE" then --BLUE
                        --                print("BLUE")
                        myNumber[i].alpha = 1
                        myNumber[i].color = datacharcter[i].element
                        myNumber[i].team_no = datacharcter[i].team_no
                        myCount[i] = myCount[i] +math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+1)/2))
                        myNumber[i].text = string.format(myCount[i] )
                        --                myNumber[i]:setFillColor(30 ,144 ,255)
                        myNumber[i]:setFillColor(0.152 ,0.245, 1)
                        transitionStash.newTransition = transition.to( myNumber[i], { time=500, alpha=1, xScale=1.5, yScale = 1.5} )

                    elseif datacharcter[i].element == 4 and color == "PURPLE" then --PURPLE
                        --                print("PURPLE")
                        myNumber[i].alpha = 1
                        myNumber[i].color = datacharcter[i].element
                        myNumber[i].team_no = datacharcter[i].team_no
                        myCount[i] = myCount[i] + math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+1)/2))
                        myNumber[i].text = string.format(myCount[i] )
                        myNumber[i]:setFillColor(1 ,0 ,1)
                        transitionStash.newTransition = transition.to( myNumber[i], { time=500, alpha=1,  xScale=1.5, yScale = 1.5} )

                    elseif datacharcter[i].element == 5 and color == "YELLOW" then --YELLOW
                        --                print("YELLOW")
                        myNumber[i].alpha = 1
                        myNumber[i].color = datacharcter[i].element
                        myNumber[i].team_no = datacharcter[i].team_no
                        myCount[i] = myCount[i] +math.ceil(datacharcter[i].atk * (countColor/4)*((countCombo+1)/2))
                        myNumber[i].text = string.format(myCount[i] )
                        myNumber[i]:setFillColor(1, 1, 0)
                        transitionStash.newTransition = transition.to( myNumber[i], { time=500, alpha=1,  xScale=1.5, yScale = 1.5} )

                    end

                end
            end

        end
    end

end
local function shiftGems ()
    print("shiftGems")
    isGemTouchEnabled = true
    for i = 1, gemX, 1 do
        if gemsTable[i][1].isMarkedToDestroy then
            gemToBeDestroyed = gemsTable[i][1]

            gemsTable[i][1] = newGem(i,1)
            --gemsTable[i][1]:scale(.16,.16)
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
                    gemsTable[i][k].destination_y = gemsTable[i][k].destination_y + widthGemY
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
    TimersST.myTimer = timer.performWithDelay( 0, checkdoubleAll )


end
local function destroyGems()
    lockGemMutiChk = true
    local color
    local num =nil
    local displayGetdate =nil
    local countColor = {0,0,0,0,0,0 }
    local count = 0
    for i = 1, gemX, 1 do
        for j = 1, gemY, 1 do

            if gemsTable[i][j].isMarkedToDestroy  then
                count = count +1
                color = gemsTable[i][j].gemType
                if color == "PINK" then
                    num = 6
                    countColor[num] = countColor[num] + 1
                elseif color == "RED" then
                    num = 1
                    countColor[num] = countColor[num] + 1
                elseif color == "GREEN" then
                    num = 2
                    countColor[num] = countColor[num] + 1
                elseif color == "BLUE" then
                    num = 3
                    countColor[num] = countColor[num] + 1
                elseif color == "PURPLE" then
                    num = 4
                    countColor[num] = countColor[num] + 1
                elseif color == "YELLOW" then
                    num = 5
                    countColor[num] = countColor[num] + 1
                end
                displayGetdate = gemsTable[i][j]
                gemsTable[i][j] = newGemPop(i,j,num)
                gemsTable[i][j]:setStrokeColor(140, 140, 140)
                gemsTable[i][j].strokeWidth = 7
                gemsTable[i][j]:setFillColor(150)

                isGemTouchEnabled = false

                countCombo = math.floor(count/4)
                PopNumIconCharacter(color,countColor[num])

                display.remove(displayGetdate)
                displayGetdate = nil
--                transitionStash.newTransition = transition.to( gemsTable[i][j], { time=300, alpha=0.1, xScale=2, yScale = 2} )
            end
        end
    end

--    PopNumIconCharacter(color,countColor)
    TimersST.myTimer = timer.performWithDelay( 500, shiftGems ) -- 3 sce

    for  pt = 1 , 6 , 1 do
        groupGem[pt] =0
    end

    lockGemMuti = 0
end
local function cleanUpGems()
    --    print("Cleaning Up Gems")
    isGemTouchEnabled = true -- edited
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
    isGemTouchEnabled = false
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
    isGemTouchEnabled = false
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
    number[i].x, number[i].y = stHp, y
    groupGameTop:insert ( number[i] )
end
function checkdoubleAll()
    isGemTouchEnabled = false
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
        if countTouch == 0 then
            for i = 1,gemX,1 do
                for j = 1,gemY,1 do
                    gemsTable[i][j].alpha =1
                end
            end
            native.setActivityIndicator( false )
        end


--        transitionStash.newTransition = transition.to( myNumber[1], { time=300, alpha=0, xScale=2, yScale = 2,onComplete = ClearNumber2})
        cleanUpGems()
    end

end

function onGemTouch( self, event )	-- was pre-declared
    local stHp, si =590, 20
    local posX =0
    local posY =0
    local pathY =0
    local pathX =0
    countTouch = 1
    if event.phase == "began" and isGemTouchEnabled == true  then

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

        widhtLineY, widhtLineX = _H*.55, _W
        sizeLineStY, sizeLineStX = _H*.725, _W*.5

        lineY = display.newImageRect("img/bar_twin_v.png",_W*.18,widhtLineY)
        lineY.x, lineY.y = self.markX, sizeLineStY

        lineX = display.newImageRect("img/bar_twin_h.png", widhtLineX, _H*.12)
        lineX.x, lineX.y = sizeLineStX, self.markY
        copyGem(self, event)
        self.chkFtPosit = ""
    elseif self.isFocus then

        if event.phase == "moved" and isGemTouchEnabled == true then
            posX = (event.x - event.xStart) + self.markX
            posY = (event.y - event.yStart) + self.markY
            pathY = event.y-event.yStart
            pathX = event.x-event.xStart

            --                 print("posX ".. posX.." posY ".. posY.." pathX ".. pathX.." pathY ".. pathY )
            --                 print ("event.xStart ".. event.xStart.. " event.x "..event.x.." self.markX ".. self.markX)
            local speedX = posX - self.markX
            if ( posY  == self.markY or ( posY-self.markY > -20 and posY-self.markY < 20)) and ( posX == self.markX or ( posX-self.markX > -20 and posX-self.markX < 20 )) then
                posY = self.markY
                posX = self.markX
                self.chkFtPosit = ""

                display.remove(lineY)
                lineY = nil
                display.remove(lineX)
                lineX = nil

                lineY = display.newImageRect("img/bar_twin_v.png",_W*.18,widhtLineY)
                lineY.x, lineY.y = self.markX, sizeLineStY

                lineX = display.newImageRect("img/bar_twin_h.png", widhtLineX, _H*.12)
                lineX.x, lineX.y = sizeLineStX, self.markY

                for  i = 1 ,gemX, 1 do
                    for  j = 1 , gemY, 1 do
                        gemsTable[i][j].colorR = gemsTable[i][j].color   --- - -- - copy gem
                        gemsTable[i][j].x = gemsTable[i][j].markX
                        gemsTable[i][j].y = gemsTable[i][j].markY
                    end
                end

                --elseif ( (posY >= self.markY+10 or posY <= self.markY - 20  ) and ( posX > self.markX or posX < self.markX ) and self.chkFtPosit =="" ) then -- move X
            elseif (( posX >= self.markX+20 or posX <= self.markX-20  ) and ( posY-self.markY >= -20 or posY-self.markY <=20 ) and self.chkFtPosit ==""  ) then -- move Y               
                posX = event.x
                posY = self.markY

                self.chkFtPosit ="x"
                --            elseif ( posX == self.markX or self.chkFtPosit == "y"  ) then -- move Y
                --elseif (( posX >= self.markX+10 or posX <= self.markX+10 ) and ( posY > self.markY or posY < self.markY ) and self.chkFtPosit ==""  ) then -- move Y
            elseif ( (posY >= self.markY+20 or posY <= self.markY-20) and ( posX-self.markX >= -20 or posX-self.markX <=20 ) and self.chkFtPosit =="" ) then -- move X    
                posX = self.markX
                posY = event.y

                self.chkFtPosit ="y"

                --          print( "posX == self.markX   moveY")
            elseif self.chkFtPosit =="x" then
                posX = event.x
                posY = self.markY
                self.chkFtPosit ="x"

            elseif self.chkFtPosit =="y" then
                posX = self.markX
                posY = event.y

                self.chkFtPosit ="y"

            else
                if (pathX + 10 < pathY  and self.chkFtPosit =="" ) then -- move Y
                    posX = self.markX-- move Y
                    posY = event.y
                    --        print("|yyyy"..pathY,pathX)
                    self.chkFtPosit ="y"
                    --                   local myText = display.newText(pathY.."!"..pathX, 0, 0, native.systemFont, 100)
                    --                    myText:setFillColor(0, 0, 0)

                else--if (pathY > pathX  and self.chkFtPosit =="") then
                    posX = event.x
                    posY = self.markY
                    --       print("|xxxx"..pathY,pathX)
                    self.chkFtPosit ="x"
                    --else
                    --          print("sssssssss sss sss s ss ")
                end

            end

            self.x, self.y = posX, posY
            --            print("x:"..posX.."selfX:"..self.x.." y:"..posY.."selfY:"..self.y,"chkFtPosit:"..self.chkFtPosit)
            --print("slide "..gemsTable[6][self.j].x)

            event.phase =   slideGem(self,event)  --- old

             if event.phase == "ended" then

                 local ch_CD = 0
                 for i=1,CountCharacterInBattle,1 do

                     characImage[i].hold_countD = characImage[i].hold_countD -1
                     if characImage[i].hold_countD ~= 0 then
                         TextCD[i].text =  string.format("CD:"..characImage[i].hold_countD)
                     else
                         isGemTouchEnabled = false
                     end
                 end

                 checkdoubleAll()

             end


        elseif event.phase == "ended" or event.phase == "cancelled" then

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

            checkdoubleAll()

        else
            isGemTouchEnabled = false
        end
    end
    return true
    -- end
end
-----------------------clear---------------------------------

function scene:createScene( event )
   defuatValue()
   countSlide = 0
    groupGameLayer = display.newGroup()
    groupGameTop = display.newGroup()
    groupGameTop1 = display.newGroup()
    --gameoverFile()
    local group = self.view

    local background1 = display.newImageRect( "img/bg_puzzle_test.png", _W, _H )
    background1.anchorX = 0
    background1.anchorY = 0
    background1.x, background1.y = 0, 0

    groupGameLayer:insert ( background1 )
    groupGameTop:insert ( groupGameTop1 )

    ------------------------- gemsTable -------------------------
   native.setActivityIndicator( true )
    for i = 1, gemX, 1 do --- x
        gemsTable[i] = {}
        for j = 1, gemY, 1 do --- y
            gemsTable[i][j] = newGem(i,j)

        end
    end
    checkdoubleAll()
    hpPlayer = sumHP
    hpFull =  sumHP

    lifeline_sh = display.newImageRect( "img/life_short.png",fullLineHP,20) -- full 550
    pointStart = _W*.08
    lifeline_sh.x, lifeline_sh.y =  pointStart, _H*.422

    groupGameTop:insert ( lifeline_sh )

    lifeline = display.newImageRect( "img/life_line.png", 600, 30) -- 490
    lifeline.x, lifeline.y = _W*.05, _H*.418
    physics.addBody( lifeline,"static", { bounce=0.5, density=1.0 ,friction = 0, shape=5 } )
    groupGameTop:insert ( lifeline )
    --
    myPink = display.newText("0",0 , _H*.415,native.systemFontBold, 25)
    myPink.x= _W*.45
    myPink:setFillColor(1,0.52,0.18)
    myPink.alpha = 0
    -------------------------- HP value -------------------------

    textHP = display.newText(hpPlayer.."/"..hpFull,0 , _H*.417,native.systemFontBold,24)
    textHP.x = _W*.95
    textHP:setFillColor(0, 1, 1)
    groupGameTop:insert ( textHP )
    groupGameLayer:insert(groupGameTop)
    group:insert(groupGameLayer)

end -- end for scene:createScene

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "teamselectView" )
    storyboard.purgeScene( "team_select" )
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

  

