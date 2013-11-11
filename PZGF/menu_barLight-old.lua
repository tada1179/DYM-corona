
---------------------------------------------------------------
module(..., package.seeall)
local storyboard = require( "storyboard" )
local sqlite3 = require("sqlite3")
local json = require("json")
local http = require("socket.http")
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
gameTimerText:setTextColor(205, 155, 29)
gameTimerText.alpha = 0

local timers = {}
------------------------------------------------------
local soundforBattle = {
    "SoundEffect/BGM/bgm_map01.wav", --walk in water
    "SoundEffect/BGM/bgm_map02.wav", --walk in water
    "SoundEffect/BGM/bgm_map03.wav", --walk in water
    "SoundEffect/BGM/bgm_map04.wav", --walk in water
    "SoundEffect/BGM/bgm_map05.wav", --walk in water

}
local se_battle09 = "SoundEffect/SE/se_battle09.wav"
local StartBattlelaserChannel = nil

local narrationSpeech = audio.loadStream("SoundEffect/BGM/bgm_map01.wav")
local laserSound = audio.loadSound(soundforBattle[10])    --water
local backgroundMusicChannel1
local backgroundMusicChannel2
function mainsound()
    local current = storyboard.getCurrentSceneName()
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

local auSEtouchPuzzleVictory
function SEtouchPuzzleVictory()

    local backgroundMusic = audio.loadStream(se_battle09)
    if auSEtouchPuzzleVictory== nil then
        auSEtouchPuzzleVictory = audio.play( backgroundMusic , { channel=21, loops=1 } )
        audio.setVolume( 0.5, { channel=21 } )
    else
        audio.stop( auSEtouchPuzzleVictory)
        auSEtouchPuzzleVictory = nil

        auSEtouchPuzzleVictory = audio.play( backgroundMusic , { channel=21, loops=1 } )
        audio.setVolume( 0.5, { channel=21 } )
    end

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
local auSEtouchPuzzleFight =nil
function SEtouchPuzzleFight()
    local se_button02 = "SoundEffect/SE/sword.mp3"
    local backgroundMusic = audio.loadStream(se_button02)

    if auSEtouchPuzzleFight == nil then
        auSEtouchPuzzleFight = audio.play( backgroundMusic , { channel=16, loops=0 } )
        audio.setVolume( 0.5, { channel=16 } )
    else
        audio.stop(auSEtouchPuzzleFight )
        auSEtouchPuzzleFight = nil

        auSEtouchPuzzleFight = audio.play( backgroundMusic , { channel=16, loops=0 } )
        audio.setVolume( 0.5, { channel=16 } )
    end

end
local auSEtouchEnamyFight =nil
function SEtouchEnamyFight()
    local se_button02 = "SoundEffect/SE/se_battle08.wav"
    local backgroundMusic = audio.loadStream(se_button02)

    if auSEtouchEnamyFight == nil then
        auSEtouchEnamyFight = audio.play( backgroundMusic , { channel=6, loops=0 } )
        audio.setVolume( 0.5, { channel=6 } )
    else
        audio.stop(auSEtouchEnamyFight )
        auSEtouchEnamyFight = nil
    end

end

local puzzlelaserChannel = nil
function SEtouchMovePuzzle()
    local se_button02 = "SoundEffect/SE/se_puzzle02.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    if puzzlelaserChannel == nil then
        puzzlelaserChannel = audio.play( backgroundMusic , { channel=15, loops=0 } )
        audio.setVolume( 0.5, { channel=15 } )
    else
        audio.stop(puzzlelaserChannel )
        puzzlelaserChannel = nil
    end
end


function SEtouchStartBattle()
    local backgroundMusic = audio.loadStream(se_battle09)

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

local auSEtouchMoveTeam = nil
function SEtouchMoveTeam()
    local se_button02 = "SoundEffect/SE/se_battle10.wav"
    local backgroundMusic = audio.loadStream(se_button02)

    if auSEtouchMoveTeam == nil then
        auSEtouchMoveTeam = audio.play( backgroundMusic , { channel=12, loops=0 } )
        audio.setVolume( 0.3, { channel=12 } )
    else
        audio.stop(auSEtouchMoveTeam )
        auSEtouchMoveTeam = nil

        auSEtouchMoveTeam = audio.play( backgroundMusic , { channel=12, loops=0 } )
        audio.setVolume( 0.3, { channel=12 } )
    end

end
local   auSEtouchButton = nil
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

local auSEtouchButtonBack  = nil
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

local auSECoin  = nil
function SECoin()
    local se_button02 = "SoundEffect/SE/test_coin.wav"
    local backgroundMusic = audio.loadStream(se_button02)
    if auSECoin == nil then

        auSECoin = audio.play( backgroundMusic , { channel=9, loops=0 } )
        audio.setVolume( 0.7, { channel=9 } )
    else
        audio.stop(auSECoin )
        auSECoin = nil

        auSECoin = audio.play( backgroundMusic , { channel=9, loops=0 } )
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
        backcolor.strokeWidth = 2
        backcolor:setStrokeColor(255,255,255)
        backcolor.alpha = 1
        backcolor:setFillColor(200, 0, 0)
--         group:insert(backcolor)

        local sizeMaxfriend = 20
        local maxLenght = string.len(maxlistFriend)
        local pointNum = (screenW*.66)-((maxLenght*sizeMaxfriend)/5)

        local Myfriend = display.newText(maxlistFriend, pointNum, screenH*.575, typeFont, sizeMaxfriend)
        Myfriend:setTextColor(0, 0, 0)
--         group:insert(Myfriend)

    end
    return group
end

function userLevel()
    SystemPhone()
    return dataLV
end
function diamond()
    SystemPhone()
    return dataDiamond
end
function FrientPoint()
    SystemPhone()
    return dataFrientPoint
end
function slot()
    SystemPhone()
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
    return dataName
end
function user_coin()
    SystemPhone()
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

    end

    if powerSTAMINA <= section[class] then
        colorSTAMINA =   (powerSTAMINA/section[class]) * maxLenghtPower

    end

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
    local data = userLevel()
end

function newMenubutton()
    local mond = display.newImageRect("img/head/DIAMOND.png",screenW*.07,screenH*.03)--contentWidth contentHeight
    mond:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    mond.x,mond.y = screenW*.62,screenH*.3
    mond.alpha = 0
--    group:insert(imgDiamond)
    return    mond
end


function background()
    local image_background  = "img/background/background_a1.png"
    local background = display.newImageRect(image_background,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
   -- return    background
end