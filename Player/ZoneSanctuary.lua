local function Sanctuary(event, player, newZone, newArea)
    if (newArea == 876) then
        -- Gm Island
        player:SetSanctuary(true)
    end
    if (newArea == 616 and newZone == 616) then
        player:SetSanctuary(true)
    end
end
RegisterPlayerEvent(27, Sanctuary);
