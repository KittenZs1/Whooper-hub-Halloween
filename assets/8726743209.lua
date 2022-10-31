--     _                     _         
--    / \   _ __   __ _  ___| |    ____
--   / _ \ | '_ \ / _` |/ _ \ |   |_  /
--  / ___ \| | | | (_| |  __/ |___ / / 
-- /_/   \_\_| |_|\__, |\___|_____/___|
--                 |___/                

-- Refinery Caves 1.0.2 
-- Created by AngeLz, Ran with the WhopperHub
-- Helpers: Axajj
-- We are not responsible for any bans that may occur from using this script.
-- Making your life easier by giving you the scripts for free!
-- DO NOT REUPLOAD THIS SCRIPT OR CLAIM IT AS YOUR OWN

return function()
    if not getgenv().sf then
        print("Don't run directly")
    end

    local win = getgenv().sf
    local DiscordLib = getgenv().ff
    local serv = win:Server("Refinery Caves", "")
    local main = serv:Channel("Main")
    local misc = serv:Channel("Misc")
    local afarm = serv:Channel("Auto Farm")
    local timeout = 0.05 -- 50ms
    local teleports = serv:Channel("Teleports")
    misc:Slider("Speed",16,250,0,
        function(t)
            getgenv().walk = t
        end
    )
    misc:Slider("Jump",50,250,0,
        function(t)
            getgenv().jump = t
        end
    )
    local function teleportBTN(x,y,z, name)
        teleports:Button(
            name,
            function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
            end
        )    
    end
    teleportBTN(-913,3,-671,"Spawn")
    teleports:Button(
        "Plot",
        function()
            for i, v in next, game:GetService("Workspace").Plots:GetChildren() do
                if v.Owner.Value == game.Players.LocalPlayer then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Base.CFrame + Vector3.new(0, 25, 0)
                end
            end
        end
    )
    teleportBTN(-1005,3,-613,"UCS")
    teleportBTN(-1007,4.74,-728,"Land Agency")
    teleportBTN(-1028,4,-589.5,"Delivery Man")
    teleportBTN(-822.2,60,-609,"Green Block")
    teleportBTN(-1574,-6.4,-518.75,"Dock")
    teleportBTN(-1333,-3.3,-437,"Shore")
    teleportBTN(-1412,-14,-285.2,"Rusty Boat")
    teleportBTN(-1225, 78.7, -103, "Bloxy Cola")
    teleportBTN(-466,5.75,13,"Wood Store")
    teleportBTN(-460,3.85,-95.5,"Sell Area")
    teleportBTN(-1018.8,4.25,690.5,"Furniture Store")
    teleportBTN(709.9,8.25,-966.97,"Dealership")
    teleportBTN(734, 2.25, 55,"Pickaxe Store")
    teleportBTN(-108.75,240,1128.46,"Logic Store")
    teleportBTN(-496, 4.25, -655,"Secret Stash")
    teleportBTN(130, 88, 1073, "Trusty Pickaxe Area")
    teleportBTN(-795, -4.25, 2750, "Facility")
    teleportBTN(-763, -55, 2529, "RadiRug")
    teleportBTN(-3475, 17.9, 1040,"Meteor Rug")
    teleportBTN(-2153, -12.9, -1622,"Island")
    teleportBTN(-596, 194, 1058, "Cable Railway")
    teleportBTN(480, 300, 708, "Meteor Bowl")
    teleportBTN(612, 986, 1519, "Mountain Chair")

    local notS, notR, notI = false, false, false
    local function getTrusty()
        -- pre check if all 3 pickaxes are existing
        for i, v in next, game:GetService("Workspace").Grabable:GetChildren() do
            if v.Name == "Boxed Stone Pickaxe" then
                notS = true
            elseif v.Name == "Boxed Rusty Pickaxe" then
                notR = true
            elseif v.Name == "Boxed Iron Pickaxe" then
                notI = true
            end
        end
        if not notS or not notR or not notI then
            DiscordLib:Notification("Notification", "Pickaxes Haven't Regenerated yet!", "Okay!")
            return
        end
        for i,v in next, game:GetService("Workspace").Grabable:GetChildren() do
            if ((v.Name == "Boxed Stone Pickaxe" and notS) or (v.Name == "Boxed Rusty Pickaxe" and notR) or (v.Name == "Boxed Iron Pickaxe" and notI)) and v:FindFirstChild("Part") then
                if not (v.Part.Position.X < 143+10 and v.Part.Position.X > 143-10 and v.Part.Position.Z < 1105+10 and v.Part.Position.Z > 1105-10) and v.Part.Position.Y > 1 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Part.CFrame
                    game:GetService("ReplicatedStorage").Events.Grab:InvokeServer(v.Part,{})
                    task.wait(0.1)
                    v:FindFirstChild("Part").CFrame = CFrame.new(143, 83, 1105)
                    task.wait(1.5)
                end
            end
        end
    end
    main:Button(
        "Give Trusty Pickaxe",
        function ()
            local t = 0
            while t<15 do
                task.spawn(getTrusty)
                task.wait(0.2)
                t = t + 1
            end
            DiscordLib:Notification("Notification", "Spawned Trusty Pickaxe!", "Okay!")
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135, 88, 1088)
        end
    )
    
    local teleportOre = serv:Channel("Teleports: Ore")
    local function teleportToOreBTN(rockType) 
        teleportOre:Button(
            rockType,
            function()
                for i, v in next, game:GetDescendants() do
                    if v.Name == "RockString" and v:IsA("StringValue") and v.Value == rockType then
                        for i2, v2 in next, v.Parent:GetDescendants() do
                            if v2.Name == "Hitbox" then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v2.CFrame + Vector3.new(0, 5, 0)
                                return
                            end
                        end
                    end
                end
                DiscordLib:Notification("Notification", "Could not find ore", "Okay!")
            end
        )
    end
    -- WIP
    -- local tpe = serv:Channel("Teleports: Entities")
    -- local studs, savedPos = 0, nil
    -- tpe:Button("Set Position", function()
    --     savedPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    --     DiscordLib:Notification("Notification", "Position Set!", "Okay!")
    -- end)    
    -- tpe:Slider("Studs",10,100,0,
    --     function(t)
    --         studs = t
    --     end
    -- )
    -- tpe:Button("Teleport", function()
    --     if savedPos then
    --         -- get all entities in studs/2 radius
    --         local count = 0
    --         for i, v in pairs(game:GetService("Workspace").Grabable:GetChildren()) do
    --             print("cycling... : name: ".. v.Name)
    --             if v.Part.Position.X < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X + studs/2 and v.Part.Position.X > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X - studs/2 and v.Part.Position.Z < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z + studs/2 and v.Part.Position.Z > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z - studs/2 then
    --                 print("true")
    --                 print("tping player to item")
    --                 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Part.CFrame
    --                 print("waiting 0.3")
    --                 task.wait(0.3)
    --                 print("tping item to pos")
    --                 v.Part.CFrame = savedPos

    --                 count = count + 1
    --             else
    --                 print("false")
    --             end
    --         end
    --         DiscordLib:Notification("Notification", "Teleported "..count.." Entities!", "Okay!")
    --     else
    --         DiscordLib:Notification("Notification", "No Position Set!", "Okay!")
    --     end
    -- end)

    -- get all ores
    local array = {
        "Rock",
        "Stone",
        "Sandstone",
        "Limestone",
        "Granite",
        "Marble",
        "Copper",
        "Silver",
        "Iron",
        "Gold",
        "Emerald",
        "Ruby",
        "Amethyst",
        "Sapphire",
        "Oddstone",
        "Sunstone",
        "Crystal",
        "Cloudnite",
        "Obsidian",
        "Volcanium",
        "Moonstone",
        "Tolmedit",
        "Dumortierite",
        "Soulstone",
        "Dirt",
        "Candy Corn"
    }
    teleportOre:Button(
        "Teleport Ores to Plot",
        function()
            local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            for _, v in next, game:GetService("Workspace").Grabable:GetChildren() do
                if v:FindFirstChild("Owner") and v:FindFirstChild("Configuration") and v.Configuration:FindFirstChild("Data") 
                and v.Configuration.Data:FindFirstChild("MatInd") and v.Configuration.Data:FindFirstChild("Size") then
                    if v.Owner.Value == game.Players.LocalPlayer then
                        -- finds the plot
                        for _, l in next, game:GetService("Workspace").Plots:GetChildren() do
                            if l.Owner.Value == game.Players.LocalPlayer then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Part.CFrame
                                task.wait(timeout)
                                v.Part.CFrame = l.Base.CFrame + Vector3.new(0, 25, 0)
                            end
                        end
                    end
                end
            end
            task.wait(timeout)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
        end
    )
    teleportOre:Button(
        "Teleport Ores to Current Pos",
        function()
            local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            for _, v in next, game:GetService("Workspace").Grabable:GetChildren() do
                if v:FindFirstChild("Owner") and v:FindFirstChild("Configuration") and v.Configuration:FindFirstChild("Data") 
                and v.Configuration.Data:FindFirstChild("MatInd") and v.Configuration.Data:FindFirstChild("Size") then
                    if v.Owner.Value == game.Players.LocalPlayer then
                        for _, l in next, game:GetService("Workspace").Plots:GetChildren() do
                            if l.Owner.Value == game.Players.LocalPlayer then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Part.CFrame
                                v.Part.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
                                task.wait(timeout)
                            end
                        end
                    end
                end
            end
            task.wait(timeout)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y+3, pos.Z)
        end
    )
    teleportOre:Button(
        "Teleport Ores to Sell",
        function()
            for _, v in next, game:GetService("Workspace").Grabable:GetChildren() do
                if v:FindFirstChild("Owner") and v:FindFirstChild("Configuration") and v.Configuration:FindFirstChild("Data") 
                and v.Configuration.Data:FindFirstChild("MatInd") and v.Configuration.Data:FindFirstChild("Size") then
                    if v.Owner.Value == game.Players.LocalPlayer then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Part.CFrame
                        task.wait(timeout)
                        -- places the ore in the sell area
                        -- v.Part.CFrame = CFrame.new(-420, 12, -75)
                        -- places it somewhere randomly inside from -404, 8,-85 to -439, 8,-67
                        v.Part.CFrame = CFrame.new(math.random(404, 436)*-1, 8, math.random(67,85)*-1)
                    end
                end
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-455,5.75,-57.7)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Sellary.Keeper.IPart.CFrame
            task.wait(1)
            workspace.Map.Sellary.Keeper.IPart.Interact:FireServer()
            task.wait(1)
            for i, v in pairs(
                getconnections(
                    game:GetService("Players").LocalPlayer.PlayerGui.UserGui.Dialog:WaitForChild("Yes").MouseButton1Click
                )
            ) do
                v:Fire()
            end
        end
    )
    local time = 0.05
    teleportOre:Slider(
        "Teleport Ores Speed",
        0,
        500,
        5,
        function(value)
            time = value/100
        end
    )
    misc:Button(
        "No Damage",
        function()
            local events = {
                Fire = true,
                Invoke = true,
                FireServer = true,
                InvokeServer = true
            }

            local gmeta = getrawmetatable(game)
            setreadonly(gmeta, false)
            local psuedoEnv = {
                ["__index"] = gmeta.__index,
                ["__namecall"] = gmeta.__namecall
            }
            gmeta.__index, gmeta.__namecall =
            newcclosure(
                function(self, index, ...)
                    if events[index] then
                        if "DamageMe" == self.Name and not checkcaller() then
                            return nil
                        end
                    end
                    return psuedoEnv.__index(self, index, ...)
                end
            )
            setreadonly(gmeta, true)
        end
    )
    misc:Button(
        "No Blur",
        function()
            game:GetService("Lighting").WaterBlur:Destroy()
            game:GetService("Lighting").Blur:Destroy()
            DiscordLib:Notification("No Blur", "No Blur has been enabled", "Okay")
        end
    )
    misc:Toggle(
        "No Shadows",
        false,
        function(t)
            if t then 
                DiscordLib:Notification("No Shadows", "No Shadows has been enabled", "Okay")
            else
                DiscordLib:Notification("No Shadows", "No Shadows has been disabled", "Okay")
            end
            game:GetService("Lighting").Shadows = t
        end
    )
    -- places a light on the players head
    misc:Toggle(
        "Head Light",
        false,
        function(t)
            if t then
                local light = Instance.new("PointLight")
                light.Parent = game.Players.LocalPlayer.Character.Head
                light.Range = 100
                light.Brightness = 1
                light.Color = Color3.fromRGB(255, 255, 255)
                DiscordLib:Notification("Head Light", "Head Light has been enabled", "Okay")
            else
                game.Players.LocalPlayer.Character.Head.PointLight:Destroy()
                DiscordLib:Notification("Head Light", "Head Light has been disabled", "Okay")
            end
        end
    )
    task.spawn(
        function()
            while true do
                -- get user ping
                task.wait(1)
                local ping = math.floor((game.Players.LocalPlayer:GetNetworkPing()*3))
                timeout = ping+time    
            end
        end
    )
    teleportOre:Seperator()
    for i,v in next, array do
        teleportToOreBTN(v)
    end
    -- checks if a player presses the F key
    local function checkF()
        local plr = game.Players.LocalPlayer
        local mouse = plr:GetMouse()
        mouse.KeyDown:Connect(
            function(key)
                if key == "f" then
                    for r, i in next, game:GetService("Workspace").Grabable:GetDescendants() do
                        if i.Name == "Grab" then
                            if i:FindFirstChild("Plr") then
                                for t, b in next, game:GetService("Workspace").Plots:GetChildren() do
                                    if b.Owner.Value == game.Players.LocalPlayer then
                                        i.Parent.CFrame = b.Base.CFrame + Vector3.new(0, 25, 0)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        )
    end
    checkF()
    local function checkH()
        local plr = game.Players.LocalPlayer
        local mouse = plr:GetMouse()
        mouse.KeyDown:Connect(
            function(key)
                if key == "h" then
                    for r, i in next, game:GetService("Workspace").Grabable:GetDescendants() do
                        if i.Name == "Grab" then
                            if i:FindFirstChild("Plr") then
                                v.Part.CFrame = CFrame.new(math.random(404, 436)*-1, 8, math.random(67,85)*-1)
                                task.wait(1)
                                workspace.Map.Sellary.Keeper.IPart.Interact:FireServer()
                                task.wait(1)
                                for i, v in pairs(
                                    getconnections(
                                        game:GetService("Players").LocalPlayer.PlayerGui.UserGui.Dialog:WaitForChild("Yes").MouseButton1Click
                                    )
                                ) do
                                    v:Fire()
                                end
                            end
                        end
                    end
                end
            end
        )
    end
    checkH()
    local mts = true
    task.spawn(
        function()
            while true do 
                task.wait()
                if mts then
                    local function conv(int)
                        return tostring(int):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
                    end
                    game:GetService("Players").LocalPlayer.PlayerGui.UserGui.Stats.Cash.Text = "$"..conv(game:GetService("Players").LocalPlayer.Values.Saveable.Cash.Value)
                else
                    game:GetService("Players").LocalPlayer.PlayerGui.UserGui.Stats.Cash.Text = "$"..require(game.ReplicatedStorage.Modules.Shortcut).Cash(game.Players.LocalPlayer.Values.Saveable.Cash.Value);
                end
            end
        end
    )
    afarm:Seperator()
    afarm:Label("Coming soon...")
    misc:Toggle("Show Full Money", true, function(t)
        if t then
            mts = true
            DiscordLib:Notification("Show Full Money", "Showing full money has been enabled", "Okay")
        else
            mts = false
            DiscordLib:Notification("Show Full Money", "Showing full money has been disabled", "Okay")
        end
    end)
    -- afarm:Toggle("Trusty Pickaxe", false,function(on)
    --     onTp = on
    -- end)
    -- afarm:Toggle("Neon Car Farm", false,function(on)
    --     onNc = on
    -- end)
    main:Label("Hotkeys")
    main:Label("F - Teleport ores to plot")
    main:Label("H - Teleport ores to sell")    
    -- changelog
    local changelog = serv:Channel("Changelog")
    local change = {
        "Update 1.0.0 - 10/24/2022",
        "- Initial Release",
        "",
        "Update 1.0.1 - 10/25/2022",
        "- Added Changelog",
        "- Added No Damage",
        "- Added No Shadows",
        "- Added Head Light (Alternative to Always day)",
        "- Added No Blur",
        "- Added Auto Farm Wood",
        "- Added Show Full Money",
        "- Slowed Down Give Trusty Interval",
        "",
        "Update 1.0.2 - 10/30/2022",
        "- Removed Meteor Spawn",
        "- Fixed Patch for Trusty Pickaxe",
        "- Fixed Changelog"
    }
    for i,v in pairs(change) do
        changelog:Label(v)
    end
end
