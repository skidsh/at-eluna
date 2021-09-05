require("Enchants")
require("ordered_table")
local GearNpc = {
    entry = 333596, -- GearNpc entry.
}

function GearNpc.OnHello(event, player, unit)
    GearNpc.GenerateMenu(1, player, unit);
end

function GearNpc.OnSelect(event, player, unit, sender, intid, code)
    if (sender == 0) then
        if (intid == 0) then
            -- Buy Gear
            GearNpc.GenerateMenu(2, player, unit);
        elseif (intid == 1) then
            -- Enchant Gear
            GearNpc.GenerateMenu(3, player, unit);
        end
    elseif (sender == 1) then
        -- Selected Slot
        for i, enchant in orderedPairs(enchantTable[intid]) do
            player:GossipMenuAddItem(5, enchant[1], 2, enchant[2])
        end 
    elseif (sender == 2) then
        -- Enchant Piece
        EnchantSlot(player, findSlotOfEnchant(intid), findRowOfEnchant(intid))
    end
end

function GearNpc.GenerateMenu(id, player, unit)
    if (id == 1) then
        -- Main Menu
        player:GossipMenuAddItem(1, "Buy Gear", 0, 0)
        player:GossipMenuAddItem(0, "Enchant Gear", 0, 1)
        player:GossipSendMenu(1, unit)
    elseif (id == 2) then
        -- Buy Gear Menu
        -- Some menu options that lead to these player:SendListInventory(player, 54)
    elseif (id == 3) then
        -- Enchant Gear Menu
        for i, slot in orderedPairs(enchantMenu) do
            player:GossipMenuAddItem(4, slot[1], 1, slot[2])
        end
        player:GossipSendMenu(1, unit)
    end

end

RegisterCreatureGossipEvent(GearNpc.entry, 1, GearNpc.OnHello)
RegisterCreatureGossipEvent(GearNpc.entry, 2, GearNpc.OnSelect)
print("[GearNpc]: Loaded");