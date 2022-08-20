require("Packets")

local ClearAllDebuffs = 34098
local WaterElemental = 510
local Gargoyle = 27829
local MirrorImage = 31216
local function RemovePetByEntry(player, entry)
    creaturesInRange = player:GetCreaturesInRange( 100 )
    for _, unit in pairs(creaturesInRange) do
        if (unit:GetEntry() == entry and unit:GetOwnerGUID() == player:GetGUID()) then
            player:Kill(unit);
        end
    end
end
local function ResetPlayer(player)
    print('wtf')
    player:ResetAllCooldowns();

    player:SetHealth(player:GetMaxHealth())
    if (player:GetPowerType() ~= 6 and player:GetPowerType() ~= 1) then
        player:SetPower(player:GetMaxPower(),player:GetPowerType())
    end

    player:CastSpell(player, ClearAllDebuffs, true)
    RemovePetByEntry(player, WaterElemental)
    RemovePetByEntry(player, Gargoyle)
    RemovePetByEntry(player, MirrorImage)
end

local function DuelReset(event, player1, player2)
    ResetPlayer(player1);
    ResetPlayer(player2);
end

RegisterPlayerEvent(9, DuelReset)
