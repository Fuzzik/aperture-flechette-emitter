AddCSLuaFile()

-- Most of the code below is edited from the flechette gun by Garry
SWEP.PrintName = "Aperture Flechette Emitter"
SWEP.Author	= "Fuzzik543"
SWEP.Purpose = "Left click to primary fire, Right click to secondary fire"

SWEP.Slot = 2
SWEP.SlotPos = 3

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.DrawAmmo = false

SWEP.ViewModel = Model( "models/weapons/v_portalgun.mdl" )
SWEP.WorldModel	= Model( "models/weapons/w_irifle.mdl" )
SWEP.ViewModelFOV = 55

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo	= "none"

game.AddParticles( "particles/hunter_flechette.pcf" )
game.AddParticles( "particles/hunter_projectile.pcf" )

local ShootSound = Sound( "weapons/portalgun/portalgun_shoot_blue1.wav" )
local ShootSound2 = Sound( "weapons/portalgun/portalgun_shoot_red1.wav" )

function SWEP:Initialize()
	self:SetHoldType( "ar2" )
end

-- Reload does nothing
function SWEP:Reload()
end

-- Primary attack
function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + 0.1 )

	self:EmitSound( ShootSound )
	self:ShootEffects( self )

	-- The rest is only done on the server
	if ( !SERVER ) then return end

	local Forward = self.Owner:EyeAngles():Forward()

	local ent = ents.Create( "hunter_flechette" )

	if ( IsValid( ent ) ) then
		ent:SetPos( self.Owner:GetShootPos() + Forward * 32 )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:Spawn()

		ent:SetVelocity( Forward * 2000 )
		ent:SetOwner( self.Owner )
	end
end

-- Secondary attack
function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire( CurTime() + 0.1 )

	self:EmitSound( ShootSound2 )
	self:ShootEffects( self )

	-- The rest is only done on the server
	if ( !SERVER ) then return end

	local Forward = self.Owner:EyeAngles():Forward()

	local ent = ents.Create( "hunter_flechette" )

	if ( IsValid( ent ) ) then
		ent:SetPos( self.Owner:GetShootPos() + Forward * 32 )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:Spawn()

		ent:SetVelocity( Forward * 2000 )
		ent:SetOwner( self.Owner )
	end
end

-- Weapon does not drop upon death
function SWEP:ShouldDropOnDie()
	return false
end