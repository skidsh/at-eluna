local function LoginPaladin(event, player)
    if (player:GetClass() == 2) then
        if (player:IsAlliance()) then
            if (not player:HasSpell(31801)) then
                player:LearnSpell(31801)
            end
        else
            if (not player:HasSpell(53736)) then
                player:LearnSpell(53736)
            end
        end

        if (player:HasSpell(25899) and not player:HasSpell(20911)) then
            player:RemoveSpell(25899)
        end
    end
end

RegisterPlayerEvent(3, LoginPaladin)