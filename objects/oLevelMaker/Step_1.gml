/// @description Insert description here
// You can write your code in this editor
if cursor != LEVEL_CURSOR_TYPE.ERASER then cursor = LEVEL_CURSOR_TYPE.CURSOR

//CAMERA CODE

var _in_level_editor = instance_exists(oPause);

if(_in_level_editor){
	camera_current_interpolation -= .07;
} else {
	camera_current_interpolation += .07;
}

camera_current_interpolation = clamp(camera_current_interpolation,0,1);

//recalculate the mouse position since I'm using  oAppSurfaceManager to resize the application surface to keep it pixel perfect
// this is instead of using the actual camera cause then it would look ugly zoomed in

var _cam_offset_x = camera_get_view_x(view_camera[0]);
var _cam_offset_y = camera_get_view_y(view_camera[0]);
	
var _cam_width = camera_get_view_width(view_camera[0]);
var _cam_height = camera_get_view_height(view_camera[0]);
	
var _app_surface_x = lerp(0, _cam_offset_x, camera_current_interpolation);
var _app_surface_y = lerp(0, _cam_offset_y, camera_current_interpolation);
	
var _gui_scale_x = lerp(1,  _cam_width/room_width, camera_current_interpolation);
var _gui_scale_y = lerp(1,  _cam_height/room_height, camera_current_interpolation);

global.level_maker_mouse_x = (mouse_x - _app_surface_x ) / _gui_scale_x;
global.level_maker_mouse_y = (mouse_y - _app_surface_y ) / _gui_scale_y;