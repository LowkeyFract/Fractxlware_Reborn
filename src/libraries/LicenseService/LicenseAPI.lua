local HttpService = game:GetService("HttpService")

local LicenseAPI = {}


function LicenseAPI.ValidateLicense(License, Identifier, HWID)

    local licenseEnc = HttpService:UrlEncode(tostring(License))
    local identifierEnc = HttpService:UrlEncode(tostring(Identifier))
    local hwidEnc = HttpService:UrlEncode(tostring(HWID))

    local url = string.format(
        "https://pandadevelopment.net/v2_validation?key=%s&service=%s&hwid=%s",
        licenseEnc, identifierEnc, hwidEnc
    )

    local success, response = pcall(game.HttpGet, game, url)
    if not success then
        warn("[LicenseAPI] HTTP request failed: " .. tostring(response))
        return false, "HTTP request failed"
    end

    local ok, data = pcall(HttpService.JSONDecode, HttpService, response)
    if not ok or not data then
        warn("[LicenseAPI] Failed to decode JSON response: " .. tostring(data))
        return false, "JSON decode error"
    end

    if data.V2_Authentication == "success" then
        return true, data -- Return the full success data
    else
        local reason = data.reason or "Unknown reason"
        return false, reason
    end
end


function LicenseAPI.GetKeyLink(Identifier, HWID)
    local identifierEnc = HttpService:UrlEncode(tostring(Identifier))
    local hwidEnc = HttpService:UrlEncode(tostring(HWID))

    return string.format(
        "https://pandadevelopment.net/getkey?service=%s&hwid=%s",
        identifierEnc, hwidEnc
    )
end

return LicenseAPI
