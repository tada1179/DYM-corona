--
print("ticket_shop.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local json = require("json")
local sqlite3 = require "sqlite3"
local widget = require "widget"
local store = require( "store" )
local http = require("socket.http")
-----------------------------------------------
local diamond
local user_id
local scrollBar
local scrollBar_line
local scrollView
local backButton
local backBtn
local _W, _H = display.contentWidth, display.contentHeight

local ticket_img = {}
local ticket_id = {}
local ticket_amound = {}
local ticket_price = {}

local _pointNextY
local gdisplay
local numberTarget = 0
local indexDiamond = 0


--------------------------------------------
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local isSimulator = "simulator" == system.getInfo("environment")
io.output():setvbuf('no')

local validProducts, invalidProducts = {}, {}
local currentProductList = nil
local appleProductList =
{
    "1BloodyDiamond",
    "6BloodyDiamond",
    "12BloodyDiamond",
    "30BloodyDiamond",
    "60BloodyDiamond",
    "85BloodyDiamond",
}

-- Product IDs for the "google" Android Marketplace store.
local googleProductList =
{
    "dym.th.pz3kd.diamond001",
    "dym.th.pz3kd.diamond006",
    "dym.th.pz3kd.diamond012",
    "dym.th.pz3kd.diamond030",
    "dym.th.pz3kd.diamond060",
    "dym.th.pz3kd.diamond085",
}
--------------------------------------------
local function onBtnRelease(event)
    local previous_scene_name = storyboard.getPrevious()
    if event.target.id == "battle" then
        storyboard.gotoScene( "map", "fade", 100 )
        --storyboard.gotoScene( "game-scene", "fade", 100 ) --game-scene
    elseif  event.target.id == "team" then

        storyboard.gotoScene( "team_main", "fade", 100 )
    elseif  event.target.id == "shop" then

        storyboard.gotoScene( "shop_main", "fade", 100 )
    elseif  event.target.id == "gacha" then

        storyboard.gotoScene( "gacha", "fade", 100 )
    elseif  event.target.id == "commu" then

        storyboard.gotoScene( "commu_main", "fade", 100 )


    elseif event.target.id == "back" then -- back button

        storyboard.gotoScene( previous_scene_name ,"fade", 100 )
    end
    --    storyboard.gotoScene( "title_page", "fade", 100 )
    return true	-- indicates successful touch
end

local function onComplete( event )
    if "clicked" == event.action then
        print(" numberTarget = ", numberTarget)
        local i = event.index
        if 1 == i then --"Buy"
            -- Do nothing; dialog will simply dismiss
        elseif 2 == i then  -- "Cencel"
            system.openURL( "http://www.coronalabs.com" )
        end
    end
end

local function scrollViewList()
    local maxList = nil
    local URL =  "http://133.242.169.252/DYM/stones.php"
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        local dataTable = json.decode(response)
        maxList =  dataTable.ticketALL

        local m = 1
        while m <= maxList do
            ticket_id[m] = dataTable.ticket[m].ticket_id
            ticket_amound[m] = tonumber(dataTable.ticket[m].ticket_amound)
            ticket_price[m] = dataTable.ticket[m].ticket_price
            ticket_img[m] = dataTable.ticket[m].ticket_img

            validProducts[m] = {}
            validProducts[m].title = ticket_amound[m].." Diamonds"
            validProducts[m].description = ticket_amound[m].." Diamonds"
            if currentProductList then
                validProducts[m].productIdentifier = currentProductList[m]
            end
            m = m + 1
        end

    end
end

function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()

    backButton = widget.newButton{
        defaultFile="img/NextBack.png",
        overFile="img/NextBack.png",
        width= _W/10, height= _H/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton.x = _W - (_W *.845)
    backButton.y = _H - (_H*.7)
    gdisplay:insert(backButton)

    -------------------------------------------------------------------------------
    function showStoreNotAvailableWarning()
        if isSimulator then
            native.showAlert("Notice", "In-app purchases is not supported by the Corona Simulator.", { "OK" } )
        else
            native.showAlert("Notice", "In-app purchases is not supported on this device.", { "OK" } )
        end
    end

    function addProductFields()
        function newBuyButton (index)
            --	Handler for buy button
            local buttonDefault = "img/Frame_mission_clear.png"
            local buttonOver = "img/shop/buttonBuyDown.png"
            local buyThis = function ( productId ,index )
                if store.isActive == false  then
                    showStoreNotAvailableWarning()
                elseif store.canMakePurchases == false then
                    native.showAlert("Store purchases are not available, please try again later", {"OK"})
                elseif productId then
                    print("Ka-ching! Purchasing " .. tostring(productId))
                    store.purchase( {productId} )
                    indexDiamond = index
                end
            end
            function buyThis_closure ( index )
                return function ( event )
                    buyThis(validProducts[index].productIdentifier,index)
                    return true
                end
            end
            local hideDescription = function ( )
            end
            local describeThis = function ( description )

                print ("About this product:  " ..description)
                timer.performWithDelay( 2000, hideDescription)
            end
            function describeThis_closure ( index )
                print("00000......")
                return function ( event )
                    describeThis (validProducts[index].description)
                    return true
                end
            end

            local label = validProducts[index].title
            if validProducts[index].price then
                label = label .. "  " string.format("%.2f", validProducts[index].price)
            else
                -- Product price is not known. In this case we expect a localized price to be
                -- displayed via the in-app purchase system's own UI.
            end

            local myButton = widget.newButton
                {
                    width= _W * .7 , height= _H *.07,
                    defaultFile = buttonDefault,
                    overFile = buttonOver,
                    label = "",
                    labelColor =
                    {
                        default = { 1, 1, 1, 1 },
                        over = { 120/255, 53/255, 128/255, 1 },
                    },
                    font =  native.systemFontBold,
                    fontSize =  20,
                    emboss = false,
                    onPress = describeThis_closure (index),
                    onRelease = buyThis_closure (index),
                }
            myButton.anchorX = 0 	-- left
            myButton:setLabel(label)
            return myButton
        end

        function newRestoreButton ()
            local buttonDefault = "img/shop/buttonRestore.png"
            local buttonOver = "img/shop/buttonRestoreDown.png"
            local restore = function ( product )

                if store.isActive then
                    print ("Restoring " )
                    store.restore()
                else
                    print("111111111")
                    showStoreNotAvailableWarning()
                end
            end
            local hideDescription = function ( )

            end
            local describeThis = function ()

                print ("Test restore feature")
                timer.performWithDelay( 2000, hideDescription)
            end
            local label = "Test restore"
            local myButton = widget.newButton
                {
                    defaultFile = buttonDefault,
                    overFile = buttonOver,
                    label = "",
                    labelColor =
                    {
                        default = { 2/255, 0, 127/255 },
                        over = { 2/255, 0, 127/255 }
                    },
                    font =  native.systemFontBold,
                    fontSize =  20,
                    emboss = false,
                    onPress = describeThis,
                    onRelease = restore,
                }

            myButton.anchorX = 0
            myButton.alpha = 0
            myButton:setLabel(label)
            gdisplay:insert(myButton)
            return myButton
        end

        print ("Loading product list")
        if (not validProducts) or (#validProducts <= 0) then

            local noProductsLabel = display.newText(
                "Sorry!\nIn-App purchases is not supported on this device.",
                display.contentWidth / 2, display.contentHeight / 3,
                display.contentWidth / 2, 0,
                native.systemFont, 16)
            noProductsLabel:setFillColor(0, 0, 0)
            noProductsLabel.anchorX = 0
            noProductsLabel.anchorY = 0
            print("222222")
            showStoreNotAvailableWarning()
        else

            print("Product list loaded")
            print("Country: " .. tostring(system.getPreference("locale", "country")))

            local buttonSpacing = 5
            local pointYY = _H*.4
            local pointTxTY = _H*.375
            print( "Found " .. #validProducts .. " valid items ")

            for i=1, #validProducts do
                print("Item " .. tostring(i) .. "  :11: " .. tostring(validProducts[i].productIdentifier)
                        .. " (" .. tostring(validProducts[i].price) .. ")")
                print(validProducts[i].title .. ",  ".. validProducts[i].description)

                local myButton = newBuyButton(i)
                myButton.x = _W*.15
                myButton.y = pointYY
                gdisplay:insert(myButton)

                local imgButton = display.newImageRect(ticket_img[i],_W*.1,_H*.05)
                imgButton.x = _W*.21
                imgButton.y = pointYY
                gdisplay:insert(imgButton)

                local TextButton = display.newText(ticket_price[i],_W*.8 ,pointTxTY ,native.systemFontBold,20)
                TextButton:setFillColor(0,1,0)
                gdisplay:insert(TextButton)

                pointYY = pointYY +(_H*.08)
                pointTxTY = pointTxTY +(_H*.08)
            end

            if store.isActive or isSimulator then
                local myButton = newRestoreButton()
                myButton.x = 0
                myButton.y = display.contentHeight - myButton.height / 2 - buttonSpacing
            end

            for i=1, #invalidProducts do
                native.showAlert( "Item " .. tostring(invalidProducts[i]) .. " is invalid.", {"OK"} )
                print("Item " .. tostring(invalidProducts[i]) .. " is invalid.")
            end
        end
    end

    function loadProductsCallback( event )
        -- Debug info for testing
        print("In loadProductsCallback()")
        print("event, event.name", event, event.name)
        print(event.products)
        print("#event.products", #event.products)
        io.flush()  -- remove for production

        validProducts = event.products
        invalidProducts = event.invalidProducts
        addProductFields()
    end

    function transactionCallback( event )
        local infoString

        print("transactionCallback: Received event " .. tostring(event.name))
        print("state: " .. tostring(event.transaction.state))
        print("errorType: " .. tostring(event.transaction.errorType))
        print("errorString: " .. tostring(event.transaction.errorString))

        if event.transaction.state == "purchased" then
            infoString = "Transaction successful!"
            print(infoString)
            print("receipt: " .. tostring(event.transaction.receipt))
            print("signature: " .. tostring(event.transaction.signature))

            --**--
            diamond =  (ticket_amound[indexDiamond])
            local URL =  "http://133.242.169.252/DYM/update_diamond.php?user_id="..user_id.."&diamond="..diamond
            local response = http.request(URL)

            local path = system.pathForFile("datas.db", system.DocumentsDirectory)
            db = sqlite3.open( path )
            local tablefill ="UPDATE user SET user_diamond = '"..diamond.."' WHERE user_id = '"..user_id.."';"
            db:exec( tablefill )

            require("menu").update_user()
            --**--

        elseif  event.transaction.state == "restored" then

            infoString = "Restoring transaction:" ..
                    "\n   Original ID: " .. tostring(event.transaction.originalTransactionIdentifier) ..
                    "\n   Original date: " .. tostring(event.transaction.originalDate)
            print(infoString)
            print("productIdentifier: " .. tostring(event.transaction.productIdentifier))
            print("receipt: " .. tostring(event.transaction.receipt))
            print("transactionIdentifier: " .. tostring(event.transaction.transactionIdentifier))
            print("date: " .. tostring(event.transaction.date))
            print("originalReceipt: " .. tostring(event.transaction.originalReceipt))

        elseif  event.transaction.state == "refunded" then
            infoString = "A previously purchased product was refunded by the store."
            print(infoString .. "\nFor product ID = " .. tostring(event.transaction.productIdentifier))

        elseif event.transaction.state == "cancelled" then
            infoString = "Transaction cancelled by user."
            print(infoString)

        elseif event.transaction.state == "failed" then
            infoString = "Transaction failed, type: " ..
                    tostring(event.transaction.errorType) .. " " .. tostring(event.transaction.errorString)
            print(infoString)

        else
            infoString = "Unknown event"
            print(infoString)
        end

        store.finishTransaction( event.transaction )

    end

    function setupMyStore(event)
        if store.isActive or isSimulator then
            if store.canLoadProducts then
                store.loadProducts( currentProductList, loadProductsCallback )
                print ("After store.loadProducts, waiting for callback")
            else
                print ("-****** store.loadProducts, waiting for callback")
                scrollViewList()
                addProductFields()
            end
        else
            -- Don't load any products. In-app purchases is not supported on this device.
            addProductFields()
        end
    end

    if store.availableStores.apple then
        currentProductList = appleProductList
        store.init("apple", transactionCallback)
        print("Using Apple's in-app purchase system.")

    elseif store.availableStores.google then
        currentProductList = googleProductList
        store.init("google", transactionCallback)
        print("Using Google's Android In-App Billing system.")

    else
        print("In-app purchases is not supported on this system/device.")
    end

    timer.performWithDelay (1000, setupMyStore)

    collectgarbage()
    ------------------------------------------------------------
    group:insert(gdisplay)


    ------------- other scene ---------------
    storyboard.removeAll ()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeAll()
    storyboard.removeAll ()
end

function scene:exitScene( event )
    local group = self.view
    storyboard.purgeAll()
    storyboard.removeAll ()
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

