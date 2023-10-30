if(x >= 700 && x <= 710) {
	spd = -6;
} else if(x >= 100 && x <= 110) {
	spd = 6;
}

x += spd * obj_game_manager.obj_speed_relativity;
