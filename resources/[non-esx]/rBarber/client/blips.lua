Citizen.CreateThread(function()  
    for k,v in pairs(Barber.Pos) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 71)
        SetBlipScale(blip, 0.60)
        SetBlipColour(blip, 26)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("BarberShop")
        EndTextCommandSetBlipName(blip)
    end
end)