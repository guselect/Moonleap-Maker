// 
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

if state == WIN or instance_exists(oPauseMenu) or numb>0
{
	key_right = 0;
	key_left = 0;
	key_jump_pressed = 0;
	key_jump = 0;
	key_start = 0;
}

if instance_exists(oTransition)
{
	if oTransition.wait != 0 or room == Room100 {
		key_right = 0;
		key_left = 0;
		key_jump_pressed = 0;
		key_jump = 0;
		key_start = 0;
	}
}

if oCamera.debug=true
{
if key_reset=true and debug_mode=true
{godmode=!godmode oCamera.show_debug=godmode}
}

if godmode {
	grav = 0;
	if key_jump or key_up then vsp = -4;
	if key_down then vsp = 2;
	if key_left then hsp = -3;
	if key_right then hsp = 3;
}

if key_right + key_left == 2 {
	key_right = 0;
	key_left = 0;
}

//not pressing, holding, star only exists ingame
if key_down_notpressed and was_on_ground {
	down_time += 1;
} else {
	down_time=0
}

if down_time >= 30 {
	idletime = 0;
	scr_changeskin()
}

//if down_time<30
//{shake=down_time*0.05} else {shake=0}
