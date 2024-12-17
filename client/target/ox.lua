if Config.Target ~= 'ox' then return end 

local Targets = {}
local target = exports.ox_target

Targets.addEntityTarget = function(netIds, options)
    if not checkArgs(netIds, options) then return end
    target:addEntity(netIds, options)
end

Targets.addCircleZone = function(circledata)
    if not checkArgs(circledata.coords, circledata.options) then return end
    target:addSphereZone(circledata)
end

Targets.addBoxZone = function(boxdata)
    if not checkArgs(boxdata.coords, boxdata.size, boxdata.options) then return end
    target:addBoxZone({
        coords = boxdata.coords,
        size = boxdata.size,
        options = boxdata.options,
        debugPoly = boxdata.debugPoly,
        heading = boxdata.heading,
        minZ = boxdata.minZ,
        maxZ = boxdata.maxZ
    })
end

Targets.removeZone = function(zone) 
    target:removeZone(zone)
end

return Targets