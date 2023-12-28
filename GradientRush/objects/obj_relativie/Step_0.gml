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
			if(!audio_is_playing(snd_relativie_laughter)) {
				audio_play_sound(snd_relativie_laughter, 3, false);
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
			if(!audio_is_playing(snd_relativie_damage)) {
				audio_play_sound(snd_relativie_damage, 3, false);
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

function attract_player() {
	if(obj_add.x > x - h_border && obj_add.x < x + h_border && obj_add.y > y - v_border && obj_add.y < y + v_border) {
		obj_add.magenta_interaction.can_use = false;
		obj_add.magenta_interaction.is_active = false;
		obj_add.magenta_interaction.gravity_multiplier = obj_add.magenta_interaction.normal_gravity;
		obj_add.magenta_interaction.speed_relativity = obj_add.magenta_interaction.normal_gravity;
		obj_game_manager.obj_speed_relativity = obj_add.magenta_interaction.normal_gravity;
		obj_add.speed = 4;
		obj_add.direction = point_direction(obj_add.x, obj_add.y, x, y);
		obj_add.can_move = false;
		obj_add.can_jump = false;
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
		spd = 3;
	} else {
		spd = 1;
	}
	
	can_attract_player = hp < 5 && hp > 0 && state != BOSSES_STATES.REACTION && state != BOSSES_STATES.STARTING;
	if(can_attract_player) {
		attract_player();
	}
}

handle_animation();
