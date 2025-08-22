local Identifier = "fractxlware_reborn"

local SCRIPT_DATA = {
    Name    = "Fractxlware Reborn",
    Build   = { Name = "Beta", Color = "#035B85" },
    Type    = { Name = "Public", Color = "#234234" },
    Version = "1.0.0",
    Author  = "discord.gg/6qyh5mfN5h",
}

local WindUI, LoadingScreen, KeyAPI = (function()
    local LIBRARIES = {
        WindUI = "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
        LoadingScreen = "https://raw.githubusercontent.com/LowkeyFract/Fractxlware_Reborn/refs/heads/main/src/libraries/LoadingScreen.lua",
        KeyAPI = "https://raw.githubusercontent.com/LowkeyFract/Fractxlware_Reborn/refs/heads/main/src/libraries/KeyService/KeyAPI.lua",
    }

    local loaded = {}
    for name, url in pairs(LIBRARIES) do
        local ok, mod = pcall(loadstring, game:HttpGet(url))
        loaded[name] = ok and mod() or warn("Failed to load "..name)
    end
    return loaded.WindUI, loaded.LoadingScreen, loaded.KeyAPI
end)()

LoadingScreen:ShowAsync()

local Elements = {}
Elements.KeyWindow = (function()
    local win = WindUI:CreateWindow({
        Title = SCRIPT_DATA.Name,
        Folder = SCRIPT_DATA.Name,
        Author = SCRIPT_DATA.Author,
        Size = UDim2.fromOffset(580, 460),
        Transparent = true,
        Theme = "Dark",
        Resizable = true,
        SideBarWidth = 200,
        BackgroundImageTransparency = 0.42,
        HideSearchBar = true,
        ScrollBarEnabled = false,
    })

    win:DisableTopbarButtons({"Minimize", "Fullscreen"})

    win:Tag({
        Title = SCRIPT_DATA.Build.Name,
        Color = Color3.fromHex(SCRIPT_DATA.Build.Color)
    })

    win:Tag({
        Title = SCRIPT_DATA.Type.Name,
        Color = Color3.fromHex(SCRIPT_DATA.Type.Color)
    })

    return win
end)()

Elements.KeySection = (function()
    local UserKey = ""

    local section = Elements.KeyWindow:Section({
        Title = "Key System",
        Icon = "key-round",
        Opened = true,
    })

    section.Login = section:Tab({
        Title = "Login",
        Icon = "log-in"
    })

    return section
end)()