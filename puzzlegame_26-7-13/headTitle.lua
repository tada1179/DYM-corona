---------------------------------------------------------------
print("HeadTitle.lua")
module(..., package.seeall)
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
---------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local typeFont =  native.systemFontBold
local sizetextname = 25

local sizeball =  screenW*.2
local size_linebaseW =  screenW*.3 -- mot /4 ok
local size_linebaseH =  screenH*.008
local pointLineX =  screenW*.08

local image_ball = "img/menu/battle_dark.png"
local image_linebase = "img/head/line_transparent.png"
local image_background = "img/background/background_2.png"

--*** data base connect
local dataName ="TADA1179"
--***********************************************************--

--function headPACK()
    local namelenght = string.len(dataName)
    print("lenght:"..namelenght)
    local pointName =  (screenW*.48)-((namelenght*sizetextname)/4)

    print("function head in HeadTitle.lua")
    local group = display.newGroup()
    local function onBtnHeadpackRelease()

        print( "event: "..event.target.id)
        if event.target.id == "battle" then
            print( "event: "..event.target.id)
            storyboard.gotoScene( "map", "fade", 100 )
        elseif  event.target.id == "team" then
            print( "event: "..event.target.id)
            storyboard.gotoScene( "unit_main", "fade", 100 )
        end
        return true

    end
    local background = display.newImageRect(image_background,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    group:insert(background)

    local Myname = display.newText(dataName, pointName, screenH*.05, typeFont, sizetextname)
    Myname:setTextColor(255, 0, 255)
    group:insert(Myname)

    local linebaseRANG = display.newImageRect(image_linebase,size_linebaseW,size_linebaseH)--contentWidth contentHeight
    linebaseRANG:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    linebaseRANG.x,linebaseRANG.y = pointLineX,screenH*.14
    group:insert(linebaseRANG)

    local linebaseSTAMINA = display.newImageRect(image_linebase,size_linebaseW,size_linebaseH)--contentWidth contentHeight
    linebaseSTAMINA:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    linebaseSTAMINA.x,linebaseSTAMINA.y = pointLineX,screenH*.19
    group:insert(linebaseSTAMINA)

    local btnBattle = widget.newButton{
        default = image_ball,
        over = image_ball,
        width= sizeball ,
        height= sizeball,
        onRelease = onBtnHeadpackRelease
    }
    btnBattle.id="battle"
    btnBattle:setReferencePoint( display.CenterReferencePoint )
    btnBattle.x =screenW*.5
    btnBattle.y =screenH*.17
    group:insert(btnBattle)

    return group
--end

