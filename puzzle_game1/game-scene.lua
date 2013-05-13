
---------------------------------------------------------------------------------
-- game-scene.lua - GAME SCENE
print("game-scene.lua")
---------------------------------------------------------------------------------


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


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

local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function print_r (t, name, indent)
    local tableList = {}
    function table_r (t, name, indent, full)
        local id = not full and name
                or type(name)~="number" and tostring(name) or '['..name..']'
        local tag = indent .. id .. ' = '
        local out = {}  -- result
        if type(t) == "table" then
            if tableList[t] ~= nil then table.insert(out, tag .. '{} -- ' .. tableList[t] .. ' (self reference)')
            else
                tableList[t]= full and (full .. '.' .. id) or id
                if next(t) then -- Table not empty
                    table.insert(out, tag .. '{')
                    for key,value in pairs(t) do
                        table.insert(out,table_r(value,key,indent .. '|  ',tableList[t]))
                    end
                    table.insert(out,indent .. '}')
                else table.insert(out,tag .. '{}') end
            end
        else
            local val = type(t)~="number" and type(t)~="boolean" and '"'..tostring(t)..'"' or tostring(t)
            table.insert(out, tag .. val)
        end
        return table.concat(out, '\n')
    end
    return table_r(t,name or 'Value',indent or '')
end

function pr (t, name)
    print(print_r(t,name))
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
local function newGem (i,j)
    local R = mRandom(1,6)
    local newGem

    picture = {"img/element/red.png","img/element/green.png","img/element/blue.png","img/element/purple.png","img/element/pink.png","img/element/yellow.png"}

    newGem = display.newImageRect(picture[R],sizeBall,sizeBall)
    newGem.x = i * size_Ball - (26+size_Ball)
    newGem.y =  j* 53 + 134

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

        backgroundTop = display.newImageRect( "img/background/lay_bt00top.png" , 320, display.contentHeight/2 - 27 )
        backgroundTop:setReferencePoint( display.TopLeftReferencePoint )
        backgroundTop.x, backgroundTop.y = 0, 0


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

    newGem = display.newImageRect(picture,sizeBall,sizeBall)
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

function onGemTouch( self, event )
    local coler
    print("touch i",self.i,"j",self.j)
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
            checkMemory()
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

    print( "\n1: createScene event")

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
    checkCreate()
    checkMemory()

    --top background create again

    backgroundTop = display.newImageRect( "img/background/lay_bt00top.png" , 320, display.contentHeight/2 - 27 )
    backgroundTop:setReferencePoint( display.TopLeftReferencePoint )
    backgroundTop.x, backgroundTop.y = 0, 0
    groupGameLayer:insert ( backgroundTop )
    groupGameLayer:insert ( powerBar )
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
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "team_main" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha" )
    storyboard.removeScene( "commu_main" )
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

    storyboard.purgeScene( "menu-scene" )

    print( "1: enterScene event" )

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