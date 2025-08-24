local UniversalScript = {}

local Elements = {}
function UniversalScript.Init(win, WindUI)

    WindUI:Notify({
        Title = "Game Not Supported",
        Content = "Loaded Universal Script",
        Icon = "scroll-text"
    })

    Elements.UniversalSection = (function()
        local section = win:Section({
            Title = "Universal Script",
            Icon = "code-xml"
        })
        return section
    end)()

    return Elements
end

return UniversalScript