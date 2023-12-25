draw_self();

if(is_color_hud_open) {
	draw_sprite(spr_color_hud, color_wheel_image_index, x, y);
}

draw_rectangle_color(x - 32, y, x + 32, y - 64, c_aqua, c_aqua, c_aqua, c_aqua, true);
