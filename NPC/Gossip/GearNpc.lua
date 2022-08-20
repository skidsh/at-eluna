require("Enchants")
require("GearHelper")
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
            -- Main Menu
            GearNpc.GenerateMenu(1, player, unit);
        elseif (intid == 1) then
            -- Buy Gear
            GearNpc.GenerateMenu(2, player, unit);
        elseif (intid == 2) then
            -- Enchant Gear
            GearNpc.GenerateMenu(3, player, unit);
        elseif (intid == 3) then
            -- Glyphs
            player:SendListInventory(unit, glyphVendorByClass[player:GetClass()])
        elseif (intid == 4) then
            -- Gems & General
            player:SendListInventory(unit, GEMS_GENERAL_VENDOR)
        elseif (intid == 5) then
            player:SetCoinage(player:GetCoinage()+100*100*50000)
            player:SendAreaTriggerMessage("50,000 Gold Successfully Added")
            GearNpc.GenerateMenu(1, player, unit);
        end
    elseif (sender == 1) then
        if (intid == 23) then
            -- Show possible weapon slots
            for i, enchant in orderedPairs(weaponMenu) do
                player:GossipMenuAddItem(0, enchant[1], 1, enchant[2])
            end
            player:GossipMenuAddItem(7, "Back", 0, 2)
            player:GossipSendMenu(333600, unit)
        else
            -- Show possible enchants for slot
            for i, enchant in orderedPairs(enchantTable[intid]) do
                player:GossipMenuAddItem(3, enchant[1], 2, enchant[2])
            end
            if (intid == 15 or intid == 16 or intid == 17 or intid == 151 or intid == 161) then
                player:GossipMenuAddItem(7, "Back", 1, 23)
            else
                player:GossipMenuAddItem(7, "Back", 0, 2)
            end
            player:GossipSendMenu(333599, unit)
        end
    elseif (sender == 2) then
        -- Enchant Piece
        if (EnchantSlot(player, findSlotOfEnchant(intid), findRowOfEnchant(intid))) then
            player:SendAreaTriggerMessage("Enchanted Item Successfully")
        end
        player:GossipComplete()
    elseif (sender == 3) then
        if (intid == 23) then
            -- stuff for weapons menu
            for i, wepSlot in orderedPairs(weaponMenuGear) do
                player:GossipMenuAddItem(1, wepSlot[1], 3, wepSlot[2])
            end
            player:GossipMenuAddItem(7, "Back", 0, 1)
            player:GossipSendMenu(333601, unit)
        else
            player:SendListInventory(unit, intid*1000000+333596)
        end
    elseif (sender == 4) then
        player:SendListInventory(unit, intid)
    end
end

function GearNpc.GenerateMenu(id, player, unit)
    if (id == 1) then
        -- Main Menu
        player:GossipMenuAddItem(0, "Buy Gear", 0, 1)
        player:GossipMenuAddItem(0, "Enchant Gear", 0, 2)
        player:GossipMenuAddItem(1, player:GetClassAsString().." Glyphs", 0, 3)
        player:GossipMenuAddItem(1, "Gems & General Goods", 0, 4)
        player:GossipMenuAddItem(6, "Add 50,000 Gold", 0, 5)
        player:GossipSendMenu(333603, unit)
    elseif (id == 2) then
        -- Buy Gear Menu
        -- Some menu options that lead to these player:SendListInventory(player, 54)
        -- Select a slot
        for i, slot in orderedPairs(slots) do
            player:GossipMenuAddItem(slot[1] == "Weapons" and 0 or 1, slot[1], 3, slot[2])
        end
        player:GossipMenuAddItem(7, "Back", 0, 0)
        player:GossipSendMenu(333601, unit)
    elseif (id == 3) then
        -- Select a slot
        for i, slot in orderedPairs(enchantMenu) do
            player:GossipMenuAddItem(0, slot[1], 1, slot[2])
        end
        player:GossipMenuAddItem(7, "Back", 0, 0)
        player:GossipSendMenu(333597, unit)
    elseif (id == 5) then
        -- Select a gem
        for i, gem in orderedPairs(gems) do
            player:GossipMenuAddItem(1, gem[1], 4, gem[2])
        end
        player:GossipMenuAddItem(7, "Back", 0, 0)
        player:GossipSendMenu(333602, unit)
    end

end

RegisterCreatureGossipEvent(GearNpc.entry, 1, GearNpc.OnHello)
RegisterCreatureGossipEvent(GearNpc.entry, 2, GearNpc.OnSelect)
print("[GearNpc]: Loaded");
