module(..., package.seeall);

local store = require("store");
local callback = nil;

--To get a price from any screen, just call iap.localizedPrices[XX] and replace the XX with the item number that you'd like
localizedPrices = {};


--[[
Fill out this section with the price that you want (otherwise it will load the prices dynamically)
******Uncomment this section if you want to override the prices that it fetches******
--]]
localizedPrices[1] = "$0.99";
localizedPrices[2] = "$4.99";
localizedPrices[3] = "$9.99";
localizedPrices[4] = "$22.99";
localizedPrices[5] = "$43.99";
localizedPrices[6] = "$59.99";


--Fill out this section with all your product IDs. Add or remove them as necessary
local productID = 
{
	"1Diamond", --buyItem1
	"6Diamonds", --buyItem2
	"12Diamonds", --buyItem3
	"30Diamonds", --buyItem4
	"60Diamonds", --buyItem5
	"85Diamonds", --buyItem6 
}

--If you specifed a callback, then your callback function (in another lua file) would be something like this:

--[[

local function callback(state)

	if (state == "purchased") then
	
	elseif (state == "cancelled") then
	
	elseif (state == "failed") then
	
	end

end

iap.buyItem1(callback)

]]--

function transactionCallback(e)
	local trans = e.transaction;
	
	if (trans.state == "purchased") then
		if (trans.productIdentifier == productID[1]) then --item1

			print ("success buying product 1! Give the user the item here, or in the callback (see comments above)");
			
		elseif (trans.productIdentifier == productID[2]) then --item2
	
			print ("success buying product 2! Give the user the item here or in the callback (see comments above)");

		elseif (trans.productIdentifier == productID[3]) then --item3
	
			print ("success buying product 3! Give the user the item here or in the callback (see comments above)");
			
		elseif (trans.productIdentifier == productID[4]) then --item4
			
			print ("success buying product 4! Give the user the item here or in the callback (see comments above)");
		
		elseif (trans.productIdentifier == productID[5]) then --item5
		
			print ("success buying product 5! Give the user the item here or in the callback (see comments above)");
		
		elseif (trans.productIdentifier == productID[6]) then --item6
			
			print ("success buying product 6! Give the user the item here or in the callback (see comments above)");
			
		elseif (trans.productIdentifier == productID[7]) then --item7
			
			print ("success buying product 7! Give the user the item here or in the callback (see comments above)");
			
		elseif (trans.productIdentifier == productID[8]) then --item8
			
			print ("success buying product 8! Give the user the item here or in the callback (see comments above)");
			
		elseif (trans.productIdentifier == productID[9]) then --item9
			
			print ("success buying product 9! Give the user the item here or in the callback (see comments above)");
			
		elseif (trans.productIdentifier == productID[10]) then --item10
			
			print ("success buying product 10! Give the user the item here or in the callback (see comments above)");
			
		end	
		
	
	elseif (trans.state == "cancelled") then
		
		print ("player cancelled; you may want to show an alert here");
		
		
	elseif (trans.state == "failed") then
		
		print ("transaction failed");
		native.showAlert("Oops!" , "Please check your internet connection and try again." , {"Dismiss"}, none);
		
	end
	
	if (callback ~=nil) then callback(trans.state); end
	
	native.setActivityIndicator(false);
	store.finishTransaction(trans);
	
end

store.init(transactionCallback);


local function loadedCallback(e)
	
	for i=1, #e.products do
		table.insert(localizedPrices, i, tostring(e.products[i].price));
    end
    
end


store.loadProducts(productID, loadedCallback);


--These are the functions that you call from another lua file.
-- Example: you'd call something like: iap.buyItem3(callback)
function buyItem1 (callbackFunction)
	store.purchase({productID[1]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end

function buyItem2 (callbackFunction)
	store.purchase({productID[2]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end

function buyItem3 (callbackFunction)
	store.purchase({productID[3]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end

function buyItem4 (callbackFunction)
	store.purchase({productID[4]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end

function buyItem5 (callbackFunction)
	store.purchase({productID[5]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end

function buyItem6 (callbackFunction)
	store.purchase({productID[6]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end

function buyItem7 (callbackFunction)
	store.purchase({productID[7]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end

function buyItem8 (callbackFunction)
	store.purchase({productID[8]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end

function buyItem9 (callbackFunction)
	store.purchase({productID[9]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end

function buyItem10 (callbackFunction)
	store.purchase({productID[10]});
	native.setActivityIndicator(true);
	callback = callbackFunction;
end




	
