return function(win, WindUI)
    local section = win:Section({
        Title = "Universal Features",
        Icon = "star",
        Opened = true
    })

    section:Button({
        Title = "Example Button",
        Callback = function()
            WindUI:Notify({
                Title = "Universal",
                Content = "This is the universal script!",
                Icon = "check"
            })
        end
    })
end