local Beastmaster = {
    entry = 26307, -- Beastmaster entry.
    maxObj = 11, -- 13 = Max amt. of menu objects.
}

function Beastmaster.OnHello(event, player, unit)
    -- Check whether the player is actually a hunter or not.
    if(player:GetClass() == 3) then
        -- Check if player is able to tame pets.
        if(player:HasSpell(1515)) then
            Beastmaster.GenerateMenu(1, player, unit);
        else
            player:GossipSendMenu(5839, unit)
        end
    else
        player:GossipSendMenu(5839, unit)
    end
end

function Beastmaster.OnSelect(event, player, unit, sender, intid, code)
    -- Intid 0 is used solely for menu pages and 1 for pet selection.
    if(intid == 0) then
        Beastmaster.GenerateMenu(sender, player, unit);
    elseif(intid == 1) then
        if (player:GetPetGUID() > 0) then
            player:CastSpell(pet, 2641, true)
        end
        -- Spawn a temporary, friendly version of the selected creature and force tame it.
        local pet = PerformIngameSpawn(1, sender, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        pet:SetFaction(35)
        pet:SetLevel(80)
        player:CastSpell(pet, 2650, true)
        player:GossipComplete()
        player:CastSpell(nil, 1539, true)  
    elseif(intid == 2) then
        player:GossipClearMenu()
        player:SendListInventory(unit);
    end
end

function Beastmaster.GenerateMenu(id, player, unit)
    local low = ((Beastmaster.maxObj*id)-Beastmaster.maxObj+1)
    local high = Beastmaster.maxObj*id

    if (id == 1) then
        player:GossipMenuAddItem(1, "Buy Pet Food", id+1, 2)
        player:GossipMenuAddItem(23, "Tame a Pet", id+1, 0)
        player:GossipSendMenu(13474, unit)
    else        
        -- Retrieve the current page sets' gossip option information.
        for i = low, high do
            local t = Beastmaster["Cache"][i]
            
            if t then -- show "i" if only exists in the table
                if (t["exotic"] == 0) or (player:HasSpell(53270)) then
                    player:GossipMenuAddItem(3, t["name"], t["entry"], 1)
                end
                
            end
        end
        
        -- If the menu is not the first menu, show Previous button.
        if(id ~= 2) then
            player:GossipMenuAddItem(4, "Previous", id-1, 0)
        end
        
        -- If the next menu has available objects and object is within player level, show Next button.
        if(Beastmaster["Cache"][high+1]) then
            player:GossipMenuAddItem(4, "Next", id+1, 0)
        end
        player:GossipSendMenu(3666, unit)
    end

    
end

function Beastmaster.LoadCache()
    Beastmaster["Cache"] = {}
    local i = 1;
    local Query;
    
    if(GetCoreName() == "MaNGOS") then
        Query = WorldDBQuery("SELECT Entry, Name, MaxLevel FROM creature_template WHERE CreatureType=1 AND CreatureTypeFlags&1 <> 0 AND Family!=0 ORDER BY MaxLevel ASC;")
    elseif(GetCoreName() == "TrinityCore" or GetCoreName() == "AzerothCore") then
        Query = WorldDBQuery("SELECT Entry, Name, CASE WHEN Type_Flags&65536 <> 0 THEN 1 ELSE 0 END as exotic FROM creature_template WHERE Entry in (SELECT MIN(Entry) FROM creature_template WHERE Type=1 AND Type_Flags&1 <> 0 AND Family!=0 Group By Family) ORDER BY exotic ASC;")
    end
    
    if(Query) then
        repeat
            Beastmaster["Cache"][i] = {
                entry = Query:GetUInt32(0),
                name = Query:GetString(1),
                exotic = Query:GetUInt8(2)
            };
            i = i+1
        until not Query:NextRow()
        print("[Beastmaster]: Cache initialized. Loaded "..Query:GetRowCount().." tameable beasts.")
    else
        print("[Beastmaster]: Cache initialized. No results found.")
    end
end

Beastmaster.LoadCache()
RegisterCreatureGossipEvent(Beastmaster.entry, 1, Beastmaster.OnHello)
RegisterCreatureGossipEvent(Beastmaster.entry, 2, Beastmaster.OnSelect)