module(..., package.seeall)
local sqlite3 = require("sqlite3")
local widget = require("widget")
local screenW = display.contentWidth
local screenH = display.contentHeight

local function dataStrone()
    print("dataStrone function ")
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    --map
    local tablemission ="INSERT INTO map(map_id,map_name,map_run) VALUES ('1','ENTRY PLAIN','3');"
    db:exec( tablemission )

    local tablemission2 ="INSERT INTO map(map_id,map_name,map_run) VALUES ('2','SHADY FOREST','7');"
    db:exec( tablemission2 )

    local tablemission3 ="INSERT INTO map(map_id,map_name,map_run) VALUES ('3','GRILLY DESERT','6');"
    db:exec( tablemission3 )

    local tablemission4 ="INSERT INTO map(map_id,map_name,map_run) VALUES ('4','SWEETY CORAL','8');"
    db:exec( tablemission4 )

    local tablemission5 ="INSERT INTO map(map_id,map_name,map_run) VALUES ('5','LONELY GLACIER','11');"
    db:exec( tablemission5 )

    local tablemission6 ="INSERT INTO map(map_id,map_name,map_run) VALUES ('6','DESOLATE YARD','12');"
    db:exec( tablemission6 )

    local tablemission7 ="INSERT INTO map(map_id,map_name,map_run) VALUES ('7','BOOGY Mountain','5');"
    db:exec( tablemission7 )

    local Wayi = 0
    local myName = {}
    local myID = {}
    local myWay = {}

    for rowdata in db:nrows ("SELECT * FROM map;") do
        Wayi = Wayi + 1
        myID[Wayi] =  tonumber(rowdata.map_id)
        myWay[Wayi] =  tonumber(rowdata.map_run)
        myName[Wayi] =  rowdata.map_name
    end
    ---map = 1 ----------------------------------------------------------------------------------------------------------
    local n = 1
    local name = myName[1].." "..n
    local tabmission ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission = tabmission.."VALUES ('"..name.."','"..myID[1].."','1','1','2','0');"
    db:exec( tabmission )

    n = 2
    local name = myName[1].." "..n
    local tabmission1 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission1 = tabmission1.."VALUES ('"..name.."','"..myID[1].."','2','2','3','-1');"
    db:exec( tabmission1 )

    n = 3
    local name = myName[1].." "..n
    local tabmission2 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission2 = tabmission2.."VALUES ('"..name.."','"..myID[1].."','3','3','4','-1');"
    db:exec( tabmission2 )

    ---map = 2---------------------------------------------------------------------------------------------------------
    n = 1
    local name = myName[2].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[2].."','1','1','2','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[2].." "..n
    local tabmission4 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission4 = tabmission4.."VALUES ('"..name.."','"..myID[2].."','2','2','3','-1');"
    db:exec( tabmission4 )

    n = 2
    local name = myName[2].." "..n
    local tabmission5 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission5 = tabmission5.."VALUES ('"..name.."','"..myID[2].."','3','2','4','-1');"
    db:exec( tabmission5 )

    n = 3
    local name = myName[2].." "..n
    local tabmission6 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission6 = tabmission6.."VALUES ('"..name.."','"..myID[2].."','4','3','5','-1');"
    db:exec( tabmission6 )

    n = 4
    local name = myName[2].." "..n
    local tabmission7 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission7 = tabmission7.."VALUES ('"..name.."','"..myID[2].."','5','4','7','-1');"
    db:exec( tabmission7 )

    n = 5
    local name = myName[2].." "..n
    local tabmission8 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission8 = tabmission8.."VALUES ('"..name.."','"..myID[2].."','6','5','6','-1');"
    db:exec( tabmission8 )

    n = 6
    local name = myName[2].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[2].."','7','6','7','-1');"
    db:exec( tabmission3 )

    n = 7
    local name = myName[2].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('HIDING THICK','"..myID[2].."','8','7','C1','-1');"
    db:exec( tabmission3 )


    ---map = 3 ----------------------------------------------------------------------------------------------------------
    n = 1
    local name = myName[3].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[3].."','1','1','2','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[3].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[3].."','2','2','3','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[3].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[3].."','3','2','4','-1');"
    db:exec( tabmission3 )

    n = 3
    local name = myName[3].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[3].."','4','3','5','-1');"
    db:exec( tabmission3 )

    n = 4
    local name = myName[3].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[3].."','5','4','6','-1');"
    db:exec( tabmission3 )

    n = 5
    local name = myName[3].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[3].."','6','5','6','-1');"
    db:exec( tabmission3 )

    n = 6
    local name = myName[3].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('ANTHELL','"..myID[3].."','7','6','D1','-1');"
    db:exec( tabmission3 )
    ---map = 4---------------------------------------------------------------------------------------------------------
    n = 1
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[4].."','1','1','2','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[4].."','2','2','3','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[4].."','3','2','4','-1');"
    db:exec( tabmission3 )

    n = 3
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[4].."','5','3','5','-1');"
    db:exec( tabmission3 )

    n = 4
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[4].."','4','4','5','-1');"
    db:exec( tabmission3 )

    n = 5
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[4].."','6','5','7','-1');"
    db:exec( tabmission3 )

    n = 6
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[4].."','7','3','6','-1');"
    db:exec( tabmission3 )

    n = 3
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[4].."','8','6','8','-1');"
    db:exec( tabmission3 )

    n = 7
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[4].."','10','8','E1','-1');"
    db:exec( tabmission3 )

    n = 8
    local name = myName[4].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('WHIRLPOOL','"..myID[4].."','9','7','E2','-1');"
    db:exec( tabmission3 )

    ---map = 5---------------------------------------------------------------------------------------------------------
    n = 1
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','1','1','2','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','2','2','3','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','3','2','4','-1');"
    db:exec( tabmission3 )

    n = 3
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','4','3','5','-1');"
    db:exec( tabmission3 )

    n = 4
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','5','5','6','-1');"
    db:exec( tabmission3 )

    n = 5
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','12','7','5','-1');"
    db:exec( tabmission3 )

    n = 6
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','7','4','8','-1');"
    db:exec( tabmission3 )

    n = 6
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','8','8','9','-1');"
    db:exec( tabmission3 )

    n = 7
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','9','9','7','-1');"
    db:exec( tabmission3 )

    n = 8
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','10','10','11','-1');"
    db:exec( tabmission3 )

    n = 7
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[5].."','11','6','F2','-1');"
    db:exec( tabmission3 )

    n = 10
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('SNOW FALL','"..myID[5].."','12','11','F1','-1');"
    db:exec( tabmission3 )

                    ----*******----ally map ----*******----
    n = 10
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('ICE CAGE 1','"..myID[5].."','13','13','14','-1');"
    db:exec( tabmission3 )

    n = 10
    local name = myName[5].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('ICE CAGE 2','"..myID[5].."','14','14','15','-1');"
    db:exec( tabmission3 )
    ---map = 6---------------------------------------------------------------------------------------------------------
    n = 1
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','1','1','2','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','2','2','3','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','3','2','4','-1');"
    db:exec( tabmission3 )

    n = 3
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','0','3','5','-1');"
    db:exec( tabmission3 )

    n = 4
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','5','4','6','-1');"
    db:exec( tabmission3 )

    n = 5
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','6','6','7','-1');"
    db:exec( tabmission3 )

    n = 6
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','7','7','8','-1');"
    db:exec( tabmission3 )

    n = 7
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','8','8','9','-1');"
    db:exec( tabmission3 )

    n = 9
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','9','8','10','-1');"
    db:exec( tabmission3 )

    n = 9
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','10','9','11','-1');"
    db:exec( tabmission3 )

    n = 10
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','10','10','0','-1');"
    db:exec( tabmission3 )

    n = 11
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','11','11','12','-1');"
    db:exec( tabmission3 )

    n = 12
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[6].."','12','12','0','-1');" -------***--
    db:exec( tabmission3 )

    --------------------------------
    -- ally map -------
    --------------------------------
    n = 11
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('SILENT WHISPER 1','"..myID[6].."','13','13','14','-1');"
    db:exec( tabmission3 )

    n = 12
    local name = myName[6].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('SILENT WHISPER 2','"..myID[6].."','14','14','15','-1');"
    db:exec( tabmission3 )
    ---map = 7---------------------------------------------------------------------------------------------------------
    n = 1
    local name = myName[7].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[7].."','1','1','2','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[7].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[7].."','2','2','3','-1');"
    db:exec( tabmission3 )

    n = 2
    local name = myName[7].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[7].."','3','2','4','-1');"
    db:exec( tabmission3 )

    n = 3
    local name = myName[7].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[7].."','4','3','5','-1');"
    db:exec( tabmission3 )

    n = 4
    local name = myName[7].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('"..name.."','"..myID[7].."','5','4','6','-1');"
    db:exec( tabmission3 )

    n = 5
    local name = myName[7].." "..n
    local tabmission3 ="INSERT INTO playMission(mission_name ,map_id ,num_way ,station_id ,next_station_id ,status)"
    tabmission3 = tabmission3.."VALUES ('INNER the BOOGY','"..myID[7].."','6','6','H1','-1');"
    db:exec( tabmission3 )
    -------------------------------------------------------------------------------------------------------------------

    return true
end
local function dataTeamTable()
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )


    for i = 1,3,1 do
        for j = 1,6,1 do
            local tablemission ="INSERT INTO team(team_no,team_name ,pin_id ,team_element) VALUES('"..i.."','000','"..j.."','"..j.."');"
            db:exec( tablemission )
        end
    end


    ---aechiement
    -----------------------
    local myName = {"Aware Fire","Aware Water","Aware Wood","Aware Bolt","Aware Dark","Aware Cure"}
    local myMaxScore = {10,10,10,10,10,10}
    for j = 1,#myName,1 do
        local tablemission ="INSERT INTO aechiement(aechiement_name,aechiement_element ,scoreMax ,score) VALUES('"..myName[j].."','"..j.."','"..myMaxScore[j].."','0');"
        db:exec( tablemission )
    end

    local bigMap = {100,200,300,400,500,600,700}
    for j = 1,#bigMap,1 do
        local tablemission ="INSERT INTO aechiementMap(map_id,scoreMax,score) VALUES('"..j.."','"..bigMap[j].."','0');"
        db:exec( tablemission )
    end

    local AllyMap = {"Ally heart #1","Ally heart #2","Ally heart #3","Ally heart #4"}
    for j = 1,#AllyMap,1 do
        local tableAllyMap ="INSERT INTO aechiement(aechiement_name,aechiement_element ,scoreMax ,score) VALUES('"..AllyMap[j].."','"..j.."','1','0');"
        db:exec( tableAllyMap )
    end
    --end aechiement


end

local function dataPinTable()
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    local element = {
        "img/element/red.png",    --fire
        "img/element/green.png",  --wood
        "img/element/blue.png",   --water
        "img/element/purple.png", --drak
        "img/element/pink.png",   --cure
        "img/element/yellow.png", --bolt
    }

     --default
    --1
    --status = 1 my pin item
    --status = 2 no have pin item in gallery
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax  ,pin_element,pin_imgmini ,pin_imgbig,pin_status,pin_exp)"
    tablemission = tablemission.." VALUES('rad','xxx','1','100','1','img/Monster_icon/1p.png','img/Monster_full/1.png',1,1);"
    db:exec( tablemission )
    --2
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status,pin_exp)"
    tablemission = tablemission.."VALUES('green','xxx','1','100','2','img/Monster_icon/2p.png','img/Monster_full/2.png',1,1);"
    db:exec( tablemission )
    --3
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('blue','xxx','1','100','3','img/Monster_icon/3p.png','img/Monster_full/3.png',1,1);"
    db:exec( tablemission )
    --4
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.." VALUES('purple','xxx','1','100','4','img/Monster_icon/4p.png','img/Monster_full/4.png',1,1);"
    db:exec( tablemission )
    --5
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.." VALUES('pink','xxx','1','100','5','img/Monster_icon/5p.png','img/Monster_full/5.png',1,1);"
    db:exec( tablemission )
    --6
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('yellow','xxx','1','100','6','img/Monster_icon/6p.png','img/Monster_full/6.png',1,1);"
    db:exec( tablemission )
    ------------------------------------------

    --1
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax  ,pin_element,pin_imgmini ,pin_imgbig,pin_status,pin_exp)"
    tablemission = tablemission.." VALUES('chibimelion','001','1','100','2','img/Monster_icon/id001p.png','img/Monster_full/id001.png',1,1);"
    db:exec( tablemission )
    --2
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status,pin_exp)"
    tablemission = tablemission.."VALUES('camelion','002','1','100','2','img/Monster_icon/id002p.png','img/Monster_full/id002.png',0,1);"
    db:exec( tablemission )
    --3
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('kingmelion','003','1','100','2','img/Monster_icon/id003p.png','img/Monster_full/id003.png',0,1);"
    db:exec( tablemission )
    --4
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.." VALUES('chibifox','004','1','100','1','img/Monster_icon/id004p.png','img/Monster_full/id004.png',0,1);"
    db:exec( tablemission )
    --5
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.." VALUES('foxy','005','1','100','1','img/Monster_icon/id005p.png','img/Monster_full/id005.png',0,1);"
    db:exec( tablemission )
    --6
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('flame fox','006','1','100','1','img/Monster_icon/id006p.png','img/Monster_full/id006.png',0,1);"
    db:exec( tablemission )
    --7
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp ,pin_generate)"
    tablemission = tablemission.."VALUES('chibisheep','007','1','105','3','img/Monster_icon/id007p.png','img/Monster_full/id007.png',1,100 ,1);"
    db:exec( tablemission )
    --8
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax  ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('sheep','008','1','1550','3','img/Monster_icon/id008p.png','img/Monster_full/id008.png',0,1);"
    db:exec( tablemission )
    --9
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('bubble sheep','009','1','1550','3','img/Monster_icon/id009p.png','img/Monster_full/id009.png',0,1);"
    db:exec( tablemission )
    --10
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('chibicandy','010','1','1550','6','img/Monster_icon/id010p.png','img/Monster_full/id010.png',1,1);"
    db:exec( tablemission )
--------------------------------------
    --11
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('candybolt','011','1','1550','6','img/Monster_icon/id011p.png','img/Monster_full/id011.png',0,1);"
    db:exec( tablemission )
    --12
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('candyblitz','012','1','1550','6','img/Monster_icon/id012p.png','img/Monster_full/id012.png',0,1);"
    db:exec( tablemission )
    --13
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('ivy','013','1','1550','2','img/Monster_icon/id013p.png','img/Monster_full/id013.png',0,1);"
    db:exec( tablemission )
    --14
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('mabolovy','014','1','1550','2','img/Monster_icon/id014p.png','img/Monster_full/id014.png',0,1);"
    db:exec( tablemission )
    --15
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('firey baer','015','1','1550','1','img/Monster_icon/id015p.png','img/Monster_full/id015.png',0,1);"
    db:exec( tablemission )
    --16
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('burning bear','016','1','1550','1','img/Monster_icon/id016p.png','img/Monster_full/id016.png',0,1);"
    db:exec( tablemission )
    --17
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('roro','017','1','1550','3','img/Monster_icon/id017p.png','img/Monster_full/id017.png',0,1);"
    db:exec( tablemission )
    --18
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('meroro','018','1','1550','3','img/Monster_icon/id018p.png','img/Monster_full/id018.png',0,1);"
    db:exec( tablemission )
    --19
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('meruroro','019','1','1550','3','img/Monster_icon/id019p.png','img/Monster_full/id019.png',0,1);"
    db:exec( tablemission )
    --20
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('biribee','020','1','1550','6','img/Monster_icon/id020p.png','img/Monster_full/id020.png',0,1);"
    db:exec( tablemission )
--------------------------------
    --21
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('buzzybee','021','1','1550','6','img/Monster_icon/id021p.png','img/Monster_full/id021.png',0,1);"
    db:exec( tablemission )
    --22
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('conolt','022','1','1550','6','img/Monster_icon/id022p.png','img/Monster_full/id022.png',0,1);"
    db:exec( tablemission )
    --23
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('sparkolt','023','1','1550','6','img/Monster_icon/id023p.png','img/Monster_full/id023.png',0,1);"
    db:exec( tablemission )
    --24
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('witch glass','024','1','1550','2','img/Monster_icon/id024p.png','img/Monster_full/id024.png',1,1);"
    db:exec( tablemission )
    --25
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('shamaglass','025','1','1550','2','img/Monster_icon/id025p.png','img/Monster_full/id025.png',0,1);"
    db:exec( tablemission )
    --26
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('firecat','026','1','1550','1','img/Monster_icon/id026p.png','img/Monster_full/id026.png',0,1);"
    db:exec( tablemission )
    --27
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('bombcat','027','1','1550','1','img/Monster_icon/id027p.png','img/Monster_full/id027.png',0,1);"
    db:exec( tablemission )
    --28
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('???','028','1','1550','3','img/Monster_icon/id028p.png','img/Monster_full/id028.png',0,1);"
    db:exec( tablemission )
    --29
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('thunderbird','029','1','1550','6','img/Monster_icon/id029p.png','img/Monster_full/id029.png',0,1);"
    db:exec( tablemission )
    --30
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','030','1','1550','6','img/Monster_icon/id030p.png','img/Monster_full/id030.png',0,1);"
    db:exec( tablemission )
-------------------------------------

    --31
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','031','1','1550','5','img/Monster_icon/id031p.png','img/Monster_full/id031.png',0,1);"
    db:exec( tablemission )
    --32
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','032','1','1550','5','img/Monster_icon/id032p.png','img/Monster_full/id032.png',0,1);"
    db:exec( tablemission )
    --33
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','033','1','1550','5','img/Monster_icon/id033p.png','img/Monster_full/id033.png',0,1);"
    db:exec( tablemission )
    --34
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','034','1','1550','5','img/Monster_icon/id034p.png','img/Monster_full/id034.png',0,1);"
    db:exec( tablemission )
    --35
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','035','1','1550','5','img/Monster_icon/id035p.png','img/Monster_full/id035.png',0,1);"
    db:exec( tablemission )
    --36
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','036','1','1550','4','img/Monster_icon/id036p.png','img/Monster_full/id036.png',0,1);"
    db:exec( tablemission )
    --37
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','037','1','1550','4','img/Monster_icon/id037p.png','img/Monster_full/id037.png',0,1);"
    db:exec( tablemission )
    --38
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','038','1','1550','4','img/Monster_icon/id038p.png','img/Monster_full/id038.png',0,1);"
    db:exec( tablemission )
    --39
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','039','1','1550','4','img/Monster_icon/id039p.png','img/Monster_full/id039.png',0,1);"
    db:exec( tablemission )
    --40
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('zapbird','040','1','1550','4','img/Monster_icon/id040p.png','img/Monster_full/id040.png',0,1);"
    db:exec( tablemission )
--------------------------------------

    --41
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('venosonix','xxx','1','1550','4','img/Monster_icon/id041p.png','img/Monster_full/id041.png',0,1);"
    db:exec( tablemission )
    --42
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('dark matter','xxx','1','1550','4','img/Monster_icon/id042p.png','img/Monster_full/id042.png',0,1);"
    db:exec( tablemission )
    --43
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('gooney','xxx','1','1550','4','img/Monster_icon/id043p.png','img/Monster_full/id043.png',0,1);"
    db:exec( tablemission )
    --44
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('brushy','xxx','1','1550','2','img/Monster_icon/id044p.png','img/Monster_full/id044.png',0,1);"
    db:exec( tablemission )
    --45
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('desery','xxx','1','1550','1','img/Monster_icon/id045p.png','img/Monster_full/id045.png',0,1);"
    db:exec( tablemission )
    --46
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('mariny','xxx','1','1550','3','img/Monster_icon/id046p.png','img/Monster_full/id046.png',0,1);"
    db:exec( tablemission )
    --47
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('chilly','xxx','1','1550','3','img/Monster_icon/id047p.png','img/Monster_full/id047.png',0,1);"
    db:exec( tablemission )
    --48
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('skully','xxx','1','1550','6','img/Monster_icon/id048p.png','img/Monster_full/id048.png',0,1);"
    db:exec( tablemission )
    --49
    local tablemission ="INSERT INTO pin( pin_name ,pin_no ,pin_expstart ,pin_expmax ,pin_element,pin_imgmini ,pin_imgbig,pin_status ,pin_exp)"
    tablemission = tablemission.."VALUES('deadly','xxx','1','1550','4','img/Monster_icon/id049p.png','img/Monster_full/id049.png',0,1);"
    db:exec( tablemission )

end
function dataINRun()

    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    local num = 0
    local mission_data = {}

    local run_set = {
        { 3,3,3} ,
        { 3,3,4,3,3, 4,4} ,
        { 3,3,3,4,4, 5} ,
        { 3,4,3,4,5, 3,4,5} ,
        { 3,3,4,5,4, 4,5,4,4,5 ,4} ,
        { 5,5,7,7,5, 5,7,5,5,5 ,5,7} ,
        { 5,5,7,5,7}

    }
    local pin_drop = {
        { 43,43,36} ,
        {44,44,13,24,44, 31,37},
        {45,45,45,45,45, 38},
        {28,46,22,46,17,46,46,39},
        {47,47,47,40,47,47,0,47,47,47,32},
        { 48,48,33,48,0,48,0,48,41,48,48,34},
        {49,49,35,49,42}
    }

    local pin_exp = {
        {10,10,10},
        {10,10,10,10,10,10,11} ,
        {11,11,11,11,11,12} ,
        {11,11,11,12,12,11,12,14} ,
        {11,11,11,13,12,12,12,12,12,11,11} ,
        {12,12,13,12,13,13,13,13,14,13,12,12} ,
        {14,14,15,15,15} ,
    }
    local pin_pop = {
        {100,100,100},
        {100,100,100,100,100,150,150} ,
        {150,150,150,200,200,200} ,
        {200,200,200,300,300,300,300,400} ,
        {400,400,400,500,500,500,500,500,500,400,400} ,
        {600,600,700,600,600,600,700,700,700,700,500,500} ,
        {800,800,1000,800,1000} ,
    }

--    local pin_score = { --this use
--        {900,1000,1100},
--        {1000,1000,1000,1000,1100,  1400,1500},
--        {1500,1500,1600,1800,2000,2000},
--        {2000,2200,2200,2800,3000, 3000,3000,3700},
--        {3700,4000,4000,4600,4600, 5000,5000,5000,500,4000,   4400},
--        {5500,6000,6400,6000,6000, 6000,7000,7000,7000,7000,   5500,5500},
--        {7300,8000,10000,8000,10000},
--    }

    local pin_score = {  --test
        {20,20,20},
        {30,30,10,10,10,  10,10},
        {10,10,10,10,10,10},
        {10,10,10,10,10, 10,10,10},
        {700,700,700,700,700, 700,500,500,550,550,   500},
        {700,700,700,700,700, 700,500,500,550,550,   500,600},
        {700,700,500,600,700},
    }

    local one = 0

    local myWay = {}
    for rowdata in db:nrows ("SELECT * FROM map;") do
        one = one + 1
        myWay[one] = {}
        myWay[one].map_id =  tonumber(rowdata.map_id)
        myWay[one].map_run =  tonumber(rowdata.map_run)
        myWay[one].map_name =  rowdata.map_name

        local two = 0
        for count = 1, myWay[one].map_run ,1 do
            two = two + 1
            local tabmission = "INSERT INTO mission(mission_id,mission_name, map_id, run_number, drop_pin_id, mission_exp,mission_pop,mission_score)"
            tabmission = tabmission.."VALUES ('"..two.."','"..myWay[one].map_name.."','"..myWay[one].map_id.."','"..run_set[one][two].."','"..pin_drop[one][two].."','"..pin_exp[one][two].."','"..pin_exp[one][two].."','"..pin_pop[one][two].."');"
            db:exec( tabmission )
        end
    end

end

function newload()
    local count =0
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

   db:exec("Drop Table user;")
   db:exec("Drop Table playMission;")
   db:exec("Drop Table mission;")
   db:exec("Drop Table pin;")
   db:exec("Drop Table map;")
   db:exec("Drop Table team;")
   db:exec("Drop Table sound;")
   db:exec("Drop Table aechiement;")
   db:exec("Drop Table aechiementMap;")
   db:exec("Drop Table run;")

    local MapSubstates = "CREATE TABLE IF NOT EXISTS user ( user_id INTEGER PRIMARY KEY AUTOINCREMENT, user_name ,"
    MapSubstates = MapSubstates.."user_element,user_level,user_score_classic,user_coin,user_gold, sound_id,BGM_id);"
    db:exec(MapSubstates)

    --------------------------------set default
    local playMission = "CREATE TABLE IF NOT EXISTS playMission( playMission_id INTEGER PRIMARY KEY AUTOINCREMENT, mission_name ,map_id ,num_way ,station_id,next_station_id,status);"
    db:exec(playMission)
   ---------------------------------

    local MapSubstates = "CREATE TABLE IF NOT EXISTS map( map_id, map_name ,map_run,drop_pin_id);"
    db:exec(MapSubstates)

    local mission = "CREATE TABLE IF NOT EXISTS mission( mission_id, mission_name,map_id,run_number,drop_pin_id,mission_exp,mission_pop,mission_score);"
    db:exec(mission)

    local mission = "CREATE TABLE IF NOT EXISTS pin( pin_id INTEGER PRIMARY KEY AUTOINCREMENT,pin_name,pin_no,pin_expstart,pin_expmax,pin_element,pin_imgmini ,pin_imgbig,pin_generate,pin_status,pin_exp);"
    db:exec(mission)

    local mission = "CREATE TABLE IF NOT EXISTS team( team_id INTEGER PRIMARY KEY AUTOINCREMENT ,team_no,team_name ,pin_id,team_element);"
    db:exec(mission)

    local mission = "CREATE TABLE IF NOT EXISTS aechiement( aechiement_id INTEGER PRIMARY KEY AUTOINCREMENT, aechiement_name,aechiement_element,scoreMax,score);"
    db:exec(mission)

    local mission1 = "CREATE TABLE IF NOT EXISTS aechiementMap( aechiementMap_id INTEGER PRIMARY KEY AUTOINCREMENT, map_id,scoreMax,score);"
    db:exec(mission1)

    local mission = "CREATE TABLE IF NOT EXISTS run( run_id INTEGER PRIMARY KEY AUTOINCREMENT,playMission_id ,map_id ,score ,pin_id);"
    db:exec(mission)

    for rowdata in db:urows ("SELECT * FROM user;") do
        count = count +1
    end

    dataStrone()
    dataPinTable()
    dataTeamTable()

    dataINRun()
    return count
end

function register(user_id)
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    local tablefill ="INSERT INTO user VALUES ('"..user_id.."','tada','1','1','0','0','0','1','1');"
    db:exec( tablefill )
    db:close()
end

function fontName()
    local sh = 50
    local scrollView = widget.newScrollView
        {
            top = 50,
            left = 10,
            width = screenW*.9,
            height = screenH*.9,
            scrollWidth = 0,
            scrollHeight = 0,
        }
    local fonts = native.getFontNames()
    for i,fontname in ipairs(fonts) do
        local myText = display.newText("score PUZZLE MENU="..fonts[i],0,sh,fonts[i],35)
        myText:setTextColor(0,0,0)
        myText.anchorX = 0
        scrollView:insert( myText )
        sh = sh + 70
    end
    local FontAndSize ={
        TypeFontMenu = "",
        SizeFontMenu = "" ,

        TypeFontText = "",
        SizeFontText = "",

        TypeFontbutton = "",
        SizeFontbutton = "",
    }
end