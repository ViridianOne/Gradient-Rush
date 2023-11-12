/*if(x >= 700 && x <= 710) {
	spd = -6;
} else if(x >= 100 && x <= 110) {
	spd = 6;
}

x += spd * obj_game_manager.obj_speed_relativity * obj_game_manager.global_speed;*/

angle++;
//h_spd = lengthdir_x(64, angle);
x = 1284 + lengthdir_x(64, angle);

//h_spd = lengthdir_y(64, angle);
y = 384 + lengthdir_y(64, angle);
