if(x >= x_right - fixed_spd && x <= x_right + fixed_spd) {
	h_spd = -fixed_spd;
} else if(x >= x_left - fixed_spd && x <= x_left + fixed_spd) {
	h_spd = fixed_spd;
}

if(y >= y_down - fixed_spd && y <= y_down + fixed_spd) {
	v_spd = -fixed_spd;
} else if(y >= y_upper - fixed_spd && y <= y_upper + fixed_spd) {
	v_spd = fixed_spd;
}

x += x_right == x_left ? 0 : h_spd * obj_game_manager.obj_speed_relativity * obj_game_manager.global_speed;
y += y_down == y_upper ? 0 : v_spd * obj_game_manager.obj_speed_relativity * obj_game_manager.global_speed;
