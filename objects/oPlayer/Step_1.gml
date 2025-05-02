scr_inputget()

if not is_at_hub() then
	object_set_room_wrapping();

numb = approach(numb, 0, 1);
flash = approach(flash, 0, 0.25);

check_controls_disabling();
set_godmode_toggling();
set_godmode_movement();
set_skin_changing();

if debug_mode {
	if keyboard_check_pressed(ord("L")) then 
	room_goto(Room28);

	if keyboard_check_pressed(ord("O")) {
		var skin = 1;
		repeat(7) {
			if skin != 6 {
				struct_set(oSaveManager.struct_main, $"s{skin}", 1);
			}
			skin++;
		}
	}
}