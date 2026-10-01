/// @desc Draws one sprite in the given position and other four sprites in four different positions from given offsets (`left`, `right`, `top`, `bottom`).
/// Same as `draw_self()` command.
function draw_self_wrap(left, right, top, bottom) {
  if is_undefined(sprite_index) or sprite_index <= -1 {
    return;
  }
  
  draw_sprite_wrap_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha, left, right, top, bottom);
}

/// @desc This function uses `draw_self_wrap()` command with `room_width` and `room_height` as offsets.
function draw_self_wrap_room() {
  draw_self_wrap(room_width, room_width, room_height, room_height);
}

/// @desc Draws one sprite in the given position and other four sprites in four different positions from given offset.
/// Same as `draw_sprite_ext(...)` command.
function draw_sprite_wrap_ext(
  sprite,
  frame,
  x,
  y,
  xscale,
  yscale,
  angle,
  blend,
  alpha,
  left,
  right,
  top,
  bottom
) {
  draw_sprite_ext(sprite, frame, x, y, xscale, yscale, angle, blend, alpha);
  draw_sprite_ext(sprite, frame, x + -abs(left), y, xscale, yscale, angle, blend, alpha);
  draw_sprite_ext(sprite, frame, x + abs(right), y, xscale, yscale, angle, blend, alpha);
  draw_sprite_ext(sprite, frame, x, y + -abs(top), xscale, yscale, angle, blend, alpha);
  draw_sprite_ext(sprite, frame, x, y + abs(bottom), xscale, yscale, angle, blend, alpha);
}

/// @desc This function uses `draw_sprite_wrap_ext(...)` command with `room_width` and `room_height` as offsets.
function draw_sprite_wrap_ext_room(
  sprite,
  frame,
  x,
  y,
  xscale,
  yscale,
  angle,
  blend,
  alpha
) {
  draw_sprite_wrap_ext(sprite, frame, x, y, xscale, yscale, angle, blend, alpha, room_width, room_width, room_height, room_height);
}

/// @desc Draws one sprite in the given position and other four sprites in four different positions from given offsets (`left`, `right`, `top`, `bottom`).
/// Same as `draw_sprite_part_ext(...)` command.
function draw_sprite_wrap_part_ext(
  sprite,
  frame,
  left_corner,
  top_corner,
  width,
  height,
  x,
  y,
  xscale,
  yscale,
  blend,
  alpha,
  left_offset,
  right_offset,
  top_offset,
  bottom_offset
) {
  draw_sprite_part_ext(sprite, frame, left_corner, top_corner, width, height, x, y, xscale, yscale, blend, alpha);
  draw_sprite_part_ext(sprite, frame, left_corner, top_corner, width, height, x + -abs(left_offset), y, xscale, yscale, blend, alpha);
  draw_sprite_part_ext(sprite, frame, left_corner, top_corner, width, height, x + abs(right_offset), y, xscale, yscale, blend, alpha);
  draw_sprite_part_ext(sprite, frame, left_corner, top_corner, width, height, x, y + -abs(top_offset), xscale, yscale, blend, alpha);
  draw_sprite_part_ext(sprite, frame, left_corner, top_corner, width, height, x, y + abs(bottom_offset), xscale, yscale, blend, alpha);
}

/// @desc This function uses `draw_sprite_wrap_part_ext(...)` command with `room_width` and `room_height` as offsets.
function draw_sprite_wrap_part_ext_room(
  sprite,
  frame,
  left_corner,
  top_corner,
  width,
  height,
  x,
  y,
  xscale,
  yscale,
  blend,
  alpha,
) {
  draw_sprite_wrap_part_ext(sprite, frame, left_corner, top_corner, width, height, x, y, xscale, yscale, blend, alpha, room_width, room_width, room_height, room_height);
}

/// @desc Draws one sprite in the given position and other four sprites in four different positions from given offsets (`left`, `right`, `top`, `bottom`) with rounded coordinates.
function draw_self_wrap_perfect(left, right, top, bottom) {
  draw_sprite_ext(sprite_index, image_index, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
  draw_sprite_ext(sprite_index, image_index, round(x) + -abs(round(left)), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
  draw_sprite_ext(sprite_index, image_index, round(x) + abs(round(right)), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
  draw_sprite_ext(sprite_index, image_index, round(x), round(y) + -abs(round(top)), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
  draw_sprite_ext(sprite_index, image_index, round(x), round(y) + abs(round(bottom)), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

/// @desc This function uses `draw_self_wrap_perfect(...)` command with `room_width` and `room_height` as offsets.
function draw_self_wrap_perfect_room() {
  draw_self_wrap_perfect(room_width, room_width, room_height, room_height);
}
