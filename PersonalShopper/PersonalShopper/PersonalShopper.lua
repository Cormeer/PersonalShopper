local addonName, addon = ...
SLASH_RELOADUI1 = "/rlui";
SlashCmdList.RELOADUI = ReloadUI;
local PSFrame = CreateFrame("FRAME", "psFrame");
local itemList = {};

local function ShowHelp()
    print('Welcome to Personal Shopper by Cormeer.')
end

local function addToList(itemLink, quantity)
    itemList[itemLink] = quantity;
end

local function removeFromList(itemLink)
    itemList[itemLink] = nil;
end

local function printItemList()
    for key,value in pairs(itemList) do print(key,value) end
end

SLASH_PERSONALSHOPPER1 = '/shopper'
function SlashCmdList.PERSONALSHOPPER(msg, editbox)
    if msg == nil or msg == '' then
        ShowHelp();
    else
        local command, itemLink, quanity = msg:match("%S+")
        if(command == 'help') then
            ShowHelp();
        end
        if(command == 'add') then
            addToList(itemLink, quantity);
        end
        if(command == 'remove') then
            removeFromList(itemLink);
        end
        if(command == 'list') then
            printItemList();
        end
    end
end