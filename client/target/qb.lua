if Config.Target ~= 'qb' then return end 

local targets = {}

local target = exports['qb-target']

targets.addEntityTarget = function(netIds, options)
    if not checkArgs(netIds, options) then return end
    local formattedOptions = {}
    for _, option in pairs(options) do
        table.insert(formattedOptions, {
            icon = option.icon,
            label = option.label,
            action = option.onSelect,
            job = option.groups,
            distance = option.distance
        })
    end
    target:AddTargetEntity(netIds, { options = formattedOptions, distance = 2.0 })
end

targets.addCircleZone = function(circledata)
    if not checkArgs(circletargets.coords, circletargets.options) then return end
    local name = circletargets.name or ("circleZone" .. math.random(1, 999999999))
    local radius = circletargets.radius or 1.5
    local formattedOptions = {}
    for _, option in pairs(circletargets.options) do
        table.insert(formattedOptions, {
            icon = option.icon,
            label = option.label,
            action = option.onSelect,
            job = option.groups,
            distance = option.distance
        })
    end
    target:AddCircleZone(name, circletargets.coords, radius, { name = name, debugPoly = circletargets.debugPoly or false }, {
        options = formattedOptions,
        distance = circletargets.distance or 2.0
    })
end

targets.addBoxZone = function(boxdata)
    if not checkArgs(boxtargets.coords, boxtargets.size, boxtargets.options) then return end
    local name = boxtargets.name or ("boxZone" .. math.random(1, 999999999))
    local length = boxtargets.size.x
    local width = boxtargets.size.y
    local heading = boxtargets.heading or 0.0
    local formattedOptions = {}
    for _, option in pairs(boxtargets.options) do
        table.insert(formattedOptions, {
            icon = option.icon,
            label = option.label,
            action = option.onSelect,
            job = option.groups,
            distance = option.distance
        })
    end
    target:AddBoxZone(name, boxtargets.coords, length, width, { name = name, heading = heading, debugPoly = boxtargets.debugPoly or false, minZ = boxtargets.minZ or boxtargets.coords.z - 1, maxZ = boxtargets.maxZ or boxtargets.coords.z + 1 }, {
        options = formattedOptions,
        distance = boxtargets.distance or 2.0
    })
end

targets.removeZone = function(zone) 
    target:RemoveZone(zone)
end

return targets