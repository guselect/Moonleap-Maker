/// @desc This function sets draw configuration values (alpha, font, text align and color) to default.
function draw_reset() {
  draw_set_alpha(1);
  draw_set_font(oCamera.font ?? -1);
  draw_set_halign(-1);
  draw_set_valign(-1);
  draw_set_color(-1);
}