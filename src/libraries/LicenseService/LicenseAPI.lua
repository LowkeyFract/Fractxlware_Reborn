local HttpService = game:GetService("HttpService")

local LicenseAPI = {}


function LicenseAPI.ValidateLicense(License, Identifier, HWID)
    local url = string.format(
        "https://pandadevelopment.net/v2_validation?key=%s&service=%s&hwid=%s",
        License, Identifier, HWID
    )

    local success, response = pcall(game.HttpGet, game, url)
    if not success then
        warn("[LicenseAPI] HTTP request failed: " .. tostring(response))
        return false, { Notes = "HTTP request failed" }
    end

    local ok, data = pcall(HttpService.JSONDecode, HttpService, response)
    if not ok or not data then
        warn("[LicenseAPI] Failed to decode JSON response: " .. tostring(data))
        return false, { Notes = "JSON decode error" }
    end

    if data.V2_Authentication == "success" then
        return true, data.Key_Information
    else
        return false, data.Key_Information or { Notes = data.reason or "Unknown reason" }
    end
end

function LicenseAPI.GetKeyLink(Identifier, HWID)
    return string.format(
        "https://pandadevelopment.net/getkey?service=%s&hwid=%s",
        Identifier, HWID
    )
end

return LicenseAPI
