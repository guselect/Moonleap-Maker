/// @description Insert description here
// You can write your code in this editor
image_speed=0.5
if instance_exists(oPlayer) and room=Room100
{
	px=oPlayer.x
	py=oPlayer.y
	//instance_deactivate_layer("Instances")

	//instance_activate_region(px-(320*2),py-(180*2),320*4,180*4,true)
}


if is_on_desktop() and room=RoomIntro0
{
window_command_set_active(window_command_close, false);	
}


/*
if levelnumb>10
{
xx=random_range(0,320)
yy=random_range(-180,0)
instance_create_layer(xx,yy,"Instances_2",oDust)
}
else
{
xx=random_range(0,320)
yy=random_range(0,180)
instance_create_layer(xx,yy,"Instances_2",oDust)
}
if night=true
{
if levelnumb<8 {oDust.sprite_index=sDustNight} else {oDust.sprite_index=sDustNightClouds}
}
else
{
	oDust.sprite_index=sDUST
}

/*
if grassmus!=noone
{
var pos1 = audio_sound_get_track_position(grassmus)
audio_sound_set_track_position(grassmus2,pos1)
audio_sound_set_track_position(grassmus,pos1)
}

if cloudmus!=noone
{
var pos2 = audio_sound_get_track_position(cloudmus)
audio_sound_set_track_position(cloudmus2,pos2)
audio_sound_set_track_position(cloudmus,pos2)
}