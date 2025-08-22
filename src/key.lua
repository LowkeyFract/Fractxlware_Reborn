local Identifier = "fractxlware_reborn"

local SCRIPT_DATA = {
    Name    = "Fractxlware Reborn",
    Build   = { Name = "Beta", Color = "#035B85" },
    Type    = { Name = "Public", Color = "#234234" },
    Version = "1.0.0",
    Author  = "discord.gg/6qyh5mfN5h",
}

local SoundService = game:GetService("SoundService")

local WindUI, LoadingScreen, SoundModule, LicenseAPI = (function()
    local LIBRARIES = {
        WindUI = "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
        LoadingScreen = "https://raw.githubusercontent.com/LowkeyFract/Fractxlware_Reborn/refs/heads/main/src/libraries/LoadingScreen.lua",
        SoundModule = "https://raw.githubusercontent.com/LowkeyFract/Fractxlware_Reborn/refs/heads/main/src/libraries/SoundService.lua",
        LicenseAPI = "https://raw.githubusercontent.com/LowkeyFract/Fractxlware_Reborn/refs/heads/main/src/libraries/LicenseService/LicenseAPI.lua",
    }

    local loaded = {}
    for name, url in pairs(LIBRARIES) do
        local ok, mod = pcall(loadstring, game:HttpGet(url))
        loaded[name] = ok and mod() or warn("Failed to load "..name)
    end
    return loaded.WindUI, loaded.LoadingScreen, loaded.SoundModule, loaded.LicenseAPI
end)()

local Elements = {}
Elements.KeyWindow = (function()
    LoadingScreen:ShowAsync()
    WindUI:Notify({
        Title = "Successfully Loaded!",
        Content = "Fractxlware Reborn has been successfully loaded.",
        Icon = "check",
    })
    SoundModule.Play(82845990304289, 1, SoundService)

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
    local License = ""

    local section = Elements.KeyWindow:Section({
        Title = "License System",
        Icon = "key-round",
        Opened = true,
    })

    section.Login = section:Tab({
        Title = "Login",
        Icon = "log-in"
    })

    section.Login.Input = section.Login:Input({
        Title = "Input",
        Desc = "Input your license key to gain access to Fractxlware Reborn.",
        Value = "",
        Type = "Input",
        Placeholder = "License here..",
        Callback = function(input) 
            License = input
        end
    })

    section.Login.CheckKey = section.Login:Button({
        Title = "Check License",
        Desc = "Check if your license key is valid.",
        Callback = function()
            if License == "" then
                WindUI:Notify({
                    Title = "Error",
                    Content = "Please enter a license key.",
                    Icon = "error",
                })
                return
            end

            local success, isValid, _ = pcall(function()
                return LicenseAPI.ValidateKey(License, Identifier, game:GetService("RbxAnalyticsService"):GetClientId())
            end)

            if not success then
                WindUI:Notify({
                    Title = "Error",
                    Content = "[LICENSE API] Service failed to respond. Please try again later.",
                    Icon = "error",
                })
                return
            end

            if isValid then
                WindUI:Notify({
                    Title = "Success",
                    Content = "License Validated!",
                    Icon = "check",
                })
            else
                WindUI:Notify({
                    Title = "Error",
                    Content = "License is invalid or expired.",
                    Icon = "error",
                })
            end
        end
    })


    return section
end)()