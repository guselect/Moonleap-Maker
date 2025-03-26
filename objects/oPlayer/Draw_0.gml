/// @description Insert description here
// You can write your code in this editor


var xx=x+random_range(-shake,shake)
var yy=y


if trueblack=true {pal_swap_set(sPlayerPal,night+2,0)} else if oCamera.current_skin!=5 {pal_swap_set(sPlayerPal,night,0)} 

if neutral=true {pal_swap_set(sPlayerPal,5,0)}

if white!=0
{
	if white<2 {pal_swap_set(sPlayerPal,4,0)}
	if white<1 {pal_swap_set(sPlayerPal,7,0)}
	if white>=2 {pal_swap_set(sPlayerPal,8,0)}
}



if flash>0 or godmode=true {pal_swap_set(sPlayerPal,4,0)}

if cape=true
{
//with(oCape) {draw_sprite(sTinySmoke160,8,x,y)}//capeoutline
//with(oCape) {draw_self()}
}

draw_sprite_ext(sprite_index,image_index,xx,yy,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,xx-roomw,yy,image_xscale,image_yscale,0,c_white,1)
draw_sprite_ext(sprite_index,image_index,xx+roomw,yy,image_xscale,image_yscale,0,c_white,1)

draw_sprite_ext(sprite_index,image_index,xx,yy-roomh,image_xscale,image_yscale,0,c_white,1)
draw_sprite_ext(sprite_index,image_index,xx,yy+roomh,image_xscale,image_yscale,0,c_white,1)


if sprite_index=PlayerClimb and cape=true {
	with(oCape) {draw_sprite(sTinySmoke160,8,x,y+1)}//capeoutline
	with(oCape) {draw_sprite(sprite_index,image_index,x,y+1)}
	}


pal_swap_reset()

//draw_text(x,y,vsp)
