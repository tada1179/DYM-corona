local rnd = math.random
local score = 0
local rect

local function resetRect(rect)

    transition.to( rect, { time=1900, alpha=1, x=rect.x, y=display.viewableContentHeight + 200 } )

end

local function rectTouch(touch)

    collectgarbage("collect")
    print("3System Memory : "..collectgarbage("count"))
    print("3balltouch")
    print("3removeBall")

    rect.x = rnd(500) ; rect.y = -150 ; rect.alpha = 1
    resetRect(rect)

end

function addRect()

    rect = display.newRect( rnd(500), -150, 125, 125 )
    rect:setFillColor(255, 0, 0 )

    collectgarbage("collect")
    print("1System Memory : "..collectgarbage("count"))
    print("1addball")

    transition.to( rect, { time=1900, alpha=1, x=rect.x, y=display.viewableContentHeight + 200 } )

    rect:addEventListener("touch", rectTouch)

    collectgarbage("collect")
    print("2System Memory : "..collectgarbage("count"))
    print("2addlistener")

end

local timerBall = timer.performWithDelay(1000, addRect,1)