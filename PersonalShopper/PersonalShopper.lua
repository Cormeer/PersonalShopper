local addonName, addon = ...
SLASH_RELOADUI1 = "/rlui";
SlashCmdList.RELOADUI = ReloadUI;
local PSFrame = CreateFrame("FRAME", "psFrame");
itemList = {};
PSFrame:RegisterEvent("MERCHANT_SHOW")

local function ShowHelp()
    print('Welcome to Personal Shopper by Cormeer.')
    print('Slash commands:')
    print('/shopper help - displays this help page.')
    print('/shopper list - displays your current shopping list.')
    print('/shopper add [Item Link] [quantity] - adds the item and quantity to your shopping list.')
    print('/shopper remove [Item Link] - removes the item from your shopping list.')
end

local function addToList(itemLink, quantity)
    itemList[itemLink] = quantity;
end

local function removeFromList(itemLink)
    itemList[itemLink] = nil;
end

local function printItemList()
    print("Your current shopping list:")
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
        
        elseif(command == 'add') then
            if itemLink ~= nil and quantity ~= nil then
                addToList(itemLink, quantity);
                print('Added: ', itemLink, ' ', quantity, ' to your shopping list.')
            else
                print("Please enter a valid item link and quantity.")
            end
        
        elseif(command == 'remove') then
            if itemLink ~= nil then
                removeFromList(itemLink);
                print('Removed ', itemLink, ' from your shopping list.')
            else
                print("Please enter a valid item link")
            end
        
        elseif(command == 'list') then
            printItemList();
        else
            print("Please enter a valid command")
        end
    end
end

local function merchantShowHandler()
  local numMerchantItems = GetMerchantNumItems();
  for i=1,numMerchantItems do
    for itemLink, quantity in pairs(itemList) do
      local name, link, quality, iLevel, reqLevel, 
      class, subclass, maxStack, equipSlot, texture, 
      vendorPrice = GetItemInfo(itemLink)
      
      local mercName, mercTexture, mercPrice, mercQuantity, 
      mercNumAvailable, mercIsUsable, 
      mercExtendedCost = GetMerchantItemInfo(i)
      
      local numOwned = GetItemCount(itemLink)
      local numToBuy = quantity-numOwned;
      if(numToBuy < 0) then numToBuy = 0; end
      if(name == mercName and numToBuy > 0) then
        if(mercNumAvailable ~= -1) then
            print('Personal Shopper will not purchase limited-quantity items.')
        else
            BuyMerchantItem(i, numToBuy)
        end
      end
    end
  end
end

PSFrame:SetScript("OnEvent", merchantShowHandler);
