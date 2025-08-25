local UniversalScript = {}

local Elements = {}
function UniversalScript.Init(win, WindUI)
    Elements.UniversalSection = (function()
        local section = win:Section({
            Title = "Universal Script",
            Icon = "code-xml"
        })

        section.PlayerSection = section:Tab({
            Title = "Player",
            Icon = "user-cog",
        })
        return section
    end)()



    return Elements
end

return UniversalScript