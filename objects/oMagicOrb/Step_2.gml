if not instance_exists(oPlayer) then exit;

if change and instance_exists(oPlayer) and cooldown == 0 {
	cooldown = 10;
	x = oPlayer.x;
	y = oPlayer.y;
	oPlayer.x = xprevious;
	oPlayer.y = yprevious;
	oPlayer.flash = true;
	flash = true;
	
	instance_create_layer(x,y,layer,oGemSpark)
	
	var sfxcogu = choose(snd_warp, snd_warp2, snd_warp3);
  
  audio_play_sfx(sfxcogu, false, -14, 2);
  
	change = false;
	scr_change_orb();
	
  night = not oPlayer.night;
}

if instance_exists(oPauseUI)
or instance_exists(oDead)
or (instance_exists(oTransition) and oTransition.title_display_wait != 0)
or maker_transition_is_running()
or (instance_exists(oPlayer) and oPlayer.state.state_is("win")) {
  image_speed = 0;
  exit;
}

apply_movement_collision();

if abs(hsp_final) > 0 and on_ground_var and irandom_range(1, 3) == 1 {
  var dust = instance_create_layer(x, bbox_bottom + 1, "Instances_2", oBigDust);
  
  dust.hsp = hsp / random_range(5, 10);
  dust.vsp = vsp / random_range(5, 10);
}
