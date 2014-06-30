local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )
local screenW = display.contentWidth
local screenH = display.contentHeight
local gdisplay

local posX,posY
local SizeImgX = 2.5
local SizeImgY = 2
local myRectangle

local transitionStash = {}
local btnOK = {}
local topImg
---------------------------------------
local pointMissionX = {
    {280,800,1300},
    { 100,620,500,950 ,800 ,1100 ,1300 ,1300 },  --(1,2, ทางแยก 3,4  ,6           --------*****
    { 900,1300,600,1000 ,800 ,300 ,300 ,1000 },
    { 1450,1200,800,1100,750,650 ,100 ,400 ,750,100,},--4
    { 1100,1250,850,1350,800,      300,750,1300 ,1000,800,    300 ,750              , 500,600},--5

    { 400,650,1100,500,650 ,      650,900,1300 ,900,1500,    600 ,750               ,200,350 },--6
    { 600,900,1300,650,700,700 ,900,1300 ,900,1500,600 ,750},


}
local pointMissionY = {
    {900,950,850},
    {850,920,650,800,400,400,600,600},
    {1500,1150,1200,600,950,700,600,600},
    {900,850,650,1200,1100,800,1200,1000,750,100},  --4
    {1700,1400,1350,1200,1000,         750,700,900,600,700,   550,700,              1750,1400},--5

    {1500,1400,1300,1200,1050,         1050,1000,900,800,1200,   900,700,          1400,1100  },--6
    {1700,1500,1700,1200,900,900,1000,900, 800,1200,  900,700},



}

local pointLineRotate = {
    {5,350},
    {10,340,75,180,140,180,235,150},
    {320,240,355,180,130,25,235,170},
    {190,105,30,200,280,320,350,325,330,100},--4
    {300,300,10,260,85     ,30,260,80,50,340   ,11,85,                          285},--5

    {340,230,165,260,130,    350,260,165,15,240,  345,310,                   300}, --6
    {330,230,210,260,100,95,260,165, 15,240,   345,310},

}

local wightXY = {
    {570,500,300},
    {570,400,300,400,400, 300,250,400},
    {570,700,700,400, 350, 600,250,700},
    {200,400,450,350,500,250,650,350,300,100},--4
    {350,250,350,350,400,     550,650,350,400,220,   11,300,                         400},--5

    {300,300,450,350,200,     300,650,400,400,350,     350,250,                      350},--6
    {400,400,450,350,350,350,650,400,400,350,350,250},


}

local slide_WayX = {
    {-250,-750,-500},
    {-250,-250,-400,-400,-800, -800,-900},
    {-800,-800,-500,-400,-500, -200,-900},
    {-850,-800,-700,-600,-700, -150,-500,-100,-100}, --4
    {-850,-800,-800,-750,-630,    -600,-500,-700,-500,-11,                   -700,-600,-100}, --5

    {-350,-400,-500,-550,-530,    -600,-700,-1100,-900,-800,                -700,-600,-100},--6
    {-450,-400,-500,-550,-530, -600,-700,-1100,-900,-800},


}

local slide_WayY = {
    {-200,-300,-300},
    {-200,-300,-300,-100,-200,-100,-100},
    {-800,-700,-500,-300,-400,-200,-100},
    {-300,-700,-400,-400,-400,-300,-400,-300,-100},--4
    {-1000,-1200,-800,-650,-500,     -500,-500,-300,-300,-11,                    -300,-800,-1000},--5

    {-800,-1000,-800,-650,-600,     -700,-500,-600,-600,-700,               -300,-500,-500},--6
    {-800,-1000,-800,-650,-600, -700,-500,-600,-600,-700},


}

local map_id = {}
local map_name
local map_run

local  mission_id = {}
local  mission_name= {}
local  num_way = {}
local  station_id = {}
local  next_station_id = {}

local status ={}
local NumberImg = 0
local count = 0
local playCount
local nameMap
local playMission_id = {}

local maxNumber = 0
---------------------------------------
local function shotWay(point,rotate)  --show a way on map

   print("No.way,NumberImg --=== ",NumberImg,point)
    local way_short = "img/mission_map/way.png"
    local imgWay = display.newImage(way_short)

  if NumberImg == 2 and point == 4 then
        imgWay.width = wightXY[NumberImg][point+1]
        imgWay.x =  pointMissionX[NumberImg][point+1]
        imgWay.y =  pointMissionY[NumberImg][point+1]
        imgWay.anchorX = 0
        imgWay.anchorY = 0.5
        imgWay:rotate( pointLineRotate[NumberImg][rotate+1] )


    elseif NumberImg == 2 and point == 5 then
       imgWay.width = wightXY[NumberImg][point+3]
       imgWay.x =  pointMissionX[NumberImg][point+3]
       imgWay.y =  pointMissionY[NumberImg][point+3]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][rotate+3] )


   elseif NumberImg == 3 and point == 4 then
       imgWay.width = wightXY[NumberImg][point+1]
       imgWay.x =  pointMissionX[NumberImg][point+1]
       imgWay.y =  pointMissionY[NumberImg][point+1]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][rotate+1] )


   elseif NumberImg == 3 and point == 5 then
       imgWay.width = wightXY[NumberImg][point+3]
       imgWay.x =  pointMissionX[NumberImg][point+3]
       imgWay.y =  pointMissionY[NumberImg][point+3]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][rotate+3] )


   elseif NumberImg == 4 and point == 7 then
       imgWay.width = wightXY[NumberImg][6]
       imgWay.x =  pointMissionX[NumberImg][6]
       imgWay.y =  pointMissionY[NumberImg][6]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][6] )


   elseif NumberImg == 4 and point == 6 then
       imgWay.width = wightXY[NumberImg][7]
       imgWay.x =  pointMissionX[NumberImg][7]
       imgWay.y =  pointMissionY[NumberImg][7]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][7] )


   elseif NumberImg == 5 and point == 4 then
       imgWay.width = wightXY[NumberImg][5]
       imgWay.x =  pointMissionX[NumberImg][5]
       imgWay.y =  pointMissionY[NumberImg][5]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][5] )


   elseif NumberImg == 5 and point == 5 then
       imgWay.width = wightXY[NumberImg][6]
       imgWay.x =  pointMissionX[NumberImg][6]
       imgWay.y =  pointMissionY[NumberImg][6]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][6] )


   elseif NumberImg == 5 and point == 7 then
       imgWay.width = wightXY[NumberImg][8]
       imgWay.x =  pointMissionX[NumberImg][8]
       imgWay.y =  pointMissionY[NumberImg][8]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][8] )


   elseif NumberImg == 5 and point == 8 then
       imgWay.width = wightXY[NumberImg][9]
       imgWay.x =  pointMissionX[NumberImg][9]
       imgWay.y =  pointMissionY[NumberImg][9]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][9] )


   elseif NumberImg == 5 and point == 9 then
       imgWay.width = wightXY[NumberImg][10]
       imgWay.x =  pointMissionX[NumberImg][10]
       imgWay.y =  pointMissionY[NumberImg][10]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][10] )

   elseif NumberImg == 5 and point == 11 then
       imgWay.width = wightXY[NumberImg][4]
       imgWay.x =  pointMissionX[NumberImg][4]
       imgWay.y =  pointMissionY[NumberImg][4]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][4]+180 )

  elseif NumberImg == 6 and point == 0 then
--       imgWay.width = wightXY[NumberImg][8]
--       imgWay.x =  pointMissionX[NumberImg][8]
--       imgWay.y =  pointMissionY[NumberImg][8]
--       imgWay.anchorX = 0
--       imgWay.anchorY = 0.5
--       imgWay:rotate( pointLineRotate[NumberImg][8] )
--
--       print("5555555 ****** **** if =", pointLineRotate[NumberImg][8],"x:y",imgWay.x ,imgWay.y)

   elseif NumberImg == 6 and point == 7 then
       imgWay.width = wightXY[NumberImg][8]
       imgWay.x =  pointMissionX[NumberImg][8]
       imgWay.y =  pointMissionY[NumberImg][8]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][8] )


   elseif NumberImg == 6 and point == 8 then
       imgWay.width = wightXY[NumberImg][10]
       imgWay.x =  pointMissionX[NumberImg][10]
       imgWay.y =  pointMissionY[NumberImg][10]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][10] )


   elseif NumberImg == 6 and point == 10 then
       imgWay.width = wightXY[NumberImg][11]
       imgWay.x =  pointMissionX[NumberImg][11]
       imgWay.y =  pointMissionY[NumberImg][11]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][11] )

   elseif NumberImg == 6 and point == 12 then

   elseif NumberImg == 6 and point == 11 then
       imgWay.width = wightXY[NumberImg][12]
       imgWay.x =  pointMissionX[NumberImg][11]
       imgWay.y =  pointMissionY[NumberImg][11]
       imgWay.anchorX = 0
       imgWay.anchorY = 0.5
       imgWay:rotate( pointLineRotate[NumberImg][12] )


   elseif NumberImg == 7 and point == 4 then
--       imgWay.width = wightXY[NumberImg][12]
--       imgWay.x =  pointMissionX[NumberImg][11]
--       imgWay.y =  pointMissionY[NumberImg][11]
--       imgWay.anchorX = 0
--       imgWay.anchorY = 0.5
--       imgWay:rotate( pointLineRotate[NumberImg][12] )

--       print("5555555 ****** **** if =", pointLineRotate[NumberImg][12],"x:y",imgWay.x ,imgWay.y)

   else
        imgWay.width = wightXY[NumberImg][point]
        imgWay.x =  pointMissionX[NumberImg][point]
        imgWay.y =  pointMissionY[NumberImg][point]
        imgWay.anchorX = 0
        imgWay.anchorY = 0.5
        imgWay:rotate( pointLineRotate[NumberImg][rotate] )

    --print("imgWay.width",imgWay.width,"imgWay.x",imgWay.x,"imgWay.Y = ",imgWay.y)
  end

   if NumberImg ~= 5 and maxNumber == 0 then
        transitionStash.newTransition = transition.to( gdisplay, { time=2000, x= slide_WayX[NumberImg][point],y = slide_WayY[NumberImg][point], alpha=1})
   end

   if NumberImg ~= 6 and maxNumber == 0 then
       transitionStash.newTransition = transition.to( gdisplay, { time=2000, x= slide_WayX[NumberImg][point],y = slide_WayY[NumberImg][point], alpha=1})
   end

   gdisplay:insert(imgWay)

end
local function onTouchMap(self,event)

    if ( "began" == event.phase ) then
        self.markX = self.x
        self.markY = self.y

        display.getCurrentStage():setFocus( self )
        self.isFocus = true

    elseif self.isFocus then

        if event.phase == "moved"  then
            posX = (event.x - event.xStart) + self.markX
            posY = (event.y - event.yStart) + self.markY

--            print("posX:",posX," posY:",posY)
            if (posX < 0 and posY < screenH*.05 ) and (posX > -screenW*(SizeImgX-1) and posY > -screenH*(SizeImgY-1)) then
                self.x, self.y = posX, posY

            end

        elseif event.phase == "ended" or event.phase == "cancelled" then
            transition.to(self,{time = 100, x = self.x , y = self.y})
            display.getCurrentStage():setFocus( nil )
            self.isFocus = false
        end

    end
    return true

end
local function ontouchMission(event)

    if event.phase == "ended"  then
        if event.target.id == "Close" then
            display.remove(gdisplay)
            gdisplay = nil
            storyboard.gotoScene("mainMap","zoomInOutFade",300)

        else -- if you can

            local nm = 0
            local data = 0
            local datanext_station_id = {}
            local touch_id = event.target.id
            -----------------

            display.remove(gdisplay)
            gdisplay = nil

            local option = {
                effect = "zoomInOutFade",
                time = 300,
                params = {
                    map_id = NumberImg,
                    mission_id = touch_id,
                    mission_name = mission_name[touch_id],
                }
            }
           storyboard.gotoScene("team_select",option)
--            require( "info").missionMODE()
        end
    end
    return true
end
function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()
    require("top_name").alphaDisplay(1)

    count = 0
    playCount = 0
    NumberImg = event.params.map_id
    nameMap = event.params.map_name

--    nameMap = "DDD444"
--    NumberImg = 4

    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    for missiondata in db:nrows ("SELECT * FROM playMission WHERE map_id = '"..NumberImg.."';") do
        playCount = playCount +1

        map_id[playCount] = tonumber(missiondata.map_id)
        playMission_id[playCount] = tonumber(missiondata.playMission_id)
        mission_name[playCount] = missiondata.mission_name
        num_way[playCount] = tonumber(missiondata.num_way)
        station_id[playCount] = tonumber(missiondata.station_id)
        next_station_id[playCount] = missiondata.next_station_id
        status[playCount] = tonumber(missiondata.status)

    end

    local img = {
        "img/mission_map/map_1.png",
        "img/mission_map/map_2.png",
        "img/mission_map/map_3.png",
        "img/mission_map/map_4.png",
        "img/mission_map/map_5.png",
        "img/mission_map/map_6.png",
        "img/mission_map/map_7.png",
    }

    topImg = display.newImageRect(img[NumberImg],screenW*SizeImgX,screenH*SizeImgY)
    topImg.x = 0
    topImg.y = screenH*.05
    topImg.anchorX = 0
    topImg.anchorY = 0
    gdisplay:insert(topImg)

    local img_OK =
    {
        "img/mission_map/past.png",
        "img/mission_map/start.png",
    }



    for i = 1,playCount,1 do
        if 0 == status[i] then -- If you can

            btnOK[i] = widget.newButton{
                defaultFile = img_OK[2],
                overFile = img_OK[2],
                onEvent = ontouchMission	-- event listener function
            }
            gdisplay.x = topImg.x - pointMissionX[NumberImg][station_id[i]]/2
            gdisplay.y = topImg.y - pointMissionY[NumberImg][station_id[i]]/2

            btnOK[i].id = station_id[i]
            btnOK[i].x = pointMissionX[NumberImg][station_id[i]]
            btnOK[i].y = pointMissionY[NumberImg][station_id[i]]
            gdisplay:insert(btnOK[i])


            if NumberImg == 3 and i == 1 then
                transitionStash.newTransition = transition.to( gdisplay, { time=2000, x= -600,y = -800, alpha=1})

            elseif NumberImg == 4 and i == 1 then
                transitionStash.newTransition = transition.to( gdisplay, { time=2000, x= -900,y = -300, alpha=1})

            elseif NumberImg == 5 and i == 1 then
                maxNumber = 1
                transitionStash.newTransition = transition.to( gdisplay, { time=2000, x= -800,y = -1000, alpha=1})


            elseif NumberImg == 6 and i == 1 then
                transitionStash.newTransition = transition.to( gdisplay, { time=2000, x= -300,y = -1000, alpha=1})

            elseif NumberImg == 7 and i == 1 then
                transitionStash.newTransition = transition.to( gdisplay, { time=2000, x= -300,y = -1000, alpha=1})

            elseif NumberImg == 5 and (i == 13 or i == 14) and  maxNumber == 0 then
                transitionStash.newTransition = transition.to( gdisplay, { time=2000, x= -100,y = -1000, alpha=1})
                if i == 14 then
                    maxNumber = 1
                end

            end

            nameMap = mission_name[i]
        end


        if 1 == status[i] then -- If you can -- you past

            if playCount ~= i then
                if NumberImg == 5 and i >= 13 then
                    maxNumber = 1

                elseif NumberImg == 6 and i >= 13 then
                    maxNumber = 1

                else
                    maxNumber = 0

                end
                shotWay(num_way[i],num_way[i])

            end


            btnOK[i] = widget.newButton{
                defaultFile = img_OK[1],
                overFile = img_OK[1],
                onEvent = ontouchMission	-- event listener function
            }
            btnOK[i].id = i
            btnOK[i].x = pointMissionX[NumberImg][station_id[i]]
            btnOK[i].y = pointMissionY[NumberImg][station_id[i]]
            gdisplay:insert(btnOK[i])

            nameMap = mission_name[i]
        end


    end
    gdisplay.touch= onTouchMap


    gdisplay:addEventListener( "touch", gdisplay )

    local textMap = display.newText(nameMap,screenW*.5,screenH*.95,native.systemFont,20)
    local tapmissionName = display.newImage("img/middle_frame/ast_scorebar.png")
    tapmissionName.x = screenW*.5
    tapmissionName.y = screenH*.95
    tapmissionName.anchorX = 0.5
    tapmissionName.anchorY = 0
    group:insert(gdisplay)
    group:insert(tapmissionName)

    textMap.anchorX = 0.5
    textMap.anchorY = 0
    group:insert(textMap)

    local buttonClose = widget.newButton
        {
            left = screenW*.85,
            top = screenH*.93,
            defaultFile = "img/universal/btt_cancel.png",
            overFile = "img/universal/btt_cancel.png",
            onEvent = ontouchMission
        }
    buttonClose.id = "Close"
    buttonClose.anchorX = 0.5
    group:insert(buttonClose)


    db:close()

end

function scene:enterScene( event )
local group = self.view
storyboard.removeAll ()
storyboard.purgeAll()
end

function scene:exitScene( event )
local group = self.view

storyboard.removeAll ()
storyboard.purgeAll()
end

function scene:destroyScene( event )
local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene