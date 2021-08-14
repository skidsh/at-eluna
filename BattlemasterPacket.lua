function GetArenaBattlemasterPacket(unit)
    -- guid + uint8 0 + bgTypeId uint32 (6) + uint8 0 + uint8 0 + uint8 0 + uint32 0 + uint32 0 + uint32 0 + uint8 0 + uint32 0
    local packet = CreatePacket(0x23D, 200)
    packet:WriteGUID(unit:GetGUID())
    packet:WriteUByte(0);
    packet:WriteULong(6);
    packet:WriteUByte(0);
    packet:WriteUByte(0);
    packet:WriteUByte(0);
    packet:WriteULong(0);
    packet:WriteULong(0);
    packet:WriteULong(0);
    packet:WriteUByte(0);
    packet:WriteULong(0);
    return packet;
end