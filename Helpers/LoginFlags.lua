function SetRename(player)
    player:SetAtLoginFlag(1)
    player:SendBroadcastMessage("Relog To Rename")
end
function SetCustomize(player)
    player:SetAtLoginFlag(8)
    player:SendBroadcastMessage("Relog To Recustomize")
end
function SetRaceChange(player)
    player:SetAtLoginFlag(128)
    player:SendBroadcastMessage("Relog To Race Change")
end
function SetFactionChange(player)
    player:SetAtLoginFlag(64)
    player:SendBroadcastMessage("Relog Faction Change")
end
function ChangeChar(player, id)
    if (id == 2) then
        SetRename(player)
    end
    if (id == 3) then
        SetCustomize(player)
    end
    if (id == 4) then
        SetRaceChange(player)
    end
    if (id == 5) then
        SetFactionChange(player)
    end
end