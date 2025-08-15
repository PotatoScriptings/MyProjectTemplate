--[[
    Date of Creation: DD/MM/YYYY (DD/MM/YYYY)
    Author: Potato
    Purpose: This module handles UI related things like toggling frames and VPFs.
]]

-- Services
local TweenService = game:GetService("TweenService")

-- Variables
local ToggleTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Back)

local VPFMax = 5000 -- The maximum VPF pos in each vector
local VPFInterval = 100 -- The interval at which VPF models are placed
local VPFX = -VPFMax -- The X position of VPF models
local VPFY = -VPFMax -- The Y position of VPF models
local VPFZ = -VPFMax -- The Z position of VPF models
local AvailableVPFPositions = {} -- The VPF positions available (Added to when a VPF is deleted)

local UIModule = {}

-- Function to toggle a frame
function UIModule:ToggleFrame(Frame : Frame)
    -- Gets Toggled
    local Toggled = Frame:FindFirstChild("Toggled")
    if not Toggled then
        Toggled = Instance.new("BoolValue")
        Toggled.Parent = Frame
        Toggled.Name = "Toggled"
        Toggled.Value = true
    else
        Toggled.Value = not Toggled.Value
    end

    -- Toggles frame
    Frame.Visible = true
    Frame.Position = if not Toggled.Value then UDim2.fromScale(0.5, 0.5) else UDim2.fromScale(0.5, 2)
    local TogglePosition = if Toggled.Value then UDim2.fromScale(0.5, 0.5) else UDim2.fromScale(0.5, 2)

    local ToggleTween = TweenService:Create(Frame, ToggleTweenInfo, {Position = TogglePosition})

    ToggleTween:Play()
    ToggleTween.Completed:Wait()

    Frame.Visible = Toggled.Value
end

-- Function to set up a ViewportFrame
function UIModule:SetUpVPF(VPF : ViewportFrame, Model : Model, Offset : Vector3)
    -- Gets components
    local Camera = VPF:FindFirstChildOfClass("Camera")
    if not Camera then
        Camera = Instance.new("Camera")
        Camera.Parent = VPF
    end
    VPF.CurrentCamera = Camera

    local WorldModel = VPF:FindFirstChildOfClass("WorldModel")
    if not WorldModel then
        WorldModel = Instance.new("WorldModel")
        WorldModel.Parent = VPF
    end

    -- Adds model
    Model = Model:Clone()
    Model.Parent = WorldModel

    -- Moves model and camera
    local TargetPos = Vector3.new(VPFX, VPFY, VPFZ)
    if #AvailableVPFPositions > 0 then
        TargetPos = AvailableVPFPositions[1]
        table.remove(AvailableVPFPositions, 1)
    end

    if not Offset then
        Offset = Vector3.new(0, 0, 8)
    end

    Camera.CFrame = CFrame.lookAt(TargetPos + Offset, TargetPos)

    Model:PivotTo(CFrame.lookAt(TargetPos, Camera.CFrame.Position))

    -- Updates X, Y, and Z
    if VPFX < VPFMax then
        VPFX += VPFInterval
    elseif VPFY < VPFMax then
        VPFX = -VPFMax
        VPFY += VPFInterval
    else
        VPFX = -VPFMax
        VPFY = -VPFMax
        VPFZ += VPFInterval
    end

    -- When VPF is deleted save VPF position
    VPF.Destroying:Connect(function()
        table.insert(AvailableVPFPositions, TargetPos)
    end)
end

return UIModule