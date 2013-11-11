---- Project : Puzzle game
---- Author  : Eric MO
---- Description : getting data from remote server and stroe in sqlite
module(..., package.seeall)
local screenW, screenH = display.contentWidth, display.contentHeight
local sqlite3 = require("sqlite3")
local json = require("json")
local http = require("socket.http")
local ltn12 = require("ltn12")

function stopLload()
    native.setActivityIndicator( false )
end
function newload()



    --local http = require("socket.http")
    local SysdeviceID = require("includeFunction").DriverIDPhone()

    local newDatas
    local FriendList_response
    local map_id

    -- User Table variables
    local user_id
    local user_name
    local user_type
    local user_coin
    local user_diamond
    local user_exp
    local user_level
    local user_lots
    local user_FrientPoint
    local user_charac
    local user_power
    local user_stima

    -- UserFriendList Table variable
    local max_no_friends
    local character_id
    local friend_id
    local friend_name
    local friend_level
    local charac_attack
    local charac_defense
    local charac_hp
    local charac_level
    local charac_element
    local charac_img_mini
    local charac_img
    local leader_id
    local friend_modify
    local team_lastuse

    --- Map Substates Table variable
    local chapter_mission_run
    local chapter_name
    local chapter_id
    local ID_status
    native.setActivityIndicator( true )
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    db:exec("Drop Table UserFriendList;")
    db:exec("Drop Table MapSubstates;")
    db:exec("Drop Table mission_list;")
    ---- Create MapSubstate Table
    local MapSubstates = "CREATE TABLE IF NOT EXISTS MapSubstates ( mapsubstate_id INTEGER PRIMARY KEY AUTOINCREMENT, map_id ,"
    MapSubstates = MapSubstates.."chapter_mission_run ,chapter_name ,"
    MapSubstates = MapSubstates.."chapter_id , ID_status);"

    db:exec(MapSubstates)

    local tablemission_list = "CREATE TABLE IF NOT EXISTS mission_list (chapter_id, All,mission_id,mission_name,"
    tablemission_list = tablemission_list.."mission_img,mission_img_boss,mission_boss_element"
    tablemission_list = tablemission_list..",mission_stamina,mission_run,characterNum,ID_clear);"
    db:exec(tablemission_list)

    local SaveUserData = function()

    -- Create/Open Database
    --local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    --db = sqlite3.open( path )

        db:exec("Drop Table user;")
        -- Create Table
        local tablesetup = "CREATE TABLE IF NOT EXISTS user (user_id INTEGER PRIMARY KEY, user_udid ,user_name , user_diamond ,"
        tablesetup = tablesetup.."user_type , user_exp , user_level , user_element , user_coin , user_power , user_deck , user_FrientPoint , user_borncharac);"

        db:exec( tablesetup )
        if (newDatas.deviceID1 ~= nil) then
            user_id   = newDatas.deviceID1.user_id
            user_name = newDatas.deviceID1.user_name
            user_type = newDatas.deviceID1.user_type
            user_coin = tonumber(newDatas.deviceID1.user_coin)
            user_diamond = tonumber(newDatas.deviceID1.user_ticket)
            user_exp  = tonumber(newDatas.deviceID1.user_exp)
            user_level = tonumber(newDatas.deviceID1.user_level)
            user_lots = tonumber(newDatas.deviceID1.user_deck)
            user_FrientPoint = tonumber(newDatas.deviceID1.user_FrientPoint)
            user_charac = tonumber(newDatas.deviceID1.user_characterAll)
            user_power = math.floor(newDatas.deviceID1.user_power) --tonumber() change string to integer


            local tablefill ="INSERT INTO user VALUES ('"..user_id.."','" .. SysdeviceID .. "','".. user_name .. "','"
                    .. user_diamond .."','".. user_type .."', '"..user_exp.."' ,'".. user_level .."', '"..user_lots.."' ,'"
                    .. user_coin .."','".. user_power .."','".. user_lots .. "','".. user_FrientPoint .."','".. user_charac .."');"
            db:exec( tablefill )
        end

        hold_character(user_id)
    -- use_character(user_id)
    end

    local SaveFriendListData = function()

    --local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    --db = sqlite3.open( path )


        db:exec("Drop Table UserFriendList;")

        local Firendtablesetup = "CREATE TABLE IF NOT EXISTS UserFriendList (user_id INTEGER PRIMARY KEY, max_no_friends "
        Firendtablesetup = Firendtablesetup ..",character_id , friend_id , friend_name , friend_level , charac_attack , "
        Firendtablesetup = Firendtablesetup .."charac_defense , charac_hp , charac_level , charac_element , charac_img_mini "
        Firendtablesetup = Firendtablesetup..", charac_img, leader_id, friend_modify, team_lastuse);"

        db:exec( Firendtablesetup )

        if(FriendList_response.chracter)then

            max_no_friends  = FriendList_response.All
            character_id	= FriendList_response.chracter[1].charac_id
            friend_id 		= FriendList_response.chracter[1].friend_id
            friend_name		= FriendList_response.chracter[1].friend_name
            friend_level	= FriendList_response.chracter[1].friend_lv
            charac_attack   = FriendList_response.chracter[1].charac_atk
            charac_defense  = FriendList_response.chracter[1].charac_def
            charac_hp		= FriendList_response.chracter[1].charac_hp
            charac_level    = FriendList_response.chracter[1].charac_lv
            charac_element  = FriendList_response.chracter[1].charac_element
            charac_img_mini = FriendList_response.chracter[1].charac_img_mini
            charac_img 		= FriendList_response.chracter[1].charac_img
            leader_id		= FriendList_response.chracter[1].leader_id
            friend_modify	= FriendList_response.chracter[1].friend_modify
            team_lastuse 	= FriendList_response.chracter[1].team_lastuse

            local Friendtablefill ="INSERT INTO UserFriendList VALUES ('"..user_id.."','" .. max_no_friends .. "','"
                    .. character_id .. "','" .. friend_id .."','".. friend_name .."','".. friend_level .."','"
                    .. charac_attack .."','".. charac_defense .."','".. charac_hp .. "','".. charac_level .."','"
                    .. charac_element .."','"..charac_img_mini.."','"..charac_img.."','"..leader_id.."','"..friend_modify.."','"..team_lastuse.."');"

            db:exec( Friendtablefill )
        end
    --db:close()

    end

    local SaveMissionList = function(chapter_id)
        local Linkmission = "http://133.242.169.252/DYM/mission_list.php"
        local numberHold_character =  Linkmission.."?user_id="..user_id.."&chapter_id="..chapter_id
        local numberHold = http.request(numberHold_character)
        local characterItem = {}
        local maxChapter
        if numberHold == nil then
            print("No Dice")
        else
            local allRow  = json.decode(numberHold)
            maxChapter = tonumber(allRow.All)

            local k = maxChapter
            while k > 0  do
                characterItem[k] = {}
                characterItem[k].mission_id = allRow.mission[k].mission_id
                characterItem[k].mission_name = allRow.mission[k].mission_name
                characterItem[k].mission_img= allRow.mission[k].mission_img
                characterItem[k].mission_img_boss= allRow.mission[k].mission_img_boss
                characterItem[k].mission_boss_element= tonumber(allRow.mission[k].mission_boss_element)
                characterItem[k].mission_stamina= tonumber(allRow.mission[k].mission_stamina)
                characterItem[k].mission_run = tonumber(allRow.mission[k].mission_run)
                characterItem[k].mission_characterNum = tonumber(allRow.mission[k].characterNum)
                characterItem[k].ID_clear = allRow.mission[k].ID_clear
                --            local insertTableFill ="INSERT INTO mission_list VALUES('"..chapter_id.."','"..maxChapter.."','"..characterItem[k].mission_id.."','"..characterItem[k].mission_name.."','"
                --                    ..characterItem[k].mission_img.."','"..characterItem[k].mission_img_boss.."','"..characterItem[k].mission_boss_element.."','"
                --                    ..characterItem[k].mission_stamina.."','"..characterItem[k].mission_run.."','"
                --                    ..characterItem[k].mission_characterNum.."','"..characterItem[k].ID_clear.."');"

                local insertTableFill ="INSERT INTO mission_list (chapter_id) VALUES('as');"
                db:exec(insertTableFill)

                k = k - 1
            end

            local path = system.pathForFile("datas.db", system.DocumentsDirectory)
            db = sqlite3.open( path )

            for x in db:nrows("SELECT * FROM mission_list WHERE chapter_id ='"..chapter_id.."';") do
                --print("aaaa")
            end
        end

    end

    -- chapter_id from map
    local SaveMapSubstates = function()
        local y = map_substates_data.All

        for index=1, y, 1 do
            chapter_mission_run = map_substates_data.chapter[index].chapter_mission_run
            chapter_name		= map_substates_data.chapter[index].chapter_name
            chapter_id			= map_substates_data.chapter[index].chapter_id
            ID_status			= map_substates_data.chapter[index].ID_status
            map_id			= map_substates_data.chapter[index].map_id


            local MapSubstatesfill = "INSERT INTO MapSubstates ( map_id , chapter_mission_run ,"
            MapSubstatesfill = MapSubstatesfill.."chapter_name, chapter_id , ID_status) "
            MapSubstatesfill = MapSubstatesfill.."VALUES ( '"..map_id.."','"..chapter_mission_run.."','"..chapter_name.."','"..chapter_id.."','"..ID_status.."');"
            local success = db:exec(MapSubstatesfill)
            --SaveMissionList(chapter_id)
        end

    --for x in db:nrows("SELECT * FROM MapSubstates WHERE map_id = 1 ") do print(x.chapter_name) end

    end
    --- get User information ----------------
    local function FNSysdeviceID()
        local URL = "http://133.242.169.252/DYM/deviceID.php?SysdeviceID="..SysdeviceID
        local response = http.request(URL)
        newDatas = json.decode(response)

        if newDatas.deviceID1 then
            user_id   = newDatas.deviceID1.user_id
            SaveUserData()

            -- Get user friend list -----------------
            local URL_FriendList = "http://133.242.169.252/DYM/request_list.php?user_id="..user_id

            response = http.request(URL_FriendList)
            FriendList_response = json.decode(response)
            SaveFriendListData()

            local map_url = "http://133.242.169.252/DYM/user_mission.php?user_id="..user_id
            --map_id = i
            map_substates = http.request(map_url)
            map_substates_data = json.decode(map_substates)
            SaveMapSubstates()
        else
            FNSysdeviceID()
        end
    end

    FNSysdeviceID()
    timer.performWithDelay( 400, stopLload)
    loadImageSprite_Upgrade_Animation5()
    loadImageSprite_Item_Effect()

    --- Chaper download
    function chapter_download()
        local mission_url = "http://133.242.169.252/DYM/mission_list.php?user_id="..user_id
    end
    db:close()

    return true
end
function hold_character(user_id)
    local LinkURL = "http://133.242.169.252/DYM/hold_character.php"
    local numberHold_character =  LinkURL.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)


    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )
    db:exec("Drop Table hold_character;")
    local hold_char = "CREATE TABLE IF NOT EXISTS hold_character ( holdcharac_id ,charac_img_mini ,charac_id ,"
    hold_char = hold_char.."charac_element ,charac_lv ,charac_exp ,charac_sac ,charac_lvmax ,formula);"
    db:exec(hold_char)


    local allRow = {}
    if numberHold == nil then
        print("No Dice")
    else
        allRow  = json.decode(numberHold)
        local Allcharacter = allRow.chrAll
        local characterItem = {}
        local formula = {}
        local k = 1
        while(k <= Allcharacter) do
            characterItem[k] = {}
            characterItem[k].holdcharac_id = allRow.chracter[k].holdcharac_id
            characterItem[k].dataTable = allRow.chracter[k].charac_img_mini
            characterItem[k].charactID = allRow.chracter[k].charac_id
            characterItem[k].element = tonumber(allRow.chracter[k].charac_element)
            characterItem[k].level = tonumber(allRow.chracter[k].charac_lv)
            characterItem[k].exp = tonumber(allRow.chracter[k].charac_exp)
            characterItem[k].charac_sac = tonumber(allRow.chracter[k].charac_sac)
            characterItem[k].charac_lvmax = tonumber(allRow.chracter[k].charac_lvmax)
            formula[k] = math.ceil(characterItem[k].charac_sac+(characterItem[k].charac_sac*((characterItem[k].level-1)/characterItem[k].charac_lvmax)*1.5))

            local hold_charfill = "INSERT INTO hold_character (   holdcharac_id ,charac_img_mini ,charac_id ,"
            hold_charfill = hold_charfill.."charac_element ,charac_lv ,charac_exp ,charac_sac ,charac_lvmax ,formula) "
            hold_charfill = hold_charfill.."VALUES ( '"..characterItem[k].holdcharac_id.."','"..characterItem[k].dataTable.."','"..characterItem[k].charactID.."','"..characterItem[k].element.."','"
                    ..characterItem[k].level.."','"..characterItem[k].exp.."','"..characterItem[k].charac_sac.."','"..characterItem[k].charac_lvmax.."','"..formula[k].."');"
            local success = db:exec(hold_charfill)

            k = k + 1
        end
    end
    -- db:close()
end
function use_character(user_id)
    local LinkURL = "http://133.242.169.252/DYM/useCharacterAll.php"
    local numberHold_character =  LinkURL.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)


    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )
    db:exec("Drop Table hold_character;")
    local hold_char = "CREATE TABLE IF NOT EXISTS useCharacterAll ( holdcharac_id ,charac_img_mini ,charac_id ,"
    hold_char = hold_char.."charac_element ,charac_lv ,charac_exp ,charac_sac ,charac_lvmax ,use_id);"
    db:exec(hold_char)

    local characterItem = {}
    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        local Allcharacter = allRow.chrAll
        local k = 1
        while(k <= Allcharacter) do
            characterItem[k] = {}
            characterItem[k].holdcharac = allRow.chracter[k].holdcharac_id
            characterItem[k].dataTable = allRow.chracter[k].charac_img_mini
            characterItem[k].charactID = allRow.chracter[k].charac_id
            characterItem[k].element = tonumber(allRow.chracter[k].charac_element)
            characterItem[k].level = tonumber(allRow.chracter[k].charac_lv)
            characterItem[k].charac_exp = tonumber(allRow.chracter[k].charac_exp)
            characterItem[k].charac_sac = tonumber(allRow.chracter[k].charac_sac)
            characterItem[k].charac_lvmax = tonumber(allRow.chracter[k].charac_lvmax)
            characterItem[k].use = allRow.chracter[k].use_id
            local hold_charfill = "INSERT INTO useCharacterAll (   holdcharac_id ,charac_img_mini ,charac_id ,"
            hold_charfill = hold_charfill.."charac_element ,charac_lv ,charac_exp ,charac_sac ,charac_lvmax ,use_id) "
            hold_charfill = hold_charfill.."VALUES ( '"..characterItem[k].holdcharac_id.."','"..characterItem[k].dataTable.."','"..characterItem[k].charactID.."','"..characterItem[k].element.."','"
                    ..characterItem[k].level.."','"..characterItem[k].exp.."','"..characterItem[k].charac_sac.."','"..characterItem[k].charac_lvmax.."','"..characterItem[k].use.."');"
            local success = db:exec(hold_charfill)
            k = k + 1
        end
    end
    db:close()
end

function loadImage()
    native.setActivityIndicator( true )
    function showImagechara_full()

        local path = system.pathForFile( "chara_full.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )

        http.request{
            url = "http://133.242.169.252/img/character/chara_full.png",
            sink = ltn12.sink.file(myFile),
        }
        timer.performWithDelay( 400, stopLload)
    end

    function loadImageicon()
        -- Create local file for saving data
        local path = system.pathForFile( "chara_icon.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/character/chara_icon.png",
            sink = ltn12.sink.file(myFile),
        }

        -- Call the showImage function after a short time dealy
        timer.performWithDelay( 50, showImagechara_full)

    end
    --bg
    function loadSprite_Upgrade_Animation_powerup_1bg()
        local path = system.pathForFile( "Upgrade_Animation_powerup_1bg.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Upgrade_Animation/powerup/1bg.png",
            sink = ltn12.sink.file(myFile),
        }
    end


    loadImageicon()
    loadSprite_Upgrade_Animation_powerup_1bg() --bg
    loadImageSprite_Upgrade_Animation4()
    loadImageTeam()
    loadImageMenu()
end
--title
function loadImageSprite_element1()
    function loadSprite_Element_Fire()
        local path = system.pathForFile( "element_Fire.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/element/Fire.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadSprite_Element_Light()
        local path = system.pathForFile( "element_Light.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/element/Light.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadSprite_Element_Water()
        local path = system.pathForFile( "element_Water.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/element/Water.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSprite_Element_Fire()
    loadSprite_Element_Light()
    loadSprite_Element_Water()
end

--map
function loadImageSprite_element2()
    function loadSprite_Element_Dark()
        local path = system.pathForFile( "element_Dark.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/element/Dark.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadSprite_Element_Earth()
        local path = system.pathForFile( "element_Earth.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/element/Earth.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSprite_Element_Dark()
    loadSprite_Element_Earth()
end

--map_substate
function loadImageSprite_Boss1()
    function loadSpriteBoss_Effect_ground()
        local path = system.pathForFile( "Boss_Effect_ground.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Boss_Effect/ground.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSpriteBoss_Effect_ground()
end

--mission
function loadImageSprite_Boss2()

    function loadSpriteBoss_Effect_thunder()
        local path = system.pathForFile( "Boss_Effect_thunder.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Boss_Effect/thunder.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSpriteBoss_Effect_thunder()
end
function loadImageSprite_Boss3()

    function loadSpriteBoss_Effect_flash()
        local path = system.pathForFile( "Boss_Effect_flash.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Boss_Effect/flash.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSpriteBoss_Effect_flash()
end

--gacha
function loadImageSprite_Gacha1()

    function loadSprite_Gacha_aura()
        local path = system.pathForFile( "gacha_aura.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/gacha/aura.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadSprite_Gacha_bg_gacha()
        local path = system.pathForFile( "gacha_bg_gacha.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/gacha/bg_gacha.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSprite_Gacha_aura()
    loadSprite_Gacha_bg_gacha()
end
function loadImageSprite_Gacha2()

    function loadSprite_Gacha_dragon()
        local path = system.pathForFile( "gacha_dragon.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/gacha/dragon.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSprite_Gacha_dragon()

end

--menu
function loadImageSprite_GachaCard()
    native.setActivityIndicator( true )
    function loadSprite_Gacha_card_aura()
        local path = system.pathForFile( "gacha_card_aura.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/gacha_card/aura.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadSprite_Gacha_card_bg_gacha()
        local path = system.pathForFile( "gacha_card_bg_gacha.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/gacha_card/bg_gacha.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadSprite_Gacha_card_dragon()
        local path = system.pathForFile( "gacha_card_dragon.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/gacha_card/dragon.png",
            sink = ltn12.sink.file(myFile),
        }
        timer.performWithDelay( 400, stopLload)
    end

    loadSprite_Gacha_card_aura()
    loadSprite_Gacha_card_bg_gacha()
    loadSprite_Gacha_card_dragon()
end

--mission_clear
function loadImageSprite_LVLup_Animation()

    function loadSprite_LVLup_Animation_1font()
        local path = system.pathForFile( "LVLup_Animation_1font.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/LVLup_Animation/1font.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadSprite_LVLup_Animation_2shield()
        local path = system.pathForFile( "LVLup_Animation_2shield.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/LVLup_Animation/2shield.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadSprite_LVLup_Animation_3effect()
        local path = system.pathForFile( "LVLup_Animation_3effect.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/LVLup_Animation/3effect.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSprite_LVLup_Animation_1font()
    loadSprite_LVLup_Animation_2shield()
    loadSprite_LVLup_Animation_3effect()
end

--unit_main
function loadImageSprite_Upgrade_Animation1()
    --1
    function loadSprite_Upgrade_Animation_powerup_3circle1()
        local path = system.pathForFile( "Upgrade_Animation_powerup_3circle1.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Upgrade_Animation/powerup/3circle1.png",
            sink = ltn12.sink.file(myFile),
        }
    end


    loadSprite_Upgrade_Animation_powerup_3circle1()  --1
end

--characterAll
function loadImageSprite_Upgrade_Animation2()
    --2
    function loadSprite_Upgrade_Animation_powerup_3circle2()
        local path = system.pathForFile( "Upgrade_Animation_powerup_3circle2.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Upgrade_Animation/powerup/3circle2.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSprite_Upgrade_Animation_powerup_3circle2() --2
end

--power_up_main
function loadImageSprite_Upgrade_Animation3()
    --3
    function loadSprite_Upgrade_Animation_powerup_4effect()
        local path = system.pathForFile( "Upgrade_Animation_powerup_4effect.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Upgrade_Animation/powerup/4effect.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    loadSprite_Upgrade_Animation_powerup_4effect()  --3
end

--title
function loadImageSprite_Upgrade_Animation4()
    --4
    function loadSprite_Upgrade_Animation_powerup2_2circle()
        local path = system.pathForFile( "Upgrade_Animation_powerup2_2circle.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Upgrade_Animation/powerup2/2circle.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    loadSprite_Upgrade_Animation_powerup2_2circle() --4
end
--title
function loadImageSprite_Upgrade_Animation5()
    --5
    function loadSprite_Upgrade_Animation_powerup2_3effect()
        local path = system.pathForFile( "Upgrade_Animation_powerup2_3effect.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Upgrade_Animation/powerup2/3effect.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    loadSprite_Upgrade_Animation_powerup2_3effect() --5
end

--guest
function loadImageSprite_Victory_Warning1()
    function loadSprite_Victory_Animation_font()
        local path = system.pathForFile( "Victory_Animation_font.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Victory_Animation/font.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSprite_Victory_Animation_font()
end
--teamselectView
function loadImageSprite_Victory_Warning2()
    function loadSprite_Victory_Animation_aura()
        local path = system.pathForFile( "Victory_Animation_aura.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )
        http.request{
            url = "http://133.242.169.252/img/sprite/Victory_Animation/aura.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    loadSprite_Victory_Animation_aura()
end
--team_select
function loadImageSprite_Victory_Warning3()
    function loadSprite_Warning_Animation()
        local path = system.pathForFile( "Warning_Animation_spritesheet.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )

        http.request{
            url = "http://133.242.169.252/img/sprite/Warning_Animation/spritesheet.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadSprite_Warning_Animation()
end


function loadImageSprite_Item_Effect()
    function loadImageSprite_Item_Effect_coin()
        local path = system.pathForFile( "Item_Effect_coin.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )

        http.request{
            url = "http://133.242.169.252/img/sprite/Item_Effect/coin.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadImageSprite_Item_Effect_flag()
        local path = system.pathForFile( "Item_Effect_flag.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )

        http.request{
            url = "http://133.242.169.252/img/sprite/Item_Effect/flag.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadImageSprite_Item_Effect_flagtest()
        local path = system.pathForFile( "Item_Effect_flagtest.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )

        http.request{
            url = "http://133.242.169.252/img/sprite/Item_Effect/flagtest.png",
            sink = ltn12.sink.file(myFile),
        }
    end
    function loadImageSprite_Item_Effect_treasure()
        local path = system.pathForFile( "Item_Effect_treasure.png", system.DocumentsDirectory )
        local myFile = io.open( path, "w+b" )

        http.request{
            url = "http://133.242.169.252/img/sprite/Item_Effect/treasure.png",
            sink = ltn12.sink.file(myFile),
        }
    end

    loadImageSprite_Item_Effect_coin()
    loadImageSprite_Item_Effect_flag()
    loadImageSprite_Item_Effect_flagtest()
    loadImageSprite_Item_Effect_treasure()
end
--
function loadImageTeam()
    local path = system.pathForFile( "team.png", system.DocumentsDirectory )
    local myFile = io.open( path, "w+b" )
    http.request{
        url = "http://133.242.169.252/img/background/team.png",
        sink = ltn12.sink.file(myFile),
    }
end

function loadImageMenu()
    local path = system.pathForFile( "menubutton.png", system.DocumentsDirectory )
    local myFile = io.open( path, "w+b" )
    http.request{
        url = "http://133.242.169.252/img/menu/menubutton.png",
        sink = ltn12.sink.file(myFile),
    }
end