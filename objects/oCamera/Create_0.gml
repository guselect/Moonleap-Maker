/// @description Insert description here
// You can write your code in this editor
//instance_create_layer(x,y,layer,obj_projector)
nice_black=make_color_rgb(0,0,72)
fancyeffects=true

if os_type=os_android
{
fancyeffects=false
}


audio_group_load(agroup_bgm);

fpscap=false
px=0
py=0
hubpar=25+12//base only

global.lstStckU =0
global.lstStckD = 0

font_add_enable_aa(false)
fntJA = font_add(working_directory + "Silver.ttf", 14, false, false, 32, 127);
font=fntSmall
window_center()

previous_room=noone

surface_depth_disable(true)

pal_swap_init_system(shd_pal_swapper)

//oCamera.font=font_add_sprite(sFont,ord("!"),true,1)
//#macro right 0
//#macro left 180
//#macro down 270
//#macro up 90
smoothnight=0

 night=false

deathcount=0
current_skin=0
levelnumb=0
shaketime=0
image_speed=0.5
/*
repeat(10)
{
xx=random_range(0,320)
yy=random_range(0,180)
//instance_create_layer(xx,yy,"Instances_2",oDust)
}
*/

window_scale=4
shake=true


arcade=false ////////////////////////////////////////////////////////////////////////

window_set_size(320*window_scale,180*window_scale)

actualroom=room

instance_create_depth(x,y,layer,oSaveManager)

levelselx=120
levesely=80


//instance_create_layer(0,0,layer,obj_projector)


drawname=0
bird0=false
bird1=false
bird2=false
bird3=false

//filter enabled
global.composite_enabled = false;
global.chromatic_enabled = false;
global.scanline_enabled  = false;
gpu_set_tex_filter        (false)


debug=false
show_debug=false
sound_test=false
if debug_mode=true {debug=true show_debug=true}

//Camera Settings////////////////////////////////////////////////////////////////////////////////////////////
apspd=0.05 //approach speed

shake=0

view_width=320
view_height=180

display_set_gui_size(view_width,view_height)

y=0
x=0

hubx=0;
huby=0;
hubx_prev = 0;
huby_prev = 0;
hubcheck=false;
hubmoving=false;


fpsreal=round(fps_real)

window_center()

xspawn=noone
yspawn=noone
xcamspawn=noone
ycamspawn=noone

hubaudiocol=noone
hubaudiocolf=noone

if(os_type == os_android){
	GooglePlayServices_SignIn();
}

//this is the PERFECT score
score_struct=
	{
		//normal levels 
	Room0:	04,
	Room1:	07,
	Room2:	08,
	Room3:	05,
	Room4:	01,
	Room5:	01,
	Room6:	04,
	Room7:	05,	
	Room8:	08,	
	Room9:	04,
	Room10: 02,
	Room11: 05,
	Room12: 06,
	Room13: 10,
	Room14: 06,
	Room15: 04,
	Room16: 03,
	Room17: 04,
	Room18: 12,
	Room19: 08,
	Room20: 02,
	Room21: 02,
	Room22: 06,
	Room23: 08,
	Room24: 04,
	Room25: 08,
	Room26: 11,
	Room27: 04,
	Room28: 07,
	Room29: 06,
	Room30: 05,
	Room31: 11,
	Room32: 11,
	Room33: 10,
	Room34: 06,
	Room35: 06,
	Room36: 02,
	Room37: 04,
	Room38: 04,
	Room39: 01,
	
		//DLC
	Room40:	04,	
	Room41:	07,	
	Room42:	05,	
	Room43:	10,	
	Room44:	08,	
	Room45:	13,	
	Room46:	02,	
	Room47:	09,	
	Room48:	11,	
	Room49:	05,	
	   //secret levels
	Room50:	06,	
	Room51:	04,
	Room52:	07,
	Room53:	05,	
	Room54:	14,	
	Room55:	13,	
	Room56:	06,	
	Room57:	08,	
	Room58:	04,	
	Room59:	06,	
		//final levels
	Room60:	02,	
	Room61:	10,	
	Room62:	14,	
	Room63:	02	
	}