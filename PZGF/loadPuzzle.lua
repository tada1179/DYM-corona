---- Project : Puzzle game
---- Author  : Eric MO
---- Description : getting data from remote server and stroe in sqlite
module(..., package.seeall)
local widget = require("widget")


local screenW, screenH = display.contentWidth, display.contentHeight
local checkload = 10
function cheack()
    return checkload
end
function NoDataInList()
    local groupView = display.newGroup()
    local sizetextName = 20
    local typeFont = native.systemFontBold
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local function ontouchNoDataInList ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function okNoDataInList(event)
        display.remove(groupView)
        groupView = nil

        if event.target.id == "okNoDataInList" then
            -- storyboard.gotoScene( "commu_main","fade",100 )
        end
    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    local myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    local SmachText = display.newText("No Leader assigned", screenW*.35, screenH *.45,typeFont, sizetextName)
    SmachText:setTextColor(255, 255, 255)
    groupView:insert(SmachText)

    --button ok profile
    local btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = okNoDataInList	-- event listener function
    }
    btn_OK.id="okNoDataInList"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.5
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)

    groupView.touch = ontouchNoDataInList
    groupView:addEventListener( "touch", groupView )

end
function newload(option)

    local sqlite3 = require("sqlite3")
    local json = require("json")
    local http = require("socket.http")
    local menu_barLight = require("menu_barLight")
    local user_name = menu_barLight.user_name()
    local user_id = option.params.user_id
    local teamNumber = option.params.team
    local friend_id = option.params.friend_id
    local mission_id = option.params.mission_id
    local stamina = option.params.mission_stamina
    local power_STAMINA = menu_barLight.power_STAMINA()

    local path = system.pathForFile("puzzle.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    db:exec("Drop Table team;")
    db:exec("Drop Table missionRun;")
    db:exec("Drop Table characterbattle;")
    local SaveCharacterBattleListData = function()
        local Firendtablesetup = "CREATE TABLE IF NOT EXISTS characterbattle (battleAll,missionCoin,battle_id"
        Firendtablesetup = Firendtablesetup..",battle ,characAll ,charac_id ,charac_name ,charac_img"
        Firendtablesetup = Firendtablesetup ..",charac_element , charac_hp , charac_def , charac_atk , charac_spw ,charac_sph"
        Firendtablesetup = Firendtablesetup..",charac_countD, charac_coin,condition);"
        db:exec( Firendtablesetup )

        local LinkURL = "http://133.242.169.252/DYM/character_battle_mission.php"
        local URL =  LinkURL.."?mission_id="..mission_id
        local response = http.request(URL)
        local dataTable
        local character_numAll
        local image_char = {}
        local mission_coin

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
                    image_char[m][k].charac_spw = tonumber(dataTable.one[m].mission.charcac[k].charac_spw)
                    image_char[m][k].charac_sph = tonumber(dataTable.one[m].mission.charcac[k].charac_sph)
                    image_char[m][k].charac_countD = tonumber(dataTable.one[m].mission.charcac[k].charac_countD)
                    image_char[m][k].charac_coin = tonumber(dataTable.one[m].mission.charcac[k].charac_coin)
                    image_char[m][k].condition = tonumber(dataTable.one[m].mission.charcac[k].condition)

                    local tablefill ="INSERT INTO characterbattle VALUES('"..character_numAll.."','"..mission_coin.."','"..image_char[m].battle_id.."','"..image_char[m].battle.."','"..image_char[m].characAll.."','"
                            ..image_char[m][k].charac_id.."','"..image_char[m][k].charac_name.."','"..image_char[m][k].charac_img.."','"
                            ..image_char[m][k].charac_element.."','"..image_char[m][k].charac_hp.."','"..image_char[m][k].charac_def.."','"
                            ..image_char[m][k].charac_atk.."','"..image_char[m][k].charac_spw.."','"..image_char[m][k].charac_sph.."','"
                            ..image_char[m][k].charac_countD.."','"..image_char[m][k].charac_coin.."','"..image_char[m][k].condition.."');"
                    db:exec( tablefill )
                    k = k+1
                end
                m = m + 1
            end
        end

    --db:close()

    end

    local SaveMissionRun = function()
        local Firendtablesetup = "CREATE TABLE IF NOT EXISTS mission_run"
        Firendtablesetup = Firendtablesetup.."(mission_img ,mission_name ,mission_exp ,chapter_id ,chapter_name ,mission_stamina);"
        db:exec( Firendtablesetup )

        local LinkURL = "http://133.242.169.252/DYM/mission.php"
        local URL =  LinkURL.."?mission_id="..mission_id
        local response = http.request(URL)
        local dataTable = json.decode(response)
        local  image_sheet
        local  mission_name
        local  mission_exp
        local  chapter_id
        local  chapter_name
        local  mission_stamina

        if dataTable.mission == nil then
            print("No Dice")

        else
            image_sheet = dataTable.mission[1].mission_img
            mission_name = dataTable.mission[1].mission_name
            mission_exp = dataTable.mission[1].mission_exp
            chapter_id = dataTable.mission[1].chapter_id
            chapter_name = dataTable.mission[1].chapter_name
            mission_stamina = dataTable.mission[1].mission_stamina

            stamina = mission_stamina

            local MapSubstatesfill = "INSERT INTO mission_run (mission_img ,mission_name ,mission_exp ,chapter_id ,chapter_name ,mission_stamina) "
            MapSubstatesfill = MapSubstatesfill.."VALUES ( '"..image_sheet.."','"..mission_name.."','"..mission_exp.."','"..chapter_id.."','"..chapter_name.."','"..mission_stamina.."');"
            local success = db:exec(MapSubstatesfill)
        end
    end

    local SaveTeamData = function()
        -- Create Table
        local tablesetup = "CREATE TABLE IF NOT EXISTS team (imgMini ,leader_id , skill_id ,holdcharac_id,"
        tablesetup = tablesetup.."element , user_exp , team_no , def , atk , hp );"
        db:exec( tablesetup )
        local LinkURL = "http://133.242.169.252/DYM/team_setting.php"
        local URL =  LinkURL.."?user_id="..user_id.."&team_no="..teamNumber
        local response = http.request(URL)
        local dataTable = json.decode(response)
        local rowCharac = tonumber(dataTable.chrAll)
        local datacharcter = {}
        local m
        if dataTable.chracter ~= nil then
            for m = 1,rowCharac,1 do
                datacharcter[m] = {}
                datacharcter[m].imagePicture= dataTable.chracter[m].imgMini
                datacharcter[m].leader_id= dataTable.chracter[m].leader_id
                datacharcter[m].skill_id= dataTable.chracter[m].skill_id
                datacharcter[m].holdcharac_id = tonumber(dataTable.chracter[m].holdcharac_id)
                datacharcter[m].element = tonumber(dataTable.chracter[m].element)
                datacharcter[m].team_no = tonumber(dataTable.chracter[m].team_no)
                datacharcter[m].def = tonumber(dataTable.chracter[m].def)
                datacharcter[m].atk = tonumber(dataTable.chracter[m].atk)
                datacharcter[m].hp = tonumber(dataTable.chracter[m].hp)

                local tablefill ="INSERT INTO team VALUES ('"..datacharcter[m].imagePicture.."','" .. datacharcter[m].leader_id .. "','".. datacharcter[m].skill_id .. "','"
                        .. datacharcter[m].holdcharac_id .."','".. datacharcter[m].element .."', NULL ,'".. datacharcter[m].team_no .."','"
                        .. datacharcter[m].def .."','".. datacharcter[m].atk.."','"..datacharcter[m].hp .. "');"
                db:exec( tablefill )
            end

            m = rowCharac +1
            local url = "http://133.242.169.252/DYM/holdcharacter.php?charac_id="
            local character =   url..friend_id
            local response = http.request(character)
            local Data_character = json.decode(response)
            if Data_character then
                datacharcter[m] = {}
                datacharcter[m].holdcharac_id =  Data_character[1].holdcharac_id
                datacharcter[m].leader_id =  Data_character[1].leader_id
                datacharcter[m].skill_id =  Data_character[1].skill_id
                datacharcter[m].imagePicture =  Data_character[1].charac_img_mini
                datacharcter[m].element =  tonumber(Data_character[1].charac_element)
                datacharcter[m].team_no  = 6
                datacharcter[m].def = tonumber(Data_character[1].charac_def)
                datacharcter[m].atk = tonumber(Data_character[1].charac_atk)
                datacharcter[m].hp = tonumber(Data_character[1].charac_hp)

                local tablefill ="INSERT INTO team VALUES ('"..datacharcter[m].imagePicture.."','" .. datacharcter[m].leader_id .. "','".. datacharcter[m].skill_id .. "','"
                        .. datacharcter[m].holdcharac_id .."','".. datacharcter[m].element .."', NULL ,'".. datacharcter[m].team_no .."','"
                        .. datacharcter[m].def .."','".. datacharcter[m].atk.."','"..datacharcter[m].hp .. "');"
                db:exec( tablefill )
            end
        else
            datacharcter[1] = {}
        end

        if datacharcter[1].team_no == nil then
            NoDataInList()
            checkload = 1
        else
           ------------------------------------------
            checkload = 10
            SaveCharacterBattleListData()
            SaveMissionRun()
            db:close()

            power_STAMINA = power_STAMINA -stamina
            local LinkURL = "http://133.242.169.252/DYM/updatestamina.php"
            local URL =  LinkURL.."?user_id="..user_id.."&stamina="..power_STAMINA.."&team_no="..teamNumber
            URL = URL.."&user_name="..user_name
            local response = http.request(URL)

            local path = system.pathForFile("datas.db", system.DocumentsDirectory)
            db = sqlite3.open( path )
            local tablefill ="UPDATE user SET 	user_power = '"..power_STAMINA.."' WHERE user_id = '"..user_id.."';"
            db:exec( tablefill )
            db:close()
        end

    end

    --- get User information ----------------
    SaveTeamData()

end
