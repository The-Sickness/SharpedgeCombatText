-- SharpedgeCombatText
-- Made by Sharpedge_Gaming
-- v1.0	 - 10.0.2

local font = [[Interface\Addons\SharpedgeCombatText\Sharp.ttf]];

local LSM = LibStub("LibSharedMedia-3.0") 
LSM:Register("font", "Sharp", font);




local optionsTable = {
	name = "SharpedgeCombatText",
	type = 'group',
	args = {
		worldTextScaleSlider = {
			type = 'range',
			name = "Text Size",
			desc = "Changes damage number size",
			min = 0.5,
			max = 2.5,
			step = 0.1,
			get = function() return tonumber(GetCVar("WorldTextScale")) end,
			set = function(_, newValue) SetCVar("WorldTextScale",newValue) end,
			order = 1,
		},
	},
};
LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("SharpedgeCombatText", optionsTable);
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SharpedgeCombatText", "SharpedgeCombatText");
