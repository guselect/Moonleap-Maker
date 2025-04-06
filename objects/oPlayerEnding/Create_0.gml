/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
gowhite=false
night=oCamera.night
time=-2.5
drawy=16
repeatime=0
dir=30
raio=4
bullet_rate=0
bullet_rate_max=16
bullet_spd=0.1
bullet=oDotEnd
direcao=0
rate=0
overlay=16

bullet1=instance_create_layer(x,y,"Instances_2",obj_bullet_creator1)
bullet2=instance_create_layer(x,y,"Instances_2",obj_bullet_creator2)
bullet3=instance_create_layer(x,y,"Instances_2",obj_bullet_creator3)
bullet4=instance_create_layer(x,y,"Instances_2",obj_bullet_creator4)
bullet5=instance_create_layer(x,y,"Instances_2",obj_bullet_creator5)
bullet6=instance_create_layer(x,y,"Instances_2",obj_bullet_creator6)
bullet7=instance_create_layer(x,y,"Instances_2",obj_bullet_creator7)
bullet8=instance_create_layer(x,y,"Instances_2",obj_bullet_creator8)

instance_create_layer(x,y,"Instances_2",oVaiProgresso);

if(!steam_get_achievement("MN_TOTHEMOON")){steam_set_achievement("MN_TOTHEMOON")}
GooglePlayServices_Achievements_Unlock("CgkIo9m7npseEAIQCg");

bullet1.obj_boss=self	bullet5.obj_boss=self
bullet2.obj_boss=self	bullet6.obj_boss=self
bullet3.obj_boss=self	bullet7.obj_boss=self
bullet4.obj_boss=self	bullet8.obj_boss=self

bullet1.can_work=true	bullet5.can_work=true
bullet2.can_work=true	bullet6.can_work=true
bullet3.can_work=true	bullet7.can_work=true
bullet4.can_work=true	bullet8.can_work=true



//non important

cape=false

godmode=false
neutral=false
if instance_exists(oSpaceDay) or instance_exists(oFlowerDay) {trueblack=true} else {trueblack=false}

if instance_exists(oNeutralFlag) 
{neutral=true}
//instance_create_layer(x,y,layer,oDust)

levelnumb=0



//virtual_key_add(0, 96, 48, 48, vk_left);
//virtual_key_add(48, 96, 48, 48, vk_right);
//virtual_key_add(120, 96, 120, 48, vk_space);



if instance_exists(oRoomTransition) {visible=false} else {visible=true}
//Variables
on_ladder=false

last_plat=0
winwait=60
grace_time=0
grace_time_frames=10
hsp=0 //horizontal speed
vsp=0 //vertical speed
jumpspeed=2.25
v_max=1//velocidade máxima do personagem
v_ace=0.25  //velocidade da aceleração do personagem
v_fric=0.25 //friction
pick=0

numb=0

inv=0 //tempo de invencibil,diasdeda
inv=true
cling_time= 4.0
move=1
sticking = true; 
can_stick = false;
flash=0

//input inicial
key_right= 0
key_left= 0
key_jump= 0
key_down= 0
key_up= 0
key_shot= 0
key_down_pressed= 0
doublepress=0


// new movement code

jumped = false;
landed = false;

platform_target = 0;
wall_target     = 0;

on_ground_var = on_ground();
was_on_ground = has_collided(0, 1);

// Used for sub-pixel movement
cx = 0;
cy = 0;

c_left    = place_meeting(x - 1, y, oSolid);
c_right   = place_meeting(x + 1, y, oSolid);
sticking = false

// States
IDLE      = 10;
RUN       = 11;
JUMP      = 12;
WIN     = 13;

state= IDLE
star=0


roomw=room_width
roomh=room_height

scr_inputcreate();

if !instance_exists(oStar)
{instance_create_layer(roomw,roomh,layer,oStar)}
inistar=instance_number(oStar)

idletime=0

timee=0
glow=false

 mypar=self

scr_checkskin() //check the skin


night=oCamera.endnight

	if oCamera.current_skin=5
{
	if night=false
	{
		PlayerIdle=		sPlayerIdle5
		PlayerRun=		sPlayerRun5
		PlayerJump=		sPlayerJump5
		PlayerSit=		sPlayerSit5
		PlayerClimb=	sPlayerClimb5
		PlayerDead=		sPlayerDead5
		PlayerEnding=	sPlayerEnding5
		PlayerEndingFlash=	sPlayerEndingFlash5
		PlayerHappy=	sPlayerHappy5
	}
	else
	{	
		PlayerIdle=		sPlayerIdle6
		PlayerRun=		sPlayerRun6
		PlayerJump=		sPlayerJump6
		PlayerSit=		sPlayerSit6
		PlayerClimb=	sPlayerClimb6
		PlayerDead=		sPlayerDead6
		PlayerEnding=	sPlayerEnding6
		PlayerEndingFlash=	sPlayerEndingFlash6
		PlayerHappy=		sPlayerHappy6		
	}
}
sprite_index=PlayerIdle