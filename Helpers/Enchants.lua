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
                end
            elseif slot == 161 then
                if(WType == 6) then
                    item:ClearEnchantment(0,0)
                    item:SetEnchantment(enchantRow[2], 0, 0)
                else
                    player:SendAreaTriggerMessage("You no have shield equipped")
                end
            end
        elseif slot == 11 or slot == 10 then
            -- 
            item:ClearEnchantment(0,0)
            item:SetEnchantment(enchantRow[2], 0, 0)
            player:CastSpell(player, 36937)
        else
            local IType = item:GetSubClass()
            if(IType==0) then
                player:SendAreaTriggerMessage("This item cannot be enchanted")
            else
                item:ClearEnchantment(0,0)
                item:SetEnchantment(enchantRow[2], 0, 0)
                player:CastSpell(player, 36937)
            end
        end
    else
        player:SendAreaTriggerMessage("No item in selected slot")
    end
end

function findRowOfEnchant(enchant)
    for i, slot in orderedPairs(enchantTable) do
        for j, enchantRow in orderedPairs(slot) do
            if (enchantRow[2] == enchant) then
                return enchantRow;
            end
        end  
    end     
    return {};
end

function findSlotOfEnchant(enchant)
    for i, slot in orderedPairs(enchantTable) do
        for j, enchantRow in orderedPairs(slot) do
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
    {"Legs", 6},
    {"Boots", 7},
    {"Bracers", 8},
    {"Gloves", 9},
    {"Cloak", 14},
    {"Main-Hand Weapons", 15},
    {"Two-Handed Weapons", 151},
    {"Off-Hand Weapons", 16},
    {"Shields", 161};
    {"Main Ring",10};
    {"Second Ring",11};
};

enchantTable = {	
	[0] = { -- Headpiece
		--{"Mind Amplification dish",3878,false};
		{"Arcanum of Burning Mysteries", 3820, false},
		{"Arcanum of Blissful Mending", 3819, false},
		{"Arcanum of the Stalward Protector", 3818, false},
		{"Arcanum of Torment", 3817, false},
		{"Arcanum of the Savage Gladiator", 3842, false},
		{"Arcanum of Triumph", 3795, false},
		{"Arcanum of Dominance", 3797, false};
	},

	[2] = { -- Shoulders
		{"Inscription of Triumph", 3793, false},
		{"Inscription of Dominance", 3794, false},
		{"Greater Inscription of the Gladiator", 3852, false},
		{"Greater Inscription of the Axe", 3808, false},
		{"Greater Inscription of the Crag", 3809, false},
		{"Greater Inscription of the Pinnacle", 3811, false},
		{"Greater Inscription of the Storm", 3810, false};
	},

	[4] = { -- Chest
		{"Enchant Chest - Powerful Stats", 3832, false},
		{"Enchant Chest - Super Health", 3297, false},
		{"Enchant Chest - Greater Mana Restoration", 2381, false},
		{"Enchant Chest - Exceptional Resilience", 3245, false},
		{"Enchant Chest - Greater Defense", 1953, false};
	},

	[6] = { -- Legs
		{"Earthen Leg Armor", 3853, false},
		{"Frosthide Leg Armor", 3822, false},
		{"Icescale Leg Armor", 3823, false},
		{"Brilliant Spellthread", 3719, false},
		{"Sapphire Spellthread", 3721, false};
	},	

	[7] = { -- Boots
		{"Enchant Boots - Nitro boosts",3606,false};
		{"Enchant Boots - Greater Assault", 1597, false},
		{"Enchant Boots - Tuskars Vitality", 3232, false},
		{"Enchant Boots - Superior Agility", 983, false},
		{"Enchant Boots - Greater Spirit", 1147, false},
		{"Enchant Boots - Greater Vitality", 3244, false},
		{"Enchant Boots - Icewalker", 3826, false},
		{"Enchant Boots - Greater Fortitude", 1075, false};
	},

	[8] = { -- Bracers
		{"Enchant Bracers - Major Stamina", 3850, false},
		{"Enchant Bracers - Superior Spellpower", 2332, false},
		{"Enchant Bracers - Greater Assault", 3845, false},
		{"Enchant Bracers - Major Spirit", 1147, false},
		{"Enchant Bracers - Expertise", 3231, false},
		{"Enchant Bracers - Greater Stats", 2661, false},
		{"Enchant Bracers - Arcane Resist", 3763, false};
		{"Enchant Bracers - Fire Resist", 3759, false};
		{"Enchant Bracers - Frost Resist ", 3760, false};
		{"Enchant Bracers - Nature Resist ", 3762, false};
		{"Enchant Bracers - Shadow Resist ", 3761, false};
		{"Enchant Bracers - Attack power + 130 ", 3756, false};
		{"Enchant Bracers - Stamina + 102 ", 3757, false};
		{"Enchant Bracers - Spell power + 76 ", 3758, false};
	},

	[9] = { -- Gloves
		{"Enchant Gloves - Hand-Mounted Pyro Rocket",3603,false};
		{"Enchant Gloves - Greater Blasting", 3249, false},
		{"Enchant Gloves - Armsman", 3253, false},
		{"Enchant Gloves - Crusher", 1603, false},
		{"Enchant Gloves - Agility", 3222, false},
		{"Enchant Gloves - Precision", 3234, false},
		{"Enchant Gloves - Expertise", 3231, false},
		{"Enchant Gloves - Exceptional Spellpower", 3246, false};
	},

	[14] = { -- Cloak
		{"Enchant Cloak - Lightweave Embroidery",3722,false};
		{"Enchant Cloak - Darkglow Embroidery",3728,false};
		{"Enchant Cloak - Swordguard Embroidery",3730,false};
		{"Enchant Cloak - Springy Arachnoweave",3859,false};
		{"Enchant Cloak - Flexweave Underlay",3605,false};
		{"Enchant Cloak - Shadow Armor", 3256, false},
		{"Enchant Cloak - Wisdom", 3296, false},
		{"Enchant Cloak - Titan Weave", 1951, false},
		{"Enchant Cloak - Greater Speed", 3831, false},
		{"Enchant Cloak - Mighty Armor", 3294, false},
		{"Enchant Cloak - Major Agility", 1099, false},
		{"Enchant Cloak - Spell Piercing", 1262, false};
	},

	[15] = {
		-- Main Hand
		{"Enchant Weapon - Titan Guard", 3851, false},
		{"Enchant Weapon - Accuracy", 3788, false},
		{"Enchant Weapon - Berserking", 3789, false},
		{"Enchant Weapon - Black Magic", 3790, false},
		{"Enchant Weapon - Mighty Spellpower", 3834, false},
		{"Enchant Weapon - Superior Potency", 3833, false},
		{"Enchant Weapon - Ice Breaker", 3239, false},
		{"Enchant Weapon - Lifeward", 3241, false},
		{"Enchant Weapon - Blood Draining", 3870, false},
		{"Enchant Weapon - Blade Ward", 3869, false},
		{"Enchant Weapon - Exceptional Agility", 1103, false},
		{"Enchant Weapon - Exceptional Spirit", 3844, false},
		{"Enchant Weapon - Executioner", 3225, false},
		{"Enchant Weapon - Mongoose", 2673, false},
		{"Enchant Weapon - Icebreaker",3239, false},
		{"Enchant Weapon - Deathfrost",3273, false},
		{"Enchant Weapon - Titanium Weapon Chain",3731, false},
	},
    [151] = {		
		-- Two-Handed
		{"Enchant 2H Weapon - Massacre", 3827, true},
		{"Enchant 2H Weapon - Scourgebane", 3247, true},
		{"Enchant 2H Weapon - Giant Slayer", 3251, true},
		{"Enchant 2H Weapon - Greater Spellpower", 3854, true};
    },
	
	[16] = {
		-- Offhand
		{"Enchant Weapon - Titan Guard", 3851, false},
		{"Enchant Weapon - Accuracy", 3788, false},
		{"Enchant Weapon - Berserking", 3789, false},
		{"Enchant Weapon - Superior Potency", 3833, false},
		{"Enchant Weapon - Ice Breaker", 3239, false},
		{"Enchant Weapon - Lifeward", 3241, false},
		{"Enchant Weapon - Blood Draining", 3870, false},
		{"Enchant Weapon - Blade Ward", 3869, false},
		{"Enchant Weapon - Exceptional Agility", 1103, false},
		{"Enchant Weapon - Exceptional Spirit", 3844, false},
		{"Enchant Weapon - Executioner", 3225, false},
		{"Enchant Weapon - Mongoose", 2673, false},
		{"Enchant Weapon - Icebreaker",3239, false},
		{"Enchant Weapon - Deathfrost",3273, false},
		{"Enchant Weapon - Titanium Weapon Chain",3731, false},
	},
    [161] = {	
		-- Shields
		{"Enchant Shield - Defense", 1952, true},
		{"Enchant Shield - Greater Intellect", 1128, true},
		{"Enchant Shield - Shield Block", 2655, true},
		{"Enchant Shield - Resilience", 3229, true},
		{"Enchant Shield - Major Stamina", 1071, true},
		{"Enchant Shield - Tough Shield", 2653, true};
		{"Enchant Shield - Titanium Plating",3849,true};
    },
	[10] = {
		-- Rings
		{"Enchant Ring - Stamina",3791,false};
		{"Enchant Ring - Attack power",3839,false};
		{"Enchant Ring - Spell power",3840,false};
	},
	[11] = {
		-- Rings
		{"Enchant Ring - Stamina",3791,false};
		{"Enchant Ring - Attack power",3839,false};
		{"Enchant Ring - Spell power",3840,false};
	},
};