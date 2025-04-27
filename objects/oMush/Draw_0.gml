var pallete_index = flash ? 4 : night + 2;

pal_swap_set(sPlayerPal, pallete_index, 0);
draw_self_perfect();
pal_swap_reset();
