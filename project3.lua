local pecho_setting = {
    Silent_aim = {
        enable = false,
        wallcheck = false,
        grabbed_check = false,
        pickup_check = false,
        Random_hitbox = false,
        chance = 100,
        prediciton = 0.121,
        aiming_part = "HumanoidRootPart",
        crewcheck = false,
        friendcheck = false,

        fov = {
            enable =false,
            size = 100,
            visible =false,
            sizes =  0,
            filled = false,
            color = Color3.fromRGB(255,255,255)
        }
    },
}



local camera = workspace.CurrentCamera
local runservice =  game:GetService("RunService")	
local mouse = game.Players.LocalPlayer:GetMouse()
local vec3 = Vector3.new
local vec2 = Vector2.new
local cf = CFrame.new
local Rnew = Ray.new
local draw = Drawing.new
local mh = math.huge
local cfa = CFrame.Angles
local mp = math.pi
local GuiInset = game:GetService("GuiService"):GetGuiInset().Y


local CC = game:GetService"Workspace".CurrentCamera
local LocalMouse = game.Players.LocalPlayer:GetMouse()
local Locking = false
local cc = game:GetService("Workspace").CurrentCamera
local gs = game:GetService("GuiService")
local ggi = gs.GetGuiInset
local lp = game:GetService("Players").LocalPlayer
local mouse = lp:GetMouse()
local UserInputService = game:GetService("UserInputService")

getgenv().Key = Enum.KeyCode.Q
getgenv().Prediction = 0.135 
getgenv().Tracer = true
getgenv().Partz = "HumanoidRootPart" -- // Can be any part it doesnt really matter
getgenv().Resolver = false 
getgenv().ResolverPrediction = 0.1123 -- // Dont touch this when u dont know what ur doing
getgenv().ResolverKey = Enum.KeyCode.C
getgenv().TargetTracer = false

local Tracer = Drawing.new("Circle")
Tracer.Visible = false
Tracer.Radius = 3.9
Tracer.Filled = true
Tracer.Color = Color3.fromRGB(252, 255, 255)
Tracer.Thickness = 3
Tracer.Transparency = 1




local m_thread = task
do
    setreadonly(m_thread, false)

    function m_thread.spawn_loop(p_time, p_callback)

        m_thread.spawn(
            function()
                while true do
                    p_callback()
                    m_thread.wait(p_time)
                end
            end
        )
    end

    setreadonly(m_thread, true)
end



local library, pointers = loadstring(game:HttpGet("https://pastebin.com/raw/Q43KL2RS"))()
do


    local window = library:New({name = "EL PECHO" , size = Vector2.new(555, 610), Accent = Color3.fromRGB(192, 118, 227)})
    local legitbot = window:Page({name = "Main", size = 90})
    local misctab = window:Page({name = "Misc", size = 90})
    local visualstab = window:Page({name = "Visuals", size = 90})
    do
    end
  
    --// loading lib    
    local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Sirius/request/library/sense/source.lua'))()


   
    
    --[[ exmaple
        Sense.teamSettings.enemy.enabled = true
        Sense.teamSettings.enemy.box = true
        Sense.teamSettings.enemy.boxColor[1] = Color3.new(0, 0.25, 0.75)
    ]]
    local misc_1 = misctab:Section({name = "Character", side = "Left"})
   
    

    misc_1:Toggle(
        {
            pointer = "Enable/CFrameSpeed",
            name = "CFrame Speed",
            callback = function(p_state)
            
            end
        }
    )

    misc_1:Keybind(
        {
            pointer = "Keybind/Speed",
            name = "CFrame Keybind",
            default = Enum.KeyCode.Z,
            callback = function(p_state)
                print(p_state)
            end
        }
    )

    misc_1:Slider(
        {
            Name = "Speed Value",   
            Minimum = 0,
            Maximum = 5,
            Default = 0.5,
            suffix = "",
            callback = function(p_state)

            end
        }
    )

    misc_1:Toggle(
        {
            pointer = "enable/RemovejumpCooldown",
            name = "Remove Jump Cooldown",
            callback = function(p_state)

            end
        }
    )

    misc_1:Toggle(
        {
            pointer = "BunnyHop",
            name = "Bunny Hop",
            callback = function(p_state)
                
            end
        }
    )

    
   
    local target_aim = legitbot:Section({name = "Target[Beta]", side = "Left"})
    target_aim:Keybind(
        {
            pointer = "Keybind/targetaim",
            name = "Keybind",
            default = Enum.KeyCode.Q,
            callback = function(p_state)
                getgenv().Key = p_state
            end
        }
    )

    target_aim:Textbox(
        {
            pointer = "textbox3",
            placeholder = "Prediction",
            text = "0.135",
            reset_on_focus = true,
            callback = function(p_state)
                getgenv().Prediction = p_state
            end
            
        }
    )


    target_aim:Dropdown(
        {
            Options = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"},
            default = "HumanoidRootPart",
            pointer = "dropdown/hitpartks",
            callback = function(p_state)
                if p_state == "HumanoidRootPart" then
                    getgenv().Partz = "HumanoidRootPart"
                elseif p_state == "Head" then
                    getgenv().Partz = "Head"
                elseif p_state == "UpperTorso" then
                    getgenv().Partz = "UpperTorso"
                elseif p_state == "LowerTorso" then
                    getgenv().Partz = "LowerTorso"
                    end
            end
        }
    )

    target_aim:Keybind(
        {
            pointer = "Resolver/Toggle",
            name = "Resolver Keybind",
            default = Enum.KeyCode.C,
            callback = function(p_state)
                getgenv()ResolverKey = p_state
            end
        }
    )

    function x(tt,tx,cc)
        game.StarterGui:SetCore("SendNotification", {
            Title = tt;
            Text = tx;
            Duration = cc;
        })
    end
    
    x("Pecho", "Loaded", 3)
    
    if getgenv().flashyes == true then
        x("Pecho", "Already Loaded", 5)
        return
    end
    getgenv().flashyes = true
    
    UserInputService.InputBegan:Connect(function(keygo,ok)
        if (not ok) then
            
            if keygo.KeyCode == getgenv().ResolverKey then 
                getgenv().Resolver = not getgenv().Resolver
                
                if getgenv().Resolver then 
                    x("Pecho", "Resolver is on", 2)
                else 
                    x("Pecho", "Resolver is off", 2)
                end
            end 
            
            if (keygo.KeyCode == getgenv().Key) then
                Locking = not Locking
                    if Locking then
                    getgenv().Plr = getClosestPlayerToCursor()
                    x("Pecho", ""..Plr.Character.Humanoid.DisplayName, 3)
                elseif not Locking then
                    if Plr then Plr = nil
                        x("Pecho", "Unlocked", 3)
                    end
                end
            end
        end
    end)
    
    
    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = 137
    
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("LowerTorso") then
                local pos = CC:WorldToViewportPoint(v.Character.UpperTorso.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalMouse.X, LocalMouse.Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end
    
    local Old; 
    Old = hookmetamethod(game,"__namecall",function(...)
        local Args = {...}
        if Locking and getnamecallmethod() == "FireServer" and getgenv().Plr ~= nil and Args[2] == "UpdateMousePos" then 
            if getgenv().Resolver then 
                Args[3] = Plr.Character[getgenv().Partz].Position+(Plr.Character.Humanoid.MoveDirection*getgenv().ResolverPrediction*19.64285714289)
                print("Resolver on")
            else 
                Args[3] = Plr.Character[getgenv().Partz].Position+(Plr.Character[getgenv().Partz].Velocity*Prediction)
                print("Resolver off")
            end 
            
            return Old(unpack(Args))
        end 
        return Old(...)
    end)
    
    game:GetService("RunService").RenderStepped:connect(function()    
        if getgenv().Tracer == true and Locking then
            if not Resolver then 
                local Vector, OnScreen = cc:worldToViewportPoint(Plr.Character[getgenv().Partz].Position+(Plr.Character[getgenv().Partz].Velocity*Prediction))
                Tracer.Visible = true
                Tracer.Position = Vector2.new(Vector.X, Vector.Y)
            else 
                local Vector, OnScreen = cc:worldToViewportPoint(Plr.Character[getgenv().Partz].Position+(Plr.Character.Humanoid.MoveDirection*getgenv().ResolverPrediction*19.64285714289))
                Tracer.Visible = true
                Tracer.Position = Vector2.new(Vector.X, Vector.Y)
            end 
        else
            Tracer.Visible = false
        end
    end)

    local Silent_Sec = legitbot:Section({name = "Silent", side = "Right"})

    Silent_Sec:Toggle(
        {
            pointer = "Enable/Silent",
            name = "Enable",
            callback = function(p_state)
                pecho_setting.silent_aim.enable = p_state
            end
        }
    )

    Silent_Sec:Toggle(
        {
            pointer = "Enable/Wallcheck",
            name = "Wallcheck",
            callback = function(p_state)
                pecho_setting.silent_aim.wallcheck = p_state
            end
        }
    )

    Silent_Sec:Toggle(
        {
            pointer = "Enable/Grabbed",
            name = "Grabbed Check",
            callback = function(p_state)
                pecho_setting.silent_aim.grabbed_check = p_state
            end
        }
    )

    Silent_Sec:Toggle(
        {
            pointer = "Enable/Pickup",
            name = "Pickup Check",
            callback = function(p_state)
            pecho_setting.silent_aim.pickup_check = p_state
            end
        }
    )

    Silent_Sec:Toggle(
        {
            pointer = "Enable/FriendCheck",
            name = "Friend Check",
            callback = function(p_state)
                pecho_setting.silent_aim.friendcheck = p_state
            end
        }
    )

    Silent_Sec:Textbox(
        {
            pointer = "Text/box1",
            placeholder = "Prediction",
            text = "",
            reset_on_focus = false,
            callback = function(p_state)
                pecho_setting.silent_aim.prediciton = p_state
            end
        }
    )

    Silent_Sec:Dropdown(
        {
            Name = "Aim-Part",
            Options = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"},
            Default = "HumanoidRootPart",
            callback = function(p_state)
               pecho_setting.silent_aim.aiming_part = p_state
            end
        }
    )

    Silent_Sec:Slider(
        {
            Name = "Hit-Chance",
            Minimum = 0,
            Maximum = 100,
            Default = 100,
            suffix = "",
            pointer = "slider/chance",
            callback = function(p_state)
               
            end
        }
    )




    local fovv = legitbot:Section({name = "FOV", side = "Right"})
    fovv:Toggle(
        {
            pointer = "Enable/Fov",
            name = "Enable",
            callback = function(p_state)
                pecho_setting.silent_aim.fov.enable = p_state
            end
        }
    )

    fovv:Colorpicker(
        {
            pointer = "ColorPicker1",
            name = "FOV Color",
            default = Color3.fromRGB(1,1,1),
            callback = function(p_state)
                pecho_setting.silent_aim.fov.color = p_state
            end
        }
    )

    fovv:Slider(
        {
            Name = "FOV Size",
            Minimum = 0,
            Maximum = 500,
            Default = 100,
            suffix = "",
            callback = function(p_state)
                
            end
        }
    )





    local esp_menu = visualstab:Section({name = "Visuals", side = "Left"})

    esp_menu:Toggle(
            {
                pointer = "Enable/Esp",
                name = "Enable",
                callback = function(p_state)
                    Sense.teamSettings.enemy.enabled = p_state
                end
            }
        )
        

        esp_menu:Toggle(
            {
                pointer = "Enable/BoxEsp",
                name = "box",
                callback = function(p_state)
                    Sense.teamSettings.enemy.box = p_state
                    Sense.teamSettings.enemy.boxColor[1] = Color3.new(255,255,255, 0.75)
                end
            }
        )


        esp_menu:Toggle(
            {
                pointer = "Enable/Health",
                name = "health",
                callback = function(p_state)
                    Sense.teamSettings.enemy.healthBar = p_state
                end
            }
        )

        esp_menu:Toggle(
            {
                pointer = "Enable/health.txt",
                name = "healthTxT",
                callback = function(p_state)
                    Sense.teamSettings.enemy.healthText = p_state
                end
            }
        )

        esp_menu:Toggle(
            {
                pointer = "Enable/name",
                name = "name",
                callback = function(p_state)
                    Sense.teamSettings.enemy.name = p_state
                end
            }
        )

        esp_menu:Toggle(
            {
                pointer = "Enable/Weapon",
                name = "weapon",
                callback = function(p_state)
                    Sense.teamSettings.enemy.weapon = p_state
                end
            }
        )

        esp_menu:Toggle(
            {
                pointer = "Enable/distance",
                name = "distance",
                callback = function(p_state)
                    Sense.teamSettings.enemy.distance = p_state
                end
            }
        )

        esp_menu:Toggle(
            {
                pointer = "Enable/tracer",
                name = "tracer",
                callback = function(p_state)
                    
                    Sense.teamSettings.enemy.tracer = p_state
                    Sense.teamSettings.enemy.tracerColor = { Color3.new(255,255,255), 1 }
                end
            }
        )
    

        Sense.Load()
        


     
    local settings_page = window:Page({name = "Configuration", side = "Left", size = 110})
    do
        local config_section = settings_page:Section({name = "Configuration", side = "Left"})
        do
            local current_list = {}
            local function update_config_list()
                local list = {}
                for idx, file in ipairs(listfiles("Linux/configs")) do
                    local file_name = file:gsub("Linux/configs\\", ""):gsub(".txt", "")
                    list[#list + 1] = file_name
                end

                local is_new = #list ~= #current_list
                if not is_new then
                    for idx, file in ipairs(list) do
                        if file ~= current_list[idx] then
                            is_new = true
                            break
                        end
                    end
                end

                if is_new then
                    current_list = list
                    pointers["settings/configuration/list"]:UpdateList(list, false, true)
                end
            end

            config_section:Listbox({pointer = "settings/configuration/list"})
            config_section:Textbox(
                {
                    pointer = "settings/configuration/name",
                    placeholder = "Config Name",
                    text = "",
                    middle = true,
                    reset_on_focus = false
                }
            )


            config_section:ButtonHolder({Buttons = {{"Create",  function()local config_name = pointers["settings/configuration/name"]:get()
                if config_name == "" or isfile("Linux/configs/" .. config_name .. ".txt") then
                    return
                end

                writefile("Linux/configs/" .. config_name .. ".txt", "")
                update_config_list() end}, {"Delete", function()
                local selected_config = pointers["settings/configuration/list"]:get()[1][1]
                if selected_config then
                    delfile("Linux/configs/" .. selected_config .. ".txt")
                    update_config_list()
                end
                end}}})
            config_section:ButtonHolder({Buttons = {{"Load", function()
                local selected_config = pointers["settings/configuration/list"]:get()[1][1]
                if selected_config then
                    window:LoadConfig(readfile("Linux/configs/" .. selected_config .. ".txt"))
                end
            end}, {"Save", function()
                local selected_config = pointers["settings/configuration/list"]:get()[1][1]
                if selected_config then
                    writefile("Linux/configs/" .. selected_config .. ".txt", window:GetConfig())
                end
            end}}})




            m_thread.spawn_loop(3, update_config_list)
    end

    local menu_section = settings_page:Section({name = "Menu"})
    do
        --
        local function gs(a)
            return game:GetService(a)
        end
        --
        local actionservice = gs("ContextActionService")
        --
        menu_section:Keybind(
            {
                pointer = "settings/menu/bind",
                name = "Bind",
                default = Enum.KeyCode.End,
                callback = function(p_state)
                    window.uibind = p_state
                end
            }
        )
        menu_section:Toggle(
            {
                pointer = "sabcd_aa",
                name = "Cursor",
                default = true,
                callback = function(p_state)
                    local userInputService = game:GetService("UserInputService")
                    if p_state == true then
                        userInputService.MouseIconEnabled = true
                    else
                        userInputService.MouseIconEnabled = false
                    end


                end
            }
        )
        local watermark_module = loadstring(game:HttpGet("https://pastebin.com/raw/UawhBK1u"))()
        watermark_module.name = "El Pecho + La Pecha"
        watermark_module.accent = Color3.fromRGB(224, 125, 224)
        watermark_module.visible = false

        menu_section:Toggle(
            {
                pointer = "settings/menu/watermark",
                name = "Watermark",
                default = false,
                callback = function(p_state)
                    watermark_module.visible = p_state
                end
            }
        )
        menu_section:Toggle(
            {
                pointer = "settings/menu/keybind_list",
                name = "Keybind List",
                callback = function(p_state)
                    window.keybindslist:Update("Visible", p_state)
                end
            }
        )

        menu_section:Toggle(
            {
                pointer = "freezemovement",
                name = "Disable Movement if UI Open",
                callback = function(bool)
                    if bool and window.isVisible then
                        actionservice:BindAction(
                            "FreezeMovement",
                            function()
                                return Enum.ContextActionResult.Sink
                            end,
                            false,
                            unpack(Enum.PlayerActions:GetEnumItems())
                        )
                    else
                        actionservice:UnbindAction("FreezeMovement")
                    end
                end
            }
        )


        menu_section:Button(
            {
                name = "Unload",
                confirmation = true,
                callback = function()
                    window:Unload()
                end
            }
        )

        menu_section:Button(
            {
                name = "force close",
                confirmation = true,
                callback = function()
                    window:Fade()
                end
            }
        )

    end

    local other_section = settings_page:Section({name = "Other", side = "Right"})
    do
        other_section:Button(
            {
                name = "Copy JobId",
                callback = function()
                    setclipboard(game.JobId)
                end
            }
        )
        other_section:Button(
            {
                name = "Copy GameID",
                callback = function()
                    setclipboard(game.GameId)
                end
            }
        )
        other_section:Button(
            {
                name = "Copy Game Invite",
                callback = function()
                    setclipboard(
                        "Roblox.GameLauncher.joinGameInstance(" .. game.PlaceId .. ',"' .. game.JobId .. '")'
                    )
                end
            }
        )
        other_section:Button(
            {
                name = "Rejoin",
                confirmation = false,
                callback = function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
                end
            }
        )

        other_section:Button(
            {
                name = "test",
                confirmation = true,
                callback = function()
                    Window.notificationlist:AddNotification({text = "no.regrets loaded. have fun"})
                end
            }
        )
    end

    local themes_section = settings_page:Section({name = "Themes", side = "Right"})
    do

        themes_section:Dropdown(
            {
                Name = "Theme",
                Options = {"Default", "Abyss", "Spotify", "np.rip", "AimWare", "Mint", "Ubuntu", "Bitch Bot", "BubbleGum", "Slime"},
                Default = "Default",
                Pointer = "themes/xd/",
                callback = function(callback)
                    if callback == "Default" then
                        library:UpdateColor("Accent", Color3.fromRGB(189, 182, 240))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(30, 30, 30))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(25, 25, 25))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "Spotify" then
                        library:UpdateColor("Accent", Color3.fromRGB(103, 212, 91))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(30, 30, 30))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(25, 25, 25))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    elseif callback == "AimWare" then
                        library:UpdateColor("Accent", Color3.fromRGB(250, 47, 47))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(41, 40, 40))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(38, 38, 38))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    elseif callback == "np.rip" then
                        library:UpdateColor("Accent", Color3.fromRGB(242, 150, 92))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(22, 12, 46))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(17, 8, 31))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    elseif callback == "Abyss" then
                        library:UpdateColor("Accent", Color3.fromRGB(81, 72, 115))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(41, 41, 41))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(31, 30, 30))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "Mint" then
                        library:UpdateColor("Accent", Color3.fromRGB(0, 255, 139))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(20, 20, 20))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(20, 20, 20))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "Ubuntu" then
                        library:UpdateColor("Accent", Color3.fromRGB(226, 88, 30))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(62,62,62))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(50, 50, 50))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "Bitch Bot" then
                        library:UpdateColor("Accent", Color3.fromRGB(126,72,163))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(62,62,62))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(50, 50, 50))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "BubbleGum" then
                      library:UpdateColor("Accent", Color3.fromRGB(169, 83, 245))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(22, 12, 46))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(17, 8, 31))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    elseif callback == "Slime" then
                        
                           library:UpdateColor("Accent", Color3.fromRGB(64, 247, 141))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(22, 12, 46))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(17, 8, 31))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    end
                end
            }
        )

        themes_section:Dropdown(
            {
                Name = "Accent Effects",
                Options = {"Rainbow", "Fade", "Disguard Fade", "Disguard Rainbow"},
                Default = "None",
                Pointer = "themes/xd/",
                callback = function(callback)
                    if callback == "Rainbow" then
                        if callback then

                            ching =
                                game:GetService("RunService").Heartbeat:Connect(
                                    function()
                                        chings:Disconnect()
                                        library:UpdateColor("Accent", Color3.fromHSV(tick() % 5 / 5, 1, 1))
                                    end
                                )
                        else
                            if ching then
                                ching:Disconnect()
                            end
                        end

                    elseif callback == "Disguard Rainbow" then
                        ching:Disconnect()


                    elseif callback == "Disguard Fade" then

                        chings:Disconnect()

                    elseif callback == "Fade" then
                        if callback then

                            chings =
                                game:GetService("RunService").Heartbeat:Connect(
                                    function()
                                        ching:Disconnect()
                                        local r = (math.sin(workspace.DistributedGameTime/2)/2)+0.5
                                        local g = (math.sin(workspace.DistributedGameTime)/2)+0.5
                                        local b = (math.sin(workspace.DistributedGameTime*1.5)/2)+0.5
                                        local color = Color3.new(r, g, b)
                                        library:UpdateColor("Accent", color)
                                    end
                                )
                        else
                            if chings then
                                chings:Disconnect()
                            end
                        end

                    end
                end
            }
        )
        themes_section:Slider(
            {
                Name = "Switch Speed",
                Minimum = 0,
                Maximum = 10,
                Default = 1,
                Decimals = .1,
                suffix = "",
                Pointer = "reload delay",
                callback = function(a)
                end
            }
        )

        themes_section:Colorpicker(
            {
                pointer = "themes/menu/accent",
                name = "Accent",
                default = Color3.fromRGB(100, 61, 200),
                callback = function(p_state)
                    library:UpdateColor("Accent", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Light Contrast",
                default = Color3.fromRGB(30, 30, 30),
                callback = function(p_state)
                    library:UpdateColor("lightcontrast", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Dark Constrast",
                default = Color3.fromRGB(25, 25, 25),
                callback = function(p_state)
                    library:UpdateColor("darkcontrast", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Outline",
                default = Color3.fromRGB(0, 0, 0),
                callback = function(p_state)
                    library:UpdateColor("outline", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Inline",
                default = Color3.fromRGB(50, 50, 50),
                callback = function(p_state)
                    library:UpdateColor("inline", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Text Color",
                default = Color3.fromRGB(255, 255, 255),
                callback = function(p_state)
                    library:UpdateColor("textcolor", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Text Border",
                default = Color3.fromRGB(0, 0, 0),
                callback = function(p_state)
                    library:UpdateColor("textborder", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Cursor Outline",
                default = Color3.fromRGB(10, 10, 10),
                callback = function(p_state)
                    library:UpdateColor("cursoroutline", p_state)
                end
            }
        )
    end
end
window.uibind = Enum.KeyCode.End
window:Initialize()
end


--silebt aim

local fov = Drawing.new("Circle")
fov.Thickness = 4
fov.Filled = pecho_setting.silent_aim.fov.filled
fov.NumSides = 999

local fovoutline = Drawing.new("Circle")
fovoutline.Thickness = 2
fov.Filled = pecho_setting.silent_aim.fov.filled
fov.NumSides = 999









function FindClosestUser()
    local closestPlayer
    local shortestDistance = pecho_setting.silent_aim.fov.size
    local chances = usechance(pecho_setting.silent_aim.chance)

    local checkcer = false

    

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos, IsVisibleOnViewPort = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)

            if IsVisibleOnViewPort then
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y)).magnitude
                    if  magnitude < shortestDistance and chances == true then
                        if (not pecho_setting.silent_aim.friendcheck or not v:IsFriendsWith(game.Players.LocalPlayer.UserId)) and (not pecho_setting.silent_aim.grabbed_check or v.Character:WaitForChild("BodyEffects")["K.O"].Value ~= true) and (not pecho_setting.silent_aim.pickup_check or v.Character:FindFirstChild("GRABBING_COINSTRAINT") == nil) and (not pecho_setting.silent_aim.wallcheck or WallCheck(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.HumanoidRootPart)) then
                            closestPlayer = v
                            shortestDistance = magnitude
                        end
                    end
                end
            end
        end

    return closestPlayer, shortestDistance
end






local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local old = gmt.__namecall
gmt.__namecall =newcclosure(function(...)
        local args = {...}
        local method = getnamecallmethod()
        if pecho_setting.silent_aim.enable  and method == "FireServer" and args[2] == "UpdateMousePos" and target ~= nil then
            args[3] = target.Character.HumanoidRootPart.Position + (target.Character.HumanoidRootPart.Velocity * pecho_setting.silent_aim.prediciton)
            return old(unpack(args))
        end
        return old(...)
    end)

    runservice.Stepped:Connect(function()
        if pecho_setting.silent_aim.enable then
            fov.Visible = pecho_setting.silent_aim.fov.visible
            fovoutline.Visible = pecho_setting.silent_aim.fov.visible
            fov.Radius = pecho_setting.silent_aim.fov.size
            fovoutline.Radius = pecho_setting.silent_aim.fov.size
            fov.Position = vec2(mouse.X, mouse.Y + GuiInset)
            fovoutline.Position = vec2(mouse.X, mouse.Y + GuiInset)
            fov.Color = pecho_setting.silent_aim.fov.color
            target = FindClosestUser()
        else
            fov.Visible = false
            fovoutline.Visible = false
        end
    end)
