
---------------------------------------------------------------
module(..., package.seeall)
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local json = require("json")
local http = require("socket.http")
local includeFUN = require("includeFunction")
---------------------------------------------------------------
local USERID
local screenW, screenH = display.contentWidth, display.contentHeight





--///////////////////////////////--
local dataName
local dataDiamond
local dataCoin
local dataLV
local powerRank = 0
local powerSTAMINA = 0
local maxLenghtPower = 200
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
function SystemPhone()

    local SysdeviceID = includeFUN.DriverIDPhone()
    local URL = "http://localhost/DYM/deviceID.php?SysdeviceID="..SysdeviceID
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        --print("ok have Dice")
        local dataTable = json.decode(response)
        USERID = dataTable.deviceID1.user_id
        dataName = dataTable.deviceID1.user_name
        dataDiamond = dataTable.deviceID1.user_ticket
        dataCoin = dataTable.deviceID1.user_coin
        dataLV = dataTable.deviceID1.user_level

        powerRank = tonumber(dataTable.deviceID1.user_power) --tonumber() change string to integer
        powerSTAMINA = tonumber(dataTable.deviceID1.user_deck)

        if powerRank > maxLenghtPower then
            powerRank = maxLenghtPower
        end

        if powerSTAMINA > maxLenghtPower then
            powerSTAMINA = maxLenghtPower
        end
    end
    return true

end
--***********************************************************--
function newMenubutton()
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
    local pointDiamond =  screenW*.66
    local pointCoin=  screenW*.73


     print("menu_barLight.lua")
    SystemPhone()
    local namelenght = string.len(dataName)
    local optionSet =
    {
            effect = "fade",
            time = 100,
            params = { USER_ID =USERID }
    }
     local pointName =  (screenW*.48)-((namelenght*sizetextname)/4)

     local group = display.newGroup()

     function onBtnnewMenuRelease(event)
         print( "event: "..event.target.id)
         if event.target.id == "battle" then
             storyboard.gotoScene( "map", optionSet )
         elseif  event.target.id == "team" then
             storyboard.gotoScene( "unit_main", optionSet )
         elseif  event.target.id == "shop" then
             storyboard.gotoScene( "shop_main", optionSet )
         elseif  event.target.id == "gacha" then
             storyboard.gotoScene( "gacha",optionSet )
         elseif  event.target.id == "commu" then
             storyboard.gotoScene( "commu_main", optionSet)
         end
         return true	-- indicates successful touch
     end
    --// community
    local LinkFriend = "http://localhost/DYM/request_list.php"
    local numberHold_character =  LinkFriend.."?user_id="..USERID
    local numberHold = http.request(numberHold_character)
    local maxlistFriend
    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        maxlistFriend = allRow.All
    end

    --

    local sizemenu = display.contentHeight*.1

     local background = display.newImageRect(image_background,screenW,screenH)--contentWidth contentHeight
     background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
     background.x,background.y = 0,0
     group:insert(background)

-- ******* ******* -----------------------------------------------------
     local Myname = display.newText(dataName, pointName, screenH*.05, typeFont, sizetextname)
     Myname:setTextColor(255, 0, 255)
     group:insert(Myname)

     local MyDiamond = display.newText(dataDiamond, pointDiamond, screenH*.12, typeFont, sizeCoinDiamond)
     MyDiamond:setTextColor(255, 0, 255)
     group:insert(MyDiamond)

     local MyCoin = display.newText(dataCoin, pointCoin, screenH*.17, typeFont, sizeCoinDiamond)
     MyCoin:setTextColor(255, 0, 255)
     group:insert(MyCoin)

     local MyLV = display.newText("Lv."..dataLV, screenW*.3, screenH*.11, typeFont, sizeCoinDiamond)
     MyLV:setTextColor(255, 0, 255)
     group:insert(MyLV)

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
     local STAMINAcoler = display.newImageRect(image_colerSTAMINA,powerSTAMINA,size_linebaseH)--contentWidth contentHeight
     STAMINAcoler:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
     STAMINAcoler.x,STAMINAcoler.y = pointLineX,linebaseSTAMINA.y
     group:insert(STAMINAcoler)
-- ******* *******   -----------------------------------------------------

     local btnBattle = widget.newButton{
         default = image_ball,
         over = image_ball,
         width= sizeball ,
         height= sizeball,
         onRelease = onBtnnewMenuRelease
     }
     btnBattle.id="battle"
     btnBattle:setReferencePoint( display.CenterReferencePoint )
     btnBattle.x =screenW*.5
     btnBattle.y =screenH*.17
     group:insert(btnBattle)

    local btnBattle = widget.newButton{
        default = "img/menu/battle_light.png",
        over = "img/menu/battle_dark.png",
        width= sizemenu ,
        height= sizemenu,
        onRelease = onBtnnewMenuRelease
    }
    btnBattle.id="battle"
    btnBattle:setReferencePoint( display.CenterReferencePoint )
    btnBattle.x =display.contentWidth-(display.contentWidth*.834)
    btnBattle.y =  display.contentHeight-(display.contentHeight*.112)

    local btnTeam = widget.newButton{
        default="img/menu/team_light.png",
        over="img/menu/team_dark.png",
        width=sizemenu,
        height=sizemenu,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x = display.contentWidth-(display.contentWidth*.667) -- 0.5 + .167
    btnTeam.y = display.contentHeight-(display.contentHeight*.112)

    local btnShop = widget.newButton{
        default="img/menu/store_light.png",
        over="img/menu/store_dark.png",
        width=sizemenu, height=sizemenu,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnShop.id="shop"
    btnShop:setReferencePoint( display.CenterReferencePoint )
    btnShop.x = display.contentWidth-(display.contentWidth*.5)-- display center
    btnShop.y = display.contentHeight-(display.contentHeight*.112)

    local btnGacha = widget.newButton{
        default="img/menu/gacha_light.png",
        over="img/menu/gacha_dark.png",
        width=sizemenu, height=sizemenu,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnGacha.id="gacha"
    btnGacha:setReferencePoint( display.CenterReferencePoint )
    btnGacha.x = display.contentWidth-(display.contentWidth*.333) -- 0.5 - .167
    btnGacha.y = display.contentHeight-(display.contentHeight*.112)

    local btnCommu = widget.newButton{
        default="img/menu/commu_light.png",
        over="img/menu/commu_dark.png",
        width=sizemenu, height=sizemenu,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnCommu.id="commu"
    btnCommu:setReferencePoint( display.CenterReferencePoint )
    btnCommu.x = display.contentWidth-(display.contentWidth*.166)
    btnCommu.y = display.contentHeight-(display.contentHeight*.112)



    group:insert(btnBattle)
    group:insert(btnTeam)
    group:insert(btnShop)
    group:insert(btnGacha)
    group:insert(btnCommu)
    print("*** maxlistFriend",maxlistFriend)
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
    checkMemory()
     return group
end

function userLevel()
    SystemPhone()
    return dataLV
end
