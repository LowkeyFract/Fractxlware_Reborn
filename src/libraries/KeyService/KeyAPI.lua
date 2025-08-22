local HttpService = game:GetService("HttpService")

local KeyAPI = {}

function KeyAPI.ValidateKey(key, serviceId, hwid)
    if not HttpService then
        warn("[Pelinda Ov2.5] HttpService not available.")
        return false, "HttpService not available"
    end

    local validationUrl = "https://pandadevelopment.net/v2_validation?key=" .. tostring(key) .. "&service=" .. tostring(serviceId) .. "&hwid=" .. tostring(hwid)
    
    local success, response = pcall(function()
        return HttpService:RequestAsync({
            Url = validationUrl,
            Method = "GET"
        })
    end)
    
    if success and response then
        if response.Success then
            local jsonData, decodeSuccess = pcall(function()
                return HttpService:JSONDecode(response.Body)
            end)
            
            if decodeSuccess and jsonData then
                if jsonData["V2_Authentication"] == "success" then
                    print("[Pelinda Ov2.5] Authenticated successfully.")
                    return true, "Authenticated"
                else
                    local reason = jsonData["reason"] or "Unknown reason"
                    print("[Pelinda Ov2.5] Authentication failed. Reason: " .. reason)
                    return false, "Authentication failed: " .. reason
                end
            else
                warn("[Pelinda Ov2.5] Failed to decode JSON response.")
                return false, "JSON decode error"
            end
        else
            warn("[Pelinda Ov2.5] HTTP request was not successful. Code: " .. tostring(response.StatusCode) .. " Message: " .. response.StatusMessage)
            return false, "HTTP request failed: " .. response.StatusMessage
        end
    else
        warn("[Pelinda Ov2.5] pcall failed for HttpService:RequestAsync. Error: " .. tostring(response)) -- 'response' here is the error message from pcall
        return false, "Request pcall error"
    end
end

function KeyAPI.GetKeyLink(serviceId, hwid)
    return "https://pandadevelopment.net/getkey?service=" .. tostring(serviceId) .. "&hwid=" .. tostring(hwid)
end

return KeyAPI