local function OnTestCommands(event, player, msg, Type, lang)
    if (msg == "#test") then
        player:SendListInventory(player, 54)
        return false
    end
end

RegisterPlayerEvent(18, OnTestCommands)
