-- have backup in file scrollImage2.lua date backup 26-6-13 08.41 AM.

module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
-- set some global values for width and height of the screen
local screenW, screenH = display.contentWidth, display.contentHeight

local prevTime = 0
local pointListY =0
local listener
-------------------------------------

-------------------------------------

function new()
    -- setup a group to be the scrolling screen
    --local scrollView = display.newGroup()
	local scrollView = widget.newScrollView{
	     width = screenW *.1,
	     height = screenH*.08,
	     scrollWidth = 250,
	     scrollHeight = 400 ,
        hideBackground = true

	 }
    local Gscroll = display.newGroup()
    local AllView = display.newGroup()

    local SCROLL_LINE
    local scrollBar
    local listCharacter = {}
    local backButton
    local txtbattle
    local pointListX = screenW *.1
    pointListY =  screenH*.03
	scrollView.y = screenH*.25
    --scrollView.top = math.floor(screenH*.25) or 0
		print("top", scrollView.top)
    --    scrollView.bottom =   math.floor(screenH*.36)
    --scrollView.bottom =   math.floor(screenH*.18)
     -------------------------------------------------------
	
	 
-- event listener for button widget
	local function onButtonEvent( event )
		
    	if event.phase == "moved" then
        	local dx = math.abs( event.x - event.xStart )
        	local dy = math.abs( event.y - event.yStart )
        
       		-- if finger drags button more than 5 pixels, pass focus to scrollView
        	if dx > 5 or dy > 5 then
            	scrollView:takeFocus( event )
			end
    
		elseif event.phase == "ended" then
		    
			if event.target.id == "gallery" then
		       storyboard.gotoScene( "gallery", "fade", 100 )

		    elseif event.target.id == "announcement" then
		        --storyboard.gotoScene( "announcement", "fade", 100 )

		    elseif event.target.id == "editname" then
		        --storyboard.gotoScene( "editname", "fade", 100 )

		    elseif event.target.id == "contactus" then
		        storyboard.gotoScene( "contact-us", "fade", 100 )

		    elseif event.target.id == "gamecenter" then
		        storyboard.gotoScene( "game-center", "fade", 100 )

			elseif event.target.id == "help" then
			    --storyboard.gotoScene( "helf", "fade", 100 )
				
			elseif event.target.id == "privacy" then
			   -- storyboard.gotoScene( "privacy", "fade", 100 )	
		
		    end
			
		end
 
		return true
	end
		
	local id
	local imgFrmList
    local maxChapter = 7
    for i = 1, maxChapter do
		
        pointListY = pointListY + (screenH*.105)
		if i == 1 then
			imgFrmList = "img/setting/GALLERY.png"
			text = "gallery"
		elseif i == 2 then
			imgFrmList = "img/setting/ANNOUNCEMENT.png"
			text = "announcement"
		elseif i == 3 then
			imgFrmList = "img/setting/EDIT_NAME.png"
			text = "editname"
		elseif i == 4 then
			imgFrmList = "img/setting/CONTACT_US.png"
			text = "contactus"
		elseif i == 5 then
			imgFrmList = "img/setting/GAME_CENTER.png"
			text = "gamecenter"
		elseif i == 6 then
			imgFrmList = "img/setting/HELP.png"
			text = "help"
		elseif i == 7 then
			imgFrmList = "img/setting/PRIVACY_POLICY.png"
			text = "privacy"
		end
		--[[
            listCharacter[i] = display.newImageRect( imgFrmList, screenW*.7, screenH*.1)
            listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
            listCharacter[i].x, listCharacter[i].y = screenW*.15, pointListY
            listCharacter[i]:addEventListener( "tap", listener );
			listCharacter[i].numTouches = 0
		--]]
	
		
			listCharacter[i] = widget.newButton{
		    	defaultFile = imgFrmList,
		    	overFile = imgFrmList,
	            width= screenW*.7 ,
	            height= screenH*.1,
		    	onEvent = onButtonEvent
			}
		    listCharacter[i].id= text
		    listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
		    listCharacter[i].x =screenW*.15
		    listCharacter[i].y =pointListY
		
        scrollView:insert(listCharacter[i])
        --scrollView:insert(backButton)
    end

    
    return scrollView
end