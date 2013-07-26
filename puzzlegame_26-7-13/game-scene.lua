
---------------------------------------------------------------------------------
-- game-scene.lua - GAME SCENE
print("game-scene.lua")
---------------------------------------------------------------------------------


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
--** add function ---------------
local widget = require "widget"
local alertMSN = require("alertMassage")
--**-----------------------------

local _W = display.contentWidth
local _H = display.contentHeight
local mRandom = math.random

local score
local scoreText

local gameTimer
local gameTimerText
local gameTimerBar
local gameTimerBar_bg
local powerBar


local gemsTable = {}
local numberOfMarkedToDestroy = 0
local gemToBeDestroyed  			-- used as a placeholder
local isGemTouchEnabled = true 		-- blocker for double touching gems
local ismarkRoworcolum = true       --## 1
local ismarkship = true    --## 2
--local downmarkship = 0


local gameOverLayout
local gameOverText1
local gameOverText2

local timers = {}
local background -- background
local backgroundTop -- backgroundTop

-- pre-declaration of function
local onGemTouch

local RED = 0
local markRed = 0
local textRED

local GREEN = 0
local markGreen = 0
local textGREEN

local BLUE = 0
local markBlue = 0
local textBLUE

local PURPLE = 0
local markPurple = 0
local textPURPLE

local PINK = 0
local markPink = 0
local textPINK

local YELLOW = 0
local markYellpw = 0
local textYELLOW

local NumbernewItem = 0

local sizeBall = display.contentWidth*.15
local size_Ball = display.contentWidth*.17


--, display.contentHeight
local typecolor = {}
typecolor[1] = 0
typecolor[2] = 0
typecolor[3] = 0
typecolor[4] = 0
typecolor[5] = 0
typecolor[6] = 0

-- tada1179.w@gmail.com -------------------------------------------------
local includeFUN = require("includeFunction")
local http = require("socket.http")
local json = require("json")
local user_id
local backButton
local bntItem
local characImage ={}
-- game option
-- 1 : ON
-- 2 : OFF
local character_numAll
local image_char


local BGM = 1
local SFX = 1
local SKL = 1
local BTN = 1

local battle = nil
local mission = nil
local checkOption = 1

local NumExp = 50
local NumCoin = 200
local NumDiamond = 10
local NumFlag = 10

--  tada1179.w@gmail.com ---------------------------------------------------
local   picture = {"img/element/red.png","img/element/green.png","img/element/blue.png","img/element/purple.png","img/element/pink.png","img/element/yellow.png"}

local function newGem (i,j)
    local R = mRandom(1,6)
    local newGem


    newGem = display.newImageRect(picture[R],48,48)
    newGem.x = i * 53 - (26+53)
    newGem.y =  j* 53 + 454

    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = false    --##
    newGem.isMarkedToDestroy = false
    --newGem.destination_y = j* 53 + 186
    newGem.destination_y = newGem.y
    if 		(R == 1 ) then

        newGem.gemType = "red"

    elseif 	(R == 2 ) then

        newGem.gemType = "green"

    elseif 	(R == 3 ) then

        newGem.gemType = "blue"

    elseif 	(R == 4 ) then

        newGem.gemType = "purple"

    elseif 	(R == 5 ) then

        newGem.gemType = "pink"

    elseif 	(R == 6 ) then

        newGem.gemType = "yellow"

    end

    --new gem falling animation
    transition.to( newGem, { time=100, y= newGem.destination_y} )

    groupGameLayer:insert( newGem )


    newGem.touch = onGemTouch
    newGem:addEventListener( "touch", newGem )

    return newGem
end

local function copynewGem (i,j,coler)

--        backgroundTop = display.newImageRect( "img/background/lay_bt00top.png" , 320, display.contentHeight/2 - 27 )
--        backgroundTop:setReferencePoint( display.TopLeftReferencePoint )
--        backgroundTop.x, backgroundTop.y = 0, 0


    local R = coler
    local newGem
    local picture
    if R == "red" then
        picture =  "img/element/red.png"
    end
    if R == "green" then
        picture =  "img/element/green.png"
    end
    if R == "blue" then
        picture =  "img/element/blue.png"
    end
    if R == "purple" then
        picture =  "img/element/purple.png"
    end
    if R == "pink" then
        picture =  "img/element/pink.png"
    end
    if R == "yellow" then
        picture =  "img/element/yellow.png"
    end

    --picture = {"image/RED.png","image/GREEN.png","image/BLUE.png","image/PURPLE.png","image/PINK.png","image/YELLOW.png"}

    newGem = display.newImageRect(picture,48,48)
    newGem.x = i * 53 - (26+53)
    -- if j == 1 then
    newGem.y = j * 53 + 134
    -- else
    --     newGem.y = j * 53 + 134 + (53/2+1)
    -- end



    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = false    --##
    newGem.isMarkedToDestroy = false
    --newGem.destination_y = j* 53 + 186
    newGem.destination_y = newGem.y
    if 		(R == "red" ) then

        newGem.gemType = "red"

    elseif 	(R == "green" ) then

        newGem.gemType = "green"

    elseif 	(R == "blue" ) then

        newGem.gemType = "blue"

    elseif 	(R == "purple" ) then

        newGem.gemType = "purple"

    elseif 	(R == "pink" ) then

        newGem.gemType = "pink"

    elseif 	(R == "yellow" ) then

        newGem.gemType = "yellow"

    end

    --new gem falling animation
    transition.to( newGem, { time=100, y= newGem.destination_y} )

    groupGameLayer:insert( newGem )


    newGem.touch = onGemTouch
    newGem:addEventListener( "touch", newGem )
    --pr(newGem,'newGem')
    return newGem
end

local function shiftGems () -- not working yet <_< of coz it's working! :P

    print ("Shifting Gems")

    -- first roww
    for i = 1, 8, 1 do
        if gemsTable[i][1].isMarkedToDestroy then
            gemToBeDestroyed = gemsTable[i][1]

            -- create a new one
            gemsTable[i][1] = newGem(i,1)

            -- destroy old gem
            gemToBeDestroyed:removeSelf()
            gemToBeDestroyed = nil
        end
    end

    -- rest of the rows
    for j = 2, 7, 1 do  -- j = row number - need to do like this it needs to be checked row by row
        for i = 1, 8, 1 do

            if gemsTable[i][j].isMarkedToDestroy then --if you find and empty hole then shift down all gems in column
                gemToBeDestroyed = gemsTable[i][j]

                -- shiftin whole column down, element by element in one column
                for k = j, 2, -1 do -- starting from bottom - finishing at the second row

                    -- curent markedToDestroy Gem is replaced by the one above in the gemsTable
                    gemsTable[i][k] = gemsTable[i][k - 1]
                    gemsTable[i][k].destination_y = gemsTable[i][k].destination_y + 53
                    transition.to( gemsTable[i][k], { time=300, y= gemsTable[i][k].destination_y} )

                    -- we change its j value as it has been 'moved down' in the gemsTable
                    gemsTable[i][k].j = gemsTable[i][k].j + 1

                end

                -- create a new gem at the first row as there is en ampty space due to gems
                -- that have been moved in the column
                gemsTable[i][1] = newGem(i,1)

                -- destroy the old gem (the one that was invisible and placed in gemToBeDestroyed holder)
                gemToBeDestroyed:removeSelf()
                gemToBeDestroyed = nil
            end
        end
    end

end

local function returnmarkToDestroy(self)
    --check on the left
    self.isMarkedToDestroy = false
    numberOfMarkedToDestroy = 0
    if self.i>2 then
        if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == true then

            if (gemsTable[self.i-1][self.j]).gemType == self.gemType then
               -- gemsTable[self.i-1][self.j].isMarkedToDestroy = false
                returnmarkToDestroy( gemsTable[self.i-1][self.j] )
            end
        end
    end

    -- check on the right
    if self.i<7 then
        if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == true then

            if (gemsTable[self.i+1][self.j]).gemType == self.gemType then
              --  gemsTable[self.i+1][self.j].isMarkedToDestroy = false
                returnmarkToDestroy( gemsTable[self.i+1][self.j] )
            end
        end
    end

    -- check above
    if self.j>2 then
        if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == true then

            if (gemsTable[self.i][self.j-1]).gemType == self.gemType then
               -- gemsTable[self.i][self.j-1].isMarkedToDestroy = false
                returnmarkToDestroy( gemsTable[self.i][self.j-1] )
            end
        end
    end

    -- check below
    if self.j<6 then
        if (gemsTable[self.i][self.j+1]).isMarkedToDestroy == true then

            if (gemsTable[self.i][self.j+1]).gemType == self.gemType then
                --gemsTable[self.i][self.j+1].isMarkedToDestroy = false
                returnmarkToDestroy( gemsTable[self.i][self.j+1] )
            end
        end
    end

end

local function markToDestroy( self , k )
  --  print("touch i",self.i,"j",self.j)
    self.isMarkedToDestroy = true
    numberOfMarkedToDestroy = numberOfMarkedToDestroy + 1
    typecolor[k] = typecolor[k] + 1

   --check on the left
    if self.i>2 then
        if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == false then

            if (gemsTable[self.i-1][self.j]).gemType == self.gemType then

                markToDestroy( gemsTable[self.i-1][self.j],k )
            end
        end
    end

   -- check on the right
    if self.i<7 then
        if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == false then

            if (gemsTable[self.i+1][self.j]).gemType == self.gemType then

                markToDestroy( gemsTable[self.i+1][self.j],k )
            end
        end
    end

    -- check above
    if self.j>2 then
        if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == false then

            if (gemsTable[self.i][self.j-1]).gemType == self.gemType then

                markToDestroy( gemsTable[self.i][self.j-1],k )
            end
        end
    end

    -- check below
    if self.j<6 then
        if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== false then

            if (gemsTable[self.i][self.j+1]).gemType == self.gemType then

                markToDestroy( gemsTable[self.i][self.j+1],k )
            end
        end
    end

end

local function enableGemTouch()
    isGemTouchEnabled = true
end

local function destroyGems()
    print ("Destroying Gems. Marked to Destroy = "..numberOfMarkedToDestroy)
    print("destroy Gems")

    for i = 2, 7, 1 do
        for j = 2, 6, 1 do

            if gemsTable[i][j].isMarkedToDestroy then


                print("i",i,"j",j,"isMarkedToDestroy",gemsTable[i][j].isMarkedToDestroy)
                isGemTouchEnabled = false
                transition.to( gemsTable[i][j], { time=100, alpha=0.2, xScale=1.2, yScale = 1.2, onComplete=enableGemTouch } )

                -- update score
                score = score + 10
                scoreText.text = string.format( "SCORE: %6.0f", score )
                scoreText:setReferencePoint(display.TopLeftReferencePoint)
                scoreText.x = 60

                if gemsTable[i][j].gemType == "red" then
                    RED = RED + 10
                    textRED.text = string.format( "RED: %6.0f", RED )
                    textRED:setReferencePoint(display.TopLeftReferencePoint)
                    textRED.x = 60



                end
                if gemsTable[i][j].gemType == "green" then
                    GREEN = GREEN + 10
                    textGREEN.text = string.format( "GREEN: %6.0f", GREEN )
                    textGREEN:setReferencePoint(display.TopLeftReferencePoint)
                    textGREEN.x = 60
                end
                if gemsTable[i][j].gemType == "blue" then
                    BLUE = BLUE + 10
                    textBLUE.text = string.format( "BLUE: %6.0f", BLUE )
                    textBLUE:setReferencePoint(display.TopLeftReferencePoint)
                    textBLUE.x = 60
                end
                if gemsTable[i][j].gemType == "purple" then
                    PURPLE = PURPLE + 10
                    textPURPLE.text = string.format( "PURPLE: %6.0f", PURPLE )
                    textPURPLE:setReferencePoint(display.TopLeftReferencePoint)
                    textPURPLE.x = 60
                end
                if gemsTable[i][j].gemType == "pink" then
                    PINK = PINK + 10
                    textPINK.text = string.format( "PINK: %6.0f", PINK )
                    textPINK:setReferencePoint(display.TopLeftReferencePoint)
                    textPINK.x = 60

                    if PINK <= 150 then

                        powerBar = display.newImageRect("img/background/bt_p_hpbar.png",PINK,6)
                        powerBar.x = 90 + PINK
                        powerBar.y =  207

                    end
                end
                if gemsTable[i][j].gemType == "yellow" then
                    YELLOW = YELLOW + 10
                    textYELLOW.text = string.format( "YELLOW: %6.0f", YELLOW )
                    textYELLOW:setReferencePoint(display.TopLeftReferencePoint)
                    textYELLOW.x = 60
                end
                -- {"RED.png","GREEN.png","BLUE.png","PURPLE.png","PINK.png","YELLOW.png"}
            end
        end
    end

    numberOfMarkedToDestroy = 0
    --
    typecolor[1] = 0
    typecolor[2] = 0
    typecolor[3] = 0
    typecolor[4] = 0
    typecolor[5] = 0
    typecolor[6] = 0

    --
  --  timer.performWithDelay( 220, shiftGems )

end


local function cleanUpGems()
    print("Cleaning Up Gems")

    numberOfMarkedToDestroy = 0

    for i = 1, 8, 1 do
        for j = 1, 7, 1 do

            -- show that there is not enough
            if gemsTable[i][j].isMarkedToDestroy then
                print("i",i,"j",j,"isMarkedToDestroy",gemsTable[i][j].isMarkedToDestroy,"ismarkRoworcolum",gemsTable[i][j].ismarkRoworcolum)
                transition.to( gemsTable[i][j], { time=100, xScale=1.2, yScale = 1.2 } )
                transition.to( gemsTable[i][j], { time=100, delay=100, xScale=1.0, yScale = 1.0} )
            end

            gemsTable[i][j].isMarkedToDestroy = false
            gemsTable[i][j].ismarkRoworcolum = false
        end
    end
end

local function deleteMarkRow( self, event )   --Mark Row touch
    print("delete mark Row")
    for  R = 1 , 8, 1 do
        if gemsTable[R][self.j].ismarkRoworcolum  == true then
            if gemsTable[R][self.j].j == gemsTable[self.i][self.j].j and gemsTable[R][self.j].y == self.markY then    --check rows
                gemsTable[R][self.j].ismarkRoworcolum = false
            end
        end
    end
end

local function deleteColumn( self, event )   --Mark column touch
    print("delete mark Colum")
    for  C = 1 , 7, 1 do
        if gemsTable[self.i][C].ismarkRoworcolum  == true then
            if gemsTable[self.i][C].i == gemsTable[self.i][self.j].i and gemsTable[self.i][C].x == self.markX then    --check rows
                gemsTable[self.i][C].ismarkRoworcolum = false
            end
        end

    end

end

local function markRow( self, event )   --Mark Row touch
    print("mark Row")
    self.ismarkRoworcolum = true
  -- degree X move Right
    for  R = 1 , 8, 1 do
        if gemsTable[R][self.j].ismarkRoworcolum  == false then
            if gemsTable[R][self.j].j == gemsTable[self.i][self.j].j and gemsTable[R][self.j].y == self.markY then    --check rows
                gemsTable[R][self.j].ismarkRoworcolum = true
            end
        end
    end


end
local function markColumn( self, event )   --Mark column touch
  print("mark Colum")
    self.ismarkRoworcolum = true
   -- degree X move Right
    for  C = 1 , 7, 1 do
        if gemsTable[self.i][C].ismarkRoworcolum  == false then
            if gemsTable[self.i][C].i == gemsTable[self.i][self.j].i and gemsTable[self.i][C].x == self.markX then    --check rows
                gemsTable[self.i][C].ismarkRoworcolum = true
            end
        end

    end

end

local function shipRow( self, event )  -- move row X
    print("ship Row")

    local nexPoint = (event.x - event.xStart)
    print("ship nexPoint:",nexPoint)

    for  R = 1 , 8, 1 do
        if gemsTable[R][self.j].ismarkRoworcolum == true then    --check rows

            if gemsTable[R][self.j].i == self.i then

                gemsTable[R][self.j].x = self.markX  + nexPoint
            else

                gemsTable[R][self.j].x =  gemsTable[R][self.j].markX  + nexPoint
            end
           -- gemsTable[R][self.j].ismarkRoworcolum = false
        end

    end


end
local function shipColumn( self, event )  -- move row Y
   print("ship colum")
    local nexPoint = (event.y - event.yStart)

    for  C = 1 ,7, 1 do
        if gemsTable[self.i][C].ismarkRoworcolum == true then    --check rows

            if gemsTable[self.i][C].j == self.j then

                gemsTable[self.i][C].y = self.markY  + nexPoint
            else

                gemsTable[self.i][C].y =  gemsTable[self.i][C].markY  + nexPoint
            end
           -- gemsTable[self.i][C].ismarkRoworcolum = false
        end
    end

end

local function swichValuecolumn( self, event )  --move column degree Y [ UP and Down ]
    print("swich Value column")

    local nexPoint = (event.y - event.yStart)
    for C = 1, 7 ,1 do

          if gemsTable[self.i][C].ismarkRoworcolum == true then
              print("C",C)
                -- move Down
                if gemsTable[self.i][C].y >= 557 then
                    gemToBeDestroyed = gemsTable[self.i][C]-- return value to memory
                    gemToBeDestroyed:removeSelf()
                    gemToBeDestroyed = nil
                    for  k = C , 2, -1 do
                        print("k",k,"11 > UPj",gemsTable[self.i][k].j)
                        gemsTable[self.i][k] = gemsTable[self.i][k - 1]
                        gemsTable[self.i][k].j = gemsTable[self.i][k].j + 1
                        print("k",k,"22 > UPj",gemsTable[self.i][k].j)
                    end
                    gemsTable[self.i][1] = copynewGem(self.i,1,gemsTable[self.i][C - 1].gemType)

                end

                -- move UP
                if gemsTable[self.i][C].y <= 134 then   -- Item row 1 on self is touch
                    gemToBeDestroyed = gemsTable[self.i][C]-- return value to memory
                    gemToBeDestroyed:removeSelf()
                    gemToBeDestroyed = nil
                    for  k = 1 , 6, 1 do
                        print("k",k,"33 < UPj",gemsTable[self.i][k].j)
                        gemsTable[self.i][k] = gemsTable[self.i][k + 1]
                        gemsTable[self.i][k].j = gemsTable[self.i][k].j - 1
                        print("k",k,"44 < UPj",gemsTable[self.i][k].j)
                    end
                    gemsTable[self.i][7] = copynewGem(self.i,7,gemsTable[self.i][C + 1].gemType)

                end
           end
    end

    for  C = 1 , 7, 1 do
        gemsTable[self.i][C].markX = gemsTable[self.i][C].x
        gemsTable[self.i][C].markY = gemsTable[self.i][C].y - nexPoint

    end

end
local function swichValueRow(self, event)  --move ROW degree X [RIGHT and LEFT]
    print("swich Value ROW")

    local nexPoint = (event.x - event.xStart)
    print("x1:nexPoint",nexPoint)
    for R = 1, 8 ,1 do
        if gemsTable[R][self.j].ismarkRoworcolum == true then
        print("",gemsTable[R][self.j].x )
            -- move Right
            if gemsTable[R][self.j].x >= 398 then
                print("R > 389",R)
                gemToBeDestroyed = gemsTable[R][self.j]-- return value to memory
                gemToBeDestroyed:removeSelf()
                gemToBeDestroyed = nil
                for  k = R , 2, -1 do

                    gemsTable[k][self.j] = gemsTable[k - 1][self.j]
                    gemsTable[k][self.j].i = gemsTable[k][self.j].i + 1

                end
                gemsTable[1][self.j] = copynewGem(1,self.j,gemsTable[R - 1][self.j].gemType)
            end

            -- move LEFT
            if gemsTable[R][self.j].x <= -79 then
                print("R < - 79",R)
                gemToBeDestroyed = gemsTable[R][self.j]-- return value to memory
                gemToBeDestroyed:removeSelf()
                gemToBeDestroyed = nil
                for  k = 1 , 7, 1 do

                    gemsTable[k][self.j] = gemsTable[k + 1][self.j]
                    gemsTable[k][self.j].i = gemsTable[k][self.j].i - 1

                end
                gemsTable[8][self.j] = copynewGem(8,self.j,gemsTable[R + 1][self.j].gemType)
            end

        end
    end
--
    print("x2:nexPoint",nexPoint)
    for  R = 1 , 8, 1 do
        gemsTable[R][self.j].markX = gemsTable[R][self.j].x - nexPoint
        gemsTable[R][self.j].markY = gemsTable[R][self.j].y

    end

end

local function slidepointX(self , event) -- move X Right and Left
    print("slide point move x")

    local Pointmove = (event.x - event.xStart)
    local pointPic
    local Dif
    local center
    local k = 1
    local between

    -- for k = 1 , 8 , 1 do
    while k < 9 do
        pointPic = k * 53 - 79
        if gemsTable[self.i][self.j].x < pointPic then

            Dif = pointPic - gemsTable[self.i][self.j].x
            center = (53/2)+1
            between = pointPic - center

            if gemsTable[self.i][self.j].x < between then
                -- move left x
                for R = 1 , 8 ,1 do
                    if gemsTable[R][self.j].j == gemsTable[self.i][self.j].j then
                        if gemsTable[R][self.j].i == self.i then

                            gemsTable[self.i][self.j].x = pointPic - 53
                        else
                            gemsTable[R][self.j].x = (gemsTable[R][self.j].x - 53 ) + Dif
                        end
                    end
                end

            else
                -- move right x
                for R = 1 , 8 ,1 do
                    if gemsTable[R][self.j].j == gemsTable[self.i][self.j].j then
                        if gemsTable[R][self.j].i == self.i then

                            gemsTable[self.i][self.j].x = pointPic
                        else
                            gemsTable[R][self.j].x = gemsTable[R][self.j].x + Dif
                        end
                    end
                end
            end
            k = k + 7

        end
        k = k + 1
    end

    swichValueRow(self, event)

end
local function slidepointY(self , event)  --move Y up and down --
    print("slide point move Y")

    local Pointmove = (event.y - event.yStart)
    local pointPic
    local Dif
    local center
    local k = 1
    local between

    -- for k = 1 , 8 , 1 do
    while k < 8 do
        pointPic = k * 53 + 134

        if gemsTable[self.i][self.j].y < pointPic then
            Dif = pointPic - gemsTable[self.i][self.j].y
            center = (53/2)+1
            between = pointPic - center

            if gemsTable[self.i][self.j].y < between then
                -- move down
                for C = 1, 7 ,1 do
                    if gemsTable[self.i][C].i == gemsTable[self.i][self.j].i then
                        if gemsTable[self.i][C].j == self.j then

                            gemsTable[self.i][self.j].y = pointPic - 53
                        else
                            gemsTable[self.i][C].y = (gemsTable[self.i][C].y - 53 ) + Dif

                        end
                    end
                end
            else
                -- move up
                for C = 1, 7 ,1 do
                    if gemsTable[self.i][C].i == gemsTable[self.i][self.j].i then
                        if gemsTable[self.i][C].j == self.j then

                            gemsTable[self.i][self.j].y = pointPic
                        else
                            gemsTable[self.i][C].y = gemsTable[self.i][C].y + Dif
                        end
                    end

                end
            end

            k = k + 6
        end
        k = k + 1
    end

    swichValuecolumn( self, event )
end


local function checkCreate()
    print("check Create")
    local k =1
    for R = 2 ,7 , 1 do
        for C = 2 , 6 , 1 do
            -- if gemsTable[R][C].ismarkRoworcolum == true then
            typecolor[k] = 0
            markToDestroy(gemsTable[R][C],k)  -- check same
            if typecolor[k] < 4 then
                returnmarkToDestroy(gemsTable[R][C])
            else
                destroyGems()
                shiftGems ()
            end
            k = k + 1
            -- end
        end
    end

    cleanUpGems()
end

-----***** MENU ITEM & Setting *****------
--  tada1179.w@gmail.com -------------------------------
local myItem = {}
local rowItem
local function createItem()

    local Linkmission = "http://localhost/dym/item.php"
    local numberHold_character =  Linkmission.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)


    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        rowItem = allRow.All

        local k = 1
        while(k <= rowItem) do
            myItem[k] = {}
            myItem[k].item_id = allRow.chracter[k].item_id
            myItem[k].element = tonumber(allRow.chracter[k].element)
            myItem[k].img = allRow.chracter[k].img
            myItem[k].holditem_id = allRow.chracter[k].holditem_id
            myItem[k].status = 1
            --1.load not use
            --2.last use


           -- print("k:"..k,"holditem_id:"..myItem[k].holditem_id,"img:"..myItem[k].img)
            k = k +1
        end
    end
end

local function LeaveOption(event)
    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25


    local function ButtouRelease(event)
        local alertMSN =  require( "alertMassage" )
        if event.target.id == "OK" then
           groupView.alpha = 0
           local useTicket = 0 --0:No use ticket
           local optionBonus = {
               params = {
                   useTicket = useTicket,
                   NumDiamond = 0 ,
                   NumCoin = 0 ,
                   NumEXP = 0,
                   NumFlag = 0,
                   user_id = user_id
               }
           }
            alertMSN.confrimLeaveTicket(optionBonus)

        elseif event.target.id =="cancel"  then
            groupView.alpha = 0
        elseif event.target.id =="useticket"  then
            groupView.alpha = 0
            local useTicket = 1 --1:Yes use ticket
            local optionBonus = {
                params = {
                    useTicket = useTicket,
                    NumDiamond = NumDiamond ,
                    NumCoin = NumCoin ,
                    NumEXP = NumExp,
                    NumFlag = NumFlag,
                    user_id = user_id
                }
            }
            alertMSN.confrimLeaveTicket(optionBonus)

        end

        return true
    end
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local pointimg = _W*.25
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, _W*.95,_H*.8 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = _W*.5
    bckCaution.y = _H*.5
    bckCaution.alpha = .8
    groupView:insert(bckCaution)

    local image_GAME_OPTION = "img/background/button/RETREAT.png"
    local btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
    btnGameop:setReferencePoint( display.CenterReferencePoint )
    btnGameop.x = _W *.5
    btnGameop.y = _H*.28
    btnGameop.alpha = 1
    groupView:insert(btnGameop)

    local util = require("util")
    local txtMSN = "USE 1 TICKET\n RETREAT FROM BATTLE BUT\n RECIEVE ALL BONUS WHICH\n GOT FROM THE BATTLE\n\n\n\nRETREAT\n RETREAT FROM THE BATTLE\n WITH NO BOUNS WHICH\n GOT FROM THE BATTLE"
    local lotsOfTextObject = util.wrappedText( txtMSN, 30, sizetext, native.systemFont, {0,200,0} )
    lotsOfTextObject.x = _W*.15
    lotsOfTextObject.y = _H*.31
    groupView:insert(lotsOfTextObject)

    local img_useticket = "img/background/button/OK_button.png"
    local btnuseticket = widget.newButton{
        default = img_useticket,
        over = img_useticket,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnuseticket.id = "useticket"
    btnuseticket:setReferencePoint( display.CenterReferencePoint )
    btnuseticket.alpha = 1
    btnuseticket.x = _W*.5
    btnuseticket.y = _H*.52
    groupView:insert(btnuseticket)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btnucancel = widget.newButton{
        default = img_cancel,
        over = img_cancel,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnucancel.id = "cancel"
    btnucancel:setReferencePoint( display.CenterReferencePoint )
    btnucancel.alpha = 1
    btnucancel.x = _W*.68
    btnucancel.y = _H*.77
    groupView:insert(btnucancel)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        default = img_OK,
        over = img_OK,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = _W*.3
    btnOK.y = _H*.77
    groupView:insert(btnOK)
end
local function BonusOption(event)
    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25
    local image_itemBouns = {
        "img/background/misstion/COIN.png", --coin img
        "img/background/misstion/DIAMOND.png",
        "img/background/misstion/FLAG.png",

    }
    local function ButtouRelease(event)
        if event.target.id == "OK" then
            groupView.alpha = 0
        end

    end

    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local pointimg = _W*.25
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, _W*.95,_H*.8 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = _W*.5
    bckCaution.y = _H*.5
    bckCaution.alpha = .8
    groupView:insert(bckCaution)

    local image_GAME_OPTION = "img/background/button/BONUS_BUTTON.png"
    local btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
    btnGameop:setReferencePoint( display.CenterReferencePoint )
    btnGameop.x = _W *.5
    btnGameop.y = _H*.3
    btnGameop.alpha = 1
    groupView:insert(btnGameop)

    local img_coin = display.newImageRect( image_itemBouns[1], _W*.12,_H*.08 )
    img_coin:setReferencePoint( display.CenterReferencePoint )
    img_coin.x = pointimg
    img_coin.y = _H*.48
    img_coin.alpha = .8
    groupView:insert(img_coin)

    local img_diamond = display.newImageRect( image_itemBouns[2],  _W*.12,_H*.08 )
    img_diamond:setReferencePoint( display.CenterReferencePoint )
    img_diamond.x = pointimg
    img_diamond.y = _H*.58
    img_diamond.alpha = .8
    groupView:insert(img_diamond)

    local img_flag = display.newImageRect( image_itemBouns[3],  _W*.12,_H*.08 )
    img_flag:setReferencePoint( display.CenterReferencePoint )
    img_flag.x = pointimg
    img_flag.y = _H*.68
    img_flag.alpha = .8
    groupView:insert(img_flag)

    local txtTest = "200"
    local pointtxt = _W*.35
    local pointnum = _W*.65
    local txtEXP = display.newText("EXP", pointtxt, _H*.37, typeFont, sizetext)
    txtEXP:setTextColor(0, 200, 0)
    txtEXP.text =  string.format("EXP")
    txtEXP.alpha = 1
    groupView:insert(txtEXP)
    local numEXP = display.newText(NumExp, pointnum, _H*.37, typeFont, sizetext)
    numEXP:setTextColor(0, 200, 0)
    numEXP.text =  string.format(NumExp)
    numEXP.alpha = 1
    groupView:insert(numEXP)

    local txtcoin = display.newText("Coin", pointtxt, _H*.46, typeFont, sizetext)
    txtcoin:setTextColor(0, 200, 0)
    txtcoin.text =  string.format("Coin")
    txtcoin.alpha = 1
    groupView:insert(txtcoin)
    local numCoin = display.newText(NumCoin, pointnum, _H*.46, typeFont, sizetext)
    numCoin:setTextColor(0, 200, 0)
    numCoin.text =  string.format(NumCoin)
    numCoin.alpha = 1
    groupView:insert(numCoin)

    local txtdiamond = display.newText("Diamond", pointtxt, _H*.56, typeFont, sizetext)
    txtdiamond:setTextColor(0, 200, 0)
    txtdiamond.text =  string.format("Diamond")
    txtdiamond.alpha = 1
    groupView:insert(txtdiamond)
    local numDiamond = display.newText(NumDiamond, pointnum, _H*.56, typeFont, sizetext)
    numDiamond:setTextColor(0, 200, 0)
    numDiamond.text =  string.format(NumDiamond)
    numDiamond.alpha = 1
    groupView:insert(numDiamond)

    local txtflag = display.newText("FLAG", pointtxt, _H*.66, typeFont, sizetext)
    txtflag:setTextColor(0, 200, 0)
    txtflag.text =  string.format("FLAG")
    txtflag.alpha = 1
    groupView:insert(txtflag)
    local numFlag = display.newText(NumFlag, pointnum, _H*.66, typeFont, sizetext)
    numFlag:setTextColor(0, 200, 0)
    numFlag.text =  string.format(NumFlag)
    numFlag.alpha = 1
    groupView:insert(numFlag)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        default = img_OK,
        over = img_OK,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = _W*.5
    btnOK.y = _H*.77
    groupView:insert(btnOK)

end
local function GameOption(option)
    local gameOption = option.params
    mission =  gameOption.mission
    battle =  gameOption.battle

    BGM =  gameOption.BGM
    SFX =  gameOption.SFX
    BTN =  gameOption.BTN
    SKL =  gameOption.SKL
    checkOption =  2


    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25

    local backgroundCaution
    local btnGameop
    local btnBGM_ON
    local btnSFX_ON
    local btnSKL_ON
    local btnBTN_ON

    -- 1: on
    -- 2: off
    local img_button = {
        "img/background/button/ON.png",
        "img/background/button/OFF.png"
    }
    local function ButtouON_Off(event)

        if event.target.id == "BGM1" then
            BGM = 2
            btnBGM_ON.alpha = 0
            btnBGM_ON = widget.newButton{
                default = img_button[BGM],
                over = img_button[BGM],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBGM_ON.id = "BGM"..BGM
            btnBGM_ON:setReferencePoint( display.CenterReferencePoint )
            btnBGM_ON.alpha = 1
            btnBGM_ON.x = _W*.7
            btnBGM_ON.y = _H*.42
            groupView:insert(btnBGM_ON)

        elseif event.target.id == "BGM2" then
            BGM = 1
            btnBGM_ON.alpha = 0
            btnBGM_ON = widget.newButton{
                default = img_button[BGM],
                over = img_button[BGM],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBGM_ON.id = "BGM"..BGM
            btnBGM_ON:setReferencePoint( display.CenterReferencePoint )
            btnBGM_ON.alpha = 1
            btnBGM_ON.x = _W*.7
            btnBGM_ON.y = _H*.42
            groupView:insert(btnBGM_ON)

        elseif event.target.id == "SFX1" then
            SFX = 2
            btnSFX_ON.alpha = 0
            btnSFX_ON = widget.newButton{
                default = img_button[SFX],
                over = img_button[SFX],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSFX_ON.id = "SFX"..SFX
            btnSFX_ON:setReferencePoint( display.CenterReferencePoint )
            btnSFX_ON.alpha = 1
            btnSFX_ON.x = _W*.7
            btnSFX_ON.y = _H*.5
            groupView:insert(btnSFX_ON)

        elseif event.target.id == "SFX2" then
            SFX = 1
            btnSFX_ON.alpha = 0
            btnSFX_ON = widget.newButton{
                default = img_button[SFX],
                over = img_button[SFX],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSFX_ON.id = "SFX"..SFX
            btnSFX_ON:setReferencePoint( display.CenterReferencePoint )
            btnSFX_ON.alpha = 1
            btnSFX_ON.x = _W*.7
            btnSFX_ON.y = _H*.5
            groupView:insert(btnSFX_ON)

        elseif event.target.id == "SKL1" then
            SKL = 2
            btnSKL_ON.alpha = 0
            btnSKL_ON = widget.newButton{
                default = img_button[SKL],
                over = img_button[SKL],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSKL_ON.id = "SKL"..SKL
            btnSKL_ON:setReferencePoint( display.CenterReferencePoint )
            btnSKL_ON.alpha = 1
            btnSKL_ON.x = _W*.7
            btnSKL_ON.y = _H*.58
            groupView:insert(btnSKL_ON)

        elseif event.target.id == "SKL2" then
            SKL = 1
            btnSKL_ON.alpha = 0
            btnSKL_ON = widget.newButton{
                default = img_button[SKL],
                over = img_button[SKL],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSKL_ON.id = "SKL"..SKL
            btnSKL_ON:setReferencePoint( display.CenterReferencePoint )
            btnSKL_ON.alpha = 1
            btnSKL_ON.x = _W*.7
            btnSKL_ON.y = _H*.58
            groupView:insert(btnSKL_ON)

        elseif event.target.id == "BTN1" then
            BTN = 2
            btnBTN_ON.alpha = 0
            btnBTN_ON = widget.newButton{
                default = img_button[BTN],
                over = img_button[BTN],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBTN_ON.id = "BTN"..BTN
            btnBTN_ON:setReferencePoint( display.CenterReferencePoint )
            btnBTN_ON.alpha = 1
            btnBTN_ON.x = _W*.7
            btnBTN_ON.y = _H*.66
            groupView:insert(btnBTN_ON)
        elseif event.target.id == "BTN2" then
            BTN = 1
            btnBTN_ON.alpha = 0
            btnBTN_ON = widget.newButton{
                default = img_button[BTN],
                over = img_button[BTN],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBTN_ON.id = "BTN"..BTN
            btnBTN_ON:setReferencePoint( display.CenterReferencePoint )
            btnBTN_ON.alpha = 1
            btnBTN_ON.x = _W*.7
            btnBTN_ON.y = _H*.66
            groupView:insert(btnBTN_ON)

        end


    end
    local function ButtouRelease(event)
        local option = {
            params = {
                BGM = BGM,
                SFX = SFX,
                SKL = SKL,
                BTN = BTN,
                battle = battle,
                mission = mission,
                checkOption = checkOption

            }
        }
        groupView.alpha = 0
    end
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    backgroundCaution = display.newImageRect( image_Caution, _W*.95,_H*.8 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = _W *.5
    backgroundCaution.y = _H*.5
    backgroundCaution.alpha = .8
    groupView:insert(backgroundCaution)

    local image_GAME_OPTION = "img/background/button/GAME_OPTION.png"
    btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
    btnGameop:setReferencePoint( display.CenterReferencePoint )
    btnGameop.x = _W *.5
    btnGameop.y = _H*.31
    btnGameop.alpha = 1
    groupView:insert(btnGameop)

    local image_ON = "img/background/button/ON.png"
    btnBGM_ON = widget.newButton{
        default = img_button[BGM],
        over = img_button[BGM],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnBGM_ON.id = "BGM"..BGM
    btnBGM_ON:setReferencePoint( display.CenterReferencePoint )
    btnBGM_ON.alpha = 1
    btnBGM_ON.x = _W*.7
    btnBGM_ON.y = _H*.42
    groupView:insert(btnBGM_ON)

    btnSFX_ON = widget.newButton{
        default = img_button[SFX],
        over = img_button[SFX],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnSFX_ON.id = "SFX"..SFX
    btnSFX_ON:setReferencePoint( display.CenterReferencePoint )
    btnSFX_ON.alpha = 1
    btnSFX_ON.x = _W*.7
    btnSFX_ON.y = _H*.5
    groupView:insert(btnSFX_ON)

    btnSKL_ON = widget.newButton{
        default = img_button[SKL],
        over = img_button[SKL],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnSKL_ON.id = "SKL"..SKL
    btnSKL_ON:setReferencePoint( display.CenterReferencePoint )
    btnSKL_ON.alpha = 1
    btnSKL_ON.x = _W*.7
    btnSKL_ON.y = _H*.58
    groupView:insert(btnSKL_ON)

    btnBTN_ON = widget.newButton{
        default = img_button[BTN],
        over = img_button[BTN],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnBTN_ON.id = "BTN"..BTN
    btnBTN_ON:setReferencePoint( display.CenterReferencePoint )
    btnBTN_ON.alpha = 1
    btnBTN_ON.x = _W*.7
    btnBTN_ON.y = _H*.66
    groupView:insert(btnBTN_ON)



    local pointtxt = _H*.12
    local txtBGM = display.newText("BGM", pointtxt, _H*.4, typeFont, sizetext)
    txtBGM:setTextColor(0, 200, 0)
    txtBGM.text =  string.format("BGM")
    txtBGM.alpha = 1
    groupView:insert(txtBGM)

    local txtSFx = display.newText("SFx", pointtxt, _H*.48, typeFont, sizetext)
    txtSFx:setTextColor(0, 200, 0)
    txtSFx.text =  string.format("SFx")
    txtSFx.alpha = 1
    groupView:insert(txtSFx)

    local txtSkill = display.newText("Skill Confirmation", pointtxt, _H*.56, typeFont, sizetext)
    txtSkill:setTextColor(0, 200, 0)
    txtSkill.text =  string.format("Skill Confirmation")
    txtSkill.alpha = 1
    groupView:insert(txtSkill)

    local txtBattle = display.newText("Battle Notification", pointtxt, _H*.64, typeFont, sizetext)
    txtBattle:setTextColor(0, 200, 0)
    txtBattle.text =  string.format("Battle Notification")
    txtBattle.alpha = 1
    groupView:insert(txtBattle)


    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        default = img_OK,
        over = img_OK,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = _W*.5
    btnOK.y = _H*.75
    groupView:insert(btnOK)

    return   option

end
local function MenuInPuzzle(option)

    local c = option.params
    mission =  c.mission
    battle =  c.battle
    BGM =  c.BGM
    SFX =  c.SFX
    BTN =  c.BTN
    SKL =  c.SKL
    checkOption =  c.checkOption



    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25

    --    mission = "ABCDEFGHIJK"
    local strMission = string.len(mission)
    local pointMission =  (_W*.5)-(strMission/4)

    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then


            return true
        end
    end

    local function ButtouRelease(event)
        groupView.alpha = 0
        if event.target.id == "setting" then

            GameOption(option)

        elseif event.target.id == "BONUS" then
            BonusOption(option)

        elseif event.target.id == "LEAVE" then
            LeaveOption(event)

        elseif event.target.id == "cancel" then

        end

    end

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .9
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local backgroundCaution = display.newImageRect( image_Caution, _W*.95,_H*.18 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = _W *.5
    backgroundCaution.y = _H*.4
    backgroundCaution.alpha = 1
    groupView:insert(backgroundCaution)

    local image_power= "img/element/green.png"
    local imgPower = display.newImageRect( image_power, _W*.5,_H*.15 )
    imgPower:setReferencePoint( display.CenterReferencePoint )
    imgPower.x = _W *.5
    imgPower.y = _H*.2
    imgPower.alpha = 1
    groupView:insert(imgPower)


    local NameMission = display.newText(battle, pointMission, _H*.35, typeFont, sizetext)
    NameMission:setTextColor(0, 200, 0)
    NameMission.text =  string.format(mission)
    NameMission.alpha = 1
    groupView:insert(NameMission)

    local  NameBattle = display.newText(battle, _W*.5, _H*.4, typeFont, sizetext)
    NameBattle:setTextColor(200, 200, 200)
    NameBattle.text =  string.format("BATTLE :"..battle)
    NameBattle.alpha = 1
    groupView:insert(NameBattle)

    local img_setting = "img/background/button/SETTING.png"
    local setting = widget.newButton{
        default = img_setting,
        over = img_setting,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    setting.id = "setting"
    setting:setReferencePoint( display.TopLeftReferencePoint )
    setting.alpha = 1
    setting.x = _W*.37
    setting.y = _H*.5
    groupView:insert(setting)

    local img_BONUS = "img/background/button/BONUS.png"
    local setBONUS = widget.newButton{
        default = img_BONUS,
        over = img_BONUS,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    setBONUS.id = "BONUS"
    setBONUS:setReferencePoint( display.TopLeftReferencePoint )
    setBONUS.alpha = 1
    setBONUS.x = _W*.37
    setBONUS.y = _H*.6
    groupView:insert(setBONUS)

    local img_LEAVE = "img/background/button/LEAVE.png"
    local setLEAVE = widget.newButton{
        default = img_LEAVE,
        over = img_LEAVE,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    setLEAVE.id = "LEAVE"
    setLEAVE:setReferencePoint( display.TopLeftReferencePoint )
    setLEAVE.alpha = 1
    setLEAVE.x = _W*.37
    setLEAVE.y = _H*.7
    groupView:insert(setLEAVE)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btncancel = widget.newButton{
        default = img_cancel,
        over = img_cancel,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btncancel.id = "cancel"
    btncancel:setReferencePoint( display.TopLeftReferencePoint )
    btncancel.alpha = 1
    btncancel.x = _W*.37
    btncancel.y = _H*.8
    groupView:insert(btncancel)

    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )

    return option

end

local function createCharacter(event)
    character_numAll = 5
    image_char = {
        --        "img/character/tgr_chfa-v101l.png"
        --        "img/character/TouTaku-v101.png"
        --        "img/character/2.png"
        --        ,"img/character/3.png"
        --        "img/character/kautu-v101.png"
        --        "img/character/ytb_chma-v101l.png"
        --        ,"img/character/tkt_chmf-v101d.png"
--        "img/character/tgr_chfb-v101l(1).png"
        "img/character/Sima_Yi[resize].png"
--                ,"img/character/tgr_chfb-v101l.png"
        ,"img/character/tgr_chfb-v101l(1).png"
        ,"img/character/GAN_NING.png"
        ,"img/character/CAO_RUI.png"

--                ,"img/character/GUO_HUAI.png"
--                ,"img/character/LU_MENG.png"
        ,"img/character/KAN_ZE.png"
--
--        ,"img/character/kanu-v1011.png"
        ,"img/character/ytb_chfa-v101.png"
--        ,"img/character/pangtong-v201.png"
--        ,"img/character/ytb_chmb-v101.png"
--
--                ,"img/character/tgr_chfa-v201.png"
--                 ,"img/character/machao-v101.png"
--                 ,"img/character/kanu-v101.png"
    }
    local pointCharacter = _W/(character_numAll+1)/1.5
    for i=1,character_numAll,1 do
        --        local imgCharacter = image_char[mRandom(1,6)]
        local imgCharacter = image_char[i]
        --        local imgCharacter = image_char[7]
        --        characImage = display.newImageRect(imgCharacter,_W*.22, _H*.2)
        --        characImage[i] = display.newImage(imgCharacter,true)
        characImage[i] = display.newImage(imgCharacter,true)
        if characImage[i].width ~= 1024 or characImage[i].height ~= 1024 then
            if characImage[i].width > characImage[i].height then
                characImage[i].height = math.floor(characImage[i].height / (characImage[i].width/1024))
                characImage[i].width = 1024
            else
                characImage[i].width = math.floor(characImage[i].width / (characImage[i].height/1024))
                characImage[i].height = 1024
            end
        end

        if image_char[i] == "img/character/kanu-v1011.png" or
           image_char[i] == "img/character/kanu-v101.png" then
            characImage[i].width = characImage[i].width/3.5
            characImage[i].height =  characImage[i].height/3.5
        else
            characImage[i].width = characImage[i].width/5.5
            characImage[i].height =  characImage[i].height/5.5
        end


--        characImage[i]:setReferencePoint( display.BottomLeftReferencePoint)
        characImage[i]:setReferencePoint( display.BottomCenterReferencePoint)
        characImage[i].x = (_W/(character_numAll+1))*i
--        characImage[i].x = pointCharacter
        characImage[i].y = _H*.3
        characImage[i].id = i
        print("characImage[i].width,characImage[i].height:",characImage[i].width,characImage[i].height)
        print("characImage[i].x,characImage[i].y:",characImage[i].x,characImage[i].y)
        pointCharacter = pointCharacter +(_W*.19)
    end
end

local function createBackButton(event)
    --loadImage()
    local gameoption =  event.params
    if gameoption then
        mission = gameoption.mission
        battle = gameoption.battle
        BGM = gameoption.BGM
        SFX = gameoption.SFX
        SKL = gameoption.SKL
        BTN = gameoption.BTN
        checkOption = gameoption.checkOption
    else
        mission = "ABCDTADA KWANTA"
        battle = "1/5"

        -- 1 : ON
        -- 2 : OFF
        BGM = 1
        SFX = 1
        SKL = 1
        BTN = 1
        checkOption = 1
    end
  -------tada1179.w@gmail.com


    --loadImage()
 -------tada1179.w@gmail.com

    local function ButtouMenu(event)
        if (event.phase == "ended" or event.phase == "release") then
            if event.target.id == "Menu"  then
                local option = {
                    params = {
                        battle = battle  ,
                        mission = mission ,
                        BGM = BGM ,
                        SFX = SFX ,
                        SKL = SKL,
                        BTN = BTN,
                        checkOption = checkOption
                    }
                }

                MenuInPuzzle(option)

            elseif event.target.id == "Item" then
                --loadImage()

            end

        end

    end






    local imgMenu ="img/background/button/as_butt_pzl_menu.png"
    backButton = widget.newButton{
        default = imgMenu,
        over = imgMenu,
        width=_W*.12, height= _H*.04,
        onRelease = ButtouMenu	-- event listener function
    }
    backButton.id = "Menu"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.alpha = 1
    backButton.x = _W - (_W*.12)
    backButton.y = 0
    --groupGameLayer:insert(backButton)

    local imgItem ="img/background/button/as_butt_sell_plus.png"
    bntItem = widget.newButton{
        default = imgItem,
        over = imgItem,
        width=_W*.12, height= _H*.04,
        onRelease = ButtouMenu	-- event listener function
--        onRelease = loadImage	-- event listener function
    }
    bntItem.id = "Item"
    bntItem:setReferencePoint( display.TopLeftReferencePoint )
    bntItem.alpha = 1
    bntItem.x = 0
    bntItem.y = 0
    --groupGameLayer:insert(bntItem)
end

-- connect HTTP
local ltn12 = require("ltn12")
function showImage( i)
    native.setActivityIndicator( false )
    testImage = display.newImage(i,system.DocumentsDirectory,_W*.1,_H*(i/4));
    groupGameLayer:insert(testImage)
end
--
function loadImage()
    -- Create local file for saving data
    local path = {}
    local myFile = {}
    for i=1,2,1 do
        path[i] = system.pathForFile(i, system.DocumentsDirectory )
        myFile[i] = io.open( path[i], "w+b" )

    native.setActivityIndicator( true )		-- show busy

    -- Request remote file and save data to local file
    local link = {
        "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-ash3/1017071_10152000604808012_2051013729_n.jpg",
        "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-prn2/10154_10152000605128012_1226496876_n.jpg"
    }

    http.request{
--        url = "http://developer.anscamobile.com/demo/hello.png",
        url = link[i],
        sink = ltn12.sink.file(myFile[i]),
    }
        _H = _H +300
    -- Call the showImage function after a short time dealy
    timer.performWithDelay( 400, showImage(i))

    end
end

--  tada1179.w@gmail.com ------------------------------
-----**********------
function onGemTouch( self, event )

    local coler
    if event.phase == "began" then
        --copy Y  --
        gemToBeDestroyed = gemsTable[self.i][1]
        gemsTable[self.i][1] = copynewGem(self.i,1,gemsTable[self.i][6].gemType)
        gemToBeDestroyed:removeSelf()  -- return value to memory
        gemToBeDestroyed = nil

        gemToBeDestroyed = gemsTable[self.i][7]
        gemsTable[self.i][7] = copynewGem(self.i,7,gemsTable[self.i][2].gemType)
        gemToBeDestroyed:removeSelf()  -- return value to memory
        gemToBeDestroyed = nil

        --copy X  --
        gemToBeDestroyed = gemsTable[1][self.j]
        gemsTable[1][self.j] = copynewGem(1,self.j,gemsTable[7][self.j].gemType)
        gemToBeDestroyed:removeSelf()  -- return value to memory
        gemToBeDestroyed = nil

        gemToBeDestroyed = gemsTable[8][self.j]
        gemsTable[8][self.j] = copynewGem(8,self.j,gemsTable[2][self.j].gemType)
        gemToBeDestroyed:removeSelf()  -- return value to memory
        gemToBeDestroyed = nil

        --mark point start event
        for  R = 1 ,8, 1 do
            for  C = 1 , 7, 1 do
                gemsTable[R][C].markX = gemsTable[R][C].x
                gemsTable[R][C].markY = gemsTable[R][C].y
            end
        end

        display.getCurrentStage():setFocus( self )
        self.isFocus = true

    elseif self.isFocus then
        if event.phase == "moved" and isGemTouchEnabled then
            local t = event.target

            if self.markY == t.y then -- move degree X
                t.x = event.x
                t.y = self.markY

               -- deleteColumn(self, event) -- mark column
                markRow(self, event) -- mark row
                shipRow(self, event) -- move row X Item
                swichValueRow(self, event)
            end

            if self.markX == t.x then -- move degree Y
                t.x = self.markX
                t.y = event.y

                deleteMarkRow(self, event) -- mark column
                markColumn(self, event) -- mark column
                shipColumn(self, event) -- move column Y Item
                swichValuecolumn(self, event)
            end

        elseif event.phase == "ended" or event.phase == "cancelled" then
            slidepointX(self , event) -- move stop x
            slidepointY(self , event) -- move stop Y
            checkCreate()
            display.getCurrentStage():setFocus( nil )
            self.isFocus = nil
        end
    end
    return true


end

function onTouchGameOverScreen ( self, event )

    if event.phase == "began" then

        storyboard.gotoScene( "game-scene", "fade", 400  )

        return true
    end
end


local function showGameOver () -- end game
    gameOverLayout.alpha = 0.8
    gameOverText1.alpha = 1
    gameOverText2.alpha = 1

end

function scene:createScene( event )
    local screenGroup = self.view
    user_id = includeFUN.USERIDPhone()

    -----------------------------------------------------------------------------

    --      CREATE display objects and add them to 'group' here.
    --      Example use-case: Restore 'group' from previously saved state.



    -- reseting values
    score		= 0
    gameTimer 	= 30
    RED         = 0
    GREEN       = 0
    BLUE        = 0
    PURPLE      = 0
    PINK        = 0
    YELLOW      = 0

    -- {"RED.png","GREEN.png","BLUE.png","PURPLE.png","PINK.png","YELLOW.png"}

    groupGameLayer = display.newGroup()
    groupEndGameLayer = display.newGroup()

    --score text
    background = display.newImageRect( "img/background/lay_bt00.png" , display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local lightWigth = display.newRoundedRect( 0, 0, _W, _H, 4)
    lightWigth:setFillColor( 255, 255, 255 )
--    backgroundTop = display.newImageRect( "image/lay_bt00top.png" , display.contentWidth, display.contentHeight )
--    backgroundTop:setReferencePoint( display.TopLeftReferencePoint )
--    backgroundTop.x, backgroundTop.y = 0, 0

    scoreText = display.newText( "SCORE:" , 40, 20, "Helvetica", 15 )
    scoreText.text = string.format( "SCORE: %6.0f", score )
    scoreText:setReferencePoint(display.TopLeftReferencePoint)
    scoreText.x = 60
    scoreText.y = 10
    scoreText:setTextColor(255, 255, 255)

    textRED = display.newText( "RED:" , 40, 20, "Helvetica", 15 )
    textRED.text = string.format( "RED:%6.0f", RED )
    textRED:setReferencePoint(display.TopLeftReferencePoint)
    textRED.x = 60
    textRED.y = 25
    textRED:setTextColor(200, 0, 0)

    textGREEN = display.newText( "GREEN:" , 40, 20, "Helvetica", 15 )
    textGREEN.text = string.format( "GREEN:%6.0f", GREEN )
    textGREEN:setReferencePoint(display.TopLeftReferencePoint)
    textGREEN.x = 60
    textGREEN.y = 40
    textGREEN:setTextColor(0, 200, 0)

    textBLUE = display.newText( "BLUE:" , 40, 20, "Helvetica", 15 )
    textBLUE.text = string.format( "BLUE: %6.0f", BLUE )
    textBLUE:setReferencePoint(display.TopLeftReferencePoint)
    textBLUE.x = 60
    textBLUE.y = 55
    textBLUE:setTextColor(0, 0, 200)

    textPURPLE = display.newText( "PURPLE:" , 40, 20, "Helvetica", 15 )
    textPURPLE.text = string.format( "PURPLE: %6.0f", PURPLE )
    textPURPLE:setReferencePoint(display.TopLeftReferencePoint)
    textPURPLE.x = 60
    textPURPLE.y = 70
    textPURPLE:setTextColor(160 ,32 ,240)

    textPINK = display.newText( "PINK:" , 40, 20, "Helvetica", 15 )
    textPINK.text = string.format( "PINK: %6.0f", PINK )
    textPINK:setReferencePoint(display.TopLeftReferencePoint)
    textPINK.x = 60
    textPINK.y = 85
    textPINK:setTextColor(255, 20 ,147)   --255 20 147

    textYELLOW = display.newText( "YELLOW:" , 40, 20, "Helvetica", 15 )
    textYELLOW.text = string.format( "YELLOW: %6.0f", YELLOW )
    textYELLOW:setReferencePoint(display.TopLeftReferencePoint)
    textYELLOW.x = 60
    textYELLOW.y = 100
    textYELLOW:setTextColor(255, 255, 0)

    -- {"RED.png","GREEN.png","BLUE.png","PURPLE.png","PINK.png","YELLOW.png"}


    gameTimerBar_bg = display.newRoundedRect( 20, 430, 280, 20, 4)
    gameTimerBar_bg:setFillColor( 60, 60, 60 )


    --	gameTimerBar = display.newRoundedRect( 95, 204, 100, 6, 4)  -- tab red (x,y,w,h,)
    --	gameTimerBar:setFillColor(255, 110, 0 )-- RED ping Herht
    --	gameTimerBar:setReferencePoint(display.TopLeftReferencePoint)

    powerBar = display.newImageRect("img/background/bt_p_hpbar.png",4,6)
    -- powerBar.x = 97 +  PINK
    -- powerBar.y =  207


    gameTimerText = display.newText( gameTimer , 0, 0, "Helvetica", 18 )
    gameTimerText:setTextColor( 255, 255, 255 )
    gameTimerText:setReferencePoint(display.TopLeftReferencePoint)
    gameTimerText.x = _W * 0.5 - 12
    gameTimerText.y = 426

    --groupGameLayer:insert ( scoreText )
    groupGameLayer:insert ( gameTimerBar_bg )
    --groupGameLayer:insert ( gameTimerBar )
    groupGameLayer:insert ( gameTimerText )

    groupGameLayer:insert ( background )


    --gemsTable
    for i = 1, 8, 1 do
        gemsTable[i] = {}

        for j = 1, 7, 1 do

            gemsTable[i][j] = newGem(i,j)

        end
    end

    --check Item
   -- checkCreate()

    --top background create again

--    backgroundTop = display.newImageRect( "img/background/lay_bt00top.png" , _W, _H *.444)
--    backgroundTop:setReferencePoint( display.TopLeftReferencePoint )
--    backgroundTop.x, backgroundTop.y = 0, 0
--    backgroundTop.alpha = 1

    --createItem(event)
    createBackButton(event)
    createCharacter(event)
--    groupGameLayer:insert ( backgroundTop )
    groupGameLayer:insert ( lightWigth )
    groupGameLayer:insert ( powerBar )
    groupGameLayer:insert ( backButton )
    groupGameLayer:insert(bntItem)
--    groupGameLayer:insert(characImage)

    groupGameLayer:insert(textPURPLE)
    groupGameLayer:insert(textBLUE)
    groupGameLayer:insert(textGREEN)
    groupGameLayer:insert(textRED)
    groupGameLayer:insert(scoreText)
    groupGameLayer:insert(textPINK)
    groupGameLayer:insert(textYELLOW)

    local function clickSheet(event)
--        require ("alertMassage").sprite_fight()
        local numcharacter = math.random(1,character_numAll)
        local colercharacter = math.random(1,5)


        local pointX = characImage[numcharacter].x
        local pointY = characImage[numcharacter].y
        if image_char[numcharacter] == "img/character/kanu-v101.png" or
           image_char[numcharacter] == "img/character/kanu-v1011.png" or
           image_char[numcharacter] == "img/character/kanu-v101.png"
        then

            pointX = characImage[numcharacter].x - (characImage[numcharacter].width/4)
        end
        print("characImage[numcharacter],pointX,pointY",characImage[numcharacter],pointX,pointY)
        require ("alertMassage").sprite_sheet(character_numAll,numcharacter,colercharacter,pointX,pointY)
        timer.performWithDelay( 150)
        if characImage[numcharacter].id == numcharacter then
                local function swapSheet()
                    characImage[numcharacter].x = characImage[numcharacter].x + 10
--                    characImage[numcharacter].y = characImage[numcharacter].y + 25
                end
                local function swapSheet2()
                    characImage[numcharacter].x = characImage[numcharacter].x - 20
--                    characImage[numcharacter].y = characImage[numcharacter].y - 50
                end
                timer.performWithDelay( 50, swapSheet )
                timer.performWithDelay( 100, swapSheet2 )
                timer.performWithDelay( 150, swapSheet )

        end


    end
    local image_ok = "img/background/button/OK_button.png"
    local btnClick = widget.newButton{
        default=image_ok,
        over=image_ok,
        width=_W*.2, height=_H*.05,
        onRelease = clickSheet	-- event listener function
    }
    btnClick.id="okNoDataInList"
    btnClick:setReferencePoint( display.CenterReferencePoint )
    btnClick.x =_W *.8
    btnClick.y = _H*.55
    groupGameLayer:insert(btnClick)





    gameOverLayout = display.newRect( 0, 0, 320, 480)
    gameOverLayout:setFillColor( 0, 0, 0 )
    gameOverLayout.alpha = 0

    gameOverText1 = display.newText( "GAME OVER", 0, 0, native.systemFontBold, 24 )
    gameOverText1:setTextColor( 255 )
    gameOverText1:setReferencePoint( display.CenterReferencePoint )
    gameOverText1.x, gameOverText1.y = _W * 0.5, _H * 0.5 -150
    gameOverText1.alpha = 0

    gameOverText2 = display.newText( "SCORE: ", 0, 0, native.systemFontBold, 24 )
    gameOverText2.text = string.format( "SCORE: %6.0f", score )
    gameOverText2:setTextColor( 255 )
    gameOverText2:setReferencePoint( display.CenterReferencePoint )
    gameOverText2.x, gameOverText2.y = _W * 0.5, _H * 0.5 - 50
    gameOverText2.alpha = 0


    gameOverLayout.touch = onTouchGameOverScreen
    gameOverLayout:addEventListener( "touch", gameOverLayout )


    groupEndGameLayer:insert ( gameOverLayout )
    groupEndGameLayer:insert ( gameOverText1 )
    groupEndGameLayer:insert ( gameOverText2 )


    -- insterting display groups to the screen group (storyboard group)
    screenGroup:insert ( groupGameLayer )
    screenGroup:insert ( groupEndGameLayer )

    ------------- other scene ---------------
    require ("menu_barLight").checkMemory()
    storyboard.purgeAll()
    storyboard.removeAll ()
    ------------------------------------


end

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      This event requires build 2012.782 or later.

    -----------------------------------------------------------------------------

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

    -----------------------------------------------------------------------------

    -- remove previous scene's view

    -- storyboard.purgeScene( "scene4" )

    -- reseting values
    score = 0


    --transition.to( gameTimerBar, { time = gameTimer * 1000, width=0 } )
    --timers.gameTimerUpdate = timer.performWithDelay(1000, gameTimerUpdate, 0)



end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

    -----------------------------------------------------------------------------

    --[[if timers.gameTimerUpdate then
        timer.cancel(timers.gameTimerUpdate)
        timers.gameTimerUpdate = nil
     end
     --]]

end

-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      This event requires build 2012.782 or later.

    -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

    -----------------------------------------------------------------------------

end

-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
    local screenGroup = self.view
    local overlay_scene = event.sceneName  -- overlay scene name

    -----------------------------------------------------------------------------

    --      This event requires build 2012.797 or later.

    -----------------------------------------------------------------------------

end

-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
    local screenGroup = self.view
    local overlay_scene = event.sceneName  -- overlay scene name

    -----------------------------------------------------------------------------

    --      This event requires build 2012.797 or later.

    -----------------------------------------------------------------------------

end

---------------------------------------------------------------------------------

---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene