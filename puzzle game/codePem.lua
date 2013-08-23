
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


local _W = display.contentWidth -- 640
local _H = display.contentHeight -- 960
local mRandom = math.random

local gemsTable = {}
local picture = { "img/element/red.png",
    "img/element/green.png",
    "img/element/blue.png",
    "img/element/purple.png",
    "img/element/pink.png",
    "img/element/yellow.png" }
local onGemTouch
local sizeGem = 96
local widthGem = 106
local gemX, gemY = 6, 5
local stTableX, enTableX = 3, 636

local limitCountGem = 4 ---- chk amount gems
local groupGem = { 0, 0, 0, 0, 0, 0 }
local groupGemChk = { 0, 0, 0, 0, 0, 0 }
local gemToBeDestroyed
local isGemTouchEnabled = true
local countSlide = 0

local channelX = { 54, --1
    160, --2
    266, --3
    372, --4
    478, --5
    584 --6
}
local channelY ={ 479, --1
    585, --2
    691, --3
    797, --4
    903, --5
}

local amountPlayer = 5 -- simple for test card input to mission
local teamPlayer = {} --- pic, element, hp, protect, lv, power special, leader, power special
local playerDB ={} -- data for player
local posXch={10,115,220,325,430,535} ---- ระยะห่าง

-------------------------- HP value -------------------------
local number ={}
local hpPlayer = 789
local hpFull = 654321


timerStash = {}
transitionStash = {}
function cancelAllTimers()
    local k, v

    for k,v in pairs(timerStash) do
        timer.cancel( v )
        v = nil; k = nil
    end

    timerStash = nil
    timerStash = {}
end

function cancelAllTransitions()
    local k, v

    for k,v in pairs(transitionStash) do
        transition.cancel( v )
        v = nil; k = nil
    end

    transitionStash = nil
    transitionStash = {}
end

local function handleLowMemory( event )
    print( "memory warning received!" )
end
Runtime:addEventListener( "memoryWarning", handleLowMemory )

local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
--checkMemory()

local function newGem (i,j)
    local R = mRandom(1,6)
    local newGem

    newGem = display.newImageRect(picture[R],sizeGem,sizeGem)

    newGem.x = i * widthGem - 52
    newGem.y = j * widthGem + 373

    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = false
    newGem.isMarkedToDestroy = false

    newGem.destination_y = j * widthGem + 373 --newGem.y


    newGem.color = R
    if (R == 1 ) then
        newGem.gemType = "RED"
    elseif (R == 2 ) then
        newGem.gemType = "GREEN"
    elseif (R == 3 ) then
        newGem.gemType = "BLUE"
    elseif (R == 4 ) then
        newGem.gemType = "PURPLE"
    elseif (R == 5 ) then
        newGem.gemType = "PINK"
    elseif (R == 6 ) then
        newGem.gemType = "YELLOW"
    end

    --new gem falling animation
    transitionStash.newTransition = transition.to( newGem, { time=100, y= newGem.destination_y} )
    groupGameLayer:insert( newGem )


    newGem.touch = onGemTouch
    newGem:addEventListener( "touch", newGem )

    return newGem
end

function copyGem(self,event)
    -- print("copyGem(self,event) ")
    -- print("pointXY :"..gemsTable[self.i][self.j].i,gemsTable[self.i][self.j].j)
    copyGemXR, copyGemXL, copyGemYU, copyGemYD = {}, {}, {}, {}
    intervalGem = sizeGem + 8
    ------ --- -- - chk event -Right -Left -Up -Down----
    rotateR = gemX + 1
    for R = 1, gemX, 1 do
        -- copyGemX[R] = gemsTable[R][self.j].colorR
        -- print("color :"..gemsTable[R][self.j].gemType, copyGemX[R])
        copyGemXR[R] = display.newImageRect(picture[gemsTable[R][self.j].colorR],sizeGem,sizeGem)
        copyGemXR[R].x, copyGemXR[R].y = enTableX + (intervalGem * R), gemsTable[gemX][self.j].markY

        copyGemXL[R] = display.newImageRect(picture[gemsTable[rotateR - R][self.j].colorR],sizeGem,sizeGem)
        copyGemXL[R].x, copyGemXL[R].y = stTableX - (intervalGem * R), gemsTable[gemX][self.j].markY
    end

    stTableY, enTableY = 400, 903
    rotateC = gemY + 1
    for C = 1, gemY, 1 do
        copyGemYU[C] = display.newImageRect(picture[gemsTable[self.i][C].colorR],sizeGem,sizeGem)
        copyGemYU[C].x, copyGemYU[C].y = gemsTable[self.i][gemY].markX, enTableY + (intervalGem * C)

        copyGemYD[C] = display.newImageRect(picture[gemsTable[self.i][rotateC - C].colorR],sizeGem,sizeGem)
        copyGemYD[C].x, copyGemYD[C].y = gemsTable[self.i][gemY].markX, stTableY - (intervalGem * C)
    end

end

function pasteGem(self, event)
    if(self.chkFtPosit == "x") then

        positSt = gemsTable[self.i][self.j].i
        positEn = gemsTable[self.i][self.j].x
        slideEvent = (event.x - event.xStart)

        colorTmp ={}
        markY = gemsTable[self.i][self.j].markY
        markJ = gemsTable[self.i][self.j].j
        slideL, slideR = 0, 0

        if ( slideEvent > 60 or slideEvent < -60) then
            countSlide = countSlide +1
        end

        for posX = gemX, 1, -1 do
            colorTmp[posX] = gemsTable[posX][self.j].colorR
            gemsTable[posX][self.j]:removeSelf()
        end

        if(positEn > 533 ) then
            slideL = 0
            slideR = 1
        elseif (positEn > 427 and positEn < 533) then
            slideL = 5
            slideR = 1
        elseif (positEn > 319 and positEn < 427) then
            slideL = 4
            slideR = 2
        elseif (positEn > 216 and positEn < 319) then
            slideL = 3
            slideR = 3
        elseif (positEn > 111 and positEn < 216) then
            slideL = 2
            slideR = 4
        else-- R to L only
            slideL = 1
            slideR = 5
        end
        -- for chk and loop
        --print("slideEvent "..slideEvent," last position "..positEn)
        for posX = gemX, 1, -1 do
            if( posX == gemX) then
                if(positSt > slideL) then --- L
                    color = colorTmp[positSt - slideL]
                    maxXTmp = positSt - slideL
                else --- R
                    color = colorTmp[positSt + slideR]
                    maxXTmp = positSt + slideR
                end
            else
                if(maxXTmp == 1 ) then
                    maxXTmp = gemX
                    color = colorTmp[maxXTmp]
                else
                    maxXTmp = maxXTmp - 1
                    color = colorTmp[maxXTmp]
                end
            end

            gemsTable[posX][self.j] = display.newImageRect(picture[color],sizeGem,sizeGem)

            if (color == 1 ) then
                gemsTable[posX][self.j].gemType = "RED"
            elseif (color == 2 ) then
                gemsTable[posX][self.j].gemType = "GREEN"
            elseif (color == 3 ) then
                gemsTable[posX][self.j].gemType = "BLUE"
            elseif (color == 4 ) then
                gemsTable[posX][self.j].gemType = "PURPLE"
            elseif (color == 5 ) then
                gemsTable[posX][self.j].gemType = "PINK"
            elseif (color == 6 ) then
                gemsTable[posX][self.j].gemType = "YELLOW"
            end

            gemsTable[posX][self.j].color = color
            gemsTable[posX][self.j].x = channelX[posX]
            gemsTable[posX][self.j].y = markY
            gemsTable[posX][self.j].i = posX
            gemsTable[posX][self.j].j = markJ

            gemsTable[posX][self.j].destination_y = markY
            gemsTable[posX][self.j].isMarkedToDestroy = false
            gemsTable[posX][self.j].touch = onGemTouch
            gemsTable[posX][self.j]:addEventListener( "touch", gemsTable[posX][self.j] )
        end

    elseif (self.chkFtPosit == "y") then
        positSt = gemsTable[self.i][self.j].j
        positEn = gemsTable[self.i][self.j].y
        slideEvent = (event.y - event.yStart)

        colorTmp = {}
        markX = gemsTable[self.i][self.j].markX
        markI = gemsTable[self.i][self.j].i
        slideU, slideD = 0, 0

        if ( slideEvent > 60 or slideEvent < -60) then
            countSlide = countSlide +1
        end

        for posY = gemY, 1, -1 do
            colorTmp[posY] = gemsTable[self.i][posY].colorR
            gemsTable[self.i][posY]:removeSelf()
        end

        if(positEn > 852 ) then
            slideU = 0
            slideD = 1
        elseif (positEn > 746 and positEn < 852) then
            slideU = 4
            slideD = 1
        elseif (positEn > 640 and positEn < 746) then
            slideU = 3
            slideD = 2
        elseif (positEn > 534 and positEn < 640) then
            slideU = 2
            slideD = 3
        else-- U to D only
            slideU = 1
            slideD = 4
        end

        for posY = gemY, 1, -1 do
            if( posY == gemY) then
                if(positSt > slideU) then --- U
                    color = colorTmp[positSt - slideU]
                    maxYTmp = positSt - slideU
                else --- D
                    color = colorTmp[positSt + slideD]
                    maxYTmp = positSt + slideD
                end
            else
                if(maxYTmp == 1 ) then
                    maxYTmp = gemY
                    color = colorTmp[maxYTmp]
                else
                    maxYTmp = maxYTmp - 1
                    color = colorTmp[maxYTmp]
                end
            end

            gemsTable[self.i][posY] = display.newImageRect(picture[color],sizeGem,sizeGem)

            if (color == 1 ) then
                gemsTable[self.i][posY].gemType = "RED"
            elseif (color == 2 ) then
                gemsTable[self.i][posY].gemType = "GREEN"
            elseif (color == 3 ) then
                gemsTable[self.i][posY].gemType = "BLUE"
            elseif (color == 4 ) then
                gemsTable[self.i][posY].gemType = "PURPLE"
            elseif (color == 5 ) then
                gemsTable[self.i][posY].gemType = "PINK"
            elseif (color == 6 ) then
                gemsTable[self.i][posY].gemType = "YELLOW"
            end

            gemsTable[self.i][posY].color = color
            gemsTable[self.i][posY].x = markX
            gemsTable[self.i][posY].y = channelY[posY]
            gemsTable[self.i][posY].i = markI
            gemsTable[self.i][posY].j = posY

            gemsTable[self.i][posY].destination_y = channelY[posY]
            gemsTable[self.i][posY].isMarkedToDestroy = false
            gemsTable[self.i][posY].touch = onGemTouch
            gemsTable[self.i][posY]:addEventListener( "touch", gemsTable[self.i][posY] )
        end
    else
        --print("just click dont move")
    end

    for R = 1, gemX, 1 do
        copyGemXR[R]:removeSelf()
        copyGemXL[R]:removeSelf()
    end
    for C = 1, gemY, 1 do
        copyGemYU[C]:removeSelf()
        copyGemYD[C]:removeSelf()
    end


    if ( lineY ~=nil) then
        lineY:removeSelf()
        lineY= nil
    end
    if ( lineX ~=nil) then
        lineX:removeSelf()
        lineX= nil
    end

    -- for i = 1, gemX, 1 do --- x
    -- for j = 1, gemY, 1 do --- y
    -- print("ยยยยi"..i.." j"..j.." dest"..gemsTable[i][j].destination_y )
    -- end
    -- end

end

function slideGem(self,event)
    -- print(self.chkFtPosit)
    if(self.chkFtPosit == "x") then -- -- -- -- -- slide X
        if ( lineY ~=nil) then
            lineY:removeSelf()
            lineY= nil
        end

        self.slideEvent = (event.x - event.xStart)

        -- gemsTable[][].j :: gemsTable[][].i == point self // gemsTable[self.i][self.j] == data self VIP
        if(gemsTable[self.i][self.j].x <= 20 or gemsTable[self.i][self.j].x >= 620) then -- jump end dont move
            pasteGem(self,event)
        else
            intervalGem = sizeGem + 8
            for posX = 1, gemX, 1 do
                if gemsTable[posX][self.j].i == self.i then -- self gem pos
                    gemsTable[posX][self.j].x = self.markX + self.slideEvent
                else
                    gemsTable[posX][self.j].x = gemsTable[posX][self.j].markX + self.slideEvent
                end

                copyGemXR[posX].x = enTableX + gemsTable[posX][self.j].markX + self.slideEvent
                copyGemXL[posX].x = stTableX - gemsTable[posX][self.j].markX + self.slideEvent
            end
        end
    elseif (self.chkFtPosit == "y") then -- ---- -- slide Y
        if ( lineX ~=nil) then
            lineX:removeSelf()
            lineX= nil
        end

        self.slideEvent = (event.y - event.yStart)

        -- print("JUMP ".. gemsTable[self.i][self.j].y)--
        if(gemsTable[self.i][self.j].y <= 455 or gemsTable[self.i][self.j].y >= 940) then -- jump end dont move
            pasteGem(self,event)
        else
            intervalGem = sizeGem + 8
            for posY = 1, gemY, 1 do
                if gemsTable[self.i][posY].i == self.y then -- self gem pos
                    gemsTable[self.i][posY].y = self.markY + self.slideEvent
                else
                    gemsTable[self.i][posY].y = gemsTable[self.i][posY].markY + self.slideEvent
                end

                stTableY, enTableY = 853, 530
                copyGemYU[posY].x = gemsTable[self.i][posY].markX--
                copyGemYU[posY].y = enTableY + gemsTable[self.i][posY].markY + self.slideEvent

                copyGemYD[posY].x = gemsTable[self.i][posY].markX
                copyGemYD[posY].y = stTableY - gemsTable[self.i][posY].markY + self.slideEvent
            end
        end
    else
        print ("Error SlideGem Func X Y")
    end

end

local function shiftGems ()
    print ("Shifting Gems")
    -- first roww
    for i = 1, gemX, 1 do
        if gemsTable[i][1].isMarkedToDestroy then
            gemToBeDestroyed = gemsTable[i][1]

            gemsTable[i][1] = newGem(i,1)

            gemToBeDestroyed:removeSelf()
            gemToBeDestroyed = nil
        end
    end
    -- rest of the rows
    for j = 2, gemY, 1 do -- j = row number - need to do like this it needs to be checked row by row
        for i = 1, gemX, 1 do
            if gemsTable[i][j].isMarkedToDestroy then --if you find and empty hole then shift down all gems in column
                gemToBeDestroyed = gemsTable[i][j]
                for k = j, 2, -1 do -- starting from bottom - finishing at the second row
                    gemsTable[i][k] = gemsTable[i][k-1]
                    gemsTable[i][k].destination_y = gemsTable[i][k].destination_y + 106
                    transitionStash.newTransition = transition.to( gemsTable[i][k], { time=100, y= gemsTable[i][k].destination_y} )

                    gemsTable[i][k].j = gemsTable[i][k].j + 1
                end

                gemsTable[i][1] = newGem(i,1)

                gemToBeDestroyed:removeSelf()
                gemToBeDestroyed = nil
            end
        end
    end
end --shiftGems()

local function enableGemTouch()
    isGemTouchEnabled = true
end

local function destroyGems(self)
    print ("Destroying Gems. Marked to Destroy = ")
    --print("self ".. self.i.. ":".. self.j)
    lockGemMutiChk = true

    for i = 1, gemX, 1 do
        for j = 1, gemY, 1 do
            if gemsTable[i][j].isMarkedToDestroy then
                -- print("nameType"..nameType)
                gemsTable[i][j]:setStrokeColor(140, 140, 140)
                gemsTable[i][j].strokeWidth = 7
                gemsTable[i][j]:setFillColor(150)

                isGemTouchEnabled = false
                transitionStash.newTransition = transition.to( gemsTable[i][j], { time=300, alpha=0.2, xScale=2, yScale = 2, onComplete=enableGemTouch } )
            end
        end
    end

    timer.performWithDelay( 200, shiftGems )

    for pt = 1 , 6 , 1 do
        groupGem[pt] =0
    end

    lockGemMuti = 0

    checkMemory()
end

local function cleanUpGems()
    print("Cleaning Up Gems")

    for i = 1, gemX, 1 do
        for j = 1, gemY, 1 do
            -- show that there is not enough
            if gemsTable[i][j].isMarkedToDestroy then
                transitionStash.newTransition = transition.to( gemsTable[i][j], { time=100, xScale=1.2, yScale = 1.2 } )
                transitionStash.newTransition = transition.to( gemsTable[i][j], { time=100, delay=100, xScale=1.0, yScale = 1.0} )
            end

            gemsTable[i][j].isMarkedToDestroy = false
        end
    end

    for pt = 1 , 6 , 1 do
        groupGem[pt] =0
    end
end

local function markPreDestory (i,j,chkMuti)
    --print("markPreDestory ".. gemsTable[i][j].gemType)
    if (gemsTable[i][j].gemType == "RED") then
        if (chkMuti == 0) then
            groupGemChk[1] = groupGemChk[1] + 1
        else
            groupGemChk[1] = 0
        end
    elseif (gemsTable[i][j].gemType == "GREEN") then
        if (chkMuti == 0) then
            groupGemChk[2] = groupGemChk[2] + 1
        else
            groupGemChk[2] = 0
        end
    elseif (gemsTable[i][j].gemType == "BLUE") then
        if (chkMuti == 0) then
            groupGemChk[3] = groupGemChk[3] + 1
        else
            groupGemChk[3] = 0
        end
    elseif (gemsTable[i][j].gemType == "PURPLE") then
        if (chkMuti == 0) then
            groupGemChk[4] = groupGemChk[4] + 1
        else
            groupGemChk[4] = 0
        end
    elseif (gemsTable[i][j].gemType == "PINK") then
        if (chkMuti == 0) then
            groupGemChk[5] = groupGemChk[5] + 1
        else
            groupGemChk[5] = 0
        end
    elseif (gemsTable[i][j].gemType == "YELLOW") then
        if (chkMuti == 0) then
            groupGemChk[6] = groupGemChk[6] + 1
        else
            groupGemChk[6] =0
        end
    end
end

local function markToDestroy(self, chkMuti)
    self.isMarkedToDestroy = true
    -- print("markToDestroy ".. gemsTable[self.i][self.j].gemType,chkMuti)
    if self.i>1 then
        if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == false then
            if (gemsTable[self.i-1][self.j]).gemType == self.gemType then
                markPreDestory (self.i-1,self.j,chkMuti)
                markToDestroy( gemsTable[self.i-1][self.j],chkMuti)
            end
        end
    end

    if self.i<gemX then
        if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == false then
            if (gemsTable[self.i+1][self.j]).gemType == self.gemType then
                markPreDestory (self.i+1,self.j,chkMuti)
                markToDestroy( gemsTable[self.i+1][self.j],chkMuti )
            end
        end
    end

    if self.j>1 then
        if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == false then
            if (gemsTable[self.i][self.j-1]).gemType == self.gemType then
                markPreDestory (self.i,self.j-1,chkMuti)
                markToDestroy( gemsTable[self.i][self.j-1] ,chkMuti)
            end
        end
    end

    if self.j<gemY then
        if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== false then
            if (gemsTable[self.i][self.j+1]).gemType == self.gemType then
                markPreDestory (self.i,self.j+1,chkMuti)
                markToDestroy( gemsTable[self.i][self.j+1] ,chkMuti)
            end
        end
    end
end

function chkGruopDel (self,chkMuti)
    self.isMarkedToDestroy = false

    if self.i>1 then
        if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == true and gemsTable[self.i-1][self.j].gemType == self.gemType then
            markPreDestory (self.i-1,self.j,chkMuti)
            chkGruopDel( gemsTable[self.i-1][self.j] ,chkMuti)
        end
    end

    if self.i<gemX then
        if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == true and gemsTable[self.i+1][self.j].gemType == self.gemType then
            markPreDestory (self.i+1,self.j,chkMuti)
            chkGruopDel( gemsTable[self.i+1][self.j],chkMuti )
        end
    end

    if self.j>1 then
        if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == true and gemsTable[self.i][self.j-1].gemType == self.gemType then
            markPreDestory (self.i,self.j-1,chkMuti)
            chkGruopDel( gemsTable[self.i][self.j-1] ,chkMuti)
        end
    end

    if self.j<gemY then
        if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== true and gemsTable[self.i][self.j+1].gemType == self.gemType then
            markPreDestory (self.i,self.j+1,chkMuti)
            chkGruopDel( gemsTable[self.i][self.j+1] ,chkMuti)
        end
    end
end

function chkGruopGem(self,kk)
    --print("self.gemType"..self.gemType)

    if (self.gemType == "RED") then
        -- print("RED "..groupGemChk[1],groupGem[1],kk)
        if groupGemChk[1] >= limitCountGem then
            if (kk ~= "RED") then
                groupGem[1]= groupGem[1]+groupGemChk[1]
            end
        elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[1] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[1] = 0
    elseif (self.gemType == "GREEN") then
        -- print("GREEN "..groupGemChk[2],groupGem[2],kk)
        if groupGemChk[2] >= limitCountGem then
            if (kk ~= "GREEN") then
                groupGem[2]= groupGem[2]+groupGemChk[2]
            end
        elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[2] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[2] = 0
    elseif (self.gemType == "BLUE") then
        -- print("BLUE "..groupGemChk[3],groupGem[3],kk)
        if groupGemChk[3] >= limitCountGem then
            if ( kk ~= "BLUE") then
                groupGem[3]= groupGem[3]+groupGemChk[3]
            end
        elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[3] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[3] = 0
    elseif (self.gemType == "PURPLE") then
        -- print("PURPLE "..groupGemChk[4],groupGem[4],kk)
        if groupGemChk[4] >= limitCountGem then
            if (kk ~= "PURPLE") then
                groupGem[4]= groupGem[4]+groupGemChk[4]
            end
        elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[4] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[4] = 0
    elseif (self.gemType == "PINK") then
        -- print("PINK "..groupGemChk[5],groupGem[5],kk)
        if groupGemChk[5] >= limitCountGem then
            if ( kk ~= "PINK") then
                groupGem[5]= groupGem[5]+groupGemChk[5]
            end
        elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[5] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[5] = 0
    elseif (self.gemType == "YELLOW") then
        -- print("YELLOW "..groupGemChk[6],groupGem[6],kk)
        if groupGemChk[6] >= limitCountGem then
            if kk ~= "YELLOW" then
                groupGem[6]= groupGem[6]+groupGemChk[6]
            end
        elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[6] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[6] = 0
    end
end

function lockGem(self, event)
    if( self.chkFtPosit ~= "" ) then
        if( self.chkFtPosit == "x" ) then
            slideEvent = (event.x - event.xStart)
        else
            slideEvent = (event.y - event.yStart)
        end

        if ( slideEvent > 60 or slideEvent < -60) then
            if( self.chkFtPosit == "x" ) then
                positEn = slideEvent + gemsTable[self.i][self.j].x

                if(positEn > 533 ) then
                    self.i = 6
                elseif (positEn > 427 and positEn < 533) then
                    self.i = 5
                elseif (positEn > 319 and positEn < 427) then
                    self.i = 4
                elseif (positEn > 216 and positEn < 319) then
                    self.i = 3
                elseif (positEn > 111 and positEn < 216) then
                    self.i = 2
                else
                    self.i = 1
                end
            elseif ( self.chkFtPosit == "y" ) then
                positEn = slideEvent + gemsTable[self.i][self.j].y

                if(positEn > 852 ) then
                    self.j = 5
                elseif (positEn > 746 and positEn < 852) then
                    self.j = 4
                elseif (positEn > 640 and positEn < 746) then
                    self.j = 3
                elseif (positEn > 534 and positEn < 640) then
                    self.j = 2
                else
                    self.j = 1
                end
            else
                print("-- not send chkFtPosit")
            end

            -- print("self.i"..self.i.." self.j"..self.j)
            if (self.chkFtPosit=="x") then
                for stX = 1, gemX, 1 do
                    self.i = stX
                    self.gemType=gemsTable[self.i][self.j].gemType

                    --print("self.i"..self.i.." self.j"..self.j..self.gemType)
                    markToDestroy(self,0)

                    local kk = stX -1
                    if(kk > 0) then
                        kk = gemsTable[kk][self.j].gemType
                    else
                        kk = "COLOR FT"
                    end

                    chkGruopGem(self, kk)

                    --print("xxx".. self.gemType,numberOfMarkedToDestroy )
                end
            elseif (self.chkFtPosit=="y" ) then
                for stY = 1, gemY, 1 do
                    self.j = stY
                    self.gemType=gemsTable[self.i][self.j].gemType

                    markToDestroy(self,0)

                    local kk = stY -1
                    if(kk > 0) then
                        kk = gemsTable[self.i][kk].gemType
                    else
                        kk = "COLOR FT"
                    end

                    chkGruopGem(self,kk)
                    -- print("yyy".. self.gemType,numberOfMarkedToDestroy )
                end
            else
                print("not heve self.chkFtPosit")
            end

            --test
            --print(" - lockGem")
            local overMin = 0
            for p = 1 , 6 , 1 do
                --print(p.." "..groupGem[p])
                if(groupGem[p] >= limitCountGem) then
                    overMin = limitCountGem
                end
            end

            -- print("destroy "..numberOfMarkedToDestroy)
            if overMin >= limitCountGem then
                destroyGems(self)
            else
                cleanUpGems()
            end
        end

    else
        --print(" self.chkFtPosit")
    end

end

function formulaMission( randomGem, powerChr)
    print("formula")
end

local function numberToimg (hp,stHp,si,i)
    number[i] =display.newImageRect("img/other/"..hp..".png",si,25)
    number[i]:setReferencePoint( display.TopLeftReferencePoint )
    number[i].x, number[i].y = stHp, 400
end

function onGemTouch( self, event )	-- was pre-declared
    local stHp, si =590, 20
    if event.phase == "began" then
        -- print("2 "..playerDB.charac_def[1])
        -- print("sss "..table.getn(playerDB.charac_def))

        for i = 1 ,gemX, 1 do
            for j = 1 , gemY, 1 do
                gemsTable[i][j].colorR = gemsTable[i][j].color --- - -- - copy gem
                gemsTable[i][j].markX = gemsTable[i][j].x
                gemsTable[i][j].markY = gemsTable[i][j].y
            end
        end

        display.getCurrentStage():setFocus( self )
        self.isFocus = true

        if(gemsTable[self.i][self.j].isMarkedToDestroy == false ) then
            self:setFillColor(100)
        end

        widhtLineY, widhtLineX = 525, 620
        sizeLineStY, sizeLineStX = 695, 320

        lineY = display.newImageRect("img/other/bar_twin_v.png",100,widhtLineY)
        lineY.x, lineY.y = self.markX, sizeLineStY

        lineX = display.newImageRect("img/other/bar_twin_h.png", widhtLineX, 100)
        lineX.x, lineX.y = sizeLineStX, self.markY

        copyGem(self, event)

        state = display.newImageRect( "img/sprite/BG_Forest/Autumn/ForestKingdom.jpg", 640, 425)
        state:setReferencePoint( display.TopLeftReferencePoint )
        state.x, state.y = 0, 0
        --
        lifeline_sh = display.newImageRect( "img/other/life_short.png", 550, 20) --- full 550
        lifeline_sh:setReferencePoint( display.TopLeftReferencePoint )
        lifeline_sh.x, lifeline_sh.y = 70, 400

        lifeline = display.newImageRect( "img/other/life_line.png", 600, 30) -- 490
        lifeline:setReferencePoint( display.TopLeftReferencePoint )
        lifeline.x, lifeline.y = 25, 395
        --
        --
        for i = string.len(hpFull) ,1, -1 do
            if ( string.sub(hpFull, i, i) == "1") then
                si =15
            else
                si = 20
            end
            stHp = stHp -si
            numberToimg (string.sub(hpFull, i, i) ,stHp,si,i)
            -- number =display.newImageRect("img/other/"..string.sub(hpFull, i, i)..".png", si, 25)
            -- number:setReferencePoint( display.TopLeftReferencePoint )
            -- number.x, number.y = stHp, 400
        end

        stHp = stHp - si
        numberBar =display.newImageRect("img/other/bar.png",si,25)
        numberBar:setReferencePoint( display.TopLeftReferencePoint )
        numberBar.x, numberBar.y = stHp, 400

        for i = string.len(hpPlayer), 1, -1 do
            if ( string.sub(hpPlayer, i, i) == "1") then
                si =15
            else
                si = 20
            end
            stHp = stHp -si
            numberToimg (string.sub(hpPlayer, i, i) ,stHp,si,string.len(hpPlayer)+ string.len(hpFull)-i+1)
        end

        frame = display.newImageRect( "img/other/frame_cha2.png", 100, 100)
        frame:setReferencePoint( display.TopLeftReferencePoint )
        frame.x, frame.y = posXch[1], 295

        self.chkFtPosit =""

        print("began :"..self.x, self.y)
        print("i".. gemsTable[self.i][self.j].i.."j" ..gemsTable[self.i][self.j].j )
        print("start".. event.xStart)
        print("mark".. self.markX )

        -- local ftCilck = ""
    elseif self.isFocus then
        if event.phase == "moved" then
            local posX = (event.x - event.xStart) + self.markX
            local posY = (event.y - event.yStart) + self.markY

            local pathY = event.y-event.yStart
            local pathX = event.x-event.xStart

            -- print("posX ".. posX.." posY ".. posY.." pathX ".. pathX.." pathY ".. pathY )
            -- print ("event.xStart ".. event.xStart.. " event.x "..event.x.." self.markX ".. self.markX)
            local speedX = posX - self.markX
            if ( (posY == self.markY) or self.chkFtPosit == "x" ) then -- move X
                if(self.chkFtPosit == "y" ) then
                    posX = self.markX
                    posY = event.y

                    self.chkFtPosit ="y"
                else
                    posX = event.x
                    posY = self.markY

                    self.chkFtPosit ="x"
                end
                -- print( "posY == self.markY moveX")
            elseif ( posX == self.markX or self.chkFtPosit == "y" ) then -- move Y
                if(self.chkFtPosit == "x") then
                    posX = event.x
                    posY = self.markY

                    self.chkFtPosit ="x"
                else
                    posX = self.markX
                    posY = event.y

                    self.chkFtPosit ="y"
                end
                -- print( "posX == self.markX moveY")
            else
                if (pathY < pathX and self.chkFtPosit =="" ) then -- move X
                    posX = event.x
                    posY = self.markY
                    -- print("|xxxx"..pathY,pathX)
                    self.chkFtPosit ="x"
                    -- local myText = display.newText(pathY.."!"..pathX, 0, 0, native.systemFont, 100)
                    -- myText:setTextColor(0, 0, 0)

                elseif (pathY > pathX and self.chkFtPosit =="") then
                    posX = self.markX-- move Y
                    posY = event.y
                    -- print("|yyyy"..pathY,pathX)
                    self.chkFtPosit ="y"
                else
                    -- print("sssssssss sss sss s ss ")
                end

            end

            self.x, self.y = posX, posY
            --print("x:"..posX.."evX:"..self.x.." y:"..posY.."evY:"..self.y)
            --print("slide "..gemsTable[6][self.j].x)

            slideGem(self,event) --- old
        elseif event.phase == "ended" or event.phase == "cancelled" then
            print("end ".. self.chkFtPosit)

            pasteGem(self,event)
            lockGem(self,event)

            self.chkFtPosit =""

            display.getCurrentStage():setFocus( nil )
            self.isFocus = false

            if(gemsTable[self.i][self.j].isMarkedToDestroy == false ) then
                self:setFillColor(255)
            else
                self:setFillColor(150)
            end

            if ( number ~=nil) then
                numberBar:removeSelf()
                numberBar= nil

                for i = 1, string.len(hpFull)+string.len(hpPlayer) do
                    number[i]:removeSelf()
                    number[i]= nil
                end
            end

            -- hpFull = 12 --- hp before play
            -- hpPlayer = 11

            for i = string.len(hpFull) ,1, -1 do
                if ( string.sub(hpFull, i, i) == "1") then
                    si =15
                else
                    si = 20
                end
                stHp = stHp -si
                numberToimg (string.sub(hpFull, i, i) ,stHp,si,i)
            end

            stHp = stHp - si
            numberBar =display.newImageRect("img/other/bar.png",si,25)
            numberBar:setReferencePoint( display.TopLeftReferencePoint )
            numberBar.x, numberBar.y = stHp, 400

            for i = string.len(hpPlayer), 1, -1 do
                if ( string.sub(hpPlayer, i, i) == "1") then
                    si =15
                else
                    si = 20
                end
                stHp = stHp -si
                numberToimg (string.sub(hpPlayer, i, i) ,stHp,si,string.len(hpPlayer)+ string.len(hpFull)-i+1)
            end

        end
    end
    return true

end

function scene:createScene( event )
    -- print("before "..table.getn(playerDB.charac_def))
    ------------------------- connect REST serviced -------------------------
    local function networkListener( event )
        if ( event.isError ) then
            print ( "Network error - download failed" )
        else
            print("Connect good")
            print ( "RESPONSE: " .. event.response )

            local json = require "json"

            playerDB = json.decode(event.response)
            print("1 "..playerDB.img[1])

        end
    end

    local url = "http://133.242.169.252/playgame.php"
    local headers = {}
    headers["Content-Type"] = "application/x-www-form-urlencoded"
    headers["Accept-Language"] = "en-US"

    local body = "color=red&size=small"
    local params = { }

    params.headers = headers
    params.body = body

    url = url.."?id=1"
    url = url.."&&state=1"
    url = url.."&&team=1"

    print("url :"..url)
    network.request( url, "GET", networkListener, params)


    print("--------------main puzzle----------------")
    checkMemory()

    groupGameLayer = display.newGroup()

    local group = self.view

    local background = display.newImageRect( "img/background/bg_puzzle_test.tga", _W, _H )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    group:insert(background)

    local state = display.newImageRect( "img/sprite/BG_Forest/Autumn/ForestKingdom.jpg", 640, 425)
    state:setReferencePoint( display.TopLeftReferencePoint )
    state.x, state.y = 0, 0
    group:insert(state)

    -- for i =1, amountPlayer do
    -- teamPlayer[i]={}
    --
    -- teamPlayer[i].pic = "img/character/minitest1001.png"
    -- teamPlayer[i].ele = 0
    -- teamPlayer[i].att = 0
    -- teamPlayer[i].ptt = 0
    -- teamPlayer[i].hp = 0
    -- teamPlayer[i].lv = 0
    -- teamPlayer[i].pw_sp = 0
    -- teamPlayer[i].lead = 0
    -- end

    local team = display.newImageRect( "img/character/mini1001.png", 100, 100)
    team:setReferencePoint( display.TopLeftReferencePoint )
    team.x, team.y = posXch[1], 295
    --group:insert(team)
    local team = display.newImageRect( "img/character/mini1005.png", 100, 100)
    team:setReferencePoint( display.TopLeftReferencePoint )
    team.x, team.y = posXch[2], 295
    group:insert(team)
    local team = display.newImageRect( "img/character/mini1006.png", 100, 100)
    team:setReferencePoint( display.TopLeftReferencePoint )
    team.x, team.y = posXch[3], 295
    group:insert(team)
    local team = display.newImageRect( "img/character/mini1004.png", 100, 100)
    team:setReferencePoint( display.TopLeftReferencePoint )
    team.x, team.y = posXch[6], 295
    group:insert(team)


    local lifeline_sh = display.newImageRect( "img/other/life_short.png", 550, 20) --- full 550
    lifeline_sh:setReferencePoint( display.TopLeftReferencePoint )
    lifeline_sh.x, lifeline_sh.y = 70, 400
    group:insert(lifeline_sh)

    local lifeline = display.newImageRect( "img/other/life_line.png", 600, 30) -- 490
    lifeline:setReferencePoint( display.TopLeftReferencePoint )
    lifeline.x, lifeline.y = 25, 395
    group:insert(lifeline)


    local frame = display.newImageRect( "img/other/frame_cha2.png", 100, 100)
    frame:setReferencePoint( display.TopLeftReferencePoint )
    frame.x, frame.y = posXch[1], 295
    group:insert(frame)
    local frame = display.newImageRect( "img/other/frame_cha5.png", 100, 100)
    frame:setReferencePoint( display.TopLeftReferencePoint )
    frame.x, frame.y = posXch[2], 295
    group:insert(frame)
    local frame = display.newImageRect( "img/other/frame_cha3.png", 100, 100)
    frame:setReferencePoint( display.TopLeftReferencePoint )
    frame.x, frame.y = posXch[3], 295
    group:insert(frame)
    local frame = display.newImageRect( "img/other/frame_cha1.png", 100, 100)
    frame:setReferencePoint( display.TopLeftReferencePoint )
    frame.x, frame.y = posXch[6], 295
    group:insert(frame)


    -- local comm = display.newImageRect( "img/character/full1002.png", 200, 200)
    -- comm:setReferencePoint( display.TopLeftReferencePoint )
    -- comm.x, comm.y =-20, 80
    -- group:insert(comm)

    local comm = display.newImageRect( "img/character/full1002.png", 200, 200)
    comm:setReferencePoint( display.TopLeftReferencePoint )
    comm.x, comm.y =100, 80
    group:insert(comm)

    local comm = display.newImageRect( "img/character/full1002.png", 200, 200)
    comm:setReferencePoint( display.TopLeftReferencePoint )
    comm.x, comm.y =220, 80
    group:insert(comm)

    local comm = display.newImageRect( "img/character/full1002.png", 200, 200)
    comm:setReferencePoint( display.TopLeftReferencePoint )
    comm.x, comm.y =340, 80
    group:insert(comm)

    local comm = display.newImageRect( "img/character/full1002.png", 200, 200)
    comm:setReferencePoint( display.TopLeftReferencePoint )
    comm.x, comm.y =460, 80
    group:insert(comm)

    -- local tileSheet = sprite.newSpriteSheet("img/other/number.png", 110, 178)
    -- local tileSet = sprite.newSpriteSet(tileSheet, 1, 10)
    -- local tile = sprite.newSprite(tileSet)
    -- tile.currentFrame = 1

    -- local test = sprite.newSpriteSheet( "img/other/number.png", 110, 178 )
    -- local spriteset = sprite.newSpriteSet(test , 1, 10)
    -- sprite.add( spriteset, "one", 1, 2, 200, 0 )
    -- sprite.add( spriteset, "two", 3, 1, 1, 0 )
    -- sprite.add( spriteset, "three", 4, 2, 100, 0 )

    -- panda = sprite.newSprite( spriteset )
    --group:insert( panda )

    -- score player/full เอา full เป็นจุดเริ่ม 590
    -------------------------- HP value -------------------------
    local stHp, si =590, 20

    for i = string.len(hpFull) ,1, -1 do
        if ( string.sub(hpFull, i, i) == "1") then
            si =15
        else
            si = 20
        end
        stHp = stHp -si
        numberToimg (string.sub(hpFull, i, i) ,stHp,si,i)
    end

    stHp = stHp - si
    numberBar =display.newImageRect("img/other/bar.png",si,25)
    numberBar:setReferencePoint( display.TopLeftReferencePoint )
    numberBar.x, numberBar.y = stHp, 400
    group:insert(numberBar)

    for i = string.len(hpPlayer), 1, -1 do
        if ( string.sub(hpPlayer, i, i) == "1") then
            si =15
        else
            si = 20
        end
        stHp = stHp -si
        numberToimg (string.sub(hpPlayer, i, i) ,stHp,si,string.len(hpPlayer)+ string.len(hpFull)-i+1)
    end

    ------------------------- gemsTable -------------------------
    for i = 1, gemX, 1 do --- x
        gemsTable[i] = {}
        for j = 1, gemY, 1 do --- y
            gemsTable[i][j] = newGem(i,j)
        end
    end

    groupGameLayer = display.newGroup()
    -- groupEndGameLayer = display.newGroup()

    group:insert(groupGameLayer)



end -- end for scene:createScene

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
end

function scene:destroyScene( event )
    local group = self.view
end
------- sample used -------
local function networkListener( event )
    -- print("address", event.address )
    -- print("isReachable", event.isReachable )
    -- print("isConnectionRequired", event.isConnectionRequired)
    -- print("isConnectionOnDemand", event.isConnectionOnDemand)
    -- print("IsInteractionRequired", event.isInteractionRequired)
    -- print("IsReachableViaCellular", event.isReachableViaCellular)
    -- print("IsReachableViaWiFi", event.isReachableViaWiFi)

    if ( event.isError ) then
        print ( "Network error - download failed" )
    else
        print("Connect good")
        -- event.target.alpha = 0
        -- transitionStash.newTransition = transition.to( event.target, { alpha = 1.0 } )
        print ( "RESPONSE: " .. event.response )

        local json = require "json"

        playerDB = json.decode(event.response)
    end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

