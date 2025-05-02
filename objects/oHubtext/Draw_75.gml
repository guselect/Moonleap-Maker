
if ceil(bright)>=1
{
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	nox_set_wave(2.25, 1, 100, "~") //full slow wave
	
	var c1 = make_color_rgb(42,57,106)
	var c2 = make_color_rgb(121,155,175)
	var c3 = make_color_rgb(170,255,255)

	if ceil(bright) == 1 then draw_set_color(c1);
	if ceil(bright) == 2 then draw_set_color(c2);
	if ceil(bright) == 3 then draw_set_color(c3);
	
	var _txt = $"~{text}~";
	
	draw_text_nox(320 / 2, 180 - 16, _txt, 0, 12, 320);
	 
	//draw_text(320/2,180-16,text)
	//draw_text(320/2,180-16,"level desbloqueado       recorde de pulos: 5")
}






