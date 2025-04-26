/// @description Insert description here
// You can write your code in this editor
if instance_exists(oPlayer)
{
if not oPlayer.state.state_is("win") {time-=0.016666666666666}
}


hearts=clamp(hearts,0,20)

//if time<0 {if instance_exists(oPlayer) {instance_destroy(oPlayer)}}

if hearts=0 {if !instance_exists(oTransition) {var trans=instance_create_layer(0,0,layer,oTransition) trans.target_room=RoomMenu instance_destroy()}}

if room=RoomMenu {des+=0.5}

if des>20 {instance_destroy()}