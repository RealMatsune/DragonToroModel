-- Services
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local Enemies = workspace:FindFirstChild("Enemies") or ReplicatedStorage:FindFirstChild("Enemies")
local CollectionService = game:GetService("CollectionService")
local TeleportService = game:GetService("TeleportService")

-- Sea IDs
local Sea1IDs = {2753915549, 85211729168715}
local Sea2IDs = {4442272183, 79091703265657}
local Sea3IDs = {7449423635, 100117331123089}

-- Functions để xác định Sea
local function isSea1() return table.find(Sea1IDs, game.PlaceId) ~= nil end
local function isSea2() return table.find(Sea2IDs, game.PlaceId) ~= nil end
local function isSea3() return table.find(Sea3IDs, game.PlaceId) ~= nil end

-- Khai báo tất cả biến
local sentFullMoon = false
local sentElite = false
local previousSword = nil
local sentLegendarySword = false
local PrehistoricSpawned = false
local MirageSpawned = false
local KitsuneSpawned = false
local sentNearFullMoon = false
local sentFruit = false
local sentDoughKing = false
local sentTyrantoftheSkies = false
local sentRipIndra = false
local sentCursedCaptain = false
local sentGreybeard2 = false
local sentDarkbeard = false 
local sentCakePrince = false
local sentSoulReaper = false
local sentBossEvent = false
local previousColor = nil
local sentHakiLegendary = false
local FrozenSpawned = false
local LeviathanSpawned = false
local previousHakiName = nil
local previousSea = nil
local lastBerryKey = ""
local sendInterval = 60
local lastSendTime = 0
local player = Players.LocalPlayer
local pirateRaidCooldown = false
local lastPirateRaidSent = 0
local PIRATE_RAID_COOLDOWN = 20 -- 20 giây

local function getEncodedJobId()
    return tostring(game.JobId)
end

local joinScript = string.format(
    'game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game.Players.LocalPlayer)',
    game.PlaceId, game.JobId
)

local function safeHttpRequest(options)
    local requestFunc = http_request or request or (syn and syn.request) or (Krnl and Krnl.request) or (delta and delta.request)
    if requestFunc then
        return pcall(function()
            return requestFunc(options)
        end)
    end
    return false, "No HTTP request function available"
end
local THUMBNAIL_URL = "https://cdn.discordapp.com/attachments/1247466019019161651/1449731460469756006/IMG_20251214_185500.jpg"
local WEBHOOK_BASE_URL = "http://phamduykhanhdev.x10.network/masune.php?name="

local function FullMoonWebhook()
    local WebhookurlFM = WEBHOOK_BASE_URL .. "FullMoon"
    local currentPhase = "Full Moon 100%"
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🌕] __Moon Phase:__**", ["value"] = "```" .. currentPhase .. "```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}                
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({Url = WebhookurlFM, Method = "POST", Headers = Headers, Body = Encoded})
end

local function NearFullMoonWeb()
    local WebhookurlFM = WEBHOOK_BASE_URL .. "NearFullMoon"
    local NearMoonphase = "Near Moon Spawned"
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🌓] __Near Moon Phase:__**", ["value"] = "```" .. NearMoonphase .. "```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({Url = WebhookurlFM, Method = "POST", Headers = Headers, Body = Encoded})
end

local function EliteWebhook(eliteName)
    local WebhookElite = WEBHOOK_BASE_URL .. "EliteHunter"
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🥷] __Elite Hunter__:**", ["value"] = "```" .. eliteName .. "```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count__:**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({Url = WebhookElite, Method = "POST", Headers = Headers, Body = Encoded})
end

local function sendWebhook()
    local encodedJobId = getEncodedJobId()
    local playerCount = #Players:GetPlayers()    
    local data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🌋] __Prehistoric Island Status:__**", ["value"] = "```Prehistoric Island spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count__:**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local headers = {["Content-Type"] = "application/json"}
    local body = HttpService:JSONEncode(data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "PrehistoricIsland",
        Method = "POST",
        Headers = headers,
        Body = body
    })
end

local function MirageWebhook()
    local encodedJobId = getEncodedJobId()
    local playerCount = #Players:GetPlayers()    
    local data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🏝️] __Mirage Island Status:__**", ["value"] = "```Mirage Island Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count__:**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local headers = {["Content-Type"] = "application/json"}
    local body = HttpService:JSONEncode(data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "MirageIsland",
        Method = "POST",
        Headers = headers,
        Body = body
    })
end

local function KitsuneWebhook()
    local encodedJobId = getEncodedJobId()
    local playerCount = #Players:GetPlayers()
    local data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🦊] __Kitsune Island Status:__**", ["value"] = "```Kitsune Island Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count__:**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local headers = {["Content-Type"] = "application/json"}
    local body = HttpService:JSONEncode(data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "KitsuneIsland",
        Method = "POST",
        Headers = headers,
        Body = body
    })
end

local function sendBerryWebhook()
    local playerCount = #Players:GetPlayers()
    local currentSea = "Unknown Sea"
    if isSea1() then
        currentSea = "Sea 1"
    elseif isSea2() then
        currentSea = "Sea 2"
    elseif isSea3() then
        currentSea = "Sea 3"
    end    
    local bushes = CollectionService:GetTagged("BerryBush")
    local berryNames = {}
    for _, bush in ipairs(bushes) do
        for _, value in pairs(bush:GetAttributes()) do
            if typeof(value) == "string" and value ~= "" then
                table.insert(berryNames, value)
            end
        end
    end    
    local seen = {}
    local uniqueBerryNames = {}
    for _, name in ipairs(berryNames) do
        if not seen[name] then
            seen[name] = true
            table.insert(uniqueBerryNames, name)
        end
    end    
    table.sort(uniqueBerryNames)
    local berryList = table.concat(uniqueBerryNames, ", ")
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🍇] Berries Available:**", ["value"] = "```" .. berryList .. "```", ["inline"] = false},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```" .. currentSea .. "```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "BerriesFruit",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendFruitWebhook(fruitName)
    local playerCount = #Players:GetPlayers()
    local currentSea = "Unknown Sea"    
    if isSea1() then
        currentSea = "Sea 1"
    elseif isSea2() then
        currentSea = "Sea 2"
    elseif isSea3() then
        currentSea = "Sea 3"
    end    
    local currentPhase = fruitName or "Unknown Fruit"
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🍓] __Fruits Spawned:__**", ["value"] = "```" .. currentPhase .. "```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```" .. currentSea .. "```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "FruitSpawning",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function senddoughkingWebhook(DoughKingName)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()   
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🧁] __Status Boss Dough King:__**", ["value"] = "```" .. DoughKingName .. " Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "DoughKing",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendRipIndraWebhook(RipIndraName)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[👻] __Status Boss Rip Indra:__**", ["value"] = "```" .. RipIndraName .. " Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "RipIndra",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendTyrantoftheSkiesWebhook(TyrantoftheSkiesName)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🦅] __Status Boss Tyrant of the Skies:__**", ["value"] = "```" .. TyrantoftheSkiesName .. " Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "TyrantOfTheSkies",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendSoulReaperWebhook(SoulReaperName)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[💀] __Status Boss Soul Reaper:__**", ["value"] = "```" .. SoulReaperName .. " Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "SoulRipper",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendCakePrinceWebhook(CakePrinceName)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🍩] __Status Boss Cake Prince:__**", ["value"] = "```" .. CakePrinceName .. " Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "CakePrince",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendCursedCaptainWebhook(CursedCaptainName)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🎃] __Status Boss Cursed Captain:__**", ["value"] = "```" .. CursedCaptainName .. " Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 2```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "CursedCaptain",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendGreybeard2Webhook(Greybeard2Name)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🦢] __Status Boss Grey Beard:__**", ["value"] = "```" .. Greybeard2Name .. " Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 1```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "GreyBeard",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendDarkbeardWebhook(DarkbeardName)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[👿] __Status Boss Dark Beard:__**", ["value"] = "```" .. DarkbeardName .. " Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 2```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "DarkBeard",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendLegendarySwordWebhook(swordName)
    local currentSea = "Sea 2"
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[⚔️] __Sword Legendary__:**", ["value"] = "```" .. swordName .. "```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```" .. currentSea .. "```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "SwordsLegendary",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendHakiLegendaryWebhook(colorName)
    local currentSea = "Unknown Sea"
    if isSea2() then
        currentSea = "Sea 2"
    elseif isSea3() then
        currentSea = "Sea 3"
    end    

    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🌈] __Haki Legendary Available__:**", ["value"] = "```" .. colorName .. "```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```" .. currentSea .. "```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "HakiLegendary",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendHakiWebhook(hakiName)
    local currentSea = "Unknown Sea"    
    if isSea2() then
        currentSea = "Sea 2"
    elseif isSea3() then
        currentSea = "Sea 3"
    end    
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🎨] __Haki Normal__:**", ["value"] = "```" .. hakiName .. "```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```" .. currentSea .. "```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "HakiColor",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local selectedBoss = "Unbound Werewolf"
local function sendBossEventWebhook(bossName)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🎉] __Status Boss " .. bossName .. ":__**", ["value"] = "```" .. bossName .. " Spawned ✅```", ["inline"] = true},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "BossEvent",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local function sendBossAllWebhook(BossAllName)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local currentSea = "Unknown"    
    if isSea1() then
        currentSea = "Sea 1"
    elseif isSea2() then
        currentSea = "Sea 2"
    elseif isSea3() then
        currentSea = "Sea 3"
    end    
    local embedData = {
        ["title"] = "Matsune Hub Notification",
        ["color"] = tonumber(0xc4f244),
        ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
        ["fields"] = {
            {["name"] = "**[👺] __Status Raid:__**", ["value"] = "```" .. BossAllName .. " Spawned ✅```", ["inline"] = true},
            {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
            {["name"] = "**[🌍] __World Sea:__**", ["value"] = "```" .. currentSea .. "```", ["inline"] = true},
            {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
            {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
        },
        ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
    }    
    local Data = {
        ["embeds"] = {embedData}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "BossRaid",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end
local function sendPirateraid2Webhook(raidMessage)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local currentSea = "Unknown"
    if isSea1() then
        currentSea = "Sea 1"
    elseif isSea2() then
        currentSea = "Sea 2"
    elseif isSea3() then
        currentSea = "Sea 3"
    end    
    local Data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "** [ 🏴‍☠️] __Pirate Raid Alert:__**", ["value"] = "```" .. raidMessage .. "```", ["inline"] = false},
                {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea:__**", ["value"] = "```" .. currentSea .. "```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}                   
            },
        ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "PirateRaid",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end

local BossList = {
    ["Sea 1"] = {
        "The Saw", "The Gorilla King", "Bobby", "Yeti", "Mob Leader", 
        "Vice Admiral", "Warden", "Chief Warden", "Swan", "Magma Admiral", 
        "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Saber Expert"
    },
    ["Sea 2"] = {
        "Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", 
        "Cursed Captain", "Darkbeard", "Order", "Awakened Ice Admiral", "Tide Keeper"
    },
    ["Sea 3"] = {
        "Stone", "Island Empress", "Rocket Admiral", "Captain Elephant", 
        "Beautiful Pirate", "rip_indra True Form", "Longma", "Soul Reaper", 
        "Cake Queen", "Cake Prince", "Dough King"
    }
}

local sentBosses = {}

local function getCurrentSea()
    if isSea1() then
        return "Sea 1"
    elseif isSea2() then
        return "Sea 2"
    elseif isSea3() then
        return "Sea 3"
    end
    return "Unknown"
end

local function sendAllBossesWebhook(spawnedBosses)
    local playerCount = #Players:GetPlayers()
    local encodedJobId = getEncodedJobId()
    local currentSea = getCurrentSea()
    local bossListText = "```" .. table.concat(spawnedBosses, ", ") .. "```"    
    local embedData = {
        ["title"] = "Matsune Hub Notification",
        ["color"] = tonumber(0xc4f244),
        ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
        ["fields"] = {
            {["name"] = "**[🐉] __Bosses Normal__**", ["value"] = bossListText, ["inline"] = false},
            {["name"] = "**[👤] __Player Count:__**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
            {["name"] = "**[🌍] __World Sea:__**", ["value"] = "```" .. currentSea .. "```", ["inline"] = true},
            {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
            {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
        },
        ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
    }
    
    local Data = {
        ["embeds"] = {embedData}
    }    
    local Headers = { ["Content-Type"] = "application/json" }
    local Encoded = HttpService:JSONEncode(Data)    
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "BossNormal",
        Method = "POST",
        Headers = Headers,
        Body = Encoded
    })
end
local function CombinedWebhook()
    local encodedJobId = getEncodedJobId()
    local playerCount = #Players:GetPlayers()    
    local statusMessage = "```No Event ❌```"
    if FrozenSpawned then
        statusMessage = "```Frozen Dimension Spawned ✅```"
    elseif LeviathanSpawned then
        statusMessage = "```Leviathan Spawned ✅```"
    end
    
    local data = {
        ["embeds"] = {{
            ["title"] = "Matsune Hub Notification",
            ["color"] = tonumber(0xc4f244),
            ["thumbnail"] = { ["url"] = THUMBNAIL_URL },
            ["fields"] = {
                {["name"] = "**[🏔️] __Frozen Dimension Status:__**", ["value"] = statusMessage, ["inline"] = true},
                {["name"] = "**[👤] __Player Count__:**", ["value"] = "```" .. playerCount .. "/12```", ["inline"] = true},
                {["name"] = "**[🌍] __World Sea__:**", ["value"] = "```Sea 3```", ["inline"] = true},
                {["name"] = "**[🔗] __Job ID (Copy Mobile):__**", ["value"] = encodedJobId, ["inline"] = true},
                {["name"] = "**[📜] __Join Script (Copy Mobile):__**", ["value"] = joinScript, ["inline"] = true}               
            },
            ["footer"] = {["text"] = "Notify blox Fruits Matsune Hub - By Dragon Toro"}
        }}
    }    
    local headers = {["Content-Type"] = "application/json"}
    local body = HttpService:JSONEncode(data)
    safeHttpRequest({
        Url = WEBHOOK_BASE_URL .. "FrozenDimension",
        Method = "POST",
        Headers = headers,
        Body = body
    })
end
task.spawn(function()
    while task.wait(1) do
        local locations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
        local FrozenDim = locations and locations:FindFirstChild("Frozen Dimension")
        
        if FrozenDim then
            if not FrozenSpawned then
                FrozenSpawned = true
                CombinedWebhook()
            end
        else
            if FrozenSpawned then
                FrozenSpawned = false
                CombinedWebhook()
            end
        end
    end
end)
task.spawn(function()
    while task.wait(1) do
        local leviathanFound = false        
        if ReplicatedStorage:FindFirstChild("Leviathan") ~= nil then
            leviathanFound = true
        elseif Workspace:FindFirstChild("SeaEvents") and Workspace.SeaEvents:FindFirstChild("Leviathan") ~= nil then
            leviathanFound = true
        elseif Workspace:FindFirstChild("Enemies") and Workspace.Enemies:FindFirstChild("Leviathan") ~= nil then
            leviathanFound = true
        end     
        if leviathanFound then
            if not LeviathanSpawned then
                LeviathanSpawned = true
                CombinedWebhook()
            end
        else
            if LeviathanSpawned then
                LeviathanSpawned = false
                CombinedWebhook()
            end
        end
    end
end)
local function CheckNotify(searchText)
    local player = Players.LocalPlayer
    if not player then return false end    
    local gui = player:FindFirstChild("PlayerGui")
    if not gui then return false end    
    local notifications = gui:FindFirstChild("Notifications")
    if not notifications then return false end    
    for _, v in pairs(notifications:GetChildren()) do
        if v and v.Parent and v:IsA("TextLabel") and v.Text then
            if string.find(string.lower(v.Text), searchText:lower()) then
                return true
            end
        end
    end
    return false
end

spawn(function()
    while wait(0.5) do
        if not pirateRaidCooldown then
            local raidDetected = false
            local raidMessage = ""           
            if isSea3() then
                if CheckNotify("Pirates have been spotted approaching the castle!") then
                    raidDetected = true
                    raidMessage = "Pirates have been spotted approaching the castle!"
                elseif CheckNotify("The pirates are raiding Castle on the Sea!") then
                    raidDetected = true
                    raidMessage = "The pirates are raiding Castle on the Sea!"
                end
            end            
            if raidDetected then
                local currentTime = tick()                
                if (currentTime - lastPirateRaidSent) > PIRATE_RAID_COOLDOWN then
                    sendPirateraid2Webhook(raidMessage)                    
                    lastPirateRaidSent = currentTime
                    pirateRaidCooldown = true                    
                    wait(PIRATE_RAID_COOLDOWN)
                    pirateRaidCooldown = false
                end
            end
        end
    end
end)

local function checkAndSendBosses()
    local currentSea = getCurrentSea()
    local availableBosses = BossList[currentSea] or {}
    local spawnedBosses = {}    
    for _, bossName in pairs(availableBosses) do
        if (ReplicatedStorage:FindFirstChild(bossName) ~= nil) or 
           (Enemies and Enemies:FindFirstChild(bossName) ~= nil) then            
            if not sentBosses[bossName] then
                table.insert(spawnedBosses, bossName)
                sentBosses[bossName] = true
            end
        else
            sentBosses[bossName] = nil
        end
    end
    if #spawnedBosses > 0 then
        sendAllBossesWebhook(spawnedBosses)
    end
end

task.spawn(function()
    while true do
        task.wait(1)
        checkAndSendBosses()
    end
end)

local lastSea = getCurrentSea()
task.spawn(function()
    while true do
        task.wait(5)
        local currentSea = getCurrentSea()
        if currentSea ~= lastSea then
            sentBosses = {}
            lastSea = currentSea
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea3() and not sentBossEvent then
            if (ReplicatedStorage:FindFirstChild(selectedBoss) ~= nil) or (Enemies and Enemies:FindFirstChild(selectedBoss) ~= nil) then
                sendBossEventWebhook(selectedBoss)
                sentBossEvent = true                
                task.wait(60)
                sentBossEvent = false
            end
        end
    end
end)

task.spawn(function()
    while true do  
        task.wait(1)          
        if true then 
            local currentHakiName = nil  
            local success, result                          
            for i = 1, 100 do 
                success, result = pcall(function()  
                    return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ColorsDealer", tostring(i))  
                end)  
                if success and type(result) == "string" and result ~= "" then  
                    currentHakiName = result
                    break
                end  
            end                                    
            if currentHakiName and currentHakiName ~= previousHakiName then  
                sendHakiWebhook(currentHakiName)
                previousHakiName = currentHakiName                  
                task.spawn(function()
                    local oldHaki = currentHakiName
                    task.wait(30)
                    if previousHakiName == oldHaki then
                        previousHakiName = nil
                    end
                end)
            end  
        else  
            previousHakiName = nil  
        end  
    end
end)

task.spawn(function()
    while true do
        local currentTime = os.time()
        if currentTime - lastSendTime >= sendInterval then
            if isSea1() or isSea2() or isSea3() then 
                local bushes = CollectionService:GetTagged("BerryBush")
                local berryNames = {}                
                for _, bush in ipairs(bushes) do
                    for _, value in pairs(bush:GetAttributes()) do
                        if typeof(value) == "string" and value ~= "" then
                            table.insert(berryNames, value)
                        end
                    end
                end                
                local seen = {}
                local uniqueBerries = {}
                for _, name in ipairs(berryNames) do
                    if not seen[name] then
                        seen[name] = true
                        table.insert(uniqueBerries, name)
                    end
                end
                table.sort(uniqueBerries)                
                local currentKeyString = table.concat(uniqueBerries, ",")               
                if currentKeyString ~= "" and currentKeyString ~= lastBerryKey then
                    lastBerryKey = currentKeyString
                    sendBerryWebhook()
                    lastSendTime = currentTime
                end
            end
        end
        task.wait(25)
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea1() and not sentGreybeard2 then
            if (ReplicatedStorage:FindFirstChild("Greybeard") ~= nil) or (Enemies and Enemies:FindFirstChild("Greybeard") ~= nil) then
                sendGreybeard2Webhook("Greybeard")
                sentGreybeard2 = true
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea2() and not sentDarkbeard then
            if (ReplicatedStorage:FindFirstChild("Darkbeard") ~= nil) or (Enemies and Enemies:FindFirstChild("Darkbeard") ~= nil) then
                sendDarkbeardWebhook("Darkbeard")
                sentDarkbeard = true
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea2() and not sentCursedCaptain then
            if (ReplicatedStorage:FindFirstChild("Cursed Captain") ~= nil) or (Enemies and Enemies:FindFirstChild("Cursed Captain") ~= nil) then
                sendCursedCaptainWebhook("Cursed Captain")
                sentCursedCaptain = true
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea3() and not sentTyrantoftheSkies then
            if (ReplicatedStorage:FindFirstChild("Tyrant of the Skies") ~= nil) or (Enemies and Enemies:FindFirstChild("Tyrant of the Skies") ~= nil) then
                sendTyrantoftheSkiesWebhook("Tyrant of the Skies")
                sentTyrantoftheSkies = true
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea3() and not sentCakePrince then
            if (ReplicatedStorage:FindFirstChild("Cake Prince") ~= nil) or (Enemies and Enemies:FindFirstChild("Cake Prince") ~= nil) then
                sendCakePrinceWebhook("Cake Prince")
                sentCakePrince = true
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea3() and not sentRipIndra then
            if (ReplicatedStorage:FindFirstChild("rip_indra True Form") ~= nil) or (Enemies and Enemies:FindFirstChild("rip_indra True Form") ~= nil) then
                sendRipIndraWebhook("Rip Indra True Form")
                sentRipIndra = true
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea3() and not sentDoughKing then
            if (ReplicatedStorage:FindFirstChild("Dough King") ~= nil) or (Enemies and Enemies:FindFirstChild("Dough King") ~= nil) then
                senddoughkingWebhook("Dough King")
                sentDoughKing = true
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea3() and not sentSoulReaper then
            if (ReplicatedStorage:FindFirstChild("Soul Reaper") ~= nil) or (Enemies and Enemies:FindFirstChild("Soul Reaper") ~= nil) then
                sendSoulReaperWebhook("Soul Reaper")
                sentSoulReaper = true
            end
        end
    end
end)

task.spawn(function()
    while true do  
        task.wait(1)          
        local currentSea
        if isSea2() then
            currentSea = 2
        elseif isSea3() then
            currentSea = 3
        else
            currentSea = nil
        end        
        if currentSea then  
            if not previousColor then  
                sentHakiLegendary = false  
            end                
            local currentColor = nil  
            local success, result                          
            success, result = pcall(function()  
                return ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "1")  
            end)  
            if success and result then  
                currentColor = "Snow White"  
            end                         
            if not currentColor then
                success, result = pcall(function()  
                    return ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "2")  
                end)  
                if success and result then  
                    currentColor = "Pure Red"  
                end  
            end                
            if not currentColor then
                success, result = pcall(function()  
                    return ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "3")  
                end)  
                if success and result then  
                    currentColor = "Winter Sky"  
                end  
            end   
            if currentColor and (currentColor ~= previousColor or currentSea ~= previousSea) and not sentHakiLegendary then  
                sendHakiLegendaryWebhook(currentColor)  
                previousColor = currentColor  
                previousSea = currentSea
                sentHakiLegendary = true  
            elseif not currentColor and previousColor then  
                previousColor = nil  
                previousSea = nil
                sentHakiLegendary = false  
            end  
        else  
            previousColor = nil  
            previousSea = nil
            sentHakiLegendary = false  
            task.wait(25)
        end  
    end
end)

task.spawn(function()
    while true do  
        task.wait(1)  
        if isSea2() then  
            if not previousSword then  
                sentLegendarySword = false  
            end                
            local currentSword = nil  
            local success, result                          
            success, result = pcall(function()  
                return ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1")  
            end)  
            if success and result then  
                currentSword = "Shizu"  
            end                          
            if not currentSword then  
                success, result = pcall(function()  
                    return ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")  
                end)  
                if success and result then  
                    currentSword = "Oroshi"  
                end  
            end                            
            if not currentSword then  
                success, result = pcall(function()  
                    return ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3")  
                end)  
                if success and result then  
                    currentSword = "Saishi"  
                end  
            end              
            if currentSword and currentSword ~= previousSword and not sentLegendarySword then  
                sendLegendarySwordWebhook(currentSword)  
                previousSword = currentSword  
                sentLegendarySword = true  
            elseif not currentSword and previousSword then  
                previousSword = nil  
                sentLegendarySword = false  
            end  
        else  
            previousSword = nil  
            sentLegendarySword = false  
            task.wait(25)
        end  
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if not sentFruit then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then
                    local handle = v:FindFirstChild("Handle")
                    if handle then
                        sendFruitWebhook(v.Name)
                        sentFruit = true
                        break
                    end
                end
            end
        else
            local fruitExists = false
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then
                    local handle = v:FindFirstChild("Handle")
                    if handle then
                        fruitExists = true
                        break
                    end
                end
            end

            if not fruitExists then
                sentFruit = false
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if isSea3() then
            local sky = Lighting:FindFirstChildOfClass("Sky")
            if sky and sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                if not sentFullMoon then
                    sentFullMoon = true
                    FullMoonWebhook()
                    task.spawn(function()
                        while sentFullMoon and task.wait(300) do
                            local checkSky = Lighting:FindFirstChildOfClass("Sky")
                            if checkSky and checkSky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                                FullMoonWebhook()
                            else
                                sentFullMoon = false
                                break
                            end
                        end
                    end)
                end
            else
                sentFullMoon = false
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isSea3() and not sentNearFullMoon then
            if Lighting:FindFirstChild("Sky") 
            and Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                NearFullMoonWeb()
                sentNearFullMoon = true
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if isSea3() then
            local eliteName
            if ReplicatedStorage:FindFirstChild("Diablo") then
                eliteName = "Diablo"
            elseif ReplicatedStorage:FindFirstChild("Deandre") then
                eliteName = "Deandre"
            elseif ReplicatedStorage:FindFirstChild("Urban") then
                eliteName = "Urban"
            end
            if eliteName then
                if not sentElite then
                    EliteWebhook(eliteName)
                    sentElite = true
                    task.spawn(function()
                        while sentElite and task.wait(300) do
                            if ReplicatedStorage:FindFirstChild(eliteName) then
                                EliteWebhook(eliteName)
                            else
                                sentElite = false
                                break
                            end
                        end
                    end)
                end
            else
                sentElite = false
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        local locations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
        local Prehistoric = locations and locations:FindFirstChild("Prehistoric Island")
        if Prehistoric then
            if not PrehistoricSpawned then
                PrehistoricSpawned = true
                sendWebhook()
                task.spawn(function()
                    while PrehistoricSpawned and task.wait(300) do
                        local checkLocations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
                        if checkLocations and checkLocations:FindFirstChild("Prehistoric Island") then
                            sendWebhook()
                        else
                            PrehistoricSpawned = false
                            break
                        end
                    end
                end)
            end
        else
            PrehistoricSpawned = false
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        local locations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
        local Mirage = locations and locations:FindFirstChild("Mirage Island")
        if Mirage then
            if not MirageSpawned then
                MirageSpawned = true
                MirageWebhook()
                task.spawn(function()
                    while MirageSpawned and task.wait(300) do
                        local checkLocations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
                        if checkLocations and checkLocations:FindFirstChild("Mirage Island") then
                            MirageWebhook()
                        else
                            MirageSpawned = false
                            break
                        end
                    end
                end)
            end
        else
            MirageSpawned = false
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        local locations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
        local Kitsune = locations and locations:FindFirstChild("Kitsune Island")
        if Kitsune then
            if not KitsuneSpawned then
                KitsuneSpawned = true
                KitsuneWebhook()
                task.spawn(function()
                    while KitsuneSpawned and task.wait(300) do
                        local checkLocations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
                        if checkLocations and checkLocations:FindFirstChild("Kitsune Island") then
                            KitsuneWebhook()
                        else
                            KitsuneSpawned = false
                            break
                        end
                    end
                end)
            end
        else
            KitsuneSpawned = false
        end
    end
end)

local BossList2 = {
    ["Sea1"] = {"Greybeard"},
    ["Sea2"] = {"Darkbeard", "Cursed Captain"},
    ["Sea3"] = {"Tyrant of the Skies", "Cake Prince", "rip_indra True Form", "Dough King", "Soul Reaper"}
}
local sentBoss = {}

task.spawn(function()
    while true do
        task.wait(1)
        local sea
        if isSea1() then
            sea = "Sea1"
        elseif isSea2() then
            sea = "Sea2"
        elseif isSea3() then
            sea = "Sea3"
        end
        if sea and BossList2[sea] then
            for _, bossName in ipairs(BossList2[sea]) do
                if not sentBoss[bossName] then
                    local found = (ReplicatedStorage:FindFirstChild(bossName) ~= nil)
                        or (Enemies and Enemies:FindFirstChild(bossName) ~= nil)
                    if found then
                        sendBossAllWebhook(bossName)
                        sentBoss[bossName] = true
                    end
                end
            end
        end
    end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/hoaihipp/phucsinhyeuem/refs/heads/main/DragonHubNotify.lua"))()
print("Webhook Notify On Top - Matsunehub")