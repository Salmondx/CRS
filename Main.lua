local appName = "|CRS:|r ";
local CRSFrame = CreateFrame("FRAME") CRSFrame:Hide()

local playerGUID = UnitGUID("player");

local soundsToMute = {
	-- ROGUE
	-- mutilate
	1302591,
	1302592,
	1302593,
	1302594,
	1301172,
	1301173,
	1301174,
	1301175,
	1301176,
	-- ambush
	1308151,
	1308152,
	1308153,
	-- envenom
	1301162,
	1301163,
	1301164,
	1301165,
	1301166,
	1301177,
	1301178,
	1301161,
	-- garrote
	1267926,
	1267927,
	1267928,
	1311830,
	1311831,
	1311832,
	1311833,
	1311834,
	-- snd
	1362393,
	1362394,
	1362395,
	1362396,
	-- shiv
	627412,
	627414,
	627416,
	-- FoK
	1301167,
	1301168,
	1301169,
	1301170,
	1301171,
	-- gouge
	568415,
	568533,
	-- crimson tempest
	1311847,
	1311848,
	1311849,
	1311850,
	1311851,
	1453442,
	1453443,
	-- saber slash
	1348450,
	1348451,
	1348452,
	1348453,
};

local _debug = true -- Enable to Display debug messages.
function errTxt(msg)
	if ( _debug == false ) then
		print(appName.. " _DEBUG : "..msg);
	end
end

function MuteSounds()
	for i, id in ipairs(soundsToMute) do
		MuteSoundFile(id);
	end
end

function CRSFrame:ADDON_LOADED(arg1)
	if arg1 ~= "CRS" then
                return
	end
	self:UnregisterEvent("ADDON_LOADED")
	print(appName.. "Loaded");
	MuteSounds();
end

local SwingSounds = {
	"Interface\\Addons\\CRS\\Sounds\\Swing1.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Swing2.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Swing3.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Swing4.ogg"
};

local DSSounds = {
	"Interface\\Addons\\CRS\\Sounds\\DS1.ogg",
	"Interface\\Addons\\CRS\\Sounds\\DS2.ogg",
	"Interface\\Addons\\CRS\\Sounds\\DS3.ogg",
};

local Swords2HSwings = {
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit1.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit2.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit3.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit4.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit5.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit6.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit7.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit8.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit9.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Swords_2H\\Hit10.ogg",
};

local Maces2HSwings = {
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit1.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit2.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit3.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit4.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit5.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit6.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit7.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit8.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit9.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Maces_2H\\Hit10.ogg",
};

local Axes2HSwings = {
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit1.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit2.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit3.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit4.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit5.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit6.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit7.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit8.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit9.ogg",
	"Interface\\Addons\\CRS\\Sounds\\Weapons\\Axes_2H\\Hit10.ogg",
};

-- contains IDs of spells that should play a Rend sound on crit
local CritEffect = {
	[7384] = true,
	-- [12294] = true,
};

local TransmogLocationMixin={}
local transmogLocation = CreateFromMixins(TransmogLocationMixin)
transmogLocation.slotID=16
transmogLocation.type=0
transmogLocation.modification=0

function PlaySwingSound()
	local itemType = DetectWeaponType();
	if itemType == "2H Mace" then
		PlaySoundFile(Maces2HSwings[math.random(#Maces2HSwings)], "SFX");
	elseif itemType == "2H Sword" then
		PlaySoundFile(Swords2HSwings[math.random(#Swords2HSwings)], "SFX");
	elseif itemType == "2H Axe" then
		PlaySoundFile(Axes2HSwings[math.random(#Axes2HSwings)], "SFX");
	end;
end

function DetectWeaponType()
	local baseSourceID, baseVisualID, appliedSourceID, appliedVisualID, appliedCategoryID, pendingSourceID, pendingVisualID, pendingCategoryID, hasUndo, isHideVisual, itemSubclass = C_Transmog.GetSlotVisualInfo(transmogLocation);
	if itemSubclass == 5 then
		return "2H Mace";
	elseif itemSubclass == 8 then
		return "2H Sword";
	elseif itemSubclass == 1 then
		return "2H Axe";
	else
		return;
	end;
end

function BladestormRend()
	local found = select(1, AuraUtil.FindAuraByName("Bladestorm", "player"));
	if found ~= nil then
		PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Rend.ogg", "SFX");
		C_Timer.After(1, BladestormRend);
	end
end

function PlayCleaveSoundIfSweepingStrikes()
	local found = select(1, AuraUtil.FindAuraByName("Sweeping Strikes", "player"));
	if found ~= nil then
		PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Cleave.ogg", "SFX");
	end
end

-- Not Used. Was an attempt to play crit related sounds but without Rend sounds
-- on retail it sounds bad. To much ambient noise on retail comparing to Classic
function CRSFrame:COMBAT_LOG_EVENT_UNFILTERED()
	HandleCombatLog(CombatLogGetCurrentEventInfo());
end

function HandleCombatLog(...)
	local ts, subevent, _, sourceGUID = ...;
	if sourceGUID ~= playerGUID then
		return;
	end

	if subevent == "SPELL_DAMAGE" then
		local spellId, _, _, _, _, _, _, _, _, critical = select(12, ...);
		if CritEffect[spellId] and critical then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Rend.ogg", "SFX");
		end
	end
end
--
function CRSFrame:UNIT_SPELLCAST_SUCCEEDED(unitID, lineID, spellID)
	if unitID == "player" then
		errTxt("Spell cast Succeeded, spellID ".. spellID);

		-- add poison sounds just for fun
		if math.random(5) == 1 then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\HellRot.ogg", "SFX");
		end

		-- Begin Mutilate
		if spellID == 1329 then
			PlaySoundFile(SwingSounds[math.random(#SwingSounds)], "SFX");
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Mutilate.ogg", "SFX");
		end

		-- Begin Rupture
		if spellID == 1943 then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Rend.ogg", "SFX");
		end

		-- Ambush
		if spellID == 8676 or spellID == 430023 then
			PlaySoundFile(SwingSounds[math.random(#SwingSounds)], "SFX");
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Backstab.ogg", "SFX");
		end

		-- Envenom
		if spellID == 32645 then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Envenom.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\HellRot.ogg", "SFX");
		end

		-- Garrote
		if spellID == 703 then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Rend.ogg", "SFX");
		end

		-- SnD
		if spellID == 315496 then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Cleave.ogg", "SFX");
		end

		-- Shiv
		if spellID == 5938 then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Backstab.ogg", "SFX");
		end

		-- FoK
		if spellID == 51723 then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\FoK.ogg", "SFX");
		end

		-- Gouge
		if spellID == 1776 then
			PlaySoundFile(SwingSounds[math.random(#SwingSounds)], "SFX");
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Gouge.ogg", "SFX");
		end

		-- Evasion
		if spellID == 5277 then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\ShadowCast.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Evasion.ogg", "SFX");
		end

		-- CS
		if spellID == 1833 then
			PlaySoundFile(SwingSounds[math.random(#SwingSounds)], "SFX");
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Kidneyshot.ogg", "SFX");
		end

		-- Crimson Tempest
		if spellID == 121411 then
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Cleave.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CRS\\Sounds\\Backstab.ogg", "SFX");
		end
	end

end
CRSFrame:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)
CRSFrame:RegisterEvent("ADDON_LOADED")
CRSFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
CRSFrame:RegisterEvent("PLAYER_DEAD")
CRSFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
