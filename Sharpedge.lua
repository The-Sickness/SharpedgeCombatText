-- SharpedgeCombatText
-- Made by Sharpedge_Gaming
-- v1.1 - enables combat text and provides size control

local ADDON_NAME = "SharpedgeCombatText"
local font = [[Interface\AddOns\SharpedgeCombatText\Sharp.ttf]]

local LSM = LibStub("LibSharedMedia-3.0")
LSM:Register("font", "Sharp", font)

-- CVars we want to enforce
local ENABLE_CVARS = {
    floatingCombatTextCombatDamage = 1,
    floatingCombatTextCombatHealing = 1,
    floatingCombatTextCombatDamageDirectionalScale = 1,
    floatingCombatTextCombatHealingAbsorbTarget = 1,
    floatingCombatTextCombatHealingAbsorbSelf = 1,
    floatingCombatTextCombatDamageAll = 1, -- include periodic/pet
    floatingCombatTextCombatHealingAll = 1,
    floatingCombatTextPetSpellDamage = 1,
    floatingCombatTextPetMeleeDamage = 1,
    floatingCombatTextReactives = 1,
    floatingCombatTextFriendlyHealers = 1,
    WorldTextScale = tonumber(GetCVar("WorldTextScale")) or 1.0,
}

local function ApplyCombatTextCVars()
    for cvar, value in pairs(ENABLE_CVARS) do
        SetCVar(cvar, value)
    end
end

-- Options table for AceConfig
local optionsTable = {
    name = ADDON_NAME,
    type = "group",
    args = {
        worldTextScaleSlider = {
            type = "range",
            name = "Text Size",
            desc = "Changes damage number size",
            min = 0.5,
            max = 2.5,
            step = 0.1,
            get = function() return tonumber(GetCVar("WorldTextScale")) end,
            set = function(_, newValue)
                SetCVar("WorldTextScale", newValue)
                ENABLE_CVARS.WorldTextScale = newValue
            end,
            order = 1,
        },
        reapply = {
            type = "execute",
            name = "Reapply Combat Text",
            desc = "Force-enable all combat text CVars",
            func = function() ApplyCombatTextCVars() end,
            order = 2,
        },
    },
}

-- Event frame to apply settings on load
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    ApplyCombatTextCVars()
end)

-- Register options
LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(ADDON_NAME, optionsTable)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions(ADDON_NAME, ADDON_NAME)

-- Slash command
SLASH_SHARPEDGECOMBATTEXT1 = "/sct"
SlashCmdList["SHARPEDGECOMBATTEXT"] = function(msg)
    msg = msg and msg:lower() or ""
    if msg == "apply" or msg == "on" then
        ApplyCombatTextCVars()
        print("|cff00ff00SharpedgeCombatText:|r Combat text CVars reapplied.")
    else
        InterfaceOptionsFrame_OpenToCategory(ADDON_NAME)
        InterfaceOptionsFrame_OpenToCategory(ADDON_NAME) -- called twice to work around Blizzard quirk
    end
end
