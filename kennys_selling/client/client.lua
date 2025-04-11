function TrySell()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local npc = GetClosestPed()

    if npc and not IsPedAPlayer(npc) and #(GetEntityCoords(npc) - playerCoords) < 1.2 then
        local npcId = NetworkGetNetworkIdFromEntity(npc)
        TriggerServerEvent('kennys_selling:attemptSell', npcId)
    end
end

function GetClosestPed()
    local coords = GetEntityCoords(PlayerPedId())
    local peds = lib.getNearbyPeds(coords, 3.0)

    for _, data in pairs(peds or {}) do
        local ped = data.ped
        if ped and DoesEntityExist(ped) and not IsPedAPlayer(ped) and not IsPedDeadOrDying(ped, true) then
            return ped
        end
    end
end

RegisterNetEvent('kennys_selling:notify', function(msg)
    lib.notify({
        description = msg,
        type = 'info'
    })
end)

RegisterNetEvent('kennys_selling:sellAnim', function(npcNetId, duration)
    local playerPed = PlayerPedId()
    local npc = NetworkGetEntityFromNetworkId(npcNetId)

    FreezeEntityPosition(playerPed, true)
    if npc then FreezeEntityPosition(npc, true) end

    local dict = 'mp_common'
    local animA, animB = 'givetake1_a', 'givetake1_b'

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end

    TaskPlayAnim(playerPed, dict, animA, 8.0, -8.0, duration, 0, 0, false, false, false)
    if npc then
        TaskPlayAnim(npc, dict, animB, 8.0, -8.0, duration, 0, 0, false, false, false)
    end

    lib.progressBar({
        duration = duration,
        label = 'Selling...',
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
            car = true,
            combat = true
        },
    })

    ClearPedTasks(playerPed)
    if npc then
        ClearPedTasks(npc)
        FreezeEntityPosition(npc, false)
    end
    FreezeEntityPosition(playerPed, false)
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 38) then -- 38 = E key
            TrySell()
        end
    end
end)
