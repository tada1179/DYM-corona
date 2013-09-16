module(..., package.seeall)
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local alertMassage = require("alertMassage")
local scene = storyboard.newScene()
local widget = require "widget"
local http = require("socket.http")
local json = require("json")
local alertMSN = require("alertMassage")
local screenW = display.contentWidth
local screenH = display.contentHeight
-----------------------------------------------
local typeFont = native.systemFontBold
local sizetext = 22
local sizetextName = 30
local pageTeam,pageItem

-----------------------------------------------
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
    return true
end
function character_powerUP(id,USERID,gplayView)
    local menu_barLight = require("menu_barLight")
    local LinkURL = "http://localhost/DYM/Onecharacter.php"
    print("character_powerUP ID:")
    local character_id =  id
    local USER_id =  USERID
    local groupView = display.newGroup()
    local frame = alertMSN.loadFramElement()

    local characterItem = {}
    local characterImg = http.request(LinkURL.."?character="..id.."&user_id="..USER_id)

    if characterImg == nil then
        print("No Dice")
    else
        local characterSelect  = json.decode(characterImg)
        characterItem[1] = {}
        characterItem[1].character_type = "smach"
        characterItem[1].character_name = characterSelect.chracter[1].charac_name
        characterItem[1].character_DEF = characterSelect.chracter[1].charac_def
        characterItem[1].character_ATK = characterSelect.chracter[1].charac_atk
        characterItem[1].character_HP = characterSelect.chracter[1].charac_hp
        characterItem[1].character_LV = tonumber(characterSelect.chracter[1].charac_lv)
        characterItem[1].ImageCharacter = characterSelect.chracter[1].charac_img_mini
        characterItem[1].FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
    end

    local options =
    {
        effect = "crossFade",
        time = 100,
        params = {
            character_id =character_id ,
            user_id = USER_id
        }
    }
    local myRectangle
    local image_text = "img/text/CHARACTER.png"
    local image_anyfun = "img/background/character/Any_functions.png"
    local image_viewpro = "img/background/character/View_profile.png"
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_background = "img/background/background_1.png"
    local image_LVHP = "img/background/character/HP,LV,ATC,DEF_character.png"

    local function onTouchGameoverFileScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)

        myRectangle:removeEventListener( "touch", myRectangle )
        groupView.alpha = 0

        display.remove(groupView)
        groupView =nil

        if event.target.id == "imageprofile" then
            gplayView:removeSelf()
            gplayView = nil
            storyboard.gotoScene( "characterprofile" ,options)

        elseif event.target.id == "anyfunction" then
            gplayView:removeSelf()
            gplayView = nil
            storyboard.gotoScene( "power_up_main" ,options )

        elseif event.target.id == "viewprofile" then
            gplayView:removeSelf()
            gplayView = nil
            storyboard.gotoScene( "characterprofile" ,options )

        elseif event.target.id == "cancel" then

        end
        return true
    end

    myRectangle = display.newRect(0, 0, screenW, screenH)
    myRectangle.strokeWidth = 3
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)

    myRectangle.touch = onTouchGameoverFileScreen
    myRectangle:addEventListener( "touch", myRectangle )
    groupView:insert(myRectangle)

    --button image profile
    local imageprofile = widget.newButton{
        defaultFile= characterItem[1].ImageCharacter,
        overFile= characterItem[1].ImageCharacter,
        width=screenW/4, height=screenH/5.3,
--        onRelease = onBtncharacter	-- event listener function
    }
    imageprofile.id = "id"..id
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x = screenW/2.65
    imageprofile.y = screenH/2.24
    groupView:insert(imageprofile)

    local framImage = display.newImageRect(frame[characterItem[1].FrameCharacter] ,screenW*.26, screenH*.2)
    framImage:setReferencePoint( display.TopLeftReferencePoint )
    framImage.x = screenW*.25
    framImage.y = screenH*.35
    groupView:insert(framImage)

    local textLVHP = display.newImageRect(image_LVHP ,screenW*.07, screenH*.1)
    textLVHP:setReferencePoint( display.TopLeftReferencePoint )
    textLVHP.x = screenW*.55
    textLVHP.y = screenH*.42
    groupView:insert(textLVHP)

    local namelenght = string.len(characterItem[1].character_name)
    local pointtextLVHP = screenW*.7

    local NameText = display.newText(characterItem[1].character_name, screenW*.55, screenH *.35,typeFont, sizetextName)
    NameText:setTextColor(0, 255, 255)
    groupView:insert(NameText)

    local SmachText = display.newText(characterItem[1].character_type.."smach", screenW*.55, screenH *.38,typeFont, sizetextName)
    SmachText:setTextColor(200, 0, 200)
    groupView:insert(SmachText)

    local LVText = display.newText(characterItem[1].character_LV, pointtextLVHP, screenH *.412,typeFont, sizetext)
    LVText:setTextColor(0, 255, 255)
    groupView:insert(LVText)

    local HPText = display.newText(characterItem[1].character_HP, pointtextLVHP, screenH *.44,typeFont, sizetext)
    HPText:setTextColor(0, 255, 255)
    groupView:insert(HPText)

    local ATKText = display.newText(characterItem[1].character_ATK, pointtextLVHP, screenH *.468,typeFont, sizetext)
    ATKText:setTextColor(0, 255, 255)
    groupView:insert(ATKText)

    local DEFText = display.newText(characterItem[1].character_DEF, pointtextLVHP, screenH *.496,typeFont, sizetext)
    DEFText:setTextColor(0, 255, 255)
    groupView:insert(DEFText)

    --button cancel profile
    local btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.23, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =display.contentWidth /2
    btn_cancel.y = display.contentHeight *.78
    groupView:insert(btn_cancel)

    --button anyfunction
    local btn_anyfunction = widget.newButton{
        defaultFile= image_anyfun,
        overFile= image_anyfun,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_anyfunction.id="anyfunction"
    btn_anyfunction:setReferencePoint( display.CenterReferencePoint )
    btn_anyfunction.x =screenW *.5
    btn_anyfunction.y = screenH *.6
    groupView:insert(btn_anyfunction)

    --button btn_view
    local btn_view = widget.newButton{
        defaultFile= image_viewpro,
        overFile= image_viewpro,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_view.id="viewprofile"
    btn_view:setReferencePoint( display.CenterReferencePoint )
    btn_view.x = screenW *.5
    btn_view.y = screenH *.69
    groupView:insert(btn_view)

    menu_barLight.checkMemory()
    return groupView
end

function character_unitBox(id,holddteam_no,team_id,USERID)
    print("character_unitBox")
    local LinkURL = "http://localhost/DYM/Onecharacter.php"
    local characterItem = {}
    local character_id =  id
    local Cholddteam_no =  holddteam_no
    local Cteam_id =  team_id
    local USER_id =  USERID
    local numCoin = nil
    local characterID =  LinkURL.."?character="..id.."&user_id="..USER_id
    local characterImg = http.request(characterID)
    local frame = alertMSN.loadFramElement()

    if characterImg == nil then
        print("No Dice")
    else
        local characterSelect  = json.decode(characterImg)
        characterItem[1] = {}
        characterItem[1].character_type = "smach"
        characterItem[1].character_name = characterSelect.chracter[1].charac_name
        characterItem[1].character_DEF = characterSelect.chracter[1].charac_def
        characterItem[1].character_ATK = characterSelect.chracter[1].charac_atk
        characterItem[1].character_HP = characterSelect.chracter[1].charac_hp
        characterItem[1].character_LV = tonumber(characterSelect.chracter[1].charac_lv)
        characterItem[1].ImageCharacter = characterSelect.chracter[1].charac_img_mini
        characterItem[1].FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
        numCoin = (characterItem[1].character_LV*100)
    end

    local options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id =character_id ,
            holddteam_no =  Cholddteam_no  ,
            team_id =  Cteam_id ,
            user_id = USER_id
        }
    }
    local maxfram = 5
    local myRectangle



    local image_text = "img/text/CHARACTER.png"
    local image_anyfun = "img/background/unit/button/DISCHARGE.png"
    local image_powerup = "img/background/unit/button/POWER_UP.png"
    local image_viewpro = "img/background/character/View_profile.png"
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_background = "img/background/background_1.png"
    local image_LVHP = "img/background/character/HP,LV,ATC,DEF_character.png"

    local groupView = display.newGroup()
    local function onTouchGameoverFileScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        myRectangle:removeEventListener( "touch", myRectangle )

        groupView.alpha = 0
        display.remove(groupView)
        groupView = nil

        if event.target.id == "imageprofile" then
            storyboard.gotoScene( "characterprofile" ,"flipFadeOutIn", 200 )

        elseif event.target.id == "DISCHARGE" then
            local  team_id = options.params.team_id
            local  charac_id = {}
            charac_id[1] = options.params.character_id
            local  holdteam_no = options.params.holddteam_no
            local  USER_id = options.params.user_id


            alertMassage.confrimDischarge(1,charac_id,numCoin,USER_id,"unit_box")
            --(countCHNo,characterAll,numCoin,user_id)

        elseif event.target.id == "viewprofile" then
            storyboard.gotoScene( "characterprofile" ,options )

        elseif event.target.id == "cancel" then
            storyboard.gotoScene( "unit_box" ,"fade", 100 )

        elseif event.target.id == "powerup" then
            local optparams = {
                params = {
                    character_id = options.params.character_id,
                    user_id = USER_id
                }
            }
            storyboard.gotoScene( "power_up_main" ,optparams)
        end

        return true

    end

    myRectangle = display.newRect(0, 0, screenW, screenH)
    myRectangle.strokeWidth = 3
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)

    myRectangle.touch = onTouchGameoverFileScreen
    myRectangle:addEventListener( "touch", myRectangle )
    --    groupENDView:insert(myRectangle)
    groupView:insert(myRectangle)

    --button image profile
    local imageprofile = widget.newButton{
        defaultFile= characterItem[1].ImageCharacter,
        overFile= characterItem[1].ImageCharacter,
        width=screenW/4, height=screenH/5.3,
       -- onRelease = onBtncharacter	-- event listener function
    }
    imageprofile.id="id"..id
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x = screenW/2.65
    imageprofile.y = screenH/2.24
    groupView:insert(imageprofile)


    local framImage = display.newImageRect(frame[characterItem[1].FrameCharacter] ,screenW*.26, screenH*.2)
    framImage:setReferencePoint( display.TopLeftReferencePoint )
    framImage.x = screenW*.25
    framImage.y = screenH*.35
    groupView:insert(framImage)

    local textLVHP = display.newImageRect(image_LVHP ,screenW*.07, screenH*.1)
    textLVHP:setReferencePoint( display.TopLeftReferencePoint )
    textLVHP.x = screenW*.55
    textLVHP.y = screenH*.42
    groupView:insert(textLVHP)

    local namelenght = string.len(characterItem[1].character_name)
    --local pointName =  (screenW*.6)-((namelenght*sizetextName)/4)
    local pointtextLVHP = screenW*.7

    local NameText = display.newText(characterItem[1].character_name, screenW*.55, screenH *.35,typeFont, sizetextName)
    NameText:setTextColor(0, 255, 255)
    groupView:insert(NameText)

    local SmachText = display.newText(characterItem[1].character_type.."smach", screenW*.55, screenH *.38,typeFont, sizetextName)
    SmachText:setTextColor(200, 0, 200)
    groupView:insert(SmachText)

    local LVText = display.newText(characterItem[1].character_LV, pointtextLVHP, screenH *.412,typeFont, sizetext)
    LVText:setTextColor(0, 255, 255)
    groupView:insert(LVText)

    local HPText = display.newText(characterItem[1].character_HP, pointtextLVHP, screenH *.44,typeFont, sizetext)
    HPText:setTextColor(0, 255, 255)
    groupView:insert(HPText)

    local ATKText = display.newText(characterItem[1].character_ATK, pointtextLVHP, screenH *.468,typeFont, sizetext)
    ATKText:setTextColor(0, 255, 255)
    groupView:insert(ATKText)

    local DEFText = display.newText(characterItem[1].character_DEF, pointtextLVHP, screenH *.496,typeFont, sizetext)
    DEFText:setTextColor(0, 255, 255)
    groupView:insert(DEFText)

    --button cancel profile
    local btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.23, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =display.contentWidth /2
    btn_cancel.y = screenH *.87
    groupView:insert(btn_cancel)

    --button DISCHARGE
    local btn_anyfunction = widget.newButton{
        defaultFile= image_anyfun,
        overFile= image_anyfun,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_anyfunction.id="DISCHARGE"
    btn_anyfunction:setReferencePoint( display.CenterReferencePoint )
    btn_anyfunction.x =screenW *.5
    btn_anyfunction.y = screenH *.69
    groupView:insert(btn_anyfunction)

    --button btn_view
    local btn_view = widget.newButton{
        defaultFile= image_viewpro,
        overFile= image_viewpro,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_view.id="viewprofile"
    btn_view:setReferencePoint( display.CenterReferencePoint )
    btn_view.x = screenW *.5
    btn_view.y = screenH *.6
    groupView:insert(btn_view)
    -- groupView:insert(groupView)

    --button btn_view
    local btn_power = widget.newButton{
        defaultFile= image_powerup,
        overFile= image_powerup,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_power.id="powerup"
    btn_power:setReferencePoint( display.CenterReferencePoint )
    btn_power.x = screenW *.5
    btn_power.y = screenH *.78
    groupView:insert(btn_power)

    groupView.touch = onTouchGameoverFileScreen
    groupView:addEventListener( "touch", groupView )
    return true
end
function character(id,holddteam_no,team_id,USERID)
    print("fn character")
    local LinkURL = "http://localhost/DYM/Onecharacter.php"

    local character_id =  id
    local Cholddteam_no =  holddteam_no
    local Cteam_id =  team_id
    local USER_id =  USERID

    local characterID =  LinkURL.."?character="..id.."&user_id="..USER_id
    local characterImg = http.request(characterID)
    local frame = alertMSN.loadFramElement()
    local  characterItem = {}
    if characterImg == nil then
        print("No Dice")
    else
        local characterSelect  = json.decode(characterImg)
        characterItem[1] = {}
        characterItem[1].character_type = "smach"
        characterItem[1].character_name = characterSelect.chracter[1].charac_name
        characterItem[1].character_DEF = characterSelect.chracter[1].charac_def
        characterItem[1].character_ATK = characterSelect.chracter[1].charac_atk
        characterItem[1].character_HP = characterSelect.chracter[1].charac_hp
        characterItem[1].character_LV = characterSelect.chracter[1].charac_lv
        characterItem[1].ImageCharacter = characterSelect.chracter[1].charac_img_mini
        characterItem[1].FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
    end

    local options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id =character_id ,
            holddteam_no =  Cholddteam_no  ,
            team_id =  Cteam_id ,
            user_id = USER_id
        }
    }
    local maxfram = 5
    local image_text = "img/text/CHARACTER.png"
    local image_anyfun = "img/background/character/Any_functions.png"
    local image_viewpro = "img/background/character/View_profile.png"
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_background = "img/background/background_1.png"
    local image_LVHP = "img/background/character/HP,LV,ATC,DEF_character.png"

    local groupView = display.newGroup()
    local function onTouchGameoverFileScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        groupView:removeEventListener( "touch", groupView )
        display.remove(groupView)
        groupView = nil

        if event.target.id == "imageprofile" then
            storyboard.gotoScene( "characterprofile" ,"flipFadeOutIn", 200 )

        elseif event.target.id == "anyfunction" then
            local  team_id = options.params.team_id
            local  charac_id = options.params.character_id
            local  holdteam_no = options.params.holddteam_no
            local  USER_id = options.params.user_id

            local ulrInsert = "http://localhost/dym/insertTeam.php"
            local characterUP =  ulrInsert.."?team_id="..team_id.."&charac_id="..charac_id.."&holdteam_no="..holdteam_no.."&user_id="..USER_id
            local characterUPImg = http.request(characterUP)

            storyboard.gotoScene( "pageWith",options )
            storyboard.removeScene( "team_main" )
            storyboard.gotoScene( "team_main",options )
            storyboard.removeScene( "pageWith" )

        elseif event.target.id == "viewprofile" then
            storyboard.gotoScene( "characterprofile" ,options )

        elseif event.target.id == "cancel" then
           --storyboard.gotoScene( "team_item" ,"fade", 100 )
        end

       return true

    end

    local myRectangle = display.newRect(0, 0, screenW, screenH)
    myRectangle.strokeWidth = 3
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    --button image profile
    local imageprofile = widget.newButton{
        defaultFile= characterItem[1].ImageCharacter,
        overFile= characterItem[1].ImageCharacter,
        width=screenW/4, height=screenH/5.3,
        onRelease = onBtncharacter	-- event listener function
    }
    imageprofile.id="id"..id
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x = screenW/2.65
    imageprofile.y = screenH/2.24
    groupView:insert(imageprofile)


    local framImage = display.newImageRect(frame[characterItem[1].FrameCharacter] ,screenW*.26, screenH*.2)
    framImage:setReferencePoint( display.TopLeftReferencePoint )
    framImage.x = screenW*.25
    framImage.y = screenH*.35
    groupView:insert(framImage)

    local textLVHP = display.newImageRect(image_LVHP ,screenW*.07, screenH*.1)
    textLVHP:setReferencePoint( display.TopLeftReferencePoint )
    textLVHP.x = screenW*.55
    textLVHP.y = screenH*.42
    groupView:insert(textLVHP)

    local namelenght = string.len(characterItem[1].character_name)
    --local pointName =  (screenW*.6)-((namelenght*sizetextName)/4)
    local pointtextLVHP = screenW*.7

    local NameText = display.newText(characterItem[1].character_name, screenW*.55, screenH *.35,typeFont, sizetextName)
    NameText:setTextColor(0, 255, 255)
    groupView:insert(NameText)

    local SmachText = display.newText(characterItem[1].character_type.."smach", screenW*.55, screenH *.38,typeFont, sizetextName)
    SmachText:setTextColor(200, 0, 200)
    groupView:insert(SmachText)

    local LVText = display.newText(characterItem[1].character_LV, pointtextLVHP, screenH *.412,typeFont, sizetext)
    LVText:setTextColor(0, 255, 255)
    groupView:insert(LVText)

    local HPText = display.newText(characterItem[1].character_HP, pointtextLVHP, screenH *.44,typeFont, sizetext)
    HPText:setTextColor(0, 255, 255)
    groupView:insert(HPText)

    local ATKText = display.newText(characterItem[1].character_ATK, pointtextLVHP, screenH *.468,typeFont, sizetext)
    ATKText:setTextColor(0, 255, 255)
    groupView:insert(ATKText)

    local DEFText = display.newText(characterItem[1].character_DEF, pointtextLVHP, screenH *.496,typeFont, sizetext)
    DEFText:setTextColor(0, 255, 255)
    groupView:insert(DEFText)

    --button cancel profile
    local btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.23, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =display.contentWidth /2
    btn_cancel.y = display.contentHeight *.78
    groupView:insert(btn_cancel)

    --button anyfunction
    local btn_anyfunction = widget.newButton{
        defaultFile= image_anyfun,
        overFile= image_anyfun,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_anyfunction.id="anyfunction"
    btn_anyfunction:setReferencePoint( display.CenterReferencePoint )
    btn_anyfunction.x =screenW *.5
    btn_anyfunction.y = screenH *.6
    groupView:insert(btn_anyfunction)

    --button btn_view
    local btn_view = widget.newButton{
        defaultFile= image_viewpro,
        overFile= image_viewpro,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_view.id="viewprofile"
    btn_view:setReferencePoint( display.CenterReferencePoint )
    btn_view.x = screenW *.5
    btn_view.y = screenH *.69
    groupView:insert(btn_view)
   -- groupView:insert(groupView)

    groupView.touch = onTouchGameoverFileScreen
    groupView:addEventListener( "touch", groupView )
    checkMemory()
    return true
end

function startBattle(team_no,item_no)
    pageTeam = team_no
    pageItem = item_no

end

function getTeamgetItem()
    local user_id =  require("menu_barLight").user_id()
    local option = {
        params = {
            team_no = pageTeam ,
            item_no = pageItem ,
            user_id =  user_id
        }
    }
    return option
end


function characterFriend_remove(Recharacter,Refriendid,ReUSERID,Nofriend_id)
    print("FN characterFriend_remove")
    local LinkURLCharac = "http://localhost/DYM/character.php"

    local character_id =  Recharacter
    local friend_id =  Refriendid
    local USER_id =  ReUSERID
    local frame = alertMSN.loadFramElement()
    local characterID =  LinkURLCharac.."?character="..character_id.."&user_id="..friend_id
    local characterImg = http.request(characterID)
    local characterItem = {}
    if characterImg == nil then
        print("No Dice")
    else
        local characterSelect  = json.decode(characterImg)
        characterItem[1] = {}
        characterItem[1].character_type = "smach"

        characterItem[1].Uuser_id = characterSelect.chracter[1].user_id
        characterItem[1].user_Name = characterSelect.chracter[1].user_Name
        characterItem[1].user_LV = characterSelect.chracter[1].user_LV
        characterItem[1].character_name = characterSelect.chracter[1].charac_name

        characterItem[1].character_DEF = characterSelect.chracter[1].charac_def
        characterItem[1].character_ATK = characterSelect.chracter[1].charac_atk
        characterItem[1].character_HP = characterSelect.chracter[1].charac_hp
        characterItem[1].character_LV = characterSelect.chracter[1].charac_lv
        characterItem[1].ImageCharacter = characterSelect.chracter[1].charac_img_mini
        characterItem[1].FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
    end

    local options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id =character_id ,
            friend_id = friend_id,
            user_id = USER_id,
            Nofriend_id = Nofriend_id,
        }
    }
    local myRectangle

    local image_text = "img/text/CHARACTER.png"
    local image_REMOVE = "img/background/button/REMOVE_FRIEND.png"
    local image_viewpro = "img/background/character/View_profile.png"
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_background = "img/background/background_1.png"
    local image_LVHP = "img/background/character/HP,LV,ATC,DEF_character.png"

    local groupView = display.newGroup()
    local function onTouchGameoverFileScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        display.remove(groupView)
        groupView = nil

        if event.target.id == "imageprofile" then

            storyboard.gotoScene( "characterprofile" ,options )

        elseif event.target.id == "Remove" then
            local respont = 2  -- remove friend
            local linkremove = "http://localhost/DYM/accepFriend.php"
            local numberHold_character =  linkremove.."?user_id="..USER_id.."&friend="..friend_id.."&respont="..respont
            local numberHold = http.request(numberHold_character)

            storyboard.gotoScene( "pageWith",options )
            storyboard.removeScene( "friend_list" )
            storyboard.gotoScene( "friend_list",options )
            storyboard.removeScene( "pageWith" )

        elseif event.target.id == "viewprofile" then
            local viewoption =
            {
                effect = "flipFadeOutIn",
                time = 100,
                params = {
                    character_id =character_id ,
                    friend_id = friend_id,
                    user_id = USER_id,
                    Nofriend_id = Nofriend_id,
                }
            }
            storyboard.gotoScene( "characterprofile_friend",viewoption )

        elseif event.target.id == "cancel" then
--            print("event.target.id =",event.target.id)
           -- storyboard.gotoScene( "friend_list" ,"fade", 100 )
        end

    end

    myRectangle = display.newRect(0, 0, screenW, screenH)
    myRectangle.strokeWidth = 3
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)

    myRectangle.touch = onTouchGameoverFileScreen
    myRectangle:addEventListener( "touch", myRectangle )
    groupView:insert(myRectangle)

    --button image profile
    local imageprofile = widget.newButton{
        defaultFile= characterItem[1].ImageCharacter,
        overFile= characterItem[1].ImageCharacter,
        width=screenW/4, height=screenH/5.3,
        onRelease = onBtncharacter	-- event listener function
    }
    imageprofile.id="id"..Recharacter
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x = screenW/2.65
    imageprofile.y = screenH/2.24
    groupView:insert(imageprofile)


    local framImage = display.newImageRect(frame[characterItem[1].FrameCharacter] ,screenW*.26, screenH*.2)
    framImage:setReferencePoint( display.TopLeftReferencePoint )
    framImage.x = screenW*.25
    framImage.y = screenH*.35
    groupView:insert(framImage)

    local textLVHP = display.newImageRect(image_LVHP ,screenW*.07, screenH*.1)
    textLVHP:setReferencePoint( display.TopLeftReferencePoint )
    textLVHP.x = screenW*.55
    textLVHP.y = screenH*.42
    groupView:insert(textLVHP)

    local namelenght = string.len(characterItem[1].character_name)
    --local pointName =  (screenW*.6)-((namelenght*sizetextName)/4)
    local pointtextLVHP = screenW*.7

    -------*****user
    local txtLV_user = display.newText("Lv."..characterItem[1].user_LV, screenW*.2, screenH *.25,typeFont, sizetextName)
    txtLV_user:setTextColor(100, 255, 255)
    groupView:insert(txtLV_user)


    local txtNameuser = display.newText(characterItem[1].user_Name, screenW*.2, screenH *.2,typeFont, sizetextName)
    txtNameuser:setTextColor(200, 200, 200)
    groupView:insert(txtNameuser)

    local txtID_user = display.newText("ID:[0000000"..characterItem[1].Uuser_id.."]", screenW*.55, screenH *.25,typeFont, sizetextName)
    txtID_user:setTextColor(0, 255, 255)
    groupView:insert(txtID_user)
    -------*****user

    local NameText = display.newText(characterItem[1].character_name, screenW*.55, screenH *.35,typeFont, sizetextName)
    NameText:setTextColor(0, 255, 255)
    groupView:insert(NameText)

    local SmachText = display.newText(characterItem[1].character_type.."smach", screenW*.55, screenH *.38,typeFont, sizetextName)
    SmachText:setTextColor(200, 0, 200)
    groupView:insert(SmachText)

    local LVText = display.newText(characterItem[1].character_LV, pointtextLVHP, screenH *.412,typeFont, sizetext)
    LVText:setTextColor(0, 255, 255)
    groupView:insert(LVText)

    local HPText = display.newText(characterItem[1].character_HP, pointtextLVHP, screenH *.44,typeFont, sizetext)
    HPText:setTextColor(0, 255, 255)
    groupView:insert(HPText)

    local ATKText = display.newText(characterItem[1].character_ATK, pointtextLVHP, screenH *.468,typeFont, sizetext)
    ATKText:setTextColor(0, 255, 255)
    groupView:insert(ATKText)

    local DEFText = display.newText(characterItem[1].character_DEF, pointtextLVHP, screenH *.496,typeFont, sizetext)
    DEFText:setTextColor(0, 255, 255)
    groupView:insert(DEFText)

    --button cancel profile
    local btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.23, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =display.contentWidth /2
    btn_cancel.y = display.contentHeight *.78
    groupView:insert(btn_cancel)

    --button anyfunction
    local btn_REMOVE = widget.newButton{
        defaultFile= image_REMOVE,
        overFile= image_REMOVE,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_REMOVE.id="Remove"
    btn_REMOVE:setReferencePoint( display.CenterReferencePoint )
    btn_REMOVE.x =screenW *.5
    btn_REMOVE.y = screenH *.69
    groupView:insert(btn_REMOVE)

    --button btn_view
    local btn_view = widget.newButton{
        defaultFile= image_viewpro,
        overFile= image_viewpro,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_view.id="viewprofile"
    btn_view:setReferencePoint( display.CenterReferencePoint )
    btn_view.x = screenW *.5
    btn_view.y = screenH *.6
    groupView:insert(btn_view)
    -- groupView:insert(groupView)

    groupView.touch = onTouchGameoverFileScreen
    groupView:addEventListener( "touch", groupView )
    checkMemory()
    return true
end

