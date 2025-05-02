var _text = "";
var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();

draw_self();

draw_set_color(text_color);
draw_set_font(oCamera.font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
nox_set_wave(2.25, 1, 1, "~");

if (time < 4) {
	 _text = $"~{text}~";
	 draw_text_nox(320 / 2, y + 180 / 2, _text, 0, 12, 320);
} else {
	 _text = text;
	 draw_text_nox(320 / 2, y + 180 - 16, _text, 0, 12, 320);
}

if confirm_skip_is(INTRO_CONFIRM_SKIP.WAITING_FOR_CONFIRM) {
    // Desenha a mensagem na tela
    draw_set_color(c_branco1);
    draw_text(320 / 2, 16, LANG.skipintro);
}
