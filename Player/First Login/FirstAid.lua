local FirstAidSpells = { 3273, 3274, 7924, 10846, 27028, 45542 }
local function LearnFirstAid(event, player)
    for _, id in pairs(FirstAidSpells) do
        player:LearnSpell(id)
    end
    player:AdvanceSkill( 129, 450 )
end
RegisterPlayerEvent(30, LearnFirstAid)