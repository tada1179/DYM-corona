
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "storyboard" module
local storyboard = require "storyboard"
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
local options =
{
    effect = "fade",
    time = 100,
    params = {
        var1 = "custom",
        myVar = "another"
    }
}
storyboard.purgeScene( "unit_main" )
storyboard.purgeScene( "discharge_main" )
storyboard.purgeScene( "map_substate" )
storyboard.purgeScene( "chapter_select" )
storyboard.purgeScene( "characterAll" )
storyboard.purgeScene( "ticket_shop" )
storyboard.purgeScene( "item_setting" )
storyboard.purgeScene( "misstion" )
storyboard.purgeScene( "guest" )
storyboard.purgeScene( "team_main" )
storyboard.purgeScene( "unit_box" )
storyboard.purgeScene( "commu_main" )
storyboard.purgeScene( "character" )
storyboard.purgeScene( "request_list" )
storyboard.purgeScene( "friend_list" )
storyboard.purgeScene( "mission_clear" )
storyboard.purgeScene( "unit_main" )

storyboard.removeAll ()
storyboard.purgeAll()
-- load menu screen
--local testMemo = require ("testMemoryleck")
--testMemo.new()
--storyboard.gotoScene( "Firstpage")
--storyboard.gotoScene( "discharge_main")
storyboard.gotoScene( "game-scene")
--storyboard.gotoScene( "title_page")
--storyboard.gotoScene( "map")
--storyboard.gotoScene( "map_substate")
--storyboard.gotoScene( "chapter_select")
--storyboard.gotoScene( "misstion")
--storyboard.gotoScene( "ticket_shop")
--storyboard.gotoScene( "characterAll")

--storyboard.gotoScene( "team_item")
--storyboard.gotoScene( "unit_box")
--storyboard.gotoScene( "unit_main")
--storyboard.gotoScene( "map")
--storyboard.gotoScene( "characterAll")
--storyboard.gotoScene( "guest")
--storyboard.gotoScene( "team_main")
--storyboard.gotoScene( "item_setting")
--storyboard.gotoScene( "team_select")
--storyboard.gotoScene( "map")
--storyboard.gotoScene( "commu_main")
--storyboard.gotoScene( "friend_list")
--storyboard.gotoScene( "character")

--storyboard.gotoScene( "request_list")
--storyboard.gotoScene( "shop_money")
--storyboard.gotoScene( "gacha")
--storyboard.gotoScene( "upgrade_main")
--storyboard.gotoScene( "power_up_main")
--storyboard.gotoScene( "battle_item")
--storyboard.gotoScene( "sell_item")
--storyboard.gotoScene( "team_select")
--storyboard.gotoScene( "shop_main")
--storyboard.gotoScene( "mission_clear")
--storyboard.gotoScene( "misstion")
--storyboard.gotoScene( "characterprofile")
--storyboard.gotoScene( "character_show")
--storyboard.gotoScene( "player_list")
--storyboard.gotoScene( "headTitle")
--storyboard.gotoScene( "menu_barLight")
--storyboard.gotoScene( "databaseConnect")
--storyboard.gotoScene( "team_item")
--storyboard.gotoScene( "includeFunction")
--storyboard.gotoScene( "discharge_main")
--storyboard.gotoScene( "characterAll")


