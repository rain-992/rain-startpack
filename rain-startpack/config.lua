Config = {}

-- NPC配置
Config.NPCs = {
    {
        coords = vector4(205.31, -920.12, 30.69, 159.29), -- 坐标和朝向
        model = "a_m_y_business_01", -- NPC模型
        scenario = "WORLD_HUMAN_STAND_MOBILE" -- NPC动作
    },
    -- 可以添加更多NPC位置
}

-- 奖励配置
Config.Rewards = {
    -- 现金奖励
    money = {
        amount = 5000,
        type = "cash" -- 可选: "cash", "bank"
    },
    
    -- 物品奖励
    items = {
        {name = "phone", amount = 1, label = "手机"},
        {name = "water", amount = 5, label = "水"},
        {name = "sandwich", amount = 5, label = "三明治"}
        -- 可以添加更多物品
    }
}

-- 系统配置
Config.Settings = {
    notifyType = "qb", -- 通知类型：可选 "qb", "okok", "custom"
    checkDistance = 3.0, -- 检测距离
    enableBlip = true, -- 是否在地图上显示NPC位置
    blipSprite = 280, -- 地图标记样式
    blipColor = 2, -- 地图标记颜色
    blipScale = 0.8 -- 地图标记大小
}