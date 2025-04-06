/// @description Insert description here
// You can write your code in this editor
if instance_exists(oPauseMenu) or instance_exists(oDead) {image_speed=0 exit;}
if instance_exists(oTransition) { if oTransition.wait!=0 {image_speed=0 exit;}}
if instance_exists(oPlayer) { if oPlayer.state=oPlayer.WIN {image_speed=0 exit;}}
image_speed=1


/// @description Insert description here
// You can write your code in this editor
// Handle sub-pixel movement


cx += hsp 
cy += vsp
hsp_new = floor(cx);
vsp_new = floor(cy);
cx -= hsp_new;
cy -= vsp_new;

jumped = false;
landed = false;

if vsp!=0 {hsp_new=0}

apply_movement_and_collision();