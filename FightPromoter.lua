require("TeleportLocations")
require("BattlemasterPacket")
local FightPromoter = {
    entry = 26760, -- FightPromoter entry.
}

function FightPromoter.GetLocations(player)
    if player:IsAlliance() then
        return TeleportLocations.Alliance
    else
        return TeleportLocations.Horde
    end
end

function FightPromoter.OnHello(event, player, unit)
    FightPromoter.GenerateMenu(1, player, unit);
end

function FightPromoter.OnSelect(event, player, unit, sender, intid, code)
    if (sender == 0) then
        if (intid == 0) then
            -- Hearthstone Bind
            local packet = CreatePacket(0x2EB, 8)
            packet:WriteGUID(unit:GetGUID())
            player:SendPacket(packet)
            player:GossipComplete()
        elseif (intid == 1) then
            FightPromoter.GenerateMenu(2, player, unit);
        elseif (intid == 2) then
            local packet = GetArenaBattlemasterPacket(unit)
            player:SendPacket(packet)
            player:GossipComplete()
        end
    elseif (sender == 1) then
        local locations = FightPromoter.GetLocations(player)
        player:Teleport(locations[intid][1], locations[intid][2], locations[intid][3], locations[intid][4], locations[intid][5]);
        player:GossipComplete()
    end
end

function FightPromoter.GenerateMenu(id, player, unit)
    local locations = FightPromoter.GetLocations(player)
    if (id == 1) then
        player:GossipMenuAddItem(0, "Bind Hearthstone Here", 0, 0)
        player:GossipMenuAddItem(0, "Teleport", 0, 1)
        player:GossipMenuAddItem(9, "Join Arena", 0, 2)
        player:GossipSendMenu(12684, unit)   
    elseif (id == 2) then
        for i=1,12,1 do
            player:GossipMenuAddItem(4, locations[i][6], 1, i)
        end
        player:GossipSendMenu(16386, unit)
    else
    end

end

RegisterCreatureGossipEvent(FightPromoter.entry, 1, FightPromoter.OnHello)
RegisterCreatureGossipEvent(FightPromoter.entry, 2, FightPromoter.OnSelect)
print("[FightPromoter]: Loaded");