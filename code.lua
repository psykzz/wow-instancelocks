-- This file is loaded from "Lockouts.toc"
local addon = CreateFrame("FRAME");

local function PrintSavedInstances(arg_raid)
    instances = GetNumSavedInstances();
    if instances > 0 then
        SendChatMessage("== Saved Instances ==", "PARTY");
        for instanceIdx = 1, instances do
            name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(instanceIdx);
            if locked == true and isRaid == arg_raid then
                message = string.format("%s (%s): %s / %s", name, difficultyName, encounterProgress, numEncounters);
                SendChatMessage(message, "PARTY");
            end
        end
    end
end

local function HandleSlash(args)
    PrintSavedInstances(args == "raid")
end

local function OnLoad()
    SLASH_PSYKZZ1 = '/lockouts';
    SlashCmdList['PSYKZZ'] = HandleSlash;
    print("Loaded psykzz' lockout")
end

local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...;
        if addonName == "Lockouts" then
            OnLoad();
            self:UnregisterEvent("ADDON_LOADED");
        end
    end
end

addon:RegisterEvent("ADDON_LOADED");
addon:SetScript("OnEvent", OnEvent);
