local ESX = nil
local itemSelected = {}
local buyLiquide = false
local buyBank = false
local buyLiquide2 = false
local buyBank2 = false
local modeDePayement = nil
local modeDePayement2 = nil

Citizen.CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(lib) ESX = lib end)
    while ESX == nil do Citizen.Wait(100) end
end)

function MenuShopFataliste()
    local menuP = RageUI.CreateMenu('Shop ', 'Bienvenue : '..GetPlayerName(PlayerId()))
    local menuCaise = RageUI.CreateSubMenu(menuP, 'Shop ', 'Bienvenue : '..GetPlayerName(PlayerId()))
    menuP.Closed = function()
        buyLiquide = false
        buyBank = false
        modeDePayement = nil
    end
    menuP:SetRectangleBanner(11, 11, 11, 1)
    menuCaise:SetRectangleBanner(11, 11, 11, 1)
            RageUI.Visible(menuP, not RageUI.Visible(menuP))
            while menuP do
            Citizen.Wait(0)
            RageUI.IsVisible(menuP, true, true, true, function()
                RageUI.Separator("~r~↓ Nourriture ↓")
            for k,v in pairs(Config.itemInShop.Food) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        itemSelected = v
                    end
                end, menuCaise)
            end

                RageUI.Separator("~r~↓ Boisson ↓")
            for k,v in pairs(Config.itemInShop.Drink) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        itemSelected = v
                    end
                end, menuCaise)
            end
            end, function()
            end)

            RageUI.IsVisible(menuCaise, true, true, true, function()


                if not buyBank then
                RageUI.Checkbox("Payer en liquide",nil, buyLiquide,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then

                        buyLiquide = Checked

                        if Checked then
                            modeDePayement = "liquide"
                        end
                    end
                end)
            else
                RageUI.ButtonWithStyle("Payer en liquide", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                    if Selected then

                    end
                end)
            end
                

            if not buyLiquide then
                RageUI.Checkbox("Payer en banque",nil, buyBank,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then

                        buyBank = Checked

                        if Checked then
                            modeDePayement = "banque"
                        end
                    end
                end)
            else
                RageUI.ButtonWithStyle("Payer en banque", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                    if Selected then
                        
                    end
                end)
            end



            RageUI.ButtonWithStyle("~g~Confirmer et payer", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("rShop:buyItemShop", itemSelected.name, itemSelected.price, modeDePayement)
                end
            end)


            end, function()
            end)

            if not RageUI.Visible(menuP) and not RageUI.Visible(menuCaise) then
            menuP = RMenu:DeleteType("menuP", true)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local Timer = 500
        local plyPos = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.posShop) do
        local dist = #(plyPos-v)
        if dist <= 10.0 then
         Timer = 0
         DrawMarker(22, v, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
        end
         if dist <= 3.0 then
            Timer = 0
                RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour acheter des produits alimentaires", time_display = 1 })
            if IsControlJustPressed(1,51) then
                MenuShopFataliste()
            end
         end
        end
    Citizen.Wait(Timer)
 end
end)


Citizen.CreateThread(function()
    for k, v in pairs(Config.posShop) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 52)
        SetBlipScale (blip, 0.65)
        SetBlipColour(blip, 18)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Supérette')
        EndTextCommandSetBlipName(blip)
    end
end)



function MenuTechShopFataliste()
    local menuP = RageUI.CreateMenu('Digital Den', 'Bienvenue : '..GetPlayerName(PlayerId()))
    local menuCaise = RageUI.CreateSubMenu(menuP, 'Digital Den', 'Bienvenue : '..GetPlayerName(PlayerId()))
    menuP.Closed = function()
        buyLiquide2 = false
        buyBank2 = false
        modeDePayement2 = nil
    end
    menuP:SetRectangleBanner(11, 11, 11, 1)
    menuCaise:SetRectangleBanner(11, 11, 11, 1)
            RageUI.Visible(menuP, not RageUI.Visible(menuP))
            while menuP do
            Citizen.Wait(0)
            RageUI.IsVisible(menuP, true, true, true, function()
                RageUI.Separator("~r~↓ Voici les articles disponibles ↓")
            for k,v in pairs(Config.itemInTechShop) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        itemSelected = v
                    end
                end, menuCaise)
            end
            end, function()
            end)

            RageUI.IsVisible(menuCaise, true, true, true, function()


                if not buyBank2 then
                RageUI.Checkbox("Payer en liquide",nil, buyLiquide2,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then

                        buyLiquide2 = Checked

                        if Checked then
                            modeDePayement2 = "liquide"
                        end
                    end
                end)
            else
                RageUI.ButtonWithStyle("Payer en liquide", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                    if Selected then

                    end
                end)
            end
                

            if not buyLiquide2 then
                RageUI.Checkbox("Payer en banque",nil, buyBank2,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then

                        buyBank2 = Checked

                        if Checked then
                            modeDePayement2 = "banque"
                        end
                    end
                end)
            else
                RageUI.ButtonWithStyle("Payer en banque", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                    if Selected then
                        
                    end
                end)
            end



            RageUI.ButtonWithStyle("~g~Confirmer et payer", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("rShop:buyItemShopTech", itemSelected.name, itemSelected.price, modeDePayement2)
                end
            end)


            end, function()
            end)

            if not RageUI.Visible(menuP) and not RageUI.Visible(menuCaise) then
            menuP = RMenu:DeleteType("menuP", true)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local Timer = 500
        local plyPos = GetEntityCoords(PlayerPedId())
        local dist = #(plyPos-Config.posTechShop)
        if dist <= 10.0 then
         Timer = 0
         DrawMarker(22, Config.posTechShop, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
        end
         if dist <= 3.0 then
            Timer = 0
                RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour acheter des produits électronique", time_display = 1 })
            if IsControlJustPressed(1,51) then
                MenuTechShopFataliste()
            end
         end
    Citizen.Wait(Timer)
 end
end)


Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.posTechShop)
    SetBlipSprite(blip, 521)
    SetBlipScale (blip, 0.65)
    SetBlipColour(blip, 18)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Digital Den')
    EndTextCommandSetBlipName(blip)
end)