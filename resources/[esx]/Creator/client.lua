ESX = nil

CreateThread(function() while ESX == nil do 
    TriggerEvent("esx:getSharedObject", function(obj) 
        ESX = obj end) 
        Wait(10) 
    end
end)

local statebtnfirstname, statebtnlastname, statebtndob, statebtnheight, statebtnsexxx, statebtnvalidate = true, false, false, false, false, false
local OpenedIdentityOpen = false
local IdentityMenu = RageUI.CreateMenu("Enregistrement", "Personnage")
IdentityMenu.Closable = false

local function TriggerServEvent(name, ...) TriggerServerEvent(name, ...) end

local function BoardIdentity(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) 
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Wait(0) end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Wait(500) 
		return result
	else
		Wait(500) 
		return nil 
	end
end

firstnamerslt, lastnamerslt, heightrslt, sexxrslt, dobbrslt = "Aucun", "Aucun", "Aucune", "h/f", "Aucune"

function OpenIdentityMenu()
    if OpenedIdentityOpen then
        OpenedIdentityOpen = false
        RageUI.Visible(IdentityMenu, false)
        return;
    else
        OpenedIdentityOpen = true
        firstnamerslt, lastnamerslt, heightrslt, sexxrslt, dobbrslt = "Aucun", "Aucun", "Aucune", "h/f", "Aucune"
        statebtnfirstname, statebtnlastname, statebtndob, statebtnheight, statebtnsexxx, statebtnvalidate = true, false, false, false, false, false
        TriggerServerEvent("Creator:setPlayerToBucket", GetPlayerServerId(PlayerId()))
        RageUI.Visible(IdentityMenu, true)
        CreateThread(function()
            while OpenedIdentityOpen do
                Wait(4.0)
                RageUI.IsVisible(IdentityMenu, function()
                    SetPlayerControl(PlayerId(), false)
                    RageUI.Button(Config.Locales.Custom["FirstName"], nil, {RightLabel = firstnamerslt}, statebtnfirstname, {
                        onSelected = function()
                            firstnamerslt = BoardIdentity(Config.Locales.Custom["FirstName"], "", 10)
                            if tostring(firstnamerslt) == "" or tostring(firstnamerslt) == "Aucun" then
                                firstnamerslt = "Aucun"
                                Notification(Config.Locales.Custom["FirstName_Missing"])
                                statebtnlastname = false
                            else
                                statebtnlastname = true
                                firstnamerslt = GetOnscreenKeyboardResult()
                                TriggerServEvent("esx_identity:updatefirstname", firstnamerslt)
                            end
                        end
                    });

                    RageUI.Button(Config.Locales.Custom["LastName"], nil, {RightLabel = lastnamerslt}, statebtnlastname, {
                        onSelected = function() 
                            lastnamerslt = BoardIdentity(Config.Locales.Custom["LastName"], "", 10)
                            if tostring(lastnamerslt) == "" or tostring(lastnamerslt) == "Aucun" then
                                lastnamerslt = "Aucun"
                                Notification(Config.Locales.Custom["LastName_Missing"])
                                statebtnheight = false
                            else
                                statebtnheight = true
                                lastnamerslt = GetOnscreenKeyboardResult()
                                TriggerServEvent("esx_identity:updatelastname", lastnamerslt)
                            end
                        end
                    });

                    RageUI.Button(Config.Locales.Custom["Height"], nil, {RightLabel = heightrslt}, statebtnheight, {
                        onSelected = function() 
                            heightrslt = BoardIdentity(Config.Locales.Custom["Height"], "", 3)
                            if tostring(heightrslt) == "" or tostring(heightrslt) == "Aucune" or #heightrslt < 3 then
                                heightrslt = "Aucune"
                                Notification(Config.Locales.Custom["Height_Missing"])
                                statebtnsexxx = false
                            elseif tonumber(heightrslt) then
                                statebtnsexxx = true
                                heightrslt = GetOnscreenKeyboardResult()
                                TriggerServEvent("esx_identity:updateheight", heightrslt)
                            else
                                heightrslt = "Aucune"
                                statebtnsexxx = false
                                Notification(Config.Locales.Custom["Height_Missing_Number"])
                            end
                        end
                    });

                    RageUI.Button(Config.Locales.Custom["Sex"], nil, {RightLabel = sexxrslt}, statebtnsexxx, {
                        onSelected = function() 
                            sexxrslt = BoardIdentity(Config.Locales.Custom["Sex_Inboard"], "", 1)
                            if tostring(sexxrslt) == "" or tostring(sexxrslt) == "h/f" then
                                sexxrslt = "h/f"
                                Notification(Config.Locales.Custom["Sexx_Missing"])
                                statebtndob = false
                            elseif tostring(sexxrslt) == "h" or tostring(sexxrslt) == "f" then
                                statebtndob = true
                                sexxrslt = GetOnscreenKeyboardResult()
                                TriggerServEvent("esx_identity:updatesexxx", sexxrslt)
                            else
                                sexxrslt = "h/f"
                                Notification(Config.Locales.Custom["Sexx_Missing"])
                            end
                        end
                    });

                    RageUI.Button(Config.Locales.Custom["DOB"], nil, {RightLabel = dobbrslt}, statebtndob, {
                        onSelected = function() 
                            dobbrslt = BoardIdentity(Config.Locales.Custom["DOB_Inboard"], "", 10)
                            if tostring(dobbrslt) == "" or tostring(dobbrslt) == "Aucun" or #dobbrslt < 10 then
                                dobbrslt = "Aucun"
                                Notification(Config.Locales.Custom["DOB_Missing"])
                                statebtnvalidate = false
                            else
                                dobbrslt = GetOnscreenKeyboardResult()
                                statebtnvalidate = true
                                TriggerServEvent("esx_identity:updatedateofbirth", dobbrslt)
                            end
                        end
                    });

                    RageUI.Button("~g~Confirmer l'enregistrement", nil, {RightLabel = "→→"}, statebtnvalidate, {
                        onSelected = function() 
                            RageUI.CloseAll()
                            OpenedIdentityOpen = false
                            CreationPersoFunction()
                        end
                    });
                end)
            end
        end)
    end
end

local MenuList = {
    List1 = 1,
    List2 = 2,
    List3 = 3,
    List4 = 4,
    List5 = 5,
    List6 = 6,
    List7 = 7,
    List8 = 8,
    List9 = 9,
    List10 = 10,
    List11 = 11,
    List12 = 12,
    List13 = 13
}

local SettingsMenu = {
    percentage = 1.0,
    ColorCheveux = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },
    ColorBarbes = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },
}

TournerCamPersoEct = function()
    if IsControlPressed(1, 10) then -- ZOOM AVANT CAMERA
        SetCamFov(cam5, GetCamFov(cam5)+0.2)
    elseif IsControlPressed(1, 11) then -- ZOOM ARRIERE CAMERA
        SetCamFov(cam5, GetCamFov(cam5)-0.2)
    end
end

setSkinToPed = function(Tenues)
    if Tenues == 1 then
        TriggerEvent("skinchanger:getSkin", function(skin)
            local uniformObject
            if skin.sex == 0 then
                uniformObject = Config.WelcomeTenues1.Male
            else
                uniformObject = Config.WelcomeTenues1.Female
            end
            if uniformObject then
                TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
                TriggerServerEvent('esx_skin:save', skin)
                Notification(Config.Locales.Custom["Tenue_retrieve"])
                TriggerEvent('skinchanger:getSkin', function(skin4)
                    TriggerServerEvent('esx_skin:save', skin4)
                end)
            end
        end)
    elseif Tenues == 2 then
        TriggerEvent("skinchanger:getSkin", function(skin)
            local uniformObject
            if skin.sex == 0 then
                uniformObject = Config.WelcomeTenues2.Male
            else
                uniformObject = Config.WelcomeTenues2.Female
            end
            if uniformObject then
                TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
                TriggerServerEvent('esx_skin:save', skin)
                Notification(Config.Locales.Custom["Tenue_retrieve"])
                TriggerEvent('skinchanger:getSkin', function(skin4)
                    TriggerServerEvent('esx_skin:save', skin4)
                end)
            end
        end)
    elseif Tenues == 3 then
        TriggerEvent("skinchanger:getSkin", function(skin)
            local uniformObject
            if skin.sex == 0 then
                uniformObject = Config.WelcomeTenues3.Male
            else
                uniformObject = Config.WelcomeTenues3.Female
            end
            if uniformObject then
                TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
                TriggerServerEvent('esx_skin:save', skin)
                Notification(Config.Locales.Custom["Tenue_retrieve"])
                TriggerEvent('skinchanger:getSkin', function(skin4)
                    TriggerServerEvent('esx_skin:save', skin4)
                end)
            end
        end)
    end
end

local MenuCreatorFirst = RageUI.CreateMenu(Config.Locales.Custom["Menu_NameCreator"], Config.Locales.Custom["SubMenu_NameCreator"])
local MenuCreatorSubTwo = RageUI.CreateSubMenu(MenuCreatorFirst, Config.Locales.Custom["SubMenu_TitleCreator"], Config.Locales.Custom["SubMenu_SubTitleCreator"])
local MenuCreatorSubThree = RageUI.CreateSubMenu(MenuCreatorFirst, Config.Locales.Custom["SubMenu_TitleCreator"], Config.Locales.Custom["SubMenu_SubTitleCreator"])
MenuCreatorFirst:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Zoom Avant"})
MenuCreatorFirst:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Zoom Arrière"})
MenuCreatorFirst.Closable = false;
MenuCreatorFirst.EnableMouse = false;
MenuCreatorSubTwo.EnableMouse = true;

local CreatorMenuOpened = false
openCreatorMenu = function()
    if CreatorMenuOpened then
        CreatorMenuOpened = false
    else
        CreatorMenuOpened = true
        SetPlayerControl(PlayerId(), true)
        RageUI.Visible(MenuCreatorFirst, true)
        CreateThread(function()
            while CreatorMenuOpened do
                Wait(1.0)
                RageUI.IsVisible(MenuCreatorFirst, function()

                    TournerCamPersoEct()

                    RageUI.Button(Config.Locales.Custom["Choice_Apparance"], nil, {RightLabel = "→→"}, true, {
                    }, MenuCreatorSubTwo);

                    RageUI.Button(Config.Locales.Custom["Choice_Dress"], nil, {RightLabel = "→→"}, true, {
                    }, MenuCreatorSubThree);

                    RageUI.Button(Config.Locales.Custom["Validate_Creator!"], nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            CreatorMenuOpened = false
                            SetPlayerControl(PlayerId(), false)
                            choixpoitionfunction()
                        end
                    });

                end, function() end)

                RageUI.IsVisible(MenuCreatorSubThree, function() 

                for k, v in pairs (Config.MenuTenue) do
                    RageUI.Button(v.NomTenue, nil, {RightLabel = v.label}, true, {
                        onSelected = function()
                            setSkinToPed(v.tenuenumero)
                        end
                    });
                end

                end, function() end)

                RageUI.IsVisible(MenuCreatorSubTwo, function()

                    RageUI.List('Sexe', {"Homme", "Femme"}, MenuList.List1, "Veuillez appuyez pour changer votre sexe", {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List1 = i;
                            changeGender(i)
                        end,
                    })

                    RageUI.List("Visage", {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45"}, MenuList.List7, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List7 = i;
                            TriggerEvent("skinchanger:change", "face", MenuList.List7)
                        end,
                    })

                    RageUI.List("Couleur de Peau", {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42"}, MenuList.List8, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List8 = i;
                            TriggerEvent('skinchanger:change', 'skin', MenuList.List8)
                        end,
                    })

                    RageUI.List('Cheveux', {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"}, MenuList.List2, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List2 = i;
                            TriggerEvent("skinchanger:change", "hair_1", MenuList.List2)
                        end,
                    })

                    RageUI.List('Type de barbe', {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"}, MenuList.List4, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List4 = i;
                            TriggerEvent("skinchanger:change", "beard_1", MenuList.List4)
                        end,
                    })

                    RageUI.List('Taille de barbe', {"1","2","3","4","5","6","7","8","9","10"}, MenuList.List11, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List11 = i;
                            TriggerEvent("skinchanger:change", "beard_2", MenuList.List11)
                        end,
                    })

                    RageUI.List('Couleur de barbe', {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"}, MenuList.List12, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List12 = i;
                            TriggerEvent("skinchanger:change", "beard_3", MenuList.List12)
                        end,
                    })

                    RageUI.List('Type de sourcils', {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"}, MenuList.List3, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List3 = i;
                            TriggerEvent("skinchanger:change", "eyebrows_1", MenuList.List3)
                        end,
                    })

                    RageUI.List('Taille de sourcils', {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"}, MenuList.List13, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List13 = i;
                            TriggerEvent("skinchanger:change", "eyebrows_2", MenuList.List13)
                        end,
                    })

                    RageUI.List('Couleur des Yeux', {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"}, MenuList.List5, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List5 = i;
                            TriggerEvent("skinchanger:change", "eye_color", MenuList.List5)
                        end,
                    })

                    RageUI.List("Taches de Rousseur", {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"}, MenuList.List6, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List6 = i;
                            TriggerEvent("skinchanger:change", "moles_1", MenuList.List6)
                        end,
                    })

                end, function() 
                    RageUI.ColourPanel("Couleur Cheveux", RageUI.PanelColour.HairCut, SettingsMenu.ColorCheveux.primary[1], SettingsMenu.ColorCheveux.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorCheveux.primary[1] = MinimumIndex
                            SettingsMenu.ColorCheveux.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_1", SettingsMenu.ColorCheveux.primary[2])
                        end
                    }, 4)

                    RageUI.ColourPanel("Couleur Barbes", RageUI.PanelColour.HairCut, SettingsMenu.ColorBarbes.primary[1], SettingsMenu.ColorBarbes.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorBarbes.primary[1] = MinimumIndex
                            SettingsMenu.ColorBarbes.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "beard_3", SettingsMenu.ColorBarbes.primary[2])
                        end
                    }, 5)
                    
                end)
            end
        end)
    end
end

TableCoordsSave = {}

local MenuSpawningOpened = false
local MenuChoicePosSpawn = RageUI.CreateMenu(Config.Locales.Custom["Spawn_MenuName"], Config.Locales.Custom["SubMenu_NameServer"])
MenuChoicePosSpawn.Closable = false;

openChoiceMenuSpawning = function()
    if MenuSpawningOpened then
        MenuSpawningOpened = false
    else
        MenuSpawningOpened = true
        SetPlayerControl(PlayerId(), true)
        RageUI.Visible(MenuChoicePosSpawn, true)
        CreateThread(function()
            while MenuSpawningOpened do
                Wait(1.0)
                RageUI.IsVisible(MenuChoicePosSpawn, function()

                for index, var in pairs (Config.SpawningMenu) do
                    RageUI.Button(var.SpawnNameLocation, nil, {RightLabel = "N°" ..index}, true, {
                        onActive = function()
                            DrawMarker(20, var.localisationsurmap, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 0, 255, 1, 1, 2, 0, nil, nil, 0)
                        end,
                        onSelected = function()
                            RageUI.CloseAll()
                            MenuSpawningOpened = false
                            DoScreenFadeOut(1500)
                            Wait(1500)
                            DisplayRadar(true)
                            ClearPedTasks(PlayerPedId())
                            destroyCameraCreator(8)
                            SetEntityCoords(PlayerPedId(), var.Coords)
                            SetEntityHeading(PlayerPedId(), var.Heading)
                            SetPlayerControl(PlayerId(), false)
                            TriggerServerEvent("Creator:setPlayerToNormalBucket")
                            Wait(1500)
                            DoScreenFadeIn(1500)
                            Advancednotif(Config.WelcomeNotif.Title, Config.WelcomeNotif.SubTitle, Config.WelcomeNotif.Message, Config.WelcomeNotif.Char_Name, 1)
                            SetPlayerControl(PlayerId(), true)
                            FreezeEntityPosition(PlayerPedId(), false)
                            whenActive = false
                        end
                    });
                end

                end, function() end)
            end
        end)
    end
end

