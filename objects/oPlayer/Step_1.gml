scr_inputget()

if room != Room100 then object_set_room_wrapping();

numb = approach(numb, 0, 1);
flash = approach(flash, 0, 0.25);

check_controls_disabling();
set_godmode_toggling();
set_godmode_movement();
set_skin_changing();
scr_checkskin();

//if debug_mode and keyboard_check_pressed(ord("L")) then 
//	room_goto(Room48);