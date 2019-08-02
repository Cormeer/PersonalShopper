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
        local command = msg:match("%S+")
        if(command == 'add' or command == 'remove') then
          itemLink = msg:match("|c.-|r")
          if(command == "add") then
            quantity = msg:match("%d+$")
          end
        end

        if(command == 'help') then
            ShowHelp();
        end
        if(command == 'add') then
            addToList(itemLink, quantity);
            print('Added: ', itemLink, ' ', quantity, ' to your shopping list.'
        end
        if(command == 'remove') then
            removeFromList(itemLink);
            print('Removed ', itemLink, ' from your shopping list.'
        end
        if(command == 'list') then
            printItemList();
        end
    end
end




        --[[local command, itemLink, quantity = msg:match("(%S+)%s*(|c.-|r)%s*(%d+)")
        print(command)
        print(itemLink)
        print(quantity)
        --print(msg:match("(%S+)%s*(|c.-|r)%s*(%d+)"))
        ]]
