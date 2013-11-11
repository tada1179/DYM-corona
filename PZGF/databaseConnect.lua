print("databaseConnect.lua")
local sqlite3 = require ("sqlite3")
local myNewData
local json = require ("json")
local decodedData

local SaveData = function ()

--Save new data to a sqlite file
--open SQLite database, if it doesn't exist, create database
    local path = system.pathForFile("movies.sqlite", system.DocumentsDirectory)
    db = sqlite3.open( path )
    print("******--"..path.."--****")

    --setup the table if it doesn't exist
    local tablesetup = "CREATE TABLE IF NOT EXISTS mymovies (id INTEGER PRIMARY KEY, movie, year);"
    db:exec( tablesetup )
    print(tablesetup)

    --save  data to database
    local counter = 1
    local index = "movie"..counter
    local movie = decodedData[index]
    print(movie)

    while ( movie ~= nil ) do
        local tablefill ="INSERT INTO mymovies VALUES (NULL,'" .. movie[2] .. "','" .. movie[3] .."');"
        print(tablefill)
        db:exec( tablefill )
        counter=counter+1
        index = "movie"..counter
        movie = decodedData[index]
    end

    --everything is saved to SQLite database; close database
    db:close()

    --Load database contents to screen
    --open database
    local path = system.pathForFile("movies.sqlite", system.DocumentsDirectory)
    db = sqlite3.open( path )
    print(path)

    --print all the table contents
    local sql = "SELECT * FROM mymovies"
    for row in db:nrows(sql) do
        local text = row.movie.." "..row.year
        local t = display.newText( text, 20, 30 * row.id, native.systemFont, 24 )
        t:setTextColor( 255,255,255 )
    end
    db:close()

end


local function networkListener( event )

    if ( event.isError ) then
        print( "Network error!")
    else
        myNewData = event.response
        print ("From server: "..myNewData)
        decodedData = (json.decode( myNewData))
        SaveData()
    end

end

network.request( "http://www.BurtonsMediaGroup.com/myMovies.php", "GET", networkListener )
--network.request( "http://133.242.169.252/DYM/databaseSQLlife.php", "GET", networkListener )