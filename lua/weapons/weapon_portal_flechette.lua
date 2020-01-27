AddCSLuaFile()

-- Most of the code below is edited from the flechette gun by Garry
SWEP.PrintName = "Aperture Flechette Emitter"
SWEP.Author = "Fuzzik"
SWEP.Purpose = "Left click to primary fire; right click to secondary fire"

SWEP.Slot = 2
SWEP.SlotPos = 3

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.DrawAmmo = false

SWEP.ViewModel = Model("models/weapons/v_portalgun.mdl")
SWEP.WorldModel = Model("models/weapons/w_irifle.mdl")
SWEP.ViewModelFOV = 55

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

game.AddParticles("particles/hunter_flechette.pcf")
game.AddParticles("particles/hunter_projectile.pcf")

local ShootSound = Sound("weapons/portalgun/portalgun_shoot_blue1.wav")
local ShootSound2 = Sound("weapons/portalgun/portalgun_shoot_red1.wav")

function SWEP:Initialize()
    self:SetHoldType("ar2")
end

-- Reload does nothing
function SWEP:Reload()
end

function SWEP:CanBePickedUpByNPCs()
    return true
end

-- Primary attack
function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.1)
    
    self:EmitSound(ShootSound)
    self:ShootEffects(self)
    
    if (CLIENT) then return end
    
    SuppressHostEvents(NULL) -- Do not suppress the flechette effects
    
    local ent = ents.Create("hunter_flechette")
    
    if (!IsValid(ent)) then return end
    
    local Forward = self:GetOwner():GetAimVector()
    
    ent:SetPos(self:GetOwner():GetShootPos() + Forward * 32)
    ent:SetAngles(self:GetOwner():EyeAngles())
    ent:SetOwner(self:GetOwner())
    ent:Spawn()
    ent:Activate()
    
    ent:SetVelocity(Forward * 2000)
end

-- Secondary attack
function SWEP:SecondaryAttack()
    self:SetNextSecondaryFire(CurTime() + 0.1)
    
    self:EmitSound(ShootSound2)
    self:ShootEffects(self)
    
    if (CLIENT) then return end
    
    SuppressHostEvents(NULL) -- Do not suppress the flechette effects
    
    local ent = ents.Create("hunter_flechette")
    
    if (!IsValid(ent)) then return end
    
    local Forward = self:GetOwner():GetAimVector()
    
    ent:SetPos(self:GetOwner():GetShootPos() + Forward * 32)
    ent:SetAngles(self:GetOwner():EyeAngles())
    ent:SetOwner(self:GetOwner())
    ent:Spawn()
    ent:Activate()
    
    ent:SetVelocity(Forward * 2000)
end

-- Weapon does not drop upon death
function SWEP:ShouldDropOnDie()
    return false
end

function SWEP:GetNPCRestTimes()
    -- Handles the time between bursts
    -- Min rest time in seconds, max rest time in seconds
    
    return 0.3, 0.6
end

function SWEP:GetNPCBurstSettings()
    -- Handles the burst settings
    -- Minimum amount of shots, maximum amount of shots, and the delay between each shot
    -- The amount of shots can end up lower than specified
    
    return 1, 6, 0.1
end

function SWEP:GetNPCBulletSpread(proficiency)
    -- Handles the bullet spread based on the given proficiency
    -- Return value is in degrees
    
    return 1
end
