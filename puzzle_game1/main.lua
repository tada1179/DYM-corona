--require "CiderDebugger";
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- ##ref
-- Scene frist page tosee
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

local options =
{
    effect = "fade",
    time = 100,
    params = {
        var1 = "custom",
        myVar = "another"
    }
}

-- load menu screen
--storyboard.gotoScene( "title_page")
--storyboard.gotoScene( "map")
--storyboard.gotoScene( "map_substate")

--storyboard.gotoScene( "team_item")
--storyboard.gotoScene( "unit_main")
--storyboard.gotoScene( "map")
--storyboard.gotoScene( "guest")
--storyboard.gotoScene( "team_main")
--storyboard.gotoScene( "item_setting")
--storyboard.gotoScene( "map")
--storyboard.gotoScene( "commu_main")
--storyboard.gotoScene( "friend_list")
--storyboard.gotoScene( "character")



--storyboard.gotoScene( "shop_money")
--storyboard.gotoScene( "gacha")
--storyboard.gotoScene( "upgrade_main")
--storyboard.gotoScene( "power_up_main")
--storyboard.gotoScene( "battle_item")
--storyboard.gotoScene( "sell_item")
--storyboard.gotoScene( "team_select")
--storyboard.gotoScene( "shop_main")
--storyboard.gotoScene( "mission_clear")
storyboard.gotoScene( "characterprofile")
--storyboard.gotoScene( "character_show")


