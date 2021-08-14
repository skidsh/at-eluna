DualSpecSpellId = 63624;
ClassChoices = {
    [1] = {200001, 200002},
    [2] = {200003, 200004},
    [3] = {200013, 200014},
    [4] = {200015, 200016},
    [5] = {200011, 200012},
    [6] = {200019},
    [7] = {200017, 200018},
    [8] = {200007, 200008},
    [9] = {200009, 200010},
    [11] = {200005, 200006};
  };

ClassSpells = {
    [1] = {},
    [2] = {}, 
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {},
    [7] = {},
    [8] = {};
    [9] = {};
    [11] = {};
}

ClassSkillsAdd = { -- Includes a mount and riding skills for every class
    [1] = {199, 200, 227, 264, 266, 674, 750, 5011, 15590},
    [2] = {196, 197, 199, 200, 750},
    [3] = {200, 202, 227, 266, 674, 8737, 15590},
    [4] = {196, 198, 201, 264, 266, 5011, 15590},
    [5] = {1180},
    [6] = {198, 199},
    [7] = {196, 197, 199, 8737, 15590},
    [8] = {201},
    [9] = {201},
    [11] = {198, 199, 200, 227, 1180, 15590}
}

MountAndRiding = {33388, 33391, 34090, 34091, 60114 }

ClassQuestSpells = {
    [1] = {8121, 8616},
    [2] = {23215,34768,34766,7329,5503,13820},
    [3] = {1579, 5300},
    [4] = {2995},
    [5] = {},
    [6] = {52382,53431,53821},
    [7] = {5396,8073,2075},
    [8] = {10143,28285,3578},
    [9] = {20700,7763,11520,11519,1373,5785,23160,1413},
    [11] = {40123,19179,8947,1446}
}

for class, templates in pairs(ClassChoices) do
    local c = 0;
    for i, v in pairs(templates) do
        local Q = WorldDBQuery("SELECT SpellID, sr.first_spell_id, sr.`rank` FROM npc_trainer nt left join spell_ranks sr on sr.spell_id = nt.SpellID where ID = "..v.." order by sr.first_spell_id, sr.rank")
        if Q then
            repeat
                local SpellID = Q:GetUInt32(0)
                local FirstSpellID = Q:GetUInt32(1)
                local rank = Q:GetUInt32(2)
                local spell = {};
                spell.id = SpellID;
                spell.rank = rank;
                spell.FirstSpellID = FirstSpellID
                table.insert( ClassSpells[class], spell)
                c = c + 1;
            until not Q:NextRow()
        end
    end
    PrintInfo("[Learn All]: Loaded "..c.." "..ClassNames[class].." Auto Learn Spells");
    table.sort(ClassSpells[class], function (left, right)
        return left.rank < right.rank
    end)
end