local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )

function locadData()
    local MapSubstates = "CREATE TABLE IF NOT EXISTS map ( map_id INTEGER PRIMARY KEY AUTOINCREMENT, map_name ,map_run);"
    db:exec(MapSubstates)

    --mission
    local tablemission ="INSERT INTO mission VALUES ('1','AAAA','3');"


    --map
    local tablemission ="INSERT INTO map VALUES ('AAAA','3');"
    db:exec( tablemission )

    local tablemission2 ="INSERT INTO map VALUES ('BBBB','7');"
    db:exec( tablemission2 )

    local tablemission3 ="INSERT INTO map VALUES ('CCCC','6');"
    db:exec( tablemission3 )

    local tablemission4 ="INSERT INTO map VALUES ('DDDD','8');"
    db:exec( tablemission4 )

    local tablemission5 ="INSERT INTO map VALUES ('EEEE','11');"
    db:exec( tablemission5 )

    local tablemission6 ="INSERT INTO map VALUES ('FFFF','12');"
    db:exec( tablemission6 )

    local tablemission7 ="INSERT INTO map VALUES ('GGGG','5');"
    db:exec( tablemission7 )

    local Wayi = 0
    local myName = {}
    local myID = {}
    local myWay = {}

    for rowdata in db:urows ("SELECT * FROM map;") do
        Wayi = Wayi + 1
        myID[Wayi] =  tonumber(rowdata.map_id)
        myWay[Wayi] =  tonumber(rowdata.map_run)
        myName[Wayi] =  rowdata.map_name

        for i=1,myWay[Wayi],1 do
            local name =  myName[Wayi]..i
            local tabmission ="INSERT INTO mission VALUES ('"..name..".','"..myID[Wayi].."','1');"
            db:exec( tabmission )
        end
    end

    for loadData in db:urows ("SELECT * FROM mission;") do
        print("mission_id =",loadData.mission_id,"mission_name =",loadData.mission_name,"map_id =",loadData.map_id,"num_way =",loadData.num_way)
    end

    return true
end





















