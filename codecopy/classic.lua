
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mRandom = math.random
local _W = display.contentWidth
local _H = display.contentHeight

local gemsTable = {}
local picture = { "img/element/red.png",        --- 1
    "img/element/green.png",    ---2
    "img/element/blue.png",      ---3
    "img/element/purple.png",   ---4
    "img/element/pink.png",      ---5
    "img/element/yellow.png" }  ---6
local onGemTouch
local sizeGemY = 96
local sizeGemX = 96
--local widthGemX = _W*.167--106
--local widthGemY = _H*.11--106

local gemX, gemY = 6, 5
local stTableX, enTableX = 4, 634

local mission_img01
local mission_img02
local gaycolorTime
local textScore

local ballX = _W*.06    --52
local ballY = _H*.39    --373

local limitCountGemSlide = 4    ---- chk amount gems
local limitCountGem = 3    ---- chk amount gems
local groupGem = { 0, 0, 0, 0, 0, 0 }
local groupGemChk = { 0, 0, 0, 0, 0, 0 }
local gemToBeDestroyed
local spriteBeDestroyed
local isGemTouchEnabled = true
local countSlide = 0

local widthGemX = 100
local widthGemY = 100

local channelX = {
    60,   --1
    164,  --2
    268,  --3
    372,  --4
    476,  --5
    580   --6
}

--local channelX = {
--    1*widthGemX - ballX,   --1
--    2*widthGemX - ballX,  --2
--    3*widthGemX - ballX,  --3
--    4*widthGemX - ballX,  --4
--    5*widthGemX - ballX,  --5
--    6*widthGemX - ballX   --6
--}

local channelY ={
    466,  --1
    570,  --2
    674,  --3
    778,  --4
    882,  --5
}

--local channelY ={
--    1*widthGemY + ballY,  --1
--    2*widthGemY + ballY,  --2
--    3*widthGemY + ballY,  --3
--    4*widthGemY + ballY,  --4
--    5*widthGemY + ballY,  --5
--}


--local amountPlayer = 5 -- simple for test card input to mission
local state_main -- state
local teamPlayer = {}  --- pic, element, hp, protect, lv, power special, leader, power special
local playerDB  ={}  -- data for player
local teamComm={}
local commDB  ={}  -- data for computer
-- ------------------------ HP value -------------------------
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
local sqlite3 = require( "sqlite3" )
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
local TimeAlllifeline_sh ,Timelifeline
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
local   picture = {"img/Monster_icon/1p.png","img/Monster_icon/2p.png","img/Monster_icon/3p.png","img/Monster_icon/4p.png","img/Monster_icon/5p.png","img/Monster_icon/6p.png"}
local   picturePop = {"img/frameNo/1.png","img/frameNo/2.png","img/frameNo/3.png","img/frameNo/4.png","img/frameNo/5.png","img/frameNo/6.png"}

local countColor = {0,0,0,0,0,0 }
local txtColor ={}
local txtNameColor ={
    "Red",
    "Green",
    "Blue",
    "Purple",
    "Pink",
    "Yellow",
}

local gameTimerBar
local gameTimer = 0
local timers = {}

local gameOverText2
local gameTimerText
local gameOverBOX
local score = 0
local oneTouch = 0
local pointStartheart
local gameTimerSET
local pause

local textimg_gameoverFile
---------------------------------------------------------------------------------------------------
-----***** MENU ITEM & Setting *****------
--  tada1179.w@gmail.com -------------------------------

local myItem = {}
local TouchCount = 0
local getCharac_id = {}
local mydata = 0
local EFSpriteCount = 1
local tu = 1
local EFSpriteSheetPoint = {}
local gameoverFile_change = 0
local displayShowMonster = display.newGroup()
local imgMons
local oldscore = 0
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

local function onTouchGameoverFileScreen (  event,self )
    isGemTouchEnabled = false
    if event.phase == "began" then


        return true
    end
end

local function enableGemTouch()
    isGemTouchEnabled = true

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
local function showGameOver(text)
    print("showGameOver = ",text)
    if score > oldscore then
        oldscore = score
        require("info").PuzzleEnd(score,oldscore,countColor)
    else
        require("info").PuzzleEnd(oldscore,score,countColor)
    end

--    if text == "win" then
--        require( "info").PuzzleEnd(score,oldscore,countColor)
----
----        mission_name = "kwanta11-5"
----        require( "info").Youwin(score,oldscore,mission_name,countColor)
--    else
--        require( "info").YouLoseMODE(oldscore)
--    end
end
local function gameTimerUpdate ()

    gameTimer = gameTimer - 1


    if gameTimer >= 0 then

        pointStartheart = (pointStartheart - (512/gameTimerSET))
        TimeAlllifeline_sh.x = pointStartheart

        gaycolorTime.width = 560 - pointStartheart + (_W*.05)
        gaycolorTime.x = pointStartheart
        gameTimerText.text = string.format("time: ".. gameTimer.." sc.")
        gameOverText2.text = string.format( "SCORE: %6.0f", score )

        local function comma_value(n) -- credit http://richard.warburton.it
            local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
            return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
        end
        local scoretext = comma_value(score)

        textScore.text = string.format( scoretext )
    else
        gameOverText2.text = string.format( "SCORE: %6.0f", score )

        local function nameFunction()
            local k, v
            for k,v in pairs(timers) do
                timer.cancel(v )
                v = nil; k = nil
            end


            timers = nil
            timers = {}
        end
        nameFunction()
        if score > oldscore then
            showGameOver("win")
        else
            showGameOver("lose")
        end

    end
    return true
end

local function newGem (i,j)
    local R = mRandom(1,6)
    local newGem

    newGem = display.newImageRect(picture[R],sizeGemX,sizeGemY)

    newGem.x = channelX[i]
    newGem.y = channelY[j]

    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = false
    newGem.isMarkedToDestroy = false

    newGem.destination_y = channelY[j] --newGem.y


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

    newGem.x = channelX[i]
    newGem.y = channelY[j]

    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = true
    newGem.isMarkedToDestroy = true

    newGem.destination_y = channelY[j] --newGem.y


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

    stTableY, enTableY = 412, 936
--    stTableY, enTableY =   widthGemY - ballY,  (gemY+1) * widthGemY + ballY --newGem.y
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

        if(positEn > (channelX[6]-ballX) ) then
            slideL = 0
            slideR = 1
        elseif (positEn > (channelX[5]-ballX)  and positEn < (channelX[6]-ballX) ) then
            slideL = 5
            slideR = 1
        elseif (positEn > (channelX[4]-ballX)  and positEn < (channelX[5]-ballX) ) then
            slideL = 4
            slideR = 2
        elseif (positEn > (channelX[3]-ballX)  and positEn < (channelX[4]-ballX) ) then
            slideL = 3
            slideR = 3
        elseif (positEn > (channelX[2]-ballX)  and positEn < (channelX[3]-ballX) ) then
            slideL = 2
            slideR = 4
        else-- R to L only
            slideL = 1
            slideR = 5
        end
--
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

        if(positEn > (channelY[5])-ballX ) then
            slideU = 0
            slideD = 1
        elseif (positEn > (channelY[4]-ballX) and positEn < (channelY[5]-ballX)) then
            slideU = 4
            slideD = 1
        elseif (positEn > (channelY[3]-ballX) and positEn < (channelY[4]-ballX)) then
            slideU = 3
            slideD = 2
        elseif (positEn > (channelY[2]-ballX) and positEn < (channelY[3]-ballX)) then
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

    event.phase = "move"
    if(self.chkFtPosit == "x") then -- -- -- -- -- slide X           
        if ( lineY ~=nil) then
            lineY:removeSelf()
            lineY= nil
        end

        self.slideEvent = (event.x - event.xStart)
        if(gemsTable[self.i][self.j].x <=  ((channelX[1] ) -(sizeGemX/2))or gemsTable[self.i][self.j].x >= (channelX[6] +(sizeGemX/2))) then     --  jump end dont move
            pasteGem(self,event)
            event.phase = "ended"
        else
            print("else x")

            for posX = 1, gemX, 1 do
                if gemsTable[posX][self.j].i == self.i then     -- self gem pos               
                    gemsTable[posX][self.j].x = self.markX + self.slideEvent
                else
                    gemsTable[posX][self.j].x = gemsTable[posX][self.j].markX + self.slideEvent
                end
                print("gemsTable[posX][self.j].x ",gemsTable[posX][self.j].x)
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

        if(gemsTable[self.i][self.j].y <= (channelY[1] - (sizeGemY/2)) or gemsTable[self.i][self.j].y >= (channelY[5] + (sizeGemY/2))) then        --  jump end dont move
            pasteGem(self,event)
            event.phase = "ended"
        else
            print("else y")
            for posY = 1, gemY, 1 do
                if gemsTable[self.i][posY].i == self.y then     -- self gem pos               
                    gemsTable[self.i][posY].y = self.markY + self.slideEvent
                else
                    gemsTable[self.i][posY].y = gemsTable[self.i][posY].markY + self.slideEvent
                end

                stTableY, enTableY = 832, 520

--                stTableY, enTableY =   _H*.89,  _H*.56
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
    enableGemTouch()
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
              --  myPink.alpha = 1
                local myCountDEF = math.ceil(sumDEF*(countColor/30)*((countCombo+2)/2) )
               -- myPink.text = string.format("+"..myCountDEF)
              --  transitionStash.newTransition = transition.to(myPink, { time=700, alpha=1, xScale=1.5, yScale = 1.5} )
                hpPlayer =  math.ceil(hpPlayer + myCountDEF)
                local x = math.ceil((fullLineHP *hpPlayer)/hpFull )
                if hpPlayer >= hpFull then
                    hpPlayer= hpFull

                end

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
                    gemsTable[i][k].destination_y = gemsTable[i][k].destination_y + widthGemY +4
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

    local count = 0
    for i = 1, gemX, 1 do
        for j = 1, gemY, 1 do

            if gemsTable[i][j].isMarkedToDestroy  then
                count = count +1
                color = gemsTable[i][j].gemType
                if oneTouch > 0 then
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


                    score = score + 100
                end
                isGemTouchEnabled = false

                countCombo = math.floor(count/4)
                PopNumIconCharacter(color,countColor[num])

                display.remove(displayGetdate)
                displayGetdate = nil
                --                transitionStash.newTransition = transition.to( gemsTable[i][j], { time=300, alpha=0.1, xScale=2, yScale = 2} )
            end
        end
    end

    for i=1,#countColor,1 do
        txtColor[i].text = string.format(txtNameColor[i].." = "..countColor[i])
    end

    TimersST.myTimer = timer.performWithDelay( 500, shiftGems ) -- 3 sce

    for  pt = 1 , 6 , 1 do
        groupGem[pt] =0
    end
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

--    gemToBeDestroyed = mission_img02
--
--    mission_img02 = display.newImage( "img/puzzle/frm_pzzl_c01.png" )
--    mission_img02.anchorX = 0
--    mission_img02.anchorY = 0
--    mission_img02.x, mission_img02.y = 0, 932
--    groupGameTop:insert ( mission_img02 )
--    gemToBeDestroyed:removeSelf()
--    gemToBeDestroyed = nil

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

function showMonster()

    timer.performWithDelay ( 200,function()
        displayShowMonster.x = 0

        local imgMonster = display.newImageRect( imgMons,256,256) -- 490
        imgMonster.anchorX = 0.5
        imgMonster.anchorY = 0.5
        imgMonster.x = 0
        imgMonster.y = _H*.2
        displayShowMonster:insert(imgMonster)

        transition.to( displayShowMonster, { time=200, x=displayShowMonster.x + _W*.5 })
    end )
    groupGameTop:insert(displayShowMonster)
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
            showMonster()
            transition.to( gameTimerBar, { time = gameTimer * 200, width=0 } )
            timers.gameTimerUpdate = timer.performWithDelay(1000, gameTimerUpdate, 0)
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


    if event.phase == "began" and isGemTouchEnabled == true and gameTimer > 0 and pause.id == 1 then
        oneTouch = oneTouch + 1
        gameOverBOX.text = string.format("Touch :"..oneTouch)
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
                checkdoubleAll()

            end


        elseif event.phase == "ended" or event.phase == "cancelled" then
            print("event.x = ",event.x)
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
local function pauseTime(event)
    local function nameFunction()
        local k, v
        for k,v in pairs(timers) do
            timer.cancel(v )
            v = nil; k = nil
        end


        timers = nil
        timers = {}
    end

    local function PlayTime()
        transition.to( gameTimerBar, { time = gameTimer * 200, width=0 } )
        timers.gameTimerUpdate = timer.performWithDelay(1000, gameTimerUpdate, 0)
    end

    if event.phase == "began" and gameTimer > 0 then
        if event.target.touch ~= 1 then
            MenuMODE()
        end
        if event.target.id == 1 then
            pause.id = 2

            pause:setFillColor(0.5, 0.5, 0.5)
            nameFunction()
        else
            pause.id = 1
            pause:setFillColor(1, 1, 1)
            PlayTime()
        end
    end
    return true
end
local function confremRetry(eventTouch,name)
    local chTouch = 0
    local tapdisplay = display.newGroup()
    local scrX = _W*.31
    local scrY = _H*.38

    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil


        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                team_no = team_no ,
                countColor = countColor
            }
        }
        local function gotoPage()
            if page == "yes" then    --yes
                if name == 1 then
                    pauseTime(eventTouch)
                else
                    require("menu").HietcreateScene()
                    storyboard.gotoScene("mainMenu","zoomInOutFade",200)
                end

            else  --no

                if name == 1 then
                    storyboard.gotoScene("mainMenu","zoomInOutFade",200)
                else
                    pauseTime(eventTouch)
                end

            end

        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        if event.phase == "ended" then
            transition.to( tapdisplay, { time=200, y= tapdisplay.y - _H*.5 ,onComplete= function()handleButtonEvent(page) end})
        end
    end

    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)

        local img_txt_youwin = "img/small_frame/frm_s_popup.png"
        local txt_youwin = display.newImage(img_txt_youwin)
        txt_youwin.x = _W*.5
        txt_youwin.y = _H*.25
        txt_youwin.anchorX = 0.5
        txt_youwin.anchorY = 0.5
        tapdisplay:insert(txt_youwin)

        local text =
        {
            "                    RETRY\n\n    DO YOU CONFIRM TO RETRY\nTHIS PUZZLE?\nYOU WILL GET NOTHING FROM\nTHE PUZZLE WHICH YOU GOT.",
            "                    EXIT\n\n    DO YOU CONFIRM TO EXIT\nTHIS PUZZLE?\nYOU WILL GET NOTHING FROM\nTHE PUZZLE WHICH YOU GOT.",
        }

        local SmachText_s = util.wrappedText(text[name], _W*.28, 30,native.systemFont)
        SmachText_s.x = _W*.15
        SmachText_s.y = _H*.07
        SmachText_s.anchorX = 0.5
        SmachText_s.anchorY = 0.5
        tapdisplay:insert(SmachText_s)

        local img_yesBTset = "img/small_frame/btt_yes.png"
        local yesBTset = widget.newButton
            {
                left = scrX,
                top = scrY,
                id = "yes",
                defaultFile = img_yesBTset,
                overFile = img_yesBTset,
                onEvent = menuMode
            }
        yesBTset.anchorX = 1
        tapdisplay:insert(yesBTset)

        scrX = scrX + _W*.38
        local img_yesBTset = "img/small_frame/btt_no.png"
        local noBTset = widget.newButton
            {
                left = scrX,
                top = scrY,
                id = "No",
                defaultFile = img_yesBTset,
                overFile = img_yesBTset,
                onEvent = menuMode
            }
        noBTset.anchorX = 1
        tapdisplay:insert(noBTset)


        transition.to( tapdisplay, { time=200, y=tapdisplay.y + _H*.25 })
    end )

end
local function MenuMODE()
    local config = {}
    config[1] = tonumber(require( "top_name" ).getSound())
    config[2] = tonumber(require( "top_name" ).getBGMSound())

    local button1 = {}
    local getPointBTonOffX = {0,0,0}
    local getPointBTonOffY = {0,0,0}
    local detailColor = {}
    local touchCount = 1
    local tapdisplay = display.newGroup()
    local img = {
        "img/small_frame/btt_on.png" ,
        "img/small_frame/btt_off.png" ,
        "img/small_frame/btt_fb.png" ,
    }

    local function handleButtonEvent( page,event )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page
            }
        }
        local function gotoPage()
            if page == 2 then  --  retry
                event.phase = "began"
                event.target.id = 2 --set to continues
                event.target.touch = 1 --set to continues

                confremRetry(event,1)

            elseif page == 1 then --  resume
                native.setActivityIndicator( true )
                event.phase = "began"
                event.target.id = 2 --set to continues
                event.target.touch = 1 --set to continues

                local get
                for i = 1, gemX, 1 do --- x
                    for j = 1, gemY, 1 do --- y
                        get =  gemsTable[i][j]
                        gemsTable[i][j] = newGem(i,j)

                        display.remove(get)
                        get = nil

                    end
                end
                Resume = 1
                checkdoubleAll()
                pauseTime(event)

            elseif page == 3 then  --exit
                event.phase = "began"
                event.target.id = 2 --set to continues
                event.target.touch = 1 --set to continues

                confremRetry(event,2)

            else

                event.phase = "began"
                event.target.id = 2 --set to continues
                event.target.touch = 1 --set to continues
                pauseTime(event)
            end
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        if event.phase == "ended"  then
            transition.to( tapdisplay, { time=200, y= tapdisplay.y - _H*.5 ,onComplete= function()handleButtonEvent(page,event) end})
        end
        return true
    end

    local function switchMode(event)
        local idObj = event.target.id
        local idObjIMG = nil
        local displayStore = nil
        if event.phase == "ended"  then
            if event.target.status == 1 then
                idObjIMG = 2
            else
                idObjIMG = 1
            end

            if event.target.id == 3  then

            else
                displayStore = button1[idObj]
                button1[idObj] = widget.newButton
                    {
                        left = getPointBTonOffX[idObj],
                        top = getPointBTonOffY[idObj],
                        id = idObj,
                        defaultFile = img[idObjIMG],
                        overFile = img[idObjIMG],
                        onEvent = switchMode
                    }

                button1[idObj].status = idObjIMG
                button1[idObj].anchorX = 1
                tapdisplay:insert(button1[idObj])

                display.remove(displayStore)
                displayStore = nil

                if idObj == 1 then
                    config[1] = idObjIMG
                    require( "top_name" ).setSound(idObjIMG,config[2])
                else
                    config[2] = idObjIMG
                    require( "top_name" ).setSound(config[1],idObjIMG)
                end

            end
        end
        return true
    end

    local scrY = _H*.02
    local scrX = _W*.39

    local color = 0
    timer.performWithDelay ( 300,function()
        local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        myRectangle.touch = touchScreen
        myRectangle:addEventListener( "touch", myRectangle )
        tapdisplay:insert(myRectangle)

        local getPlay = 1 --if touch pause in game
        if getPlay then
            local ModeIngame = function(event)
                if event.phase == "ended"  then
                    menuMode(event)
                end

            end


            local img_BGMenuMode1 = "img/small_frame/frm_s_pause01.png"
            local BGMode = display.newImage(img_BGMenuMode1)
            BGMode.x = _W*.5
            BGMode.y = -_H*.15
            BGMode.anchorX = 0.5
            BGMode.anchorY = 0
            tapdisplay:insert(BGMode)


            local img_BGMenuMode = "img/small_frame/frm_u_pause02.png"
            local BGMenuMode = display.newImage(img_BGMenuMode)
            BGMenuMode.x = _W*.5
            BGMenuMode.y = _H*.35
            BGMenuMode.anchorX = 0.5
            BGMenuMode.anchorY = 0
            tapdisplay:insert(BGMenuMode)

            local imgPause= {
                "img/small_frame/btt_resume.png" ,
                "img/small_frame/btt_retry01.png" ,
                "img/small_frame/btt_exit01.png" ,
            }
            local pointpauseY = _H*.4
            local pointpauseX = _W*.3
            local pausePlay ={}
            for i=1,#imgPause,1 do
                pausePlay[i] = {}
                detailColor[i] = {}

                if i == 1 then
                    pausePlay[i] = widget.newButton
                        {
                            left = _W*.5,
                            top = pointpauseY,
                            id = i,
                            defaultFile = imgPause[i],
                            overFile = imgPause[i],
                            onEvent = ModeIngame
                        }
                    pausePlay[i].status = 1
                    pausePlay[i].anchorX = 1
                    tapdisplay:insert(pausePlay[i])

                    pointpauseY = pointpauseY + (_H*.1)
                else
                    pausePlay[i] = widget.newButton
                        {
                            left = pointpauseX,
                            top = pointpauseY,
                            id = i,
                            defaultFile = imgPause[i],
                            overFile = imgPause[i],
                            onEvent = ModeIngame
                        }
                    pausePlay[i].status = 1
                    pausePlay[i].anchorX = 1
                    tapdisplay:insert(pausePlay[i])
                    pointpauseX = pointpauseX + _W*.4
                end
            end
        end


        for i=1,#img,1 do
            button1[i] = {}
            detailColor[i] = {}


            if i <= 2 then
                print("i = < 2 =  ",i)
                button1[i] = widget.newButton
                    {
                        left = scrX,
                        top = scrY,
                        id = i,
                        defaultFile = img[config[i]],
                        overFile = img[config[i]],
                        onEvent = switchMode
                    }
                button1[i].status = 1
                button1[i].anchorX = 1
                tapdisplay:insert(button1[i])
                getPointBTonOffX[i] = scrX
                getPointBTonOffY[i] = scrY

                scrX = scrX + (_W*.37)
            else

                scrX = scrX - (_W*.37)
                scrY = scrY + _H*.14
                button1[i] = widget.newButton
                    {
                        left = scrX,
                        top = scrY,
                        id = i,
                        defaultFile = img[i],
                        overFile = img[i],
                        onEvent = switchMode
                    }
                button1[i].status = 1
                button1[i].anchorX = 1
                tapdisplay:insert(button1[i])

                getPointBTonOffX[i] = scrX
                getPointBTonOffY[i] = scrY
            end
        end

        local close = widget.newButton
            {
                left = _W*.92,
                top = -_H*.17,
                defaultFile = "img/universal/btt_cancel.png",
                overFile = "img/universal/btt_cancel.png",
                onEvent = menuMode
            }
        close.font = native.newFont("CooperBlackMS",50)
        close.anchorX = 1
        tapdisplay:insert(close)

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + _H*.25 })
    end )

    return true

end


local function timerClock()
    TimeAlllifeline_sh = display.newImageRect( "img/heart.png",_W*.05,_H*.025) -- full 550
    pointStartheart = 560
    --    pointStart = _W*.5
    --    TimeAlllifeline_sh:setFillColor (0,0,1,0.5)
    TimeAlllifeline_sh.anchorX = 0
    TimeAlllifeline_sh.x, TimeAlllifeline_sh.y =  pointStartheart, _H*.385

    gaycolorTime = display.newImage( "img/puzzle/ast_timer.png") -- 490
    gaycolorTime.anchorX = 0
    gaycolorTime.width = 0
    gaycolorTime.x, gaycolorTime.y = pointStartheart, _H*.385
    --    physics.addBody( lifeline,"static", { bounce=0.5, density=1.0 ,friction = 0, shape=5 } )

    --    Timelifeline = display.newImageRect( "img/puzzle/frm_timer.png", 600, 30) -- 490
    Timelifeline = display.newImage( "img/puzzle/frm_timer.png") -- 490
    Timelifeline.anchorX = 0.5
    Timelifeline.x, Timelifeline.y = _W*.5, _H*.385
    --    physics.addBody( lifeline,"static", { bounce=0.5, density=1.0 ,friction = 0, shape=5 } )

    groupGameTop:insert ( Timelifeline )
    groupGameTop:insert ( gaycolorTime)
    groupGameTop:insert ( TimeAlllifeline_sh )
end

local function Condition()

    local tabCon = display.newImage( "img/puzzle/frm_condition.png") -- full 550
    tabCon.anchorX = 0.5
    tabCon.x, tabCon.y =  _W*.45, _H*.025
    groupGameTop:insert ( tabCon )

    local tabConColorPoint = display.newImage( "img/puzzle/ast_point.png") -- full 550
    tabConColorPoint.anchorX = 0
    tabConColorPoint.x, tabConColorPoint.y =  _W*.05, _H*.02
    groupGameTop:insert ( tabConColorPoint )


    textScore = display.newText(score,_W*.15,_H*.045,"CooperBlackMS",35)
    textScore.anchorX = 0
    textScore.anchorY = 1
    groupGameTop:insert (textScore )
end
local function loadMonster()
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )
    local rowaechiemen = {}
    local rowdata = 0

    for Pindata in db:nrows ("SELECT * FROM pin WHERE pin_status = 1 and pin_id > 6;") do
        rowdata = rowdata + 1
        rowaechiemen[rowdata]= Pindata.pin_imgbig
        print("imgMos =",rowaechiemen[rowdata])

    end

    local m = math.random(1,rowdata)
    imgMons = rowaechiemen[m]

end

function scene:createScene( event )
--    oldscore = tonumber(event.params.user_score)
    oldscore = 20
    score = 0
    gameTimerSET = 60 * 1 *(3)
    gameTimer = gameTimerSET
    require("top_name").alphaDisplay(0)
    defuatValue()
    loadMonster()
    countSlide = 0
    groupGameLayer = display.newGroup()
    groupGameTop = display.newGroup()
    groupGameTop1 = display.newGroup()
    --gameoverFile()
    local group = self.view

    local mission_img = display.newImage( "img/map_classic.jpg" )
    mission_img.anchorX = 0
    mission_img.anchorY = 0
    mission_img.x = 0
    mission_img.y = 0
    groupGameTop:insert ( mission_img )

    local background1 = display.newImage( "img/puzzle/frm_pzzl_b01.png" )
    background1.anchorX = 0
    background1.anchorY = 0
    background1.x, background1.y = 0, 416

    groupGameLayer:insert ( background1 )

    groupGameTop:insert ( groupGameTop1 )

    local texttitle = display.newText("CLASSIC",_W*.5,_H*.05,"CooperBlackMS",45)
    texttitle.anchorX = 0.5
    texttitle.anchorY = 1
    groupGameLayer:insert (texttitle )



    local pointYY = _H*.1
    for i=1,#countColor,1 do
        txtColor[i] = display.newText(txtNameColor[i].." = "..countColor[1],_W*.05,pointYY,"CooperBlackMS",30)
        txtColor[i].anchorX = 0
        txtColor[i].anchorY = 1
        txtColor[i].alpha = 0
        pointYY = pointYY + _H*.05

        groupGameTop:insert (txtColor[i] )
    end
    ------------------------- gemsTable -------------------------
    native.setActivityIndicator( true )
    for i = 1, gemX, 1 do --- x
        gemsTable[i] = {}
        for j = 1, gemY, 1 do --- y
            gemsTable[i][j] = newGem(i,j)

        end
    end

   local mission_img01 = display.newImage( "img/puzzle/frm_pzzl_a01.png" )
    mission_img01.anchorX = 0
    mission_img01.anchorY = 0
    mission_img01.x, mission_img01.y = 0, 388
    groupGameTop:insert ( mission_img01 )

    mission_img02 = display.newImage( "img/puzzle/frm_pzzl_c01.png" )
    mission_img02.anchorX = 0
    mission_img02.anchorY = 0
    mission_img02.x, mission_img02.y = 0, 932
    groupGameTop:insert ( mission_img02 )


    checkdoubleAll()
    hpPlayer = sumHP
    hpFull =  sumHP

    -------------------------- timer value -------------------------

    gameTimerText = display.newText("time: ".. gameTimer.." sc.",0 , _H*.217,native.systemFontBold,24)
    gameTimerText.x = _W*.85
    gameTimerText:setFillColor(0, 1, 1)
    gameTimerText.alpha = 0
    groupGameTop:insert ( gameTimerText )

    gameOverBOX = display.newText("Touch :"..oneTouch,0 , _H*.27,native.systemFontBold,24)
    gameOverBOX.x = _W*.85
    gameOverBOX.alpha = 0
    gameOverBOX:setFillColor(0, 1, 1)
    groupGameTop:insert ( gameOverBOX )

    gameOverText2 = display.newText(hpPlayer.."/"..hpFull,0 , _H*.3,native.systemFontBold,24)
    gameOverText2.x = _W*.85
    gameOverText2.alpha = 0
    gameOverText2:setFillColor(0, 1, 1)
    groupGameTop:insert ( gameOverText2 )
    -----------------------------

    textHP = display.newText(hpPlayer.."/"..hpFull,0 , _H*.417,native.systemFontBold,24)
    textHP.x = _W*.95
    textHP.alpha = 0
    textHP:setFillColor(0, 1, 1)
    groupGameTop:insert ( textHP )

    timerClock()
    Condition()

    local imagepuse = "img/puzzle/btt_pause.png"
    pause = display.newImage( imagepuse) -- 490
    pause.anchorX = 0
    pause.x, pause.y = _W*.88, _H*.04
    pause.id = 1
--    pause.touch = pauseTime
    pause:addEventListener( "touch", pauseTime )
    groupGameTop:insert ( pause )

--    require("mission_anima").mission_horse()
--    require("mission_anima").mission_Forest()
    groupGameLayer:insert(groupGameTop)
    group:insert(groupGameLayer)

end -- end for scene:createScene

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

  

