print("guscha.lua")




display.setStatusBar( display.HiddenStatusBar )

--import the scrolling classes
local scrollView = require("scrollView")
local tableView = require("tableView")
--local ui = require ("ui")
local util = require("util")
local json = require("json")
local widget = require ("widget")

local id = {}
local amound = {}
local price = {}
local image = {}

local data = {}
local URL
local myList, backBtn, detailScreenText

--local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
--background:setFillColor(140, 140, 140)

local background = display.newImageRect("img/background/MISSION-SELECT-LAYOT.jpg",display.contentWidth, display.contentHeight )
background:setReferencePoint( display.TopLeftReferencePoint )
background.x, background.y = 0, 0

-- Setup a scrollable content group
local topBoundary = display.screenOriginY
local bottomBoundary = display.screenOriginY
local scrollView = scrollView.new{ top=topBoundary, bottom=bottomBoundary }

local myText = display.newText("Move Up to Scroll", 0, 0, native.systemFontBold, 16)
myText:setTextColor(255, 0, 0)
myText.x = math.floor(display.contentWidth*0.5)
myText.y = 150
scrollView:insert(myText)

-- add some text to the scrolling screen
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth , display.contentHeight - display.viewableContentHeight
local detailScreen = display.newGroup()

local detailBg = display.newRect(0,0,display.contentWidth,display.contentHeight-display.screenOriginY)
detailBg:setFillColor(0,200,255)
detailScreen:insert(detailBg)

--local gacha = display.newRect("/Users/APPLE/Desktop/corona/gacha/gold1.png",display.contentWidth,display.contentHeight)
--gacha:setReferencePoint( display.TopLeftReferencePoint )
--detailScreen:insert(gacha)

detailScreenText = display.newText("You tapped item", 0, 0, native.systemFontBold, 20)
detailScreenText:setTextColor(0, 0, 0)
detailScreen:insert(detailScreenText)


detailScreenText.x = math.floor(display.contentWidth/2)
detailScreenText.y = math.floor(display.contentHeight/2)
detailScreen.x = display.contentWidth

--setup functions to execute on touch of the list view items
function listButtonRelease( event )

    self = event.target
    local id = self.id
    print("self:"..id)
    --print("img"..data[1].image)
    detailScreenText.text = "id:"..self.id

    transition.to(myList, {time=400, x=display.contentWidth*-1, transition=easing.outExpo })
    transition.to(detailScreen, {time=400, x=0, transition=easing.outExpo })
    transition.to(backBtn, {time=400, x=math.floor(backBtn.width/2) + screenOffsetW*.5 + 6, transition=easing.outExpo })
    transition.to(backBtn, {time=400, alpha=1 })

    transition.to(scrollView,  {time=400, x=display.contentWidth*-1, transition=easing.outExpo })

    delta, velocity = 0, 0
end

function backBtnRelease( event )
    print("back button released")
    image.isVisible=false

    transition.to(myList, {time=400, x=0, transition=easing.outExpo })
    transition.to(detailScreen, {time=400, x=display.contentWidth, transition=easing.outExpo })
    transition.to(backBtn, {time=400, x=math.floor(backBtn.width/2)+backBtn.width, transition=easing.outExpo })
    transition.to(backBtn, {time=400, alpha=0 })

    transition.to(scrollView, {time=400, x=0, transition=easing.outExpo })

    delta, velocity = 0, 0
end
--
--Setup the back button
backBtn = widget.newButton{
    default = "img/background/listItemBg.png",
    over = "img/background/listItemBg.png",
    onRelease = backBtnRelease
}
backBtn.x = math.floor(backBtn.width/2) + backBtn.width + screenOffsetW
backBtn.y = 50
backBtn.alpha = 0


local http = require("socket.http")
local function onoptionBtnRelease(event)
	print("event id",event.id)
end


for i = 1, 6 , 1 do
local dataTable = {}
	URL =  "http://localhost/DYM/stones.php?ticket_id="..i
	local response = http.request(URL)
	if response == nil then
   		print("No Dice")
	else
		print("-----")
    	dataTable = json.decode(response)
    	print(dataTable.ticket_id);
    	print(dataTable.ticket_amound);
    	print(dataTable.ticket_price);
        print(dataTable.ticket_img)
	end
	data[i] = "ID:"..dataTable.ticket_id.."amound:"..dataTable.ticket_amound.."price:"..dataTable.ticket_price;


	local lotsOfTextObject = util.wrappedText( data[i], 39, 14, native.systemFont, {200,200,0} )
	scrollView:insert(lotsOfTextObject)


	lotsOfTextObject.x = 50
	lotsOfTextObject.y = (i*40) + 140
    data[i] = {}
    data[i].id = dataTable.ticket_id
    data[i].amound = dataTable.ticket_amound
    data[i].price = dataTable.ticket_price
    data[i].image1 = dataTable.ticket_img


--    local frog = display.newImageRect( data[i].image1, 35, 35)
--    frog.x = 70
--    frog.y = (i * 40) + 160
--    scrollView:insert(frog)

    myList = widget.newButton
    {
        --top = math.floor(myText.y + myText.height) + (i*40) ,
        top =  (i*40) + 140 ,
        left = 50,
        data = data,
        id = data[i].id,
        onRelease=listButtonRelease,
        default = "img/background/listItemBg_over.png",
        over = "img/background/listItemBg.png",
        width=200, height=40,
        callback=function(row)
            local t = display.newText(row, 0, 0, native.systemFontBold, 16)
            t:setTextColor(200, 0 ,200)
            t.x = math.floor(t.width/2)
            t.y = 60
            return t
        end
    }
    scrollView:insert(1, myList)

    local frog = display.newImageRect( data[i].image1, 35, 35)
    frog.x = 70
    frog.y = (i * 40) + 160
    scrollView:insert(frog)

	local scrollBackground = display.newImageRect( "img/background/listItemBg.png", 100,210 )
    scrollBackground.x = 100
    scrollBackground.y = math.floor(myText.y + myText.height) + (i*40)
    scrollView:insert( scrollBackground )

end

scrollView:addScrollBar()
