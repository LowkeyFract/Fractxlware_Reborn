local HttpService = game:GetService("HttpService")

local KeyAPI = {}

-- Validates a license key
function KeyAPI.ValidateLicense(key, serviceId, hwid)
    local validationUrl = string.format(
        "https://pandadevelopment.net/v2_validation?key=%s&service=%s&hwid=%s",
        tostring(key), tostring(serviceId), tostring(hwid)
    )

    local success, response = pcall(game.HttpGet, game, validationUrl)
    if not success then
        warn("[LICENSE API] HTTP request failed: " .. tostring(response))
        return false, "Request failed"
    end

    local ok, data = pcall(HttpService.JSONDecode, HttpService, response)
    if not ok or not data then
        warn("[LICENSE API] Failed to decode JSON response: " .. tostring(data))
        return false, "JSON decode error"
    end

    if data.V2_Authentication == "success" then
        print("[LICENSE API] Authenticated successfully.")
        return true, "Authenticated"
    else
        local reason = data.reason or "Unknown reason"
        print("[LICENSE API] Authentication failed. Reason: " .. reason)
        return false, "Authentication failed: " .. reason
    end
end

-- Returns a link to get a license
function KeyAPI.GetLicenseLink(serviceId, hwid)
    return string.format(
        "https://pandadevelopment.net/getkey?service=%s&hwid=%s",
        tostring(serviceId), tostring(hwid)
    )
end

return KeyAPI
