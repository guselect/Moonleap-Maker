

changecount=0
dsquash=false
dwater=false
shake=0
white=0	gowhite=false //fade out on portal
key=0
scr_inputcreate()

cape=true
birdstuck=false
godmode=false
neutral=false
jump_trigger = false;
down_time=0
	
if instance_exists(oSpaceDay) or instance_exists(oFlowerDay)or instance_exists(oDunDay) {trueblack=true} else {trueblack=false}

if instance_exists(oNeutralFlag) 
{neutral=true}
//instance_create_layer(x,y,layer,oDust)

levelnumb=0

idletime=0

//virtual_key_add(0, 96, 48, 48, vk_left);
//virtual_key_add(48, 96, 48, 48, vk_right);
//virtual_key_add(120, 96, 120, 48, vk_space);

night=false

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



// new movement code

jumped = false;
landed = false;

platform_target = 0;
wall_target     = 0;

on_ground_var = on_ground();

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

//if !instance_exists(oStar)
//{
//	show_debug_message("Criei uma estrela na room, te vira.");
//	var s=instance_create_layer(roomw,roomh,layer,oStar)
//	s.visible=false
//}
	
inistar=0//instance_number(oStar)

idletime=0

timee=0
glow=false

mypar=self

alarm[11] = game_get_speed(gamespeed_fps) * 30;

if instance_exists(oSaveManager) and room!=RoomIntro0
{
	scr_checkskin() 

}
else{
	PlayerIdle=			sPlayerIdle
	PlayerRun=			sPlayerRun
	PlayerJump=			sPlayerJump
	PlayerSit=			sPlayerSit
	PlayerClimb=		sPlayerClimb
	PlayerDead=			sPlayerDead
	PlayerEnding=		sPlayerEnding
	PlayerEndingFlash=	sPlayerEndingFlash
	PlayerHappy=		sPlayerHappy	
}

if room=RoomFinal {night=oCamera.endnight}

mask_index=sPlayerIdle