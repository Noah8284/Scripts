-- colocar em ServerScriptService
local Players = game:GetService("Players")

-- Lista de jogadores autorizados
local allowedUsers = {
    ["mest_x"] = true,
    ["rbxV1P3R"] = true
}

-- Nome do item que será duplicado
local itemName = "Timebomb" -- Verifique se esse nome está correto

-- Função para processar o comando do chat
local function onPlayerChatted(player, message)
    local args = string.split(message, " ")
    
    if allowedUsers[player.Name] and args[1] == "/copy" and tonumber(args[2]) then
        local quantity = math.min(tonumber(args[2]), 100) -- Limite máximo de 100 para evitar lag

        -- Pegar a mochila do jogador
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            local originalItem = backpack:FindFirstChild(itemName)
            if originalItem then
                for i = 1, quantity do
                    local clone = originalItem:Clone()
                    clone.Parent = backpack
                end
            end
        end
    end
end

-- Conectar a função ao chat
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end)
