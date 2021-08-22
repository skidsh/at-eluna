require("TeleportLocations")
require("Packets")
require("LoginFlags")
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
        elseif (intid == 3) then
            FightPromoter.GenerateMenu(3, player, unit);
        end
    elseif (sender == 1) then
        local locations = FightPromoter.GetLocations(player)
        player:Teleport(locations[intid][1], locations[intid][2], locations[intid][3], locations[intid][4], locations[intid][5]);
        player:GossipComplete()
    elseif (sender == 2) then
        ChangeChar(player, intid);
        player:GossipComplete()
    end
end

function FightPromoter.GenerateMenu(id, player, unit)
    local locations = FightPromoter.GetLocations(player)
    if (id == 1) then
        player:GossipMenuAddItem(0, "Bind Hearthstone Here", 0, 0)
        player:GossipMenuAddItem(0, "Teleport", 0, 1)
        player:GossipMenuAddItem(0, "Change Character", 0, 3)
        player:GossipMenuAddItem(9, "Join Arena", 0, 2)
        player:GossipSendMenu(12684, unit)   
    elseif (id == 2) then
        for i=0,12,1 do
            player:GossipMenuAddItem(4, locations[i][6], 1, i)
        end
        player:GossipSendMenu(16386, unit)
    elseif (id == 3) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "|TInterface/icons/INV_Misc_Gift_01:35|t|r Character Name Change", 2, 2)
        player:GossipMenuAddItem(0, "|TInterface/icons/INV_Misc_Gift_02:35|t|r Character My Appearance", 2, 3)
        player:GossipMenuAddItem(0, "|TInterface/icons/INV_Misc_Gift_03:35|t|r Character Race Change", 2, 4)
        player:GossipMenuAddItem(0, "|TInterface/icons/INV_Misc_Gift_04:35|t|r Change Faction Change", 2, 5)
        player:GossipSendMenu(1, unit)   
    end

end

RegisterCreatureGossipEvent(FightPromoter.entry, 1, FightPromoter.OnHello)
RegisterCreatureGossipEvent(FightPromoter.entry, 2, FightPromoter.OnSelect)
print("[FightPromoter]: Loaded");