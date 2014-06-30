module(..., package.seeall)
local _W = display.contentWidth
local _H = display.contentHeight

local timers = {}
local groupPic
---------------------------------------------------------------------------------------

function mission_horse()
    local gdisplay = display.newGroup()
    local centerX = display.contentCenterX
    local centerY = display.contentCenterY


    -- Define reference points locations anchor ponts
    local TOP_REF = 0
    local BOTTOM_REF = 1
    local LEFT_REF = 0
    local RIGHT_REF = 1
    local CENTER_REF = 0.5

--    display.setDefault( "anchorX", 0.0 )	-- default to TopLeft anchor point for new objects
--    display.setDefault( "anchorY", 0.0 )

    --local backgroundtop = display.newImage("img/bg_puzzle_test.png", 0, 0 )
--    local background = display.newImage("img/mission/background.png", 0, 0 )

    local moon = display.newImage("img/mission/moon.png", 22, 19)

    local mountain_big = display.newImage("img/mission/mountain_big.png", 132-240, 92)
    local mountain_big2 = display.newImage("img/mission/mountain_big.png", 132-720, 92)
    local mountain_sma = display.newImage("img/mission/mountain_small.png", 84, 111)
    local mountain_sma2 = display.newImage("img/mission/mountain_small.png", 84 - 480, 111)

    local tree_s = display.newImage("img/mission/tree_s.png", 129-30, 151)
    local tree_s2 = display.newImage("img/mission/tree_s.png", 270 + 10,151)
    local tree_l = display.newImage("img/mission/tree_l.png", 145, 131)

    local tree_s3 = display.newImage("img/mission/tree_s.png", 129-30 - 320, 151)
    local tree_s4 = display.newImage("img/mission/tree_s.png", 270 + 10 - 320,151)
    local tree_l2 = display.newImage("img/mission/tree_l.png", 145 - 320, 131)

    local tree_s5 = display.newImage("img/mission/tree_s.png", 129 - 30 - 640, 151)
    local tree_s6 = display.newImage("img/mission/tree_s.png", 270 + 10 - 640,151)
    local tree_l3 = display.newImage("img/mission/tree_l.png", 145 - 640, 131)

--    local fog = display.newImage("img/mission/Fog.png", 0, 214)
--    local fog2 = display.newImage("img/mission/Fog.png",-480,214)

--    background.x = 0
--    background.y = 0
    gdisplay:insert(moon)
    gdisplay:insert(mountain_big)
    gdisplay:insert(mountain_big2)
    gdisplay:insert(mountain_sma)
    gdisplay:insert(mountain_sma2)

    gdisplay:insert(tree_s)
    gdisplay:insert(tree_s2)
    gdisplay:insert(tree_l)

    gdisplay:insert(tree_s3)
    gdisplay:insert(tree_s4)
    gdisplay:insert(tree_l2)

    gdisplay:insert(tree_s5)
    gdisplay:insert(tree_s6)
    gdisplay:insert(tree_l3)

--    gdisplay:insert(fog)
--    gdisplay:insert(fog2)
    -- The following demonstrates using the new image sheet data format
    -- where uma_old.lua has been migrated to the new format (uma.lua)
    local options =
    {
        frames = require("uma").frames,
    }

    -- The new sprite API
    local umaSheet = graphics.newImageSheet( "img/mission/uma.png", options )
    local spriteOptions = { name="uma", start=1, count=8, time=1000 }
    local spriteInstance = display.newSprite( umaSheet, spriteOptions )

    spriteInstance.anchorX = RIGHT_REF
    spriteInstance.anchorY = BOTTOM_REF
    spriteInstance.x = 480
    spriteInstance.y = 320

    local tree_l_sugi = display.newImage("img/mission/tree_l_sugi.png", 23, 150)
    local tree_l_take = display.newImage("img/mission/tree_l_take.png", 151, 150)

    local tPrevious = system.getTimer()
    local intCount = 0
    local function countTime()
        timer.performWithDelay ( 4000, function()
            intCount =0
            spriteInstance:play()
            Runtime:addEventListener("enterFrame",move)
        end)
    end
     function move(event)
        intCount = intCount + 0.1
        print("move",intCount)
        if (intCount/20)>=1 then
            print("intCount/20 = ",intCount/20)
            spriteInstance:pause()
            Runtime:removeEventListener("enterFrame",move)
            countTime()
        end

        local tDelta = event.time - tPrevious
        tPrevious = event.time

        local xOffset = ( 0.2 * tDelta )

        moon.x = moon.x + xOffset*0.05

--        fog.x = fog.x + xOffset
--        fog2.x = fog2.x + xOffset

        mountain_big.x = mountain_big.x + xOffset*0.5
        mountain_big2.x = mountain_big2.x + xOffset*0.5
        mountain_sma.x = mountain_sma.x + xOffset*0.5
        mountain_sma2.x = mountain_sma2.x + xOffset*0.5


        tree_s.x = tree_s.x + xOffset
        tree_s2.x = tree_s2.x + xOffset
        tree_l.x = tree_l.x + xOffset

        tree_s3.x = tree_s3.x + xOffset
        tree_s4.x = tree_s4.x + xOffset
        tree_l2.x = tree_l2.x + xOffset

        tree_s5.x = tree_s5.x + xOffset
        tree_s6.x = tree_s6.x + xOffset
        tree_l3.x = tree_l3.x + xOffset


        tree_l_sugi.x = tree_l_sugi.x + xOffset * 1.5
        tree_l_take.x = tree_l_take.x + xOffset * 1.5

        if moon.x > 480 + moon.width / 2 then
            moon:translate ( -480*2 , 0)
        end
--        if fog.x > 480 + fog.width / 2 then
--            fog:translate( -480 * 2, 0)
--        end
--
--        if fog2.x > 480 + fog2.width / 2 then
--            fog2:translate( -480 * 2, 0)
--        end


        if mountain_big.x > 480 + mountain_big.width / 2 then
            mountain_big:translate(-480*2 , 0)
        end
        if mountain_big2.x > 480 + mountain_big2.width / 2 then
            mountain_big2:translate(-480*2 , 0)
        end
        if mountain_sma.x > 480 + mountain_sma.width / 2 then
            mountain_sma:translate(-480*2,0)
        end
        if mountain_sma2.x > 480 + mountain_sma2.width / 2 then
            mountain_sma2:translate(-480*2,0)
        end

        if tree_s.x > 480 + tree_s.width / 2 then
            tree_s:translate(-480*2 , 0)
        end
        if tree_s2.x > 480 + tree_s2.width / 2 then
            tree_s2:translate(-480*2 , 0)
        end
        if tree_l.x > 480 + tree_l.width / 2 then
            tree_l:translate(-480*2 , 0)
        end

        if tree_s3.x > 480 + tree_s3.width / 2 then
            tree_s3:translate(-480*2 , 0)
        end
        if tree_s4.x > 480 + tree_s4.width / 2 then
            tree_s4:translate(-480*2 , 0)
        end
        if tree_l2.x > 480 + tree_l2.width / 2 then
            tree_l2:translate(-480*2 , 0)
        end

        if tree_s5.x > 480 + tree_s5.width / 2 then
            tree_s5:translate(-480*2 , 0)
        end
        if tree_s6.x > 480 + tree_s6.width / 2 then
            tree_s6:translate(-480*2 , 0)
        end
        if tree_l3.x > 480 + tree_l3.width / 2 then
            tree_l3:translate(-480*2 , 0)
        end

        if tree_l_sugi.x > 480 + tree_l_sugi.width / 2 then
            tree_l_sugi:translate(-480*4,0)
        end

        if tree_l_take.x > 480 + tree_l_take.width / 2 then
            tree_l_take:translate(-480*5,0)
        end

    end

    spriteInstance:play()

--    Runtime:addEventListener("enterFrame",move)
end

function mission_Forest()
    groupPic = display.newGroup()
    local tPrevious = system.getTimer()

    local background = display.newImage("img/mission22/Forest/background.png", _W*.5, 194)
    groupPic:insert(background)

    local mountain = display.newImage("img/mission22/Forest/mountain.png", 520, 50)
    groupPic:insert(mountain)

    local house = display.newImage("img/mission22/Forest/house2.png", 200, 100)
    groupPic:insert(house)


    local tree1 = display.newImage("img/mission22/Forest/tree1.png", 350, 120)
    groupPic:insert(tree1)

    local tree2 = display.newImage("img/mission22/Forest/tree2.png", -50, 120)
    groupPic:insert(tree2)

    local House4 = display.newImage("img/mission22/Forest/House4.png", 750, 120)
    groupPic:insert(House4)

    local tree3 = display.newImage("img/mission22/Forest/tree3.png", 100, 120)
    groupPic:insert(tree3)

    local gates = display.newImage("img/mission22/Forest/gates.png", 200, 180)
    groupPic:insert(gates)

    local tege1 = display.newImage("img/mission22/Forest/tege.png", -100, 310)
    groupPic:insert(tege1)

    local tege = display.newImage("img/mission22/Forest/tege.png", 420, 310)
    groupPic:insert(tege)
    local tree4 = display.newImage("img/mission22/Forest/tree4.png", 500, 250)
    groupPic:insert(tree4)

    local tree5 = display.newImage("img/mission22/Forest/tree5.png", 80, 320)
    groupPic:insert(tree5)

    local tree21 = display.newImage("img/mission22/Forest/tree21.png", 600, 120)
    groupPic:insert(tree21)



    local function move(event)

        local tDelta = event.time - tPrevious
        tPrevious = event.time

        local xOffset = ( 0.2 * tDelta )

        mountain.x = mountain.x + xOffset*0.3

        --        fog.x = fog.x + xOffset
        --        fog2.x = fog2.x + xOffset
        house.x = house.x + xOffset*0.5

        House4.x = House4.x + xOffset*0.5
        tree1.x = tree1.x + xOffset*0.5
        tree2.x = tree2.x + xOffset*0.5
        tree3.x = tree3.x + xOffset*0.5
        gates.x = gates.x + xOffset*0.5


        tege1.x = tege1.x + xOffset
        tege.x = tege.x + xOffset
        tree4.x = tree4.x + xOffset
        tree5.x = tree5.x + xOffset
        tree21.x = tree21.x + xOffset *.5

        local framLeft = 600

        if mountain.x > framLeft + mountain.width / 2 then
            mountain:translate(-480*2 , 0)
        end
        if tree5.x > framLeft + tree5.width / 2 then
            tree5:translate(-480*2 , 0)
        end
        if tree4.x > framLeft + tree4.width / 2 then
            tree4:translate(-480*2,0)
        end
        if tege.x > framLeft + tege.width / 2 then
            tege:translate(-480*2,0)
        end

        if tege1.x > framLeft + tege1.width / 2 then
            tege1:translate(-480*2,0)
        end

        if gates.x > framLeft + gates.width / 2 then
            gates:translate(-480*2 , 0)
        end
        if tree3.x > framLeft + tree3.width / 2 then
            tree3:translate(-480*2 , 0)
        end
        if tree1.x > framLeft + tree1.width / 2 then
            tree1:translate(-480*2 , 0)
        end

        if house.x > framLeft + house.width / 2 then
            house:translate(-480*2 , 0)
        end

        if House4.x > framLeft + House4.width / 2 then
            House4:translate(-480*2 , 0)
        end

        if tree21.x > framLeft + tree21.width / 2 then
            tree21:translate(-480*2 , 0)
        end

        if tree2.x > framLeft + tree21.width / 2 then
            tree2:translate(-480*2 , 0)
        end

    end
--    Runtime:addEventListener("enterFrame",move)
    timers.gameTimerUpdate = timer.performWithDelay(10, move, 0)

end

function TimeOut()
    local k, v
    for k,v in pairs(timers) do
        timer.cancel(v )
        v = nil; k = nil
    end


    timers = nil
    timers = {}

    display.remove(groupPic)
    groupPic = nil
end