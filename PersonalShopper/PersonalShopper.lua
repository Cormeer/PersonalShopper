local addonName, addon = ...
SLASH_RELOADUI1 = "/rlui";
SlashCmdList.RELOADUI = ReloadUI;
local PSFrame = CreateFrame("FRAME", "psFrame");
itemList = {}
PSFrame:RegisterEvent("MERCHANT_SHOW")
PSFrame:RegisterEvent("ADDON_LOADED")
versionNum = 1;

local function ShowHelp()
    print('Welcome to Personal Shopper by Cormeer.')
    print('Slash commands:')
    print('/shopper help - displays this help page.')
    print('/shopper list - displays your current shopping list.')
    print('/shopper add [Item Link] [quantity] - adds the item and quantity to your shopping list.')
    print('/shopper remove [Item Link] - removes the item from your shopping list.')
print('/shopper clear - removes all items from your shopping list.')
end

local function addToList(itemID, quantity)
    itemList[itemID] = quantity;
end

local function removeFromList(itemID)
    itemList[itemID] = nil;
end

local function printItemList()
    print("Your current shopping list:")
    for key,value in pairs(itemList) do
      local _,itemLink,_,_,_,
      _,_,_,_,_,_ = GetItemInfo(key)
      print(itemLink,value)
    end
end

SLASH_PERSONALSHOPPER1 = '/shopper'
function SlashCmdList.PERSONALSHOPPER(msg, editbox)
    if msg == nil or msg == '' then
        ShowHelp();
    else
        local command = msg:match("%S+")
        if(command == 'add' or command == 'remove') then
          itemLink = msg:match("|c.-|r")
          itemID,_,_,_,_,_,_ = GetItemInfoInstant(itemLink)
          if(command == "add") then
            quantity = msg:match("%d+$")
          end
        end

        if(command == 'help') then
            ShowHelp();
       
        elseif(command == 'add') then
            if itemID ~= nil and itemLink ~= nil and quantity ~= nil then
                addToList(itemID, quantity);
                print('Added:', itemLink, 'x',quantity, 'to your shopping list.')
            else
                print("Please enter a valid item link and quantity.")
            end
       
        elseif(command == 'remove') then
            if itemID ~= nil and itemLink ~= nil then
                removeFromList(itemID);
                print('Removed', itemLink, 'from your shopping list.')
            else
                print("Please enter a valid item link.")
            end
       
        elseif(command == 'clear') then
          print("Clearing all items from your shopping list.")
          itemList = {}
       
        elseif(command == 'list') then
            printItemList();
        else
            print("Please enter a valid command.")
        end
    end
end

local function merchantShowHandler()
  local numMerchantItems = GetMerchantNumItems();
  for i=1,numMerchantItems do
    for itemID, quantity in pairs(itemList) do
      local name, link, quality, iLevel, reqLevel,
      class, subclass, maxStack, equipSlot, texture,
      vendorPrice = GetItemInfo(itemID)
     
      local mercName, mercTexture, mercPrice, mercQuantity,
      mercNumAvailable, mercIsUsable,
      mercExtendedCost = GetMerchantItemInfo(i)
     
      local numOwned = GetItemCount(itemID)
      local numToBuy = quantity-numOwned;
      if(numToBuy < 0) then numToBuy = 0; end
      if(name == mercName and numToBuy > 0 and name ~= nil and mercName ~= nil) then
        if(mercNumAvailable ~= -1) then
            print('Personal Shopper will not purchase limited-quantity items.')
        else
            if( numToBuy > maxStack ) then
              local remainder = numToBuy % maxStack;
              local tempNum = numToBuy - remainder;
              local stacks = tempNum / maxStack;
              for j=1, stacks do
                BuyMerchantItem(i, maxStack)
              end
              if(remainder > 0) then BuyMerchantItem(i, remainder) end
            else
              BuyMerchantItem(i, numToBuy)
            end
        end
      end
    end
  end
end


local function updateToVersion2()
  local tempItemList = {}
  for itemLink,quantity in pairs(itemList) do
    local itemID,_,_,_,_,_,_ = GetItemInfoInstant(itemLink);
    tempItemList[itemID] = quantity;
  end
  itemList=tempItemList;
  versionNum=2;
end

local function checkVersion()
  if(versionNum == 1) then updateToVersion2() end
end

local function eventHandler(self, event, arg1, ...)
  if (event == "MERCHANT_SHOW") then 
    merchantShowHandler() 
  elseif (event == "ADDON_LOADED" and arg1==addonName) then 
    checkVersion() 
  end
end

PSFrame:SetScript("OnEvent", eventHandler);
