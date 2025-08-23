local SoundService = game:GetService("SoundService")

local SCRIPT_DATA = {
    Name   = "Fractxlware Reborn",
    Build   = { Name = "In Development", Color = "#FFA41A" },
    Type   = { Name = "Freemium", Color = "#BAFF9C" },
    Author = "discord.gg/6qyh5mfN5h",
}

local CLIENT_DATA = {
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

local WindUI, SoundModule = (function()
    local LIBRARIES = {
        WindUI      = "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
        SoundModule = "https://raw.githubusercontent.com/LowkeyFract/Fractxlware_Reborn/refs/heads/main/src/libraries/SoundModule.lua",
    }

    local loaded = {}
    for name, url in pairs(LIBRARIES) do
        local ok, mod = pcall(loadstring, game:HttpGet(url))
        loaded[name] = ok and mod() or warn("Failed to load "..name)
    end

    return loaded.WindUI, loaded.SoundModule
end)()

local Elements = {}
Elements.FreemiumWindow = (function()
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
        Title = CLIENT_DATA.GAME,
        Icon = "gamepad",
        Opened = false,
    })

    win:Divider()

    return win
end)()
