Citizen.CreateThread(function()  
    for k,v in pairs(Mask.Pos) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 102)
        SetBlipScale(blip, 0.60)
        SetBlipColour(blip, 26)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Magasin de Masque")
        EndTextCommandSetBlipName(blip)
    end
end)
