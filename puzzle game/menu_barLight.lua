
---------------------------------------------------------------
module(..., package.seeall)
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local json = require("json")
local http = require("socket.http")
local current = storyboard.getCurrentSceneName()
---------------------------------------------------------------
local USERID
local screenW, screenH = display.contentWidth, display.contentHeight

--///////////////////////////////--
local dataName
local dataDiamond
local dataCoin
local dataLV
local dataslot
local dataFrientPoint
local datacharacterAll

local powerRank = 0
local powerSTAMINA = 0
local colorSTAMINA = 0
local maxLenghtPower = 200
local maxlistFriend

function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "menu MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
    return true
end
function SystemPhone()
    local SysdeviceID = require("includeFunction").DriverIDPhone()

    --    ---check user----
    --    local NewUserCheck = "http://133.242.169.252/DYM/checkuser.php?deviceID="..SysdeviceID
    --    local UserCheck = http.request(NewUserCheck)
    --
    --    if UserCheck == "OLD" then
    --        local function onComplete( event )
    --            if "clicked" == event.action then
    --                local i = event.index
    --                if 1 == i then
    --                        -- Do nothing; dialog will simply dismiss
    --                elseif 2 == i then
    --                        -- Open URL if "Learn More" (the 2nd button) was clicked
    --                        system.openURL( "http://www.coronalabs.com" )
    --                end
    --            end
    --        end
    --        -- Show alert with two buttons
    --        --local alert = native.showAlert( "Three Kindoms", "Welcome Back")
    --    else
    --        --- save new device
    --        local NewUserSave = "http://133.242.169.252/DYM/SaveUser.php?deviceID="..SysdeviceID
    --        local UserSave = http.request(NewUserSave)
    --
    --    end
    --    ---end check user------

--    local URL = "http://133.242.169.252/DYM/deviceID.php?SysdeviceID="..SysdeviceID
    local URL = "http://localhost/DYM/deviceID.php?SysdeviceID="..SysdeviceID
    --    local URL = "http://133.242.169.252/DYM/deviceID.php?SysdeviceID="..SysdeviceID
    print("URL", URL);
    local response = http.request(URL)
    local dataTable = json.decode(response)
    if dataTable.deviceID1 == nil then
        --storyboard.gotoScene( "register", "fade",100 )
    else
        local dataTable = json.decode(response)
        USERID = dataTable.deviceID1.user_id
        dataName = dataTable.deviceID1.user_name
        dataDiamond = tonumber(dataTable.deviceID1.user_ticket)
        dataCoin = tonumber(dataTable.deviceID1.user_coin)
        dataLV = tonumber(dataTable.deviceID1.user_level)
        dataslot = tonumber(dataTable.deviceID1.user_deck)
        dataFrientPoint = tonumber(dataTable.deviceID1.user_FrientPoint)
        datacharacterAll = tonumber(dataTable.deviceID1.user_characterAll)

        powerRank = tonumber(dataTable.deviceID1.user_level) --tonumber() change string to integer
        powerSTAMINA = tonumber(dataTable.deviceID1.user_power)


    end
    return true

end
--***********************************************************--
function numFriend()
    SystemPhone()
--    local LinkFriend = "http://133.242.169.252/DYM/request_list.php"
    local LinkFriend = "http://localhost/DYM/request_list.php"
    local numberHold_character =  LinkFriend.."?user_id="..USERID
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        maxlistFriend = allRow.All
    end
    return maxlistFriend
end

function newMenubutton()
    local previous_scene_name = storyboard.getCurrentSceneName()
    local image_ball = "img/menu/battle_dark.png"
    local image_linebase = "img/head/line.png"
    local image_colerRANK = "img/head/red_colour.png"
    local image_colerSTAMINA = "img/head/blue_colour.png"
    local image_background = "img/background/background_2.png"

    local typeFont =  native.systemFontBold
    local sizetextname = 25
    local sizeCoinDiamond = 20

    local sizeball =  screenW*.2
    local size_linebaseW =  screenW*.3 -- 640*3=192,192/4= 48 ok (mod = 0 )
    local size_linebaseH =  screenH*.008
    local pointLineX =  screenW*.08

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
    local maxpowerSTAMINA = stamina()
    local background = display.newImageRect(image_background,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    group:insert(background)

    local imgDiamond = display.newImageRect("img/head/DIAMOND.png",screenW*.07,screenH*.03)--contentWidth contentHeight
    imgDiamond:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgDiamond.x,imgDiamond.y = screenW*.62,screenH*.115
    group:insert(imgDiamond)

    local imgCoin = display.newImageRect("img/head/COIN.png",screenW*.05,screenH*.03)--contentWidth contentHeight
    imgCoin:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgCoin.x,imgCoin.y = screenW*.62,screenH*.165
    group:insert(imgCoin)

    --[[local imgSetting = display.newImageRect("img/head/as_butt_menu.png",screenW*.08,screenH*.04)--contentWidth contentHeight
    imgSetting:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgSetting.x,imgSetting.y = screenW*.8,screenH*.108
    group:insert(imgSetting)--]]
    -- ******* ******* -----------------------------------------------------
    local Myname = display.newText(dataName, pointName, screenH*.05, typeFont, sizetextname)
    Myname:setTextColor(255, 255, 255)
    group:insert(Myname)

    local MyDiamond = display.newText(dataDiamond, pointDiamond, screenH*.116, typeFont, sizeCoinDiamond)
    MyDiamond:setTextColor(205, 38, 38)
    group:insert(MyDiamond)

    local MyCoin = display.newText(dataCoin, pointCoin, screenH*.17, typeFont, sizeCoinDiamond)
    MyCoin:setTextColor(205, 155, 29)
    group:insert(MyCoin)

    local MyLV = display.newText("Lv."..dataLV, screenW*.28, screenH*.11, typeFont, sizeCoinDiamond)
    MyLV:setTextColor(255, 255, 255)
    group:insert(MyLV)

    local MyStamina = display.newText(powerSTAMINA.."/"..maxpowerSTAMINA, screenW*.28, screenH*.16, typeFont, sizeCoinDiamond)
    MyStamina:setTextColor(255, 255, 255)
    group:insert(MyStamina)

    local linebaseRANG = display.newImageRect(image_linebase,size_linebaseW,size_linebaseH)--contentWidth contentHeight
    linebaseRANG:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    linebaseRANG.x,linebaseRANG.y = pointLineX,screenH*.14
    group:insert(linebaseRANG)
    local RANKcoler = display.newImageRect(image_colerRANK,powerRank,size_linebaseH)--contentWidth contentHeight
    RANKcoler:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    RANKcoler.x,RANKcoler.y = pointLineX,linebaseRANG.y
    group:insert(RANKcoler)

    local linebaseSTAMINA = display.newImageRect(image_linebase,size_linebaseW,size_linebaseH)--contentWidth contentHeight
    linebaseSTAMINA:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    linebaseSTAMINA.x,linebaseSTAMINA.y = pointLineX,screenH*.19
    group:insert(linebaseSTAMINA)
    local STAMINAcoler = display.newImageRect(image_colerSTAMINA,colorSTAMINA,size_linebaseH)--contentWidth contentHeight
    STAMINAcoler:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    STAMINAcoler.x,STAMINAcoler.y = pointLineX,linebaseSTAMINA.y
    group:insert(STAMINAcoler)
    -- ******* *******   -----------------------------------------------------
    local btnHead
    local btnBattle
    local btnTeam
    local btnShop
    local btnGacha
    local btnCommu
    local btnSetting

    local function onBtnnewMenuRelease(event)

        ------------------------------------
        if event.target.id == "battle" and previous_scene_name ~= "map" then
            display.remove(linebaseSTAMINA)
            linebaseSTAMINA = nil
            display.remove(STAMINAcoler)
            STAMINAcoler = nil
            display.remove(RANKcoler)
            RANKcoler = nil
            display.remove(linebaseRANG)
            linebaseRANG = nil
            display.remove(MyStamina)
            MyStamina = nil
            display.remove(MyLV)
            MyLV = nil
            display.remove(MyCoin)
            MyCoin = nil
            display.remove(MyDiamond)
            MyDiamond = nil
            display.remove(Myname)
            Myname = nil
            display.remove(imgCoin)
            imgCoin = nil
            display.remove(imgDiamond)
            imgDiamond = nil
            display.remove(background)
            background = nil

            btnSetting:remove(btnSetting)
            display.remove(btnSetting)
            btnSetting= nil
            btnBattle:remove(btnBattle)
            display.remove(btnBattle)
            btnBattle= nil
            btnTeam:remove(btnTeam)
            display.remove(btnTeam)
            btnTeam = nil
            btnShop:remove(btnShop)
            display.remove(btnShop)
            btnShop = nil
            btnGacha:remove(btnGacha)
            display.remove(btnGacha)
            btnGacha = nil
            btnCommu:remove(btnCommu)
            display.remove(btnCommu)
            btnCommu = nil
            group:remove(btnCommu)
            display.remove(group)
            group = nil

            storyboard.gotoScene( "map", optionSet )

        elseif  event.target.id == "team" and previous_scene_name ~= "unit_main" then
            display.remove(linebaseSTAMINA)
            linebaseSTAMINA = nil
            display.remove(STAMINAcoler)
            STAMINAcoler = nil
            display.remove(RANKcoler)
            RANKcoler = nil
            display.remove(linebaseRANG)
            linebaseRANG = nil
            display.remove(MyStamina)
            MyStamina = nil
            display.remove(MyLV)
            MyLV = nil
            display.remove(MyCoin)
            MyCoin = nil
            display.remove(MyDiamond)
            MyDiamond = nil
            display.remove(Myname)
            Myname = nil
            display.remove(imgCoin)
            imgCoin = nil
            display.remove(imgDiamond)
            imgDiamond = nil
            display.remove(background)
            background = nil

            btnSetting:remove(btnSetting)
            display.remove(btnSetting)
            btnSetting= nil
            btnBattle:remove(btnBattle)
            display.remove(btnBattle)
            btnBattle= nil
            btnTeam:remove(btnTeam)
            display.remove(btnTeam)
            btnTeam = nil
            btnShop:remove(btnShop)
            display.remove(btnShop)
            btnShop = nil
            btnGacha:remove(btnGacha)
            display.remove(btnGacha)
            btnGacha = nil
            btnCommu:remove(btnCommu)
            display.remove(btnCommu)
            btnCommu = nil
            group:remove(btnCommu)
            display.remove(group)
            group = nil
            storyboard.gotoScene( "unit_main", optionSet )

        elseif  event.target.id == "shop" and previous_scene_name ~= "shop_main" then
            display.remove(linebaseSTAMINA)
            linebaseSTAMINA = nil
            display.remove(STAMINAcoler)
            STAMINAcoler = nil
            display.remove(RANKcoler)
            RANKcoler = nil
            display.remove(linebaseRANG)
            linebaseRANG = nil
            display.remove(MyStamina)
            MyStamina = nil
            display.remove(MyLV)
            MyLV = nil
            display.remove(MyCoin)
            MyCoin = nil
            display.remove(MyDiamond)
            MyDiamond = nil
            display.remove(Myname)
            Myname = nil
            display.remove(imgCoin)
            imgCoin = nil
            display.remove(imgDiamond)
            imgDiamond = nil
            display.remove(background)
            background = nil

            btnSetting:remove(btnSetting)
            display.remove(btnSetting)
            btnSetting= nil
            btnBattle:remove(btnBattle)
            display.remove(btnBattle)
            btnBattle= nil
            btnTeam:remove(btnTeam)
            display.remove(btnTeam)
            btnTeam = nil
            btnShop:remove(btnShop)
            display.remove(btnShop)
            btnShop = nil
            btnGacha:remove(btnGacha)
            display.remove(btnGacha)
            btnGacha = nil
            btnCommu:remove(btnCommu)
            display.remove(btnCommu)
            btnCommu = nil
            group:remove(btnCommu)
            display.remove(group)
            group = nil
            storyboard.gotoScene( "shop_main" , optionSet)

        elseif  event.target.id == "gacha" and previous_scene_name ~= "gacha" then
            display.remove(linebaseSTAMINA)
            linebaseSTAMINA = nil
            display.remove(STAMINAcoler)
            STAMINAcoler = nil
            display.remove(RANKcoler)
            RANKcoler = nil
            display.remove(linebaseRANG)
            linebaseRANG = nil
            display.remove(MyStamina)
            MyStamina = nil
            display.remove(MyLV)
            MyLV = nil
            display.remove(MyCoin)
            MyCoin = nil
            display.remove(MyDiamond)
            MyDiamond = nil
            display.remove(Myname)
            Myname = nil
            display.remove(imgCoin)
            imgCoin = nil
            display.remove(imgDiamond)
            imgDiamond = nil
            display.remove(background)
            background = nil

            btnSetting:remove(btnSetting)
            display.remove(btnSetting)
            btnSetting= nil
            btnBattle:remove(btnBattle)
            display.remove(btnBattle)
            btnBattle= nil
            btnTeam:remove(btnTeam)
            display.remove(btnTeam)
            btnTeam = nil
            btnShop:remove(btnShop)
            display.remove(btnShop)
            btnShop = nil
            btnGacha:remove(btnGacha)
            display.remove(btnGacha)
            btnGacha = nil
            btnCommu:remove(btnCommu)
            display.remove(btnCommu)
            btnCommu = nil
            group:remove(btnCommu)
            display.remove(group)
            group = nil
            storyboard.gotoScene( "gacha" , optionSet)

        elseif  event.target.id == "commu" and previous_scene_name ~= "commu_main" then
            display.remove(linebaseSTAMINA)
            linebaseSTAMINA = nil
            display.remove(STAMINAcoler)
            STAMINAcoler = nil
            display.remove(RANKcoler)
            RANKcoler = nil
            display.remove(linebaseRANG)
            linebaseRANG = nil
            display.remove(MyStamina)
            MyStamina = nil
            display.remove(MyLV)
            MyLV = nil
            display.remove(MyCoin)
            MyCoin = nil
            display.remove(MyDiamond)
            MyDiamond = nil
            display.remove(Myname)
            Myname = nil
            display.remove(imgCoin)
            imgCoin = nil
            display.remove(imgDiamond)
            imgDiamond = nil
            display.remove(background)
            background = nil

            btnSetting:remove(btnSetting)
            display.remove(btnSetting)
            btnSetting= nil
            btnBattle:remove(btnBattle)
            display.remove(btnBattle)
            btnBattle= nil
            btnTeam:remove(btnTeam)
            display.remove(btnTeam)
            btnTeam = nil
            btnShop:remove(btnShop)
            display.remove(btnShop)
            btnShop = nil
            btnGacha:remove(btnGacha)
            display.remove(btnGacha)
            btnGacha = nil
            btnCommu:remove(btnCommu)
            display.remove(btnCommu)
            btnCommu = nil
            group:remove(btnCommu)
            display.remove(group)
            group = nil
            storyboard.gotoScene( "commu_main", optionSet )
        elseif  event.target.id == "setting" and previous_scene_name ~= "setting" then

            storyboard.gotoScene( "game-setting", optionSet )
        end
    end
    btnSetting = widget.newButton{
        defaultFile = "img/head/as_butt_menu.png",
        overFile= "img/head/as_butt_menu.png",
        width= screenW*.1 ,
        height= screenH*.05,
        onRelease = onBtnnewMenuRelease
    }
    btnSetting.id="setting"
    btnSetting:setReferencePoint( display.CenterReferencePoint )
    btnSetting.x = screenW*.82
    btnSetting.y = screenH*.128

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

    group:insert(btnSetting)
    group:insert(btnHead)
    group:insert(btnBattle)
    group:insert(btnTeam)
    group:insert(btnShop)
    group:insert(btnGacha)
    group:insert(btnCommu)


    --    maxlistFriend = 5

    if maxlistFriend > 0 then
        local backcolor =  display.newRoundedRect(screenW*.845, screenH*.823, screenW*.05, screenH*.033,5)
        backcolor.strokeWidth = 2
        backcolor:setStrokeColor(255,255,255)
        backcolor.alpha = 1
        backcolor:setFillColor(200, 0, 0)
        group:insert(backcolor)

        local sizeMaxfriend = 20
        local maxLenght = string.len(maxlistFriend)
        local pointNum = (screenW*.865)-((maxLenght*sizeMaxfriend)/5)

        local Myfriend = display.newText(maxlistFriend, pointNum, screenH*.827, typeFont, sizeMaxfriend)
        Myfriend:setTextColor(0, 0, 0)
        group:insert(Myfriend)

    end

    storyboard.removeAll ()
    storyboard.purgeAll()
    --checkMemory()
    return group
end

function newrequestList()
    local typeFont =  native.systemFontBold
    local group = display.newGroup()
    --        maxlistFriend = 1
    if maxlistFriend > 0 then
        local backcolor =  display.newRoundedRect(screenW*.642, screenH*.57, screenW*.05, screenH*.033,5)
        backcolor.strokeWidth = 2
        backcolor:setStrokeColor(255,255,255)
        backcolor.alpha = 1
        backcolor:setFillColor(200, 0, 0)
        group:insert(backcolor)

        local sizeMaxfriend = 20
        local maxLenght = string.len(maxlistFriend)
        local pointNum = (screenW*.66)-((maxLenght*sizeMaxfriend)/5)

        local Myfriend = display.newText(maxlistFriend, pointNum, screenH*.575, typeFont, sizeMaxfriend)
        Myfriend:setTextColor(0, 0, 0)
        group:insert(Myfriend)

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



