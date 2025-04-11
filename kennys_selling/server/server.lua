local QBCore = exports['qb-core']:GetCoreObject()
local npcHistory = {}

RegisterServerEvent('kennys_selling:attemptSell', function(npcId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    npcHistory[src] = npcHistory[src] or {}
    local now = os.time()

    local lastSold = npcHistory[src][npcId]
    if lastSold and (now - lastSold) < Config.NPCResellCooldown then
        TriggerClientEvent('kennys_selling:notify', src, 'You recently sold to this person. Try someone else.')
        return
    end

    local sold = false

    for drug, data in pairs(Config.Drugs) do
        local itemCount = exports.ox_inventory:GetItemCount(src, drug)
        if itemCount > 0 then
            local minBags = data.bags and data.bags.min or 1
            local maxBags = data.bags and data.bags.max or 1
            local amountToSell = math.min(itemCount, math.random(minBags, maxBags))

            local pricePerItem = math.random(data.price.min, data.price.max)
            local totalWorth = amountToSell * pricePerItem

            TriggerClientEvent('kennys_selling:sellAnim', src, npcId, Config.SellDuration)

            SetTimeout(Config.SellDuration, function()
                local Player = QBCore.Functions.GetPlayer(src)
                if not Player then return end

                exports.ox_inventory:RemoveItem(src, drug, amountToSell)
                exports.ox_inventory:AddItem(src, data.rewardItem, totalWorth)

                npcHistory[src][npcId] = os.time()

                TriggerClientEvent('kennys_selling:notify', src,
                    ('You sold %sx %s for $%s'):format(amountToSell, data.label, totalWorth))
            end)

            sold = true
            break
        end
    end

    if not sold then
        TriggerClientEvent('kennys_selling:notify', src, 'You have no drugs to sell.')
    end
end)

AddEventHandler('playerDropped', function(source)
    npcHistory[source] = nil
end)
