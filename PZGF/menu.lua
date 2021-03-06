
---------------------------------------------------------------
module(..., package.seeall)
local storyboard = require( "storyboard" )
--storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local sqlite3 = require("sqlite3")
local json = require("json")
local http = require("socket.http")
local current = storyboard.getCurrentSceneName()
local previous_scene_name = storyboard.getPrevious()--page call befor
local loadImageSprite = require ("downloadData").loadImageSprite_Gacha1()

local sheetInfo = require("menubutton")
local myImageSheet = graphics.newImageSheet( "menubutton.png",system.DocumentsDirectory, sheetInfo:getSheet() )
---------------------------------------------------------------
local USERID
local screenW, screenH = display.contentWidth, display.contentHeight
local Myname
local MyDiamond
local MyCoin
local MyLV
local maxpowerSTAMINA = 0
--///////////////////////////////--
local dataName
local dataDiamond
local dataCoin
local dataLV
local dataslot
local dataexp
local dataFrientPoint
local datacharacterAll

local powerRank = 0
local powerSTAMINA = 0
local colorSTAMINA = 0
local maxLenghtPower = 200
local maxlistFriend
local maxFriendPoint



local sizeball =  screenW*.2
local size_linebaseW =  screenW*.3 -- 640*3=192,192/4= 48 ok (mod = 0 )
local size_linebaseH =  screenH*.008
local image_colerSTAMINA = "img/head/blue_colour.png"
local MyStamina
local pointLineX =  screenW*.08
local pointLineXX =  screenW*.1


local STAMINAcoler  = display.newImageRect(image_colerSTAMINA,0,size_linebaseH)--contentWidth contentHeight
STAMINAcoler.width = 0
STAMINAcoler:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
--STAMINAcoler.x = pointLineX
--STAMINAcoler.y = screenH*.5
STAMINAcoler.alpha = 0

local image_colerRANK = "img/head/red_colour.png"
local RANKcoler = display.newImageRect(image_colerRANK,0,size_linebaseH)--contentWidth contentHeight
RANKcoler.width  = 0
RANKcoler:setReferencePoint(display.TopLeftReferencePoint)
--RANKcoler.x = pointLineXX

-----------------------------
local FontAndSizeText = {}
function TypeFontAndSizeText()

    local typeFont = "Optima-ExtraBlack"
    --    local typeFont = "Optima-Bold"
    local fontGuest =  20 /  display.contentScaleY     --  25 pixel
    local fontSize =  23 /  display.contentScaleY     --  25 pixel
    local fontSizeHead =  26 /  display.contentScaleY -- 30 pixel
    local fontSizeHeadMax =  30 /  display.contentScaleY -- 35 pixel

    if( display.contentScaleY < 1 ) then
        --editSize =  editSize /math.ceil(display.contentScaleY)
    end
    local FontAndSize = {
        fontGuest = fontGuest,
        typeFont = typeFont,
        fontSize = fontSize,
        fontSizeHead = fontSizeHead,
        fontSizeHeadMax = fontSizeHeadMax ,

    }

    return FontAndSize
end

FontAndSizeText = TypeFontAndSizeText()
-----------------------------------------------

--FontAndSizeText = TypeFontAndSizeText()
local typeFont = "Optima-ExtraBlack"
local fontSize = FontAndSizeText.fontSize --25
local fontSizeHead = FontAndSizeText.fontSizeHead --30
-----------------------------------------------------
-----------timer -------------------------
local gameTimer = 0
local timers = {}
local count = 0
local gameTimerText = display.newText(0, screenW*.5, 0, typeFont, fontSizeHead)
gameTimerText:setReferencePoint(display.TopLeftReferencePoint)
gameTimerText:setFillColor(205, 155, 29)
gameTimerText.alpha = 0

local timers = {}
function CountStamina()
    local gameTimer = 0
    STAMINAcoler.alpha = 1
    local current_TEAMSELECT = storyboard.getCurrentSceneName()

    if timers.gameTimerUpdate then
        timer.cancel(timers.gameTimerUpdate)
        timers.gameTimerUpdate = nil
    end
    if current == "title_page" then

        local FullpowerSTAMINA = stamina()
        local function gameTimerUpdate ()

            gameTimer = gameTimer - 1

            if gameTimer >= 0 then
                gameTimerText.text = string.format(gameTimer)
                gameTimerText.alpha = 0

            elseif powerSTAMINA <= FullpowerSTAMINA then
                --powerSTAMINA = powerSTAMINA + 1


                local path = system.pathForFile("datas.db", system.DocumentsDirectory)
                db = sqlite3.open( path )
                local tablefill ="UPDATE user SET 	user_power = '"..powerSTAMINA.."' WHERE user_id = '"..USERID.."';"
                db:exec( tablefill )
                stamina()
                -- if current_TEAMSELECT ~= "team_select" or current_TEAMSELECT ~="puzzleCode" then
                MyStamina.text = string.format(powerSTAMINA.."/"..FullpowerSTAMINA)
                STAMINAcoler.width = colorSTAMINA
                STAMINAcoler:setReferencePoint(display.TopLeftReferencePoint)
                STAMINAcoler.x = pointLineX
                -- end

                CountStamina()
            end
        end


        if powerSTAMINA < FullpowerSTAMINA  then
            gameTimer =  (5*60)*60    -- 5 minute = 1 stamina
            -- gameTimer =  5
            powerSTAMINA = powerSTAMINA + 1
            timers.gameTimerUpdate = timer.performWithDelay(1000, gameTimerUpdate, 0)
        end

    end
end

------------------------------------------------------
local soundforBattle = {
    "SoundEffect/BGM/bgm_map01.wav", --walk in water
    "SoundEffect/BGM/bgm_map02.wav", --walk in water
    "SoundEffect/BGM/bgm_map03.wav", --walk in water
    "SoundEffect/BGM/bgm_map04.wav", --walk in water
    "SoundEffect/BGM/bgm_map05.wav", --walk in water

}
local StartBattlelaserChannel = nil

local narrationSpeech = audio.loadStream("SoundEffect/BGM/bgm_map01.wav")
local laserSound = audio.loadSound(soundforBattle[10])    --water
local backgroundMusicChannel1
local backgroundMusicChannel2
function mainsound()
    local current = storyboard.getCurrentSceneName()
   -- print("mainsound current = ",current)
    if current~= "puzzleCode" then
        if backgroundMusicChannel2 ~=nil then
            audio.stop( backgroundMusicChannel2)
            backgroundMusicChannel2 = nil
        end
        local backgroundMusic = audio.loadStream("SoundEffect/BGM/bgm_title.wav")
        backgroundMusicChannel1 = audio.play( backgroundMusic, { channel=20, loops=-1 }  )
        audio.setVolume( 0.2, { channel=20 } )
    else

        if backgroundMusicChannel1 ~=nil then
            audio.stop( backgroundMusicChannel1)
            backgroundMusicChannel1 = nil
        end

        if StartBattlelaserChannel ~=nil then
            audio.stop( StartBattlelaserChannel)
            StartBattlelaserChannel = nil
        end
        local i = math.random(1,5)
        local backgroundMusic = audio.loadStream(soundforBattle[i])
        backgroundMusicChannel2 = audio.play( backgroundMusic, { channel=20, loops=-1 }  )
        audio.setVolume( 0.2, { channel=20 } )
    end
end

function SEtouchPuzzleVictory()
    local se_button02 = "SoundEffect/SE/se_battle09.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    local laserChannel = audio.play( backgroundMusic , { channel=21, loops=1 } )
    audio.setVolume( 0.5, { channel=21 } )
end

local auSEtouchPuzzleBossgread = nil
function SEtouchPuzzleBossgread()
    local se_button02 = "SoundEffect/SE/test_bossappear.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    if auSEtouchPuzzleBossgread ==nil then
        auSEtouchPuzzleBossgread = audio.play( backgroundMusic , { channel=19, loops=0 } )
        audio.setVolume( 0.5, { channel=19 } )
    else
        audio.stop( auSEtouchPuzzleBossgread)
        auSEtouchPuzzleBossgread = nil

        auSEtouchPuzzleBossgread = audio.play( backgroundMusic , { channel=19, loops=0 } )
        audio.setVolume( 0.5, { channel=19 } )
    end


end

function SEtouchPuzzleWarning()
    local se_button02 = "SoundEffect/SE/test_warnning.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    local laserChannel = audio.play( backgroundMusic , { channel=18, loops=1 } )
    audio.setVolume( 0.5, { channel=18 } )
end

function SEtouchPuzzleWalkOnBattle()
    local se_button02 = "SoundEffect/SE/se_battle01.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    local laserChannel = audio.play( backgroundMusic , { channel=17, loops=0 } )
    audio.setVolume( 1.0, { channel=17 } )
end
local laserChannel =nil

function SEtouchPuzzleFight()
    local se_button02 = "SoundEffect/SE/sword.mp3"
    local backgroundMusic = audio.loadStream(se_button02)

    if laserChannel == nil then
        laserChannel = audio.play( backgroundMusic , { channel=16, loops=0 } )
        audio.setVolume( 0.5, { channel=16 } )
    else
        audio.stop(laserChannel )
        laserChannel = nil

        laserChannel = audio.play( backgroundMusic , { channel=16, loops=0 } )
        audio.setVolume( 0.5, { channel=16 } )
    end

end
function SEtouchEnamyFight()
    local se_button02 = "SoundEffect/SE/se_battle08.mp3"
    local backgroundMusic = audio.loadStream(se_button02)

    if laserChannel == nil then
        laserChannel = audio.play( backgroundMusic , { channel=6, loops=0 } )
        audio.setVolume( 0.5, { channel=6 } )
    else
        audio.stop(laserChannel )
        laserChannel = nil

        laserChannel = audio.play( backgroundMusic , { channel=6, loops=0 } )
        audio.setVolume( 0.5, { channel=6 } )
    end

end

function SEEndMovePuzzle()
    if laserChannel ~= nil then
        audio.stop(laserChannel )
        laserChannel = nil
    end
end

local puzzlelaserChannel = nil
function SEtouchMovePuzzle()
    local se_button02 = "SoundEffect/SE/se_puzzle02.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    if puzzlelaserChannel == nil then
        puzzlelaserChannel = audio.play( backgroundMusic , { channel=15, loops=-1 } )
        audio.setVolume( 0.5, { channel=15 } )
    else
        audio.stop(puzzlelaserChannel )
        puzzlelaserChannel = nil
    end
end


function SEtouchStartBattle()
    local se_button02 = "SoundEffect/SE/se_battle09.wav"
    local backgroundMusic = audio.loadStream(se_button02)

    StartBattlelaserChannel = audio.play( backgroundMusic , { channel=14, loops=0 } )
    audio.setVolume( 0.7, { channel=14 } )

    if backgroundMusicChannel1 ~= nil then
        audio.stop( backgroundMusicChannel1)
        backgroundMusicChannel1 = nil
    end

end
local auSEtouchPuzzleBoom = nil
function SEtouchPuzzleBoom()
    --    local se_button02 = "SoundEffect/SE/se_battle05.wav"
    local se_button02 = "SoundEffect/SE/gem_break.mp3"
    local backgroundMusic = audio.loadStream(se_button02)
    if auSEtouchPuzzleBoom == nil  then
        auSEtouchPuzzleBoom = audio.play( backgroundMusic , { channel=13, loops=0 } )
        audio.setVolume( 0.3, { channel=13 } )
    else
        audio.stop(auSEtouchPuzzleBoom )
        auSEtouchPuzzleBoom = nil

        auSEtouchPuzzleBoom = audio.play( backgroundMusic , { channel=13, loops=0 } )
        audio.setVolume( 0.3, { channel=13 } )
    end


end

function SEtouchMoveTeam()
    local se_button02 = "SoundEffect/SE/se_battle10.wav"
    local backgroundMusic = audio.loadStream(se_button02)

    if laserChannel == nil then
        laserChannel = audio.play( backgroundMusic , { channel=12, loops=0 } )
        audio.setVolume( 0.3, { channel=12 } )
    else
        audio.stop(laserChannel )
        laserChannel = nil

        laserChannel = audio.play( backgroundMusic , { channel=12, loops=0 } )
        audio.setVolume( 0.3, { channel=12 } )
    end

end
local   auSEtouchButton
function SEtouchButton()
    local se_button02 = "SoundEffect/test/touch01.wav"
    local backgroundMusic = audio.loadStream(se_button02)

    if auSEtouchButton == nil then
        auSEtouchButton = audio.play( backgroundMusic , { channel=11, loops=0 } )
        audio.setVolume( 1.0, { channel=11 } )
    else
        audio.stop(auSEtouchButton )
        auSEtouchButton = nil

        auSEtouchButton = audio.play( backgroundMusic , { channel=11, loops=0 } )
        audio.setVolume( 1.0, { channel=11 } )
    end

end

local auSEtouchButtonBack
function SEtouchButtonBack()
    local se_button02 = "SoundEffect/SE/se_button02.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    if auSEtouchButtonBack == nil then
        auSEtouchButtonBack = audio.play( backgroundMusic , { channel=10, loops=0 } )
        audio.setVolume( 1.0, { channel=10 } )
    else
        audio.stop(auSEtouchButtonBack )
        auSEtouchButtonBack = nil

        auSEtouchButtonBack = audio.play( backgroundMusic , { channel=10, loops=0 } )
        audio.setVolume( 1.0, { channel=10 } )
    end


end

function SECoin()
    if laserChannel == nil then
        local se_button02 = "SoundEffect/SE/test_coin.wav"
        local backgroundMusic = audio.loadStream(se_button02)
        laserChannel = audio.play( backgroundMusic , { channel=9, loops=0 } )
        audio.setVolume( 0.7, { channel=9 } )
    end

end

function SEFlag()
    local se_button02 = "SoundEffect/SE/test_flag.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    if laserChannel == nil then

        laserChannel = audio.play( backgroundMusic , { channel=8, loops=0 } )
        audio.setVolume( 0.7, { channel=8 } )
    else
        audio.stop(laserChannel )
        laserChannel = nil

        laserChannel = audio.play( backgroundMusic , { channel=8, loops=0 } )
        audio.setVolume( 0.7, { channel=8 } )
    end

end

function SEAlertMSN()
    local se_button02 = "SoundEffect/SE/se_level02.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    if laserChannel == nil then

        laserChannel = audio.play( backgroundMusic , { channel=7, loops=0 } )
        audio.setVolume( 0.7, { channel=8 } )
    else
        audio.stop(laserChannel )
        laserChannel = nil

        laserChannel = audio.play( backgroundMusic , { channel=7, loops=0 } )
        audio.setVolume( 0.7, { channel=8 } )
    end

end


function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
    return true
end
function SystemPhone()
    local SysdeviceID = require("includeFunction").DriverIDPhone()
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    for x in db:nrows("SELECT * FROM user") do

        USERID = x.user_id
        dataName = x.user_name
        dataDiamond = tonumber(x.user_diamond)
        dataCoin = tonumber(x.user_coin)
        dataLV = tonumber(x.user_level)
        dataslot = tonumber(x.user_deck)
        dataexp = tonumber(x.user_exp)
        dataFrientPoint = tonumber(x.user_FrientPoint)
        datacharacterAll = tonumber(x.user_borncharac)

        powerRank = tonumber(x.user_level) --tonumber() change string to integer
        powerSTAMINA = tonumber(x.user_power)
    end

    db:close()

    return USERID

end
--***********************************************************--
function numFriend()
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    for x in db:nrows("SELECT * FROM UserFriendList") do maxlistFriend = tonumber(x.max_no_friends) end
    if(maxlistFriend == nil)then
        maxlistFriend = 0
    end
    db:close()
    return maxlistFriend
end



function newrequestList()
    local group = display.newGroup()
    --        maxlistFriend = 1
    if maxlistFriend > 0 then
        local backcolor =  display.newRoundedRect(screenW*.642, screenH*.57, screenW*.05, screenH*.033,5)
        backcolor:setReferencePoint(display.TopLeftReferencePoint)
        backcolor.strokeWidth = 2
        backcolor:setStrokeColor(255,255,255)
        backcolor.alpha = 1
        backcolor:setFillColor(200, 0, 0)
        --         group:insert(backcolor)

        local sizeMaxfriend = 20
        local maxLenght = string.len(maxlistFriend)
        local pointNum = (screenW*.66)-((maxLenght*sizeMaxfriend)/5)

        local Myfriend = display.newText(maxlistFriend, pointNum, screenH*.575, typeFont, sizeMaxfriend)
        Myfriend:setReferencePoint(display.TopLeftReferencePoint)
        Myfriend:setFillColor(0, 0, 0)
        --         group:insert(Myfriend)

    end
    return group
end

function userLevel()
    SystemPhone()
    MyLV.text = string.format(dataLV)
    return dataLV
end
function diamond()
    SystemPhone()
    MyDiamond.text = string.format(dataDiamond)
    return dataDiamond
end
function FrientPoint()
    SystemPhone()
    return dataFrientPoint
end
function slot()
    SystemPhone()
    -- print("dataslot == ",dataslot)
    return dataslot
end
function characterAll()
    SystemPhone()
    return datacharacterAll
end
function user_id()
    SystemPhone()
    return USERID
end
function user_name()
    SystemPhone()
    Myname.text = string.format(dataName)
    return dataName
end
function user_coin()

    SystemPhone()
    MyCoin.text = string.format(dataCoin)
    return dataCoin
end
function user_exp()
    SystemPhone()

    return dataexp
end

function stamina()
    SystemPhone()
    local section = {
        18,21,24,27,30,33,37,41,45,50
    }
    local class = tonumber(math.floor(dataLV/10))
    if (class+1) > 10 then
        class = 10
    else
        class = class + 1
    end

    if powerRank > maxLenghtPower then
        powerRank = maxLenghtPower
        RANKcoler:setReferencePoint(display.TopLeftReferencePoint)
        RANKcoler.width = powerRank
        RANKcoler.x = pointLineX
    end

    if powerSTAMINA <= section[class] then
        colorSTAMINA =   (powerSTAMINA/section[class]) * maxLenghtPower
        STAMINAcoler.width = colorSTAMINA
        STAMINAcoler:setReferencePoint(display.TopLeftReferencePoint)
        STAMINAcoler.x = pointLineX
    end
    MyStamina.text = string.format(powerSTAMINA.."/"..section[class])
    return  section[class]  --maxStamina
end
function power_STAMINA()
    SystemPhone()
    return powerSTAMINA  --in use now
end
function HoldcharacterAll()
    SystemPhone()
    local Allcharacter
    local LinkURL = "http://133.242.169.252/DYM/hold_character.php"
    local numberHold_character =  LinkURL.."?user_id="..USERID
    local numberHold = http.request(numberHold_character)
    local allRow = {}
    if numberHold == nil then
        print("No Dice")
    else
        allRow  = json.decode(numberHold)
        Allcharacter = allRow.chrAll
    end
    return Allcharacter
end

function update_user()
    local data = slot()
    local data = stamina()
    local data = newrequestList()
    local data = user_coin()
    local data = diamond()
    local data = power_STAMINA()
    local data = user_name()
    local data = userLevel()
end


------------------------------------
    local previous_scene_name = storyboard.getCurrentSceneName()
    local image_ball = "img/menu/battle_dark.png"
    local image_linebase = "img/head/line.png"


    local image_background = "img/background/background_2.png"

    local sizetextname = 25 /  display.contentScaleY
    local sizeCoinDiamond = 20 /  display.contentScaleY     --  20 pixel





    local pointDiamond =  (screenW*.7)
    local pointCoin=  screenW*.7

    SystemPhone()
    numFriend()
    local namelenght = string.len(dataName)
    local optionSet =
    {
        effect = "fade",
        time = 100,
        params = { USER_ID =USERID }
    }
    local pointName =  (screenW*.48)-((namelenght*sizetextname)/4)

    local group = display.newGroup()


    local sizemenuH = screenH*.1
    local sizemenuW = screenW*.15

    local background1 = display.newImageRect(image_background,screenW,screenH)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0


    local imgDiamond = display.newImageRect("img/head/DIAMOND.png",screenW*.07,screenH*.03)--contentWidth contentHeight
    imgDiamond:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgDiamond.x,imgDiamond.y = screenW*.62,screenH*.115


    local imgCoin = display.newImageRect("img/head/COIN.png",screenW*.05,screenH*.03)--contentWidth contentHeight
    imgCoin:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgCoin.x,imgCoin.y = screenW*.62,screenH*.165


    --[[local imgSetting = display.newImageRect("img/head/as_butt_menu.png",screenW*.08,screenH*.04)--contentWidth contentHeight
    imgSetting:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgSetting.x,imgSetting.y = screenW*.8,screenH*.108
    group:insert(imgSetting)--]]
    -- ******* ******* -----------------------------------------------------


    Myname = display.newText(dataName, pointName, screenH*.05, typeFont, sizetextname)
    Myname:setReferencePoint(display.TopLeftReferencePoint)
    Myname:setFillColor(255, 255, 255)


    MyDiamond = display.newText(dataDiamond, pointDiamond, screenH*.116, typeFont, sizeCoinDiamond)
    MyDiamond:setReferencePoint(display.TopLeftReferencePoint)
    MyDiamond:setFillColor(205, 38, 38)


    MyCoin = display.newText(dataCoin, pointCoin, screenH*.17, typeFont, sizeCoinDiamond)
    MyCoin:setReferencePoint(display.TopLeftReferencePoint)
    MyCoin:setFillColor(205, 155, 29)


    MyLV = display.newText("Lv."..dataLV, screenW*.28, screenH*.11, typeFont, sizeCoinDiamond)
    MyLV:setReferencePoint(display.TopLeftReferencePoint)
    MyLV:setFillColor(255, 255, 255)


    MyStamina = display.newText(powerSTAMINA.."/"..maxpowerSTAMINA, screenW*.28, screenH*.16, typeFont, sizeCoinDiamond)
    MyStamina:setReferencePoint(display.TopLeftReferencePoint)
    MyStamina:setFillColor(255, 255, 255)
    maxpowerSTAMINA = stamina()


    local linebaseRANG = display.newImageRect(image_linebase,size_linebaseW,size_linebaseH)--contentWidth contentHeight
    linebaseRANG:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    linebaseRANG.x,linebaseRANG.y = pointLineX,screenH*.14
   --

    RANKcoler = display.newImageRect(image_colerRANK,0,size_linebaseH)--contentWidth contentHeight
    RANKcoler.width = powerRank
    RANKcoler:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    RANKcoler.x,RANKcoler.y = pointLineX,linebaseRANG.y
   --

    local linebaseSTAMINA = display.newImageRect(image_linebase,size_linebaseW,size_linebaseH)--contentWidth contentHeight
    linebaseSTAMINA:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    linebaseSTAMINA.x,linebaseSTAMINA.y = pointLineX,screenH*.19
   --

    STAMINAcoler = display.newImageRect(image_colerSTAMINA,0,size_linebaseH)--contentWidth contentHeight
    STAMINAcoler.width = colorSTAMINA
    STAMINAcoler:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    STAMINAcoler.x,STAMINAcoler.y = pointLineX,linebaseSTAMINA.y
   --

--group:insert(background1)
--group:insert(imgDiamond)
--group:insert(imgCoin)
--group:insert(Myname)
--group:insert(MyDiamond)
--group:insert(MyCoin)
--group:insert(MyLV)
--group:insert(MyStamina)
--group:insert(linebaseRANG)
--group:insert(RANKcoler)
--group:insert(linebaseSTAMINA)
--group:insert(STAMINAcoler)

    -- ******* *******   -----------------------------------------------------
    local btnHead
    local btnBattle
    local btnTeam
    local btnShop
    local btnGacha
    local btnCommu
    local btnSetting

    local function onBtnnewMenuRelease(event)
        SEtouchButton()
        native.setActivityIndicator( true )
        ------------------------------------
--        if event.target.id == "battle" and previous_scene_name ~= "map" then
        if event.target.id == "battle"  then
            storyboard.gotoScene( "map", optionSet )

        elseif  event.target.id == "team"  then

            storyboard.gotoScene( "unit_main", optionSet )

        elseif  event.target.id == "shop"  then

            storyboard.gotoScene( "shop_money" , optionSet)

        elseif  event.target.id == "gacha" then

            storyboard.gotoScene( "gacha" , optionSet)

        elseif  event.target.id == "commu" then

            storyboard.gotoScene( "commu_main", optionSet )
        elseif  event.target.id == "setting" then

            storyboard.gotoScene( "game-setting", optionSet )
        end
    end
    btnSetting = widget.newButton{
        defaultFile = "img/head/as_butt_menu.png",
        width= sizemenuW*.65 ,
        height= sizemenuH*.40,
        onRelease = onBtnnewMenuRelease
    }
    btnSetting.id="setting"
    btnSetting:setReferencePoint( display.CenterReferencePoint )
    btnSetting.x = screenW*.82
    btnSetting.y = screenH*.128
local imgAll = {
       "battle_light",
       "battle_dark",

       "team_light",
       "team_dark",

       "battle_dark",
       "battle_dark",
       "battle_dark",
}

    btnHead = widget.newButton{
        defaultFile = image_ball,
        overFile = image_ball,
        width= sizeball ,
        height= sizeball,
        onRelease = onBtnnewMenuRelease
    }
    btnHead.id="battle1"
    btnHead:setReferencePoint( display.CenterReferencePoint )
    btnHead.x =screenW*.5
    btnHead.y =screenH*.17


    btnBattle = widget.newButton{
        defaultFile = "img/menu/battle_light.png",
        overFile = "img/menu/battle_dark.png",
        width= sizemenuW ,
        height= sizemenuH,
        onRelease = onBtnnewMenuRelease
    }
    btnBattle.id="battle"
    btnBattle:setReferencePoint( display.CenterReferencePoint )
    btnBattle.x =screenW-(screenW*.834)
    btnBattle.y = screenH-(screenH*.112)

    btnTeam = widget.newButton{
        defaultFile="img/menu/team_light.png",
        overFile="img/menu/team_dark.png",
        width=sizemenuW,
        height=sizemenuH,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x = screenW-(screenW*.667) -- 0.5 + .167
    btnTeam.y =screenH-(screenH*.112)

    btnShop = widget.newButton{
        defaultFile="img/menu/store_light.png",
        overFile="img/menu/store_dark.png",
        width=sizemenuW, height=sizemenuH,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnShop.id="shop"
    btnShop:setReferencePoint( display.CenterReferencePoint )
    btnShop.x = screenW-(screenW*.5)-- display center
    btnShop.y =screenH-(screenH*.112)

    btnGacha = widget.newButton{
        defaultFile="img/menu/gacha_light.png",
        overFile="img/menu/gacha_dark.png",
        width=sizemenuW, height=sizemenuH,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnGacha.id="gacha"
    btnGacha:setReferencePoint( display.CenterReferencePoint )
    btnGacha.x = screenW-(screenW*.333) -- 0.5 - .167
    btnGacha.y =screenH-(screenH*.112)

    btnCommu = widget.newButton{
        defaultFile="img/menu/commu_light.png",
        overFile="img/menu/commu_dark.png",
        width=sizemenuW, height=sizemenuH,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnCommu.id="commu"
    btnCommu:setReferencePoint( display.CenterReferencePoint )
    btnCommu.x = screenW-(screenW*.166)
    btnCommu.y =screenH-(screenH*.112)

--group:insert(btnHead)
--        group:insert(btnSetting)
--        group:insert(btnBattle)
--        group:insert(btnTeam)
--        group:insert(btnShop)
--        group:insert(btnGacha)
--        group:insert(btnCommu)


    --    maxlistFriend = 5
    local backcolorFN
    local MyfriendFN
    if maxlistFriend > 0 then
        backcolorFN=  display.newRoundedRect(screenW*.845, screenH*.823, screenW*.05, screenH*.033,5)
        backcolorFN:setReferencePoint(display.TopLeftReferencePoint)
        backcolorFN.strokeWidth = 2
        backcolorFN:setStrokeColor(255,255,255)
        backcolorFN.alpha = 1
        backcolorFN:setFillColor(200, 0, 0)
      --

        local sizeMaxfriend =  fontSize     --  25 pixel
        local maxLenght = string.len(maxlistFriend)
        local pointNum = (screenW*.865)-((maxLenght*sizeMaxfriend)/5)

        MyfriendFN = display.newText(maxlistFriend, pointNum, screenH*.827, typeFont, sizeMaxfriend)
        MyfriendFN:setReferencePoint(display.TopLeftReferencePoint)
        MyfriendFN:setFillColor(0, 0, 0)
--        group:insert(backcolorFN)
--        group:insert(MyfriendFN)
    end

    local usedataFrientPoint = 200
    local Myfriend
    local backcolor
    if dataFrientPoint >= usedataFrientPoint then
        backcolor =  display.newRoundedRect(screenW*.68, screenH*.823, screenW*.05, screenH*.033,5)
        backcolor:setReferencePoint(display.TopLeftReferencePoint)
        backcolor.strokeWidth = 2
        backcolor:setStrokeColor(255,255,255)
        backcolor.alpha = 1
        backcolor:setFillColor(200, 0, 0)

        local sizeMaxfriend = 20
        maxFriendPoint = math.floor(dataFrientPoint/usedataFrientPoint)
        local maxLenght = string.len(maxFriendPoint)
        local pointNum = (screenW*.70)-((maxLenght*sizeMaxfriend)/5)

        Myfriend = display.newText(maxFriendPoint, pointNum, screenH*.827, typeFont, sizeMaxfriend)
        Myfriend:setReferencePoint(display.TopLeftReferencePoint)
        Myfriend:setFillColor(0, 0, 0)
--        group:insert(backcolor)
--        group:insert(Myfriend)

    end




function removeDisplay()
    group:insert(background1)
    group:insert(imgDiamond)
    group:insert(imgCoin)
    group:insert(Myname)
    group:insert(MyDiamond)
    group:insert(MyCoin)
    group:insert(MyLV)
    group:insert(MyStamina)
    group:insert(linebaseRANG)
    group:insert(RANKcoler)
    group:insert(linebaseSTAMINA)
    group:insert(STAMINAcoler)

    group:insert(btnHead)
    group:insert(btnSetting)
    group:insert(btnBattle)
    group:insert(btnTeam)
    group:insert(btnShop)
    group:insert(btnGacha)
    group:insert(btnCommu)

    if backcolor then
        group:insert(backcolor)
        group:insert(Myfriend)
    end
    if backcolorFN then
        group:insert(backcolorFN)
        group:insert(MyfriendFN)
    end

     group.alpha = 0
--     group = nil

end
function ShowDisplay()
    group.alpha = 1
end

    --checkMemory()
--    return group
--end

function newMenubutton()
    local mond = display.newImageRect("img/head/DIAMOND.png",screenW*.07,screenH*.03)--contentWidth contentHeight
    mond:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    mond.x,mond.y = screenW*.62,screenH*.3
    mond.alpha = 0
    --    group:insert(imgDiamond)
    return    mond
end