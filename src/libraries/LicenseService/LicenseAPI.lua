local HttpService = game:GetService("HttpService")
local LicenseAPI = {}

function LicenseAPI.LicenseCheck(License, Indetifier, HWID)
    local url = string.format(
        "https://pandadevelopment.net/v2_validation?key=%s&service=%s&hwid=%s",
        License, Indetifier, HWID
    )

    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        warn("[KeyAuthError]: License request failed -", response)
        return nil
    end

    local ok, licensedata = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    if not ok then
        warn("[KeyAuthError]: Failed to decode license JSON -", licensedata)
        return nil
    end

    return licensedata
end

return LicenseAPI

