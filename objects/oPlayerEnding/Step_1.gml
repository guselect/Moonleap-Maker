/// @description Insert description here
// You can write your code in this editor

night=oCamera.endnight



/// @description Insert description here
// You can write your code in this editor
/// @description Insert description here
// You can write your code in this editor

//on_water = place_meeting(x,y,obj_water);

scr_inputget() //é o que dá sentido aos key_left key_right...

c_left  = place_meeting(x - 1, y, oSolid)
c_right = place_meeting(x + 1, y, oSolid);

if (c_left) 
    wall_target = instance_place(x - 1, y, oSolid);

if (c_right) 
    wall_target = instance_place(x + 1, y, oSolid);

if room!=Room100

{
	if y>roomh{y-=roomh}
	if x>roomw{x-=roomw}
	if y<0{y+=roomh}
	if x<0{x+=roomw}
}

numb=approach(numb,0,1)

if state = WIN or instance_exists(oPauseUI) or numb>0

{
	key_right=		0
	key_left=			0
	key_jump_pressed=0
	key_jump=			0
	key_start=		0
}

if instance_exists(oTransition)

{
	if oTransition.title_display_wait!=0
	{
		key_right=		0
		key_left=			0
		key_jump_pressed=0
		key_jump=			0
		key_start=		0
	}
}

if oCamera.debug=true
{
	grav=0
	if keyboard_check(ord("I")){vsp=-2}
if keyboard_check(ord("K")){vsp=+2}
	if keyboard_check(ord("J")){hsp=-3}
	if keyboard_check(ord("L")){hsp=3}
	
}

if key_right+key_left=2
{key_right=		0
key_left=		0}

/*
if key_down_notpressed=true
{down_time+=1} else {down_time=0}

if down_time=30
{scr_changeskin()}

if down_time<30
{shake=down_time*0.05} else {shake=0}







