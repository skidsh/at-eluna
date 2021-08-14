local Paymaster = {
    entry = 26075, -- Paymaster entry.
    spell = 46642  -- 5,000 gold
}

function Paymaster.OnHello(event, player, unit)
    Paymaster.GenerateMenu(1, player, unit);
end

function Paymaster.OnSelect(event, player, unit, sender, intid, code)
    if(intid == 0) then
        Paymaster.GenerateMenu(sender, player, unit);
    elseif(intid == 1) then        
        unit:CastSpell(player, Paymaster.spell, true)
        player:GossipComplete()
    elseif(intid == 2) then        
        player:GossipComplete()
    end
end

function Paymaster.GenerateMenu(id, player, unit)
    player:GossipMenuAddItem(1, "Yes, Please", id+1, 1)
    player:GossipMenuAddItem(0, "Goodbye", id, 2)
    player:GossipSendMenu(12532, unit)

    
end

RegisterCreatureGossipEvent(Paymaster.entry, 1, Paymaster.OnHello)
RegisterCreatureGossipEvent(Paymaster.entry, 2, Paymaster.OnSelect)
print("[Paymaster]: Loaded");