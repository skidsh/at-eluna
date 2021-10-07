-- Original script by Foereaper (emudevs)
-- Edited by Renatokeys(emudevs)
-- http://emudevs.com/
-- Thanks.
require("ordered_table")

function EnchantSlot(player, slot, enchantRow)
    if (slot == -1 or enchantRow == {}) then
        return
    end    
    local dslot = slot;
    if(slot == 161 or slot == 151) then
        dslot = math.floor(slot/10)
    end
    local item = player:GetEquippedItemBySlot(dslot)
    if item then
        if (enchantRow[3]) then
            -- Two-Hand / Shield
            local WType = item:GetSubClass()
            if (slot == 151) then
                if(WType == 1 or WType == 5 or WType == 6 or WType == 8 or WType == 10) then
                    item:ClearEnchantment(0,0)
                    item:SetEnchantment(enchantRow[2], 0, 0)
                else
                    player:SendAreaTriggerMessage("You not have Two-handed weapon equipped")
					return false;
                end
            elseif slot == 161 then
                if(WType == 6) then
                    item:ClearEnchantment(0,0)
                    item:SetEnchantment(enchantRow[2], 0, 0)
                else
                    player:SendAreaTriggerMessage("You no have shield equipped")
					return false;
                end
            end
		elseif slot == 5 then
			-- belt socket
			item:SetUInt32Value(22 + 6 * 3 + 0, enchantRow[2]);
			item:SetUInt32Value(22 + 6 * 3 + 1, 0);
			item:SetUInt32Value(22 + 6 * 3 + 2, 0);
        elseif slot == 11 or slot == 10 then
            -- rings
			local enh = enchantRow[2]
			if (slot == 10) then
				enh = enh/10;
			end
            item:ClearEnchantment(0,0)
            item:SetEnchantment(enh, 0, 0)
            player:CastSpell(player, 36937)
		elseif slot == 17 then
			local rangedType = item:GetSubClass();
			if rangedType == 2 or rangedType == 3 then
				item:ClearEnchantment(0,0)
				item:SetEnchantment(enchantRow[2], 0, 0)
				player:CastSpell(player, 36937)
			else
				player:SendAreaTriggerMessage("Bow or Gun not equipped")
				return false;
			end
        else
            local IType = item:GetSubClass()
            if(IType==0) then
                player:SendAreaTriggerMessage("This item cannot be enchanted")
				return false;
            else
				if (enchantRow[2] == 3717 or enchantRow[2] == 3723) then
					-- blacksmithing socket
					item:SetUInt32Value(22 + 6 * 3 + 0, enchantRow[2]);
					item:SetUInt32Value(22 + 6 * 3 + 1, 0);
					item:SetUInt32Value(22 + 6 * 3 + 2, 0);
				else
               	 	item:ClearEnchantment(0,0)
                	item:SetEnchantment(enchantRow[2], 0, 0)
				end
                player:CastSpell(player, 36937)
            end
        end
    else
        player:SendAreaTriggerMessage("No item in selected slot")
		return false;
    end
	return true;
end

function findRowOfEnchant(enchant)
    for i, slot in pairs(enchantTable) do
        for j, enchantRow in pairs(slot) do
            if (enchantRow[2] == enchant) then
                return enchantRow;
            end
        end  
    end     
    return {};
end

function findSlotOfEnchant(enchant)
    for i, slot in pairs(enchantTable) do
        for j, enchantRow in pairs(slot) do
            if (enchantRow[2] == enchant) then
                return i;
            end
        end  
    end     
    return -1;
end

enchantMenu = {
    {"Headpiece", 0},
    {"Shoulders", 2},
    {"Chest", 4},
	{"Waist", 5},
    {"Legs", 6},
    {"Boots", 7},
    {"Bracers", 8},
    {"Gloves", 9},
    {"Cloak", 14},
	{"Weapons", 23},
    {"Main Ring",10};
    {"Second Ring",11};
};

weaponMenu = {	
    {"Main-Hand Weapons", 15},
    {"Two-Handed Weapons", 151},
    {"Off-Hand Weapons", 16},
    {"Shields", 161};
	{"Bow / Gun", 17};
}

enchantTable = {	
	[0] = { -- Headpiece
		--{"Mind Amplification dish",3878,false};
		{"+30 Spell Power and +20 Critical strike rating", 3820, false},
		{"+30 Spell Power and +10 mana per 5 seconds.", 3819, false},
		{"+37 Stamina and +20 Defense Rating", 3818, false},
		{"+50 Attack Power and +20 Critical Strike Rating", 3817, false},
		{"+30 Stamina and +25 Resilience Rating", 3842, false},
		{"+50 Attack Power and +20 Resilience Rating", 3795, false},
		{"+29 Spell Power and +20 Resilience Rating", 3797, false};
	},

	[2] = { -- Shoulders
		{"+40 Attack Power and +15 Resilience Rating", 3793, false},
		{"+23 Spell Power and +15 Resilience Rating", 3794, false},
		{"+30 Stamina and +15 Resilience Rating", 3852, false},
		{"+40 Attack Power and +15 Crit Rating", 3808, false},
		{"+24 Spell Power and +8 Mana per 5 sec", 3809, false},
		{"+20 Dodge Rating and +15 Defense Rating", 3811, false},
		{"+24 Spell Power and +15 Critical Strike Rating", 3810, false};
	},

	[4] = { -- Chest
		{"+10 All Stats", 3832, false},
		{"+275 Health", 3297, false},
		{"+10 mana every 5 sec.", 2381, false},
		{"+20 Resilience Rating", 3245, false},
		{"+22 Defense Rating", 1953, false};
	},

	[6] = { -- Legs
		{"+40 Resilience Rating and +28 Stamina", 3853, false},
		{"+55 Stamina and +22 Agility", 3822, false},
		{"+75 Attack Power and +22 Critical Strike Rating", 3823, false},
		{"+50 Spell Power and +20 Spirit", 3719, false},
		{"+50 Spell Power and +30 Stamina", 3721, false};
	},	

	[7] = { -- Boots
		--{"Enchant Boots - Nitro boosts",3606,false};
		{"+32 Attack Power", 1597, false},
		{"+15 Stamina and Minor Speed Increase", 3232, false},
		{"+6 Agility and Minor Speed Increase", 2939, false},
		{"+16 Agility", 983, false},
		{"+18 Spirit", 1147, false},
		{"+7 Health and Mana every 5 sec", 3244, false},
		{"+12 Hit Rating and +12 Critical Strike Rating", 3826, false},
		{"+22 Stamina", 1075, false};
	},

	[8] = { -- Bracers
		{"+40 Stamina", 3850, false},
		{"+30 Spell Power", 2332, false},
		{"+50 Attack Power", 3845, false},
		{"+18 Spirit", 1147, false},
		{"+15 Expertise Rating", 3231, false},
		{"+6 All Stats", 2661, false},
		{"+70 Arcane Resistance", 3763, false};
		{"+70 Fire Resistance", 3759, false};
		{"+70 Frost Resistance", 3760, false};
		{"+70 Nature Resistance", 3762, false};
		{"+70 Shadow Resistance", 3761, false};
		{"+130 Attack Power (Leathworking 400)", 3756, false};
		{"+102 Stamina (Leathworking 400)", 3757, false};
		{"+76 Spell Power (Leathworking 400)", 3758, false};
		{"Socket Bracer (Blacksmithing 400)", 3717, false};
	},

	[9] = { -- Gloves
		{"+16 Critical Strike Rating", 3249, false},
		{"+2% Threat and 10 Parry Rating", 3253, false},
		{"+44 Attack Power", 1603, false},
		{"+20 Agility", 3222, false},
		{"+20 Hit Rating", 3234, false},
		{"+15 Expertise Rating", 3231, false},
		{"+28 Spell Power", 3246, false};
		{"Socket Gloves (Blacksmithing 400)", 3723, false};
		{"Hand-Mounted Pyro Rocket (Engineering 375)",3603,false};
	},

	[14] = { -- Cloak
		{"Lightweave Embroidery (Tailoring 400)",3722,false};
		{"Darkglow Embroidery (Tailoring 400)",3728,false};
		{"Swordguard Embroidery (Tailoring 400)",3730,false};
		{"+27 Spell Power",3859,false};
		{"Flexweave Underlay",3605,false};
		{"Increased Stealth and +10 Agility", 3256, false},
		{"+10 Spirit and 2% Reduced Threat", 3296, false},
		{"+16 Defense Rating", 1951, false},
		{"+23 Haste Rating", 3831, false},
		{"+225 Armor", 3294, false},
		{"+22 Agility", 1099, false},
		{"+20 Arcane Resistance", 1262, false};
		{"+35 Spell Penetration", 3243, false};		
	},

	[15] = {
		-- Main Hand
		{"Titan Guard", 3851, false},
		{"Accuracy", 3788, false},
		{"Berserking", 3789, false},
		{"Black Magic", 3790, false},
		{"Mighty Spellpower", 3834, false},
		{"Superior Potency", 3833, false},
		{"Ice Breaker", 3239, false},
		{"Lifeward", 3241, false},
		{"Blood Draining", 3870, false},
		{"Blade Ward", 3869, false},
		{"Exceptional Agility", 1103, false},
		{"Exceptional Spirit", 3844, false},
		{"Executioner", 3225, false},
		{"Mongoose", 2673, false},
		{"Icebreaker",3239, false},
		{"Deathfrost",3273, false},
		{"Titanium Weapon Chain",3731, false},
	},
    [151] = {		
		-- Two-Handed
		{"Massacre", 3827, true},
		{"Scourgebane", 3247, true},
		{"Giant Slayer", 3251, true},
		{"Greater Spellpower", 3854, true};
    },
	
	[16] = {
		-- Offhand
		{"Titan Guard", 3851, false},
		{"Accuracy", 3788, false},
		{"Berserking", 3789, false},
		{"Superior Potency", 3833, false},
		{"Ice Breaker", 3239, false},
		{"Lifeward", 3241, false},
		{"Blood Draining", 3870, false},
		{"Blade Ward", 3869, false},
		{"Exceptional Agility", 1103, false},
		{"Exceptional Spirit", 3844, false},
		{"Executioner", 3225, false},
		{"Mongoose", 2673, false},
		{"Icebreaker",3239, false},
		{"Deathfrost",3273, false},
		{"Titanium Weapon Chain",3731, false},
	},
    [161] = {	
		-- Shields
		{"Defense", 1952, true},
		{"Greater Intellect", 1128, true},
		{"Shield Block", 2655, true},
		{"Resilience", 3229, true},
		{"Major Stamina", 1071, true},
		{"Tough Shield", 2653, true};
		{"Titanium Plating",3849,true};
    },
	[17] = {		
		-- Ranged
		{"+15 Damage", 3843, false},
		{"+40 Ranged Critical Strike", 3608, false},
		{"+40 Ranged Haste Rating", 3607, false};
    },
	[10] = {
		-- Rings
		{"Stamina (Enchanting 400)",37910,false};
		{"Attack power (Enchanting 400)",38390,false};
		{"Spell power (Enchanting 400)",38400,false};
	},
	[11] = {
		-- Rings
		{"Stamina (Enchanting 400)",3791,false};
		{"Attack power (Enchanting 400)",3839,false};
		{"Spell power (Enchanting 400)",3840,false};
	},
	[5] = {
		{"Eternal Belt Buckle - Socket",3729,false};		
	}
};