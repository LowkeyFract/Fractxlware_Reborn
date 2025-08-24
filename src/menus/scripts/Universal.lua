return function(win, WindUI)
    print("Window object:", win)
    print("Has Section method:", win.Section ~= nil)

    local section = win:Section({
        Title = "Universal Features",
        Icon = "star",
        Opened = true
    })

    print("Section created:", section)
end
