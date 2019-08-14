This is an add-on can be used to automatically purchase items at the vendor.
Personal Shopper works by creating a vitual shopping list that is consulted when you visit a vendor.
You may add an item and a quantity to your shopping list, and each time you visit a vendor that sells that item,
Personal Shopper will purchase a number of that item up to that quantity.

# Getting started
1. install the World of Warcraft Classic beta
2. on this web page, click the green **Clone or download** button above and to the right
3. click **Download ZIP**
4. once the ZIP is downloaded, open it on your desktop
5. open the `PersonalShopper-master` folder inside the ZIP file
6. open a new Windows File Explorer window (Windows key + E) and use it to open the World of Warcraft Classic beta installation directory (if you installed World of Warcraft in its default location, you can copy and paste this into the address bar for Windows File Explorer: `%PROGRAMFILES(X86)%\World of Warcraft\_classic_beta_`)
7. open the `Interface` folder (if it doesn't exist, create it)
8. open the `AddOns` folder (if it doesn't exist, create it)
9. copy the `PersonalShopper` folder from the ZIP file into the `AddOns` folder

# Using Personal Shopper
1. the base slash command for using Personal Shopper is /shopper. Entering this by itself will display the help page.
2. enter "/shopper help" into the chat window to see a list of the available slash commands
3. enter "/shopper list" to view your current shopping list. If you list is empty, nothing will be displayed.
4. enter "/shopper add [item link] X" (where [item link] is the actual link to the intended item and X is the intended quantity) 
   to add the item and desired quantity to your shopping list. Once an item is in your shopping list, Personal Shopper will buy that item    up to the desired quantity. It will not buy that quantity each time you visit the vendor. Rather, it checks how many of the item you      currently posess and it will buy enough of the item to where you posses X number of the item.
   Note: if the item is already in your list and you enter a new quantity, Personal Shopper will update the list entry with the new          quantity.
5. enter "/shopper remove [item link]" (where [item link] is the actual link to the intended item) to remove an item from your shopping      list
