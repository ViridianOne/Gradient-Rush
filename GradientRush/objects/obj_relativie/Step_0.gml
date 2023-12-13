function handle_animation() {
	switch(state) {
		case BOSSES_STATES.DID_NOT_DETECT:
			sprite_index = spr_relativie_idle;
			break;
		case BOSSES_STATES.REACTION:
			sprite_index = spr_relativie_laugh;
			if(round(image_index) > 6) {
				state = BOSSES_STATES.STARTING;
				is_starting = true;
				image_index = 0;
			}
			break;
		case BOSSES_STATES.STARTING:
			sprite_index = spr_relativie_start;
			if(round(image_index) > 4) {
				state = BOSSES_STATES.ATTACK;
			}
			break;
		case BOSSES_STATES.ATTACK:
			switch(hp) {
				case 4:
					sprite_index = spr_relativie_stage_1;
					break;
				case 3:
					sprite_index = spr_relativie_stage_2;
					break;
				case 2:
					sprite_index = spr_relativie_stage_3;
					break;
				case 1:
					sprite_index = spr_relativie_stage_4;
					break;
			}
			break;
		case BOSSES_STATES.DAMAGED:
			switch(hp) {
				case 4:
					sprite_index = spr_relativie_damage_test;
					if(round(image_index) > 2) {
						image_xscale = 1;
					}
					if(round(image_index) > 4) {
						state = BOSSES_STATES.REACTION;
						image_index = 0;
					}
					break;
				case 3:
					sprite_index = spr_relativie_damage_1;
					if(round(image_index) > 4) {
						state = BOSSES_STATES.ATTACK;
					}
					break;
				case 2:
					sprite_index = spr_relativie_damage_2;
					if(round(image_index) > 4) {
						state = BOSSES_STATES.ATTACK;
					}
					break;
				case 1:
					sprite_index = spr_relativie_damage_3;
					if(round(image_index) > 4) {
						state = BOSSES_STATES.ATTACK;
					}
					break;
			}
			break;
		case BOSSES_STATES.DEAD:
			sprite_index = spr_relativie_death;
			if(round(image_index) == 7) {
				image_index = 7;
			}
			if(alarm < 0) {
				alarm[0] = 60;
			}
			break;
	}
}

function start_bossfight() {
	y -= spd;
	if(y <= start_pos_y) {
		is_starting = false;
		path_start(next_path, spd, path_action_stop, true);
		wall.strength = 0;
		wall.can_destroy = false;
	}
}

if(state != BOSSES_STATES.DEAD) {
	if(hp <= 0) {
		state = BOSSES_STATES.DEAD;
	}
	
	if(is_starting) {
		start_bossfight();
	}
	
	if(current_path != next_path) {
		path_start(next_path, spd, path_action_stop, true);
		current_path = next_path;
		a = 0;
	}
	if(obj_game_manager.obj_speed_relativity > 1) {
		path_speed = spd * obj_game_manager.global_speed * obj_game_manager.obj_speed_relativity * 0.5;
	} else {
		path_speed = spd * obj_game_manager.global_speed * obj_game_manager.obj_speed_relativity * 2;
	}
	
	if(obj_add.x - x >= 768) {
		spd = 4;
	} else {
		spd = 1.5;
	}
}

handle_animation();