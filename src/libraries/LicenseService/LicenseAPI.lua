local HttpService = game:GetService("HttpService")
local LicenseAPI = {}

function LicenseAPI.ValidateKey(key, serviceId, hwid)
    if not key or not serviceId or not hwid then
        return false, "Missing parameters"
    end

    local url = string.format(
        "https://pandadevelopment.net/v2_validation?key=%s&service=%s&hwid=%s",
        key, serviceId, hwid
    )

    local response
    local success, err = pcall(function()
        -- For executor, GetAsync works in most cases
        response = HttpService:GetAsync(url, true)
    end)

    if not success then
        return false, "HTTP request failed: " .. tostring(err)
    end

    local decoded
    local ok, decodeErr = pcall(function()
        decoded = HttpService:JSONDecode(response)
    end)

    if not ok then
        return false, "Failed to decode response: " .. tostring(decodeErr)
    end

    if decoded.valid then
        return true, decoded
    else
        return false, decoded.message or "Invalid key"
    end
end

return LicenseAPI