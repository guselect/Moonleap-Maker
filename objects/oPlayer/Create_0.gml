// ---------------------- NOTA IMPORTANTE ----------------------
//
// Nas fases, o jogador deve ser instanciado depois que as estrelas forem instanciadas.
// Havia um problema no editor de níveis onde algumas estrelas eram instanciadas depois
// do oPlayer, fazendo com que estas não sejam contabilizadas.
// O ideal é que o oPlayer seja criado na Room depois que as estrelas já forem criadas
// para que a contagem de estrelas seja feita corretamente.
//
// -------------------------------------------------------------

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

trueblack = false;
if instance_exists(oLevelMaker) {
	switch(oLevelMaker.selected_style) {
		case LEVEL_STYLE.FLOWERS:
		case LEVEL_STYLE.SPACE:
		case LEVEL_STYLE.DUNGEON:
			trueblack = true; break;
	}
} else if instance_exists(oSpaceDay) or instance_exists(oFlowerDay)or instance_exists(oDunDay) {
	trueblack = true;
}

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
grav = 0.125;

numb=0

inv=0 //tempo de invencibil,diasdeda
inv=true
cling_time= 4.0
move=1
sticking = true; 
can_stick = false;
flash=0
squash = false;


// new movement code

jumped = false;
landed = false;

wall_target = 0;

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

roomw=room_width
roomh=room_height

has_collected_bird = false;
stars_collected = 0;
stars_to_collect = 0;

if not instance_exists(oStar) {
	var hidden_star = instance_create_layer(roomw, roomh, layer, oStar);
	hidden_star.visible = false;
}

has_collected_all_stars = function() {
	return stars_collected == stars_to_collect;
}

stars_to_collect = instance_number(oStar);

// If level is secret bird level
if room == Room58 { 
	stars_to_collect = 1;
}

idletime=0

timee=0
glow=false

mypar=self

ladder_list = ds_list_create();

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