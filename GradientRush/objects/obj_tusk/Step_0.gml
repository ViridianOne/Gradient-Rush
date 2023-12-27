function make_rush() {
	if(can_rush) {
		max_spd = rush_spd;
		decceleration = 0.05;
		run_direction = sign(image_xscale);
		is_with_spikes = true;
		obj_add.is_damaged = (run_direction > 0 && obj_add.x >= bbox_right && obj_add.x <= bbox_right + rush_damage_right_border 
			|| run_direction < 0 && obj_add.x <= bbox_left && obj_add.x >= bbox_left - rush_damage_right_border) 
			&& obj_add.y >= bbox_top + 10;
	}
}

function check_h_collision() {
	if(place_meeting(x + h_spd, y, obj_ground)) {
		while(!place_meeting(x + sign(h_spd), y, obj_ground)) {
			x += sign(h_spd);
		}
	h_spd = 0;
	}
}

function check_v_collision() {
	if(place_meeting(x, y + v_spd, obj_ground)) {
		while(!place_meeting(x, y + sign(v_spd), obj_ground)) {
			y += sign(v_spd);
		}
	v_spd = 0;
	}
}

function move_horizontal() {
	if(can_move || can_rush) {
		make_rush();
		if(run_direction != 0 && (sign(h_spd) == sign(run_direction) || h_spd == 0 || !is_on_ground)) {
			spd += max_spd * acceleration;
			if(spd >= max_spd) {
				spd = max_spd;
			}
			h_spd = run_direction * spd;
			image_xscale = sign(h_spd);
			state = can_rush ? ADD_STATES.RUSHING : ADD_STATES.MOVING;
		} else {
			h_spd -= max_spd * decceleration * sign(h_spd);
			if(abs(h_spd) <= 0.5) {
				h_spd = 0;
			}
			spd = min_spd;
		}
	}
	check_h_collision();
	x += h_spd * obj_game_manager.global_speed * obj_game_manager.obj_speed_relativity;
}

function move_vertical() {	
	if(state == ADD_STATES.FALLING && is_on_ground) {
		state = ADD_STATES.IDLE;
	}
	
	if(sign(grv) == 1 && v_spd > 2 || sign(grv) == -1 && v_spd < -2) {
		v_spd = v_spd + grv * 2;
	} else {
		v_spd = v_spd < 2 && v_spd > -2 ? v_spd + grv / 1.5 : v_spd + grv;
	}

	if(v_spd > 1) {
		state = ADD_STATES.FALLING;
	}

	check_v_collision();
	y += v_spd * obj_game_manager.global_speed * obj_game_manager.obj_speed_relativity;
}

function check_existance() {
	is_active = bbox_top < room_height;
	if(!is_active || place_meeting(x, y, obj_damage) || is_damaged) {
		state = ADD_STATES.LOST;
		if(alarm[0] <= 0) {
			alarm[0] = 56;
			image_index = 0;
		}
	}
}

function handle_animation() {
	if(state == ADD_STATES.LOST) {
		sprite_index = spr_tusk_death;
	} else if(state == ADD_STATES.HIDING_SPIKES) {
		sprite_index = spr_tusk_hiding_spikes;
		if(round(image_index) == 4) {
			is_with_spikes = false;
			state = ADD_STATES.IDLE;
			sprite_index = spr_tusk_idle_without_spikes;
		}
	} else if (state == ADD_STATES.SHOWING_SPIKES) {
		sprite_index = spr_tusk_showing_spikes;
		if(round(image_index) == 11) {
			is_with_spikes = true;
		} else if (round(image_index) == 13) {
			state = ADD_STATES.IDLE;
			sprite_index = spr_tusk_idle_with_spikes;
		}
	} else if(state == ADD_STATES.MOVING && h_spd != 0) {
		sprite_index = is_with_spikes ? spr_tusk_walking_with_spikes : spr_tusk_walking_without_spikes;
	} else if(state == ADD_STATES.RUSHING) {
		sprite_index = spr_tusk_running_with_spikes;
	} else {
		sprite_index = is_with_spikes ? spr_tusk_idle_with_spikes : spr_tusk_idle_without_spikes;
	}
}

function handle_sound() {
	if(state == ADD_STATES.LOST && !audio_is_playing(snd_add_death)) {
		audio_play_sound_at(snd_add_death, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, false, 4);
		audio_stop_sound(snd_tusk_step);
		audio_stop_sound(snd_tusk_running);
	} else if(state == ADD_STATES.MOVING && !audio_is_playing(snd_tusk_step)) {
		audio_play_sound_at(snd_tusk_step, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, true, 4);
		audio_stop_sound(snd_tusk_running);
	} else if(can_roar && state == ADD_STATES.RUSHING && !audio_is_playing(snd_tusk_running)) {
		//audio_play_sound_at(snd_tusk_roar, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, false, 4);
		audio_play_sound_at(snd_tusk_running, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, true, 4);
		audio_stop_sound(snd_tusk_step);
	} else if(state == ADD_STATES.HIDING_SPIKES && !audio_is_playing(snd_tusk_spikes_hiding)) {
		audio_play_sound_at(snd_tusk_spikes_hiding, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, false, 4);
		audio_stop_sound(snd_tusk_step);
		audio_stop_sound(snd_tusk_running);
	} else if(state == ADD_STATES.SHOWING_SPIKES && !audio_is_playing(snd_tusk_spikes_showing)) {
		audio_play_sound_at(snd_tusk_spikes_showing, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, false, 4);
		audio_stop_sound(snd_tusk_step);
		audio_stop_sound(snd_tusk_running);
	} else {
		audio_stop_sound(snd_tusk_step);
		audio_stop_sound(snd_tusk_running);
	}
	audio_listener_position(obj_add.x, obj_add.y, 0);
	can_roar = state != ADD_STATES.RUSHING;
}

if(!obj_game_manager.is_paused) {
	if(state != ADD_STATES.LOST) {
		if(alarm[1] <= 0) {
			alarm[1] = 300;
		}
		
		if(alarm[2] <= 0) {
			alarm[2] = is_with_spikes ? 180 : 360;
			if(!is_with_spikes) {
				//audio_play_sound_at(snd_tusk_roar, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, false, 4);
			}
		}

		can_rush = obj_add.y >= player_detector_up && obj_add.y <= player_detector_down 
				&& obj_add.x >= walking_border_left && obj_add.x <= walking_border_right 
				&& x > walking_border_left && x < walking_border_right
				&& sign(obj_add.x - x) == sign(image_xscale);
		
		if(can_rush) {
			state = ADD_STATES.RUSHING;
		} else if(state != ADD_STATES.LOST && state != ADD_STATES.HIDING_SPIKES && state != ADD_STATES.SHOWING_SPIKES) {
			state = h_spd == 0 ? ADD_STATES.IDLE : ADD_STATES.MOVING;
		}
		
		if(can_move && !can_rush) {
			run_direction = sign(image_xscale);
			if(x <= walking_border_left) {
				run_direction = 1;
			} else if(x >= walking_border_right) {
				run_direction = -1;
			}
			max_spd = 2;
			decceleration = 0.1;
		} else {
			run_direction = 0;
			h_spd = 0;
		}
	
		move_horizontal();
		move_vertical();
	}
	handle_animation();
	handle_sound();
	check_existance();
}
