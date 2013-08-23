module(..., package.seeall)
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local json = require("json")
local http = require("socket.http")

--------------------------------------------------
local LinkuserID = "http://localhost/DYM/deviceID.php?SysdeviceID="

local screenW = display.contentWidth
local screenH = display.contentHeight
local dataLV
--------------------------------
function DriverIDPhone()
    local SysdeviceID = system.getInfo( "deviceID" ) -- deviceID IMEI Phone
    --print("System deviceID:"..SysdeviceID)
    return  SysdeviceID
end

function USERIDPhone()
    local SysdeviceID = system.getInfo( "deviceID" ) -- deviceID IMEI Phone
    local URL =  LinkuserID..SysdeviceID
    local response = http.request(URL)
    local USERID
    if response == nil then
        print("fail ! can't select user id")
    else
       -- print("includeFunction USER")
        local dataTable = json.decode(response)
        USERID = dataTable.deviceID1.user_id
        dataLV = dataTable.deviceID1.user_level
    end
    return USERID
end
function userLevel()
    USERIDPhone()
    return dataLV
end

function holdcharac(id)
    local url = "http://localhost/DYM/holdcharacter.php?charac_id="
    local character =   url..id
    local response = http.request(character)
    local dataTable = json.decode(response)
    if dataTable == nil then
        print("No data")
    end
    print("FN dataTable",dataTable[1].charac_img)
    return  dataTable
end

