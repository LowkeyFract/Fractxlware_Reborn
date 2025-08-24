return function(win, WindUI)
    local tab = win.GameSection:Tab({
        Title = "Universal Features",
        Icon = "star"
    })

    tab:Button({
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