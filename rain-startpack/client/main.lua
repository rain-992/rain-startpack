local QBCore = exports['qb-core']:GetCoreObject()
local hasReceivedReward = false
local npcs = {}


local function OpenRewardMenu()
    lib.registerContext({
        id = 'startpack_menu',
        title = '新手礼包',
        options = {
            {
                title = '领取新手礼包',
                description = '领取一次性的新手礼包，包含金钱和物品',
                icon = 'gift',
                onSelect = function()
                    if not hasReceivedReward then
                        TriggerServerEvent('qb-newbiereward:server:giveReward')
                        hasReceivedReward = true
                    else
                        QBCore.Functions.Notify('你已经领取过新手礼包了！', 'error')
                    end
                end
            },
            {
                title = '关闭菜单',
                description = '取消领取新手礼包',
                icon = 'xmark',
                onSelect = function()
                    lib.hideContext()
                end
            }
        }
    })
    lib.showContext('startpack_menu')
end


local function CreateNPCs()
    for i, npcConfig in ipairs(Config.NPCs) do
        local model = GetHashKey(npcConfig.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
        
        local npc = CreatePed(4, model, npcConfig.coords.x, npcConfig.coords.y, npcConfig.coords.z, npcConfig.coords.w, false, true)
        SetEntityAsMissionEntity(npc, true, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        
        if npcConfig.scenario then
            TaskStartScenarioInPlace(npc, npcConfig.scenario, 0, true)
        end
        
        
        exports['qb-target']:AddTargetEntity(npc, {
            options = {
                {
                    type = "client",
                    event = "rain-startpack:client:openMenu",
                    icon = "fas fa-gift",
                    label = "与新手礼包NPC交谈",
                }
            },
            distance = 2.0
        })
        
        if Config.Settings.enableBlip then
            local blip = AddBlipForCoord(npcConfig.coords.x, npcConfig.coords.y, npcConfig.coords.z)
            SetBlipSprite(blip, Config.Settings.blipSprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.Settings.blipScale)
            SetBlipColour(blip, Config.Settings.blipColor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("新手礼包NPC")
            EndTextCommandSetBlipName(blip)
        end
        
        table.insert(npcs, npc)
    end
end


RegisterNetEvent('rain-startpack:client:openMenu', function()
    OpenRewardMenu()
end)


CreateThread(function()
    CreateNPCs()
end)


AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, npc in ipairs(npcs) do
            DeleteEntity(npc)
        end
    end
end)