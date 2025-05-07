local QBCore = exports['qb-core']:GetCoreObject()


CreateThread(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `player_startpack` (
            `citizenid` varchar(50) NOT NULL,
            `received` tinyint(1) NOT NULL DEFAULT 0,
            `received_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (`citizenid`)
        )
    ]], {})
end)

local function HasPlayerReceivedReward(citizenid)
    local result = MySQL.Sync.fetchScalar('SELECT received FROM player_startpack WHERE citizenid = ?', {citizenid})
    return result == 1
end


local function MarkPlayerAsRewarded(citizenid)
    MySQL.Async.execute('INSERT INTO player_startpack (citizenid, received) VALUES (?, 1)', {citizenid})
end


RegisterNetEvent('qb-newbiereward:server:giveReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenId = Player.PlayerData.citizenid

    if not HasPlayerReceivedReward(citizenId) then
        
        Player.Functions.AddMoney(Config.Rewards.money.type, Config.Rewards.money.amount)
        
        
        for _, item in ipairs(Config.Rewards.items) do
            Player.Functions.AddItem(item.name, item.amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'add')
        end

        
        MarkPlayerAsRewarded(citizenId)
        
        
        if Config.Settings.notifyType == "qb" then
            TriggerClientEvent('QBCore:Notify', src, '新手礼包已发放！', 'success')
        elseif Config.Settings.notifyType == "okok" then
            exports['okokNotify']:Alert("新手礼包", "新手礼包已发放！", 5000, 'success')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, '你已经领取过新手礼包了！', 'error')
    end
end)