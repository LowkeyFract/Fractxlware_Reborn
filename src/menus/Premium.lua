local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")

local SCRIPT_DATA = {
    Name   = "Fractxlware Reborn",
    Build   = { Name = "In Development", Color = "#FFA41A" },
    Type   = { Name = "Premium", Color = "#005BD9" },
    Author = "discord.gg/6qyh5mfN5h",
}

local CLIENT_DATA = {
    DEVICE = (function()
        local platform = game:GetService("UserInputService"):GetPlatform()

        if platform == Enum.Platform.IOS or platform == Enum.Platform.Android then
            return "Mobile"
        elseif platform == Enum.Platform.OSX or platform == Enum.Platform.Windows then
            return "PC"
        elseif platform == Enum.Platform.UWP then
            return "Tablet"
        elseif platform == Enum.Platform.Emulator then
            return "Emulator"
        else
            return "Unknown"
        end
    end)(),
    ACC_NAME = Players.LocalPlayer.Name or "Unknown",
    ACC_DISPLAY_NAME = Players.LocalPlayer.DisplayName or "Unknown",
    PLAYER_ID = Players.LocalPlayer.UserId or 0,
    CLIENT_ID = game:GetService("RbxAnalyticsService"):GetClientId(),
    ACCOUNT_AGE = Players.LocalPlayer.AccountAge or 0,
    GAME = (function()
        local name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown"
        name = name:gsub("%b()", "")
        name = name:gsub("%b[]", "")
        name = name:gsub("[%z\1-\127\194-\244][\128-\191]*", function(c)
            if c:match("[%w%s]") then
                return c
            else
                return ""
            end
        end)
        name = name:gsub("[^%w%s]", "")
        name = name:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
        return name
    end)(),
}

local SERVER_DATA = {
    PLACE_ID = game.PlaceId,
    JOB_ID = game.JobId,
    SERVER_REGION = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(game.Players.LocalPlayer) or "Unknown",
    MAX_PLAYERS = game.Players.MaxPlayers,
    CURRENT_PLAYERS = (function()
        local current = #Players:GetPlayers()
        Players.PlayerAdded:Connect(function()
            current = #Players:GetPlayers()
        end)
        Players.PlayerRemoving:Connect(function()
            current = #Players:GetPlayers()
        end)
        return function()
            return current
        end
    end)()
}


local WindUI, SoundModule, ScriptTable = (function()
    local LIBRARIES = {
        WindUI      = "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
        SoundModule = "https://raw.githubusercontent.com/LowkeyFract/Fractxlware_Reborn/refs/heads/main/src/libraries/SoundModule.lua",
        ScriptTable = "https://raw.githubusercontent.com/LowkeyFract/Fractxlware_Reborn/refs/heads/main/src/menus/scripts/ScriptTable.lua",
    }

    local loaded = {}
    for name, url in pairs(LIBRARIES) do
        local ok, mod = pcall(loadstring, game:HttpGet(url))
        loaded[name] = ok and mod() or warn("Failed to load "..name)
    end

    return loaded.WindUI, loaded.SoundModule, loaded.ScriptTable
end)()

local DETECTED_SCRIPT = loadstring(game:HttpGet(ScriptTable[SERVER_DATA.PLACE_ID] or ScriptTable["universal"]))()
local gameSupported = ScriptTable[SERVER_DATA.PLACE_ID] ~= nil
local GameSupportColor = gameSupported and "#BFFFBF" or "#F28D7C"

local Elements = {}
Elements.PremiumWindow = (function()
    SoundModule.Play(82845990304289, 1, SoundService)

    local win = WindUI:CreateWindow({
        Title = SCRIPT_DATA.Name,
        Folder = SCRIPT_DATA.Name,
        Author = SCRIPT_DATA.Author,
        Icon = "droplet",
        Size = UDim2.fromOffset(580, 460),
        Transparent = true,
        Theme = "Dark",
        Resizable = true,
        SideBarWidth = 200,
        BackgroundImageTransparency = 0.42,
        HideSearchBar = true,
        ScrollBarEnabled = false,
    })

    win:IsResizable(false)

    win:DisableTopbarButtons({"Minimize", "Fullscreen"})

    win:Tag({
        Title = SCRIPT_DATA.Build.Name,
        Color = Color3.fromHex(SCRIPT_DATA.Build.Color)
    })

    win:Tag({
        Title = SCRIPT_DATA.Type.Name,
        Color = Color3.fromHex(SCRIPT_DATA.Type.Color)
    })

    win.GameSection = win:Section({
        Title = string.format('<font color="%s">%s</font>', GameSupportColor, CLIENT_DATA.GAME),
        Icon = "gamepad",
        Opened = false,
    })

    win:Divider()

    return win
end)()

Elements.InformationSection = (function()
    local section = Elements.PremiumWindow:Section({
        Title = "Information",
        Icon = "info",
        Opened = true
    })

    section.ClientInformation = section:Tab({
        Title = "Client",
        Icon = "monitor-down"
    })

    section.ClientInformation.ClientInfo = section.ClientInformation:Code({
        Title = "Client Information",
        Code = 'Device : '..CLIENT_DATA.DEVICE..'\n'..
               'Name : '..CLIENT_DATA.ACC_NAME.."("..CLIENT_DATA.ACC_DISPLAY_NAME..")"..'\n'..
               'Player ID : '..CLIENT_DATA.PLAYER_ID..'\n'..
               'Client ID : '..CLIENT_DATA.CLIENT_ID..'\n'..
               'Account Age : '..CLIENT_DATA.ACCOUNT_AGE..' days'
    })

    section.ClientInformation:Divider()

    section.ClientInformation:Button({
        Title = "Copy Client ID",
        Description = "Copies your Client ID to your clipboard.",
        Callback = function()
            setclipboard(CLIENT_DATA.CLIENT_ID)
            WindUI:Notify({
                Title = "Copied Client ID",
                Content = "Your Client ID has been copied to your clipboard.",
                Icon = "clipboard"
            })
        end
    })

    section.ClientInformation:Button({
        Title = "Copy Player ID",
        Description = "Copies your Player ID to your clipboard.",
        Callback = function()
            setclipboard(CLIENT_DATA.PLAYER_ID)
            WindUI:Notify({
                Title = "Copied Player ID",
                Content = "Your Player ID has been copied to your clipboard.",
                Icon = "clipboard"
            })
        end
    })

    section.ServerInformation = section:Tab({
        Title = "Server",
        Icon = "server"
    })

    
    section.ServerInformation.ServerInfo = section.ServerInformation:Code({
        Title = "Server Information",
        Code = 'Game : '..CLIENT_DATA.GAME..'\n'..
               'Place ID : '..SERVER_DATA.PLACE_ID..'\n'..
               'Job ID : '..SERVER_DATA.JOB_ID..'\n'..
               'Region : '..SERVER_DATA.SERVER_REGION..'\n'..
               'Players : '..SERVER_DATA.CURRENT_PLAYERS()..'/'..SERVER_DATA.MAX_PLAYERS
    })

    
    game:GetService("RunService").Heartbeat:Connect(function()
        section.ServerInformation.ServerInfo:SetCode(
            'Game : '..CLIENT_DATA.GAME..'\n'..
            'Place ID : '..SERVER_DATA.PLACE_ID..'\n'..
            'Job ID : '..SERVER_DATA.JOB_ID..'\n'..
            'Region : '..SERVER_DATA.SERVER_REGION..'\n'..
            'Players : '..SERVER_DATA.CURRENT_PLAYERS()..'/'..SERVER_DATA.MAX_PLAYERS
        )
    end)

    section.ServerInformation:Divider()

    section.ServerInformation.CopyJobId = section.ServerInformation:Button({
        Title = "Copy Job ID",
        Description = "Copies the current server's Job ID to your clipboard.",
        Callback = function()
            setclipboard(SERVER_DATA.JOB_ID)
            WindUI:Notify({
                Title = "Copied Job ID",
                Content = "The Job ID has been copied to your clipboard.",
                Icon = "clipboard"
            })
        end
    })

    section.ServerInformation.CopyPlaceID = section.ServerInformation:Button({
        Title = "Copy Place ID",
        Description = "Copies the current server's Place ID to your clipboard.",
        Callback = function()
            setclipboard(SERVER_DATA.PLACE_ID)
            WindUI:Notify({
                Title = "Copied Place ID",
                Content = "The Place ID has been copied to your clipboard.",
                Icon = "clipboard"
            })
        end
    })

    return section
end)()

DETECTED_SCRIPT.Init(Elements.PremiumWindow, WindUI)