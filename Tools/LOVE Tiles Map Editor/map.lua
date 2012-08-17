require "tileset"

map = {
}

mapProperties = {
    maximum = {
        x = 800*2,
        y = 800*2
    },
    noUnsavedChanges = false
}

function SetupMap()
	for y = 0, 600/32 * 2 do
		for x = 0, 800/32 * 2 do			
			AppendTileToMap( math.floor(x) * 32, math.floor(y) * 32, tileset.grass )
		end
	end
end

function ClearMap()
    for idx in pairs (map) do
        map[idx] = nil
    end
    
    SetupMap()
end

function AppendTileToMap( newx, newy, tileType )
    newTile = {
        tile = tileType,
        x = newx,
        y = newy
    }
    table.insert( map, newTile )
    mapProperties.noUnsavedChanges = falseeex
end

function RemoveLastTile()
    table.remove( map )
end

function DrawMap()
	love.graphics.setColor( 255, 255, 255, 255 )
	for index, mapTile in pairs( map ) do
		love.graphics.draw( mapTile.tile.image, mapTile.x - viewOffset.x, mapTile.y - viewOffset.y )
	end
end	

-- Map format:
-- map = {
--      "0" = {
--          "x" = mapTile.x,
--          "y" = mapTile.y,
--          "tile" = mapTile.tile.name
--      }
-- }

function SaveMap()
    filename = "GeneratedMap.lua" 
    file = io.open( filename, "w" )
    
    file:write( "map = {") -- Beginning of generated map table
	for index, mapTile in pairs( map ) do
        file:write( "\n" )
        file:write( "   \"" .. index .. "\" = {" ) -- beginning of map[i]
        file:write( "\n" )
        file:write( "         \"x\" = " .. mapTile.x .. "," )
        file:write( "\n" )
        file:write( "         \"y\" = " .. mapTile.y .. "," )
        file:write( "\n" )
        file:write( "         \"tile\" = \"" .. mapTile.tile.name .. "\"" )
        file:write( "\n" )
        file:write( "   }" ) -- end of map[i]
        if ( index ~= #map ) then
            file:write(",") -- Elements are separated by commas
        end
	end
    file:write( "\n" )
    file:write( "}" ) -- end of map table
    
    file:close()
    mapProperties.noUnsavedChanges = true
end

