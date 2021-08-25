function UnlearnSkill(id, player)
    if (id == 171) then
        UnlearnAlchemy(player)
    elseif (id == 164) then
        UnlearnBlacksmithing(player)
    elseif (id == 333) then
        UnlearnEnchanting(player)
    elseif (id == 202) then
        UnlearnEngineering(player)
    elseif (id == 182) then
        UnlearnHerb(player)
    elseif (id == 773) then
        UnlearnInscription(player)
    elseif (id == 755) then
        UnlearnJewelcrafting(player)
    elseif (id == 165) then
        UnlearnLeatherworking(player)
    elseif (id == 186) then
        UnlearnMining(player)
    elseif (id == 393) then
        UnlearnSkinning(player)
    elseif (id == 197) then
        UnlearnTailoring(player)
    elseif (id == 356) then
        UnlearnFishing(player)
    elseif (id == 185) then
        UnlearnCooking(player)
    elseif (id == 129) then
        UnlearnFirstAid(player)
    end
end

function UnlearnFishing(player)
    player:RemoveSpell(51294)
    player:RemoveSpell(33095)
    player:RemoveSpell(18248)
    player:RemoveSpell(7732)
    player:RemoveSpell(7731)
    player:RemoveSpell(7620)
end

function UnlearnFirstAid(player)
    player:RemoveSpell(45542)
    player:RemoveSpell(27028)
    player:RemoveSpell(10846)
    player:RemoveSpell(7924)
    player:RemoveSpell(3274)
    player:RemoveSpell(3273)
end

function UnlearnCooking(player)
    player:RemoveSpell(51296)
    player:RemoveSpell(33359)
    player:RemoveSpell(18260)
    player:RemoveSpell(3413)
    player:RemoveSpell(3102)
    player:RemoveSpell(2550)
    player:RemoveSpell(2550)
end

function UnlearnMining(player)
    player:RemoveSpell(50310)
    player:RemoveSpell(29354)
    player:RemoveSpell(10248)
    player:RemoveSpell(3564)
    player:RemoveSpell(2576)
    player:RemoveSpell(2575)
end

function UnlearnSkinning(player)
    player:RemoveSpell(50305)
    player:RemoveSpell(32678)
    player:RemoveSpell(10768)
    player:RemoveSpell(8618)
    player:RemoveSpell(8617)
    player:RemoveSpell(8613)
end

function UnlearnHerb(player)
    player:RemoveSpell(50300)
    player:RemoveSpell(28695)
    player:RemoveSpell(11993)
    player:RemoveSpell(3570)
    player:RemoveSpell(2368)
    player:RemoveSpell(2366)
end

function UnlearnInscription(player)
    player:RemoveSpell(45363)
    player:RemoveSpell(45361)
    player:RemoveSpell(45360)
    player:RemoveSpell(45359)
    player:RemoveSpell(45358)
    player:RemoveSpell(45357)
end

function UnlearnAlchemy(player)
    player:RemoveSpell(51304)
    player:RemoveSpell(28596)
    player:RemoveSpell(11611)
    player:RemoveSpell(3464)
    player:RemoveSpell(3101)
    player:RemoveSpell(2259)
end

function UnlearnBlacksmithing(player)
    player:RemoveSpell(51300)
    player:RemoveSpell(29844)
    player:RemoveSpell(9785)
    player:RemoveSpell(3538)
    player:RemoveSpell(3100)
    player:RemoveSpell(2018)
end

function UnlearnLeatherworking(player)
    player:RemoveSpell(51302)
    player:RemoveSpell(32549)
    player:RemoveSpell(10662)
    player:RemoveSpell(3811)
    player:RemoveSpell(3104)
    player:RemoveSpell(2108)
end

function UnlearnTailoring(player)
    player:RemoveSpell(51309)
    player:RemoveSpell(26790)
    player:RemoveSpell(12180)
    player:RemoveSpell(3910)
    player:RemoveSpell(3909)
    player:RemoveSpell(3908)
end

function UnlearnEngineering(player)
    player:RemoveSpell(51306)
    player:RemoveSpell(30350)
    player:RemoveSpell(12656)
    player:RemoveSpell(4038)
    player:RemoveSpell(4037)
    player:RemoveSpell(4036)
end

function UnlearnEnchanting(player)
    player:RemoveSpell(51313)
    player:RemoveSpell(28029)
    player:RemoveSpell(13920)
    player:RemoveSpell(7413)
    player:RemoveSpell(7412)
    player:RemoveSpell(7411)
end

function UnlearnJewelcrafting(player)
    player:RemoveSpell(51311)
    player:RemoveSpell(28897)
    player:RemoveSpell(28895)
    player:RemoveSpell(28894)
    player:RemoveSpell(25230)
    player:RemoveSpell(25229)
end