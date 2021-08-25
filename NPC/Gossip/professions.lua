require('unlearnproffs')
local NPC_ID = 26760 --CHANGE IT
local itemid = nil -- to use with an item change from nil to item id.
local recipeList = {
    [171] = {},
    [164] = {},
    [333] = {},
    [202] = {},
    [182] = {},
    [773] = {},
    [755] = {},
    [165] = {},
    [186] = {},
    [393] = {},
    [197] = {},
}
local prof = {
    [1] = {
        --  {skill, spell, "name",      "npc_trainer reference IDs"},
        {171, 51303, 2259, "|TInterface\\icons\\INV_Elemental_Eternal_Life:29|tAlchemy",         "201001, 201002, 201003"},
        {164, 51298, 2018, "|TInterface\\icons\\Ability_Repair.png:29|tBlacksmithing",   "201004, 201005, 201006"},
        {333, 51312, 7411, "|TInterface\\icons\\INV_Enchant_DreamShard_02.png:29|tEnchanting",      "201009, 201010, 201011"},
        {202, 51305, 4036, "|TInterface\\icons\\INV_Gizmo_02.png:29|tEngineering",     "201012, 201013, 201014"},
        {182, 50301, 9134, "|TInterface\\icons\\INV_Misc_Herb_07.png:29|tHerbalism",       "201018, 201019, 201020"},
        {773, 45380, 45357, "|TInterface\\icons\\INV_Inscription_InkGreen02.png:29|tInscription",     "201021, 201022, 201023"},
        {755, 51310, 25229, "|TInterface\\icons\\INV_JEWELCRAFTING_GEM_37.png:29|tJewelcrafting",   "201024, 201025, 201026"},
        {165, 51301, 2108, "|TInterface\\icons\\INV_Misc_LeatherScrap_19.png:29|tLeatherworking",  "201027, 201028, 201029"},
        {186, 50309, 2575, "|TInterface\\icons\\INV_Ingot_Cobalt.png:29|tMining",          "201033, 201034, 201035"},
        {393, 50307, 8613, "|TInterface\\icons\\INV_Misc_ArmorKit_31.png:29|tSkinning",        "201036, 201037, 201038"},
        {197, 51308, 3908, "|TInterface\\icons\\INV_Fabric_Silk_02.png:29|tTailoring",       "201039, 201040, 201041"},
    },
   
    [2] = {
        --  {skill, spell, "name",  "npc_trainer reference IDs"},
        {356, 51293, 7620, "|TInterface\\icons\\INV_Misc_MonsterHead_04.png:29|tFishing",     "202001, 202002, 202003"},
        {185, 51295, 2550, "|TInterface\\icons\\Ability_Mage_ConjureFoodRank10.png:29|tCooking",     "202004, 202005, 202006"},
        {129, 50299, 746, "|TInterface\\icons\\INV_Misc_Bandage_Frostweave_Heavy.png:29|tFirst Aid",   "202007, 202008, 202009"},
    },
}
for s1, s2 in pairs(recipeList) do
    local q = WorldDBQuery("select spellid_2 from item_template where class = 9 and requiredSkill = "..s1)
    if q then
        repeat
            table.insert(s2, q:GetUInt32(0))
        until not q:NextRow()
    end
end
for _, p in ipairs(prof) do
    for k, v in ipairs(p) do
        local skill, spell, r1spell, name, profrefs = table.unpack(v)
        local q = WorldDBQuery("SELECT SpellID FROM npc_trainer WHERE ID in("..profrefs..")")
        v[5] = {};
        local recipes = v[5]
        if q then
            repeat
                table.insert(recipes, q:GetUInt32(0))
            until not q:NextRow()
        end
    end
end
 
local function On_Gossip(event, player, unit)
    player:GossipClearMenu()
	player:GossipSendMenu(100, unit)
end
 
local function On_Select(event, player, unit, id, intid, code)
    if id == 3 then
        player:GossipClearMenu()
        if intid == 1 or intid == 2 then
            for k, v in ipairs(prof[intid]) do
                local skill, spell, r1spell, name, recipes = table.unpack(v)
                if not player:HasSkill(skill) then
                    player:GossipMenuAddItem(4, name, 3+intid, k)
                else
                    player:GossipMenuAddItem(4, name.." (Unlearn)", 3+intid, k)
                end
            end
            player:GossipMenuAddItem(7, "|TInterface\\icons\\INV_Ingot_Titansteel_red.png:29|tExit", 3, 3)
            player:GossipSendMenu(100, unit)
            return
        elseif intid == 3 then
            On_Gossip(event, player, unit)
            return
        end
        player:GossipComplete()
    end
   
    if id == 4 or id == 5 then
        player:GossipClearMenu()
        id = id-3
       
        local skill, spell, r1spell, name, recipes = table.unpack(prof[id][intid])
        if not player:HasSkill(skill) then
            -- if id is primary prof and we cant learn more
            -- 0x0368 + 0x008E + 0x0006
            local proffsLeft = player:GetUInt32Value(1021);
            if id == 1 and proffsLeft <= 0 then
                player:SendNotification("You can not learn more primary professions")
            else
                player:LearnSpell(r1spell)
                player:CastSpell(player, spell)
                player:SetSkill(skill, 450, 450, 450)
                if (recipeList[skill]) then
                    for _, f in pairs(recipeList[skill]) do
                        player:LearnSpell(f)
                    end
                end
                for k, v in ipairs(recipes) do
                    if not player:HasSpell(v) then
                        player:LearnSpell(v)
                    end
                end
            end
        else
            player:SetSkill(skill, 0, 0, 0)
            UnlearnSkill(skill, player)
            player:RemoveSpell(r1spell)
        end
       
        On_Select(event, player, unit, 0, id)
        player:GossipComplete()
        return
    end
   
end
 
RegisterCreatureGossipEvent(NPC_ID, 2, On_Select)