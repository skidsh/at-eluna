local repValue = 999999

local bothReps = {
    1156
}

local allianceReps = {
    47,	    -- IronForge
    72,	    -- Stormwind
    69,	    -- Darnassus
    389,	-- Gnomeregan
    930,	-- Exodar
}

local hordeReps = {
    68,     --Undercity
    76,     --Orgrimmar
    81,     --Thunder Bluff
    530,    --DarkSpear
    911,    --Silvermoon
}

local reps = {
    [0] = allianceReps,
    [1] = hordeReps
}

local function GrantRep(event, player)
    local factions = reps[player:GetTeam()]
    table.insert(factions, table.unpack(bothReps))
    for c, faction in pairs(factions) do
        player:SetReputation(faction, repValue);
    end
end

RegisterPlayerEvent(30, GrantRep)