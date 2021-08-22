require("Shared")
require("SpellData")

local queuedPlayers = {}

local function DualSpec(event, player)   
    player:CastSpell(player, DualSpecSpellId, true);
end

local function LearnAllSkills(player, class)
    for i, skill in pairs(ClassSkillsAdd[class]) do
        player:LearnSpell(skill);
    end
end

local function PaladinFix(player)
    if (player:IsAlliance()) then
        player:LearnSpell(31801)
    else
        player:LearnSpell(53736)
    end
end

local function LearnAllSpells(player, class)
    for i, spell in orderedPairs(ClassSpells[class]) do
        local allowed = true;
        if (spell.req_spell and spell.req_spell > 1) then
            local req_spell = player:HasSpell(spell.req_spell)
            allowed = req_spell;
        end
        if (spell.rank and spell.rank > 1) then
            local learnedFirst = player:HasSpell(spell.FirstSpellID)
            if (allowed and learnedFirst and not player:HasSpell(spell.id)) then
                player:LearnSpell(spell.id);   
            end
        elseif (allowed and not player:HasSpell(spell.id)) then
            player:LearnSpell(spell.id);
        end
    end
    if (class == 2) then
        PaladinFix(player)
    end
end

local function LearnRidingAndMount(player)
    for _, spellid in pairs(MountAndRiding) do
        player:LearnSpell(spellid)
    end
end

local function LearnQuestSpells(player, class)
    for c, spellid in pairs(ClassQuestSpells[class]) do
        player:CastSpell(player, spellid, true)
    end
end

local function LearnSkillsAndSpells()
    local queue = table.remove(queuedPlayers, 1)
    local player = GetPlayerByGUID(queue.playerGuid);
    local class = queue.class
    LearnAllSkills(player, class)
    LearnAllSpells(player, class)   
    LearnRidingAndMount(player)
    player:SendBroadcastMessage("All spells learned")
end

local function LearnAll(event, player)
    local class = player:GetClass()
    LearnQuestSpells(player, class)
    local queue = {}
    queue.playerGuid = player:GetGUID();
    queue.class = class
    table.insert( queuedPlayers, queue )
    eventId = CreateLuaEvent( LearnSkillsAndSpells, 2000, 1 ) 
end

RegisterPlayerEvent(30, LearnAll)
RegisterPlayerEvent(30, DualSpec)