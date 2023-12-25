function attack() {
	if(state != ADD_STATES.PUNCHING && state != ADD_STATES.DASHING && state != ADD_STATES.REACTION) {
		state = ADD_STATES.REACTION;
		if(alarm[4] < 0) {
			alarm[4] = 90;
		}
	}
}

function make_punch() {
	if(can_punch && state != ADD_STATES.PUNCHING 
		&& state != ADD_STATES.DASHING && state != ADD_STATES.REACTION) {
		state = ADD_STATES.REACTION;
		if(alarm[4] < 0) {
			alarm[4] = 100;
		}
	}
}

function make_dash() {
	if(can_dash && state != ADD_STATES.DASHING 
		&& state != ADD_STATES.PUNCHING && state != ADD_STATES.REACTION) {
		state = ADD_STATES.REACTION;
		if(alarm[4] < 0) {
			alarm[4] = 100;
		}
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
	if(can_move) {
		//make_dash();
		//make_punch();
		attack();
		if(run_direction != 0 && (sign(h_spd) == sign(run_direction) || h_spd == 0 || !is_on_ground) 
			&& state != ADD_STATES.DASHING && state != ADD_STATES.PUNCHING && state != ADD_STATES.REACTION) {
			spd += max_spd * acceleration;
			if(spd >= max_spd) {
				spd = max_spd;
			}
			h_spd = run_direction * spd;
			image_xscale = sign(h_spd);
			state = ADD_STATES.MOVING;
		} else {
			h_spd -= max_spd * decceleration * sign(h_spd);
			if(abs(h_spd) <= 0.5) {
				h_spd = 0;
			}
			if(state == ADD_STATES.DASHING && abs(h_spd) <= 4) {
				state = is_on_ground ? ADD_STATES.MOVING : ADD_STATES.FALLING;
				max_spd = 4;
				mask_index = spr_add_idle;
				decceleration = 0.1;
			}
			spd = min_spd;
		}
	}
	check_h_collision();
	x += h_spd * obj_game_manager.global_speed * obj_game_manager.obj_speed_relativity;
}

function move_vertical() {	
	if(state != ADD_STATES.DASHING && state != ADD_STATES.PUNCHING) {
		if(state == ADD_STATES.FALLING && is_on_ground) {
			state = ADD_STATES.IDLE;
		}
	}
	
	if (state == ADD_STATES.DASHING || state == ADD_STATES.PUNCHING) {
		v_spd = 0;
	} else if(sign(grv) == 1 && v_spd > 2 || sign(grv) == -1 && v_spd < -2) {
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
			alarm[0] = 64;
			image_index = 0;
		}
	}
}

function handle_animation() {
	if(state == ADD_STATES.MOVING && h_spd != 0) {
		sprite_index = spr_punchman_running;
	} else if(state == ADD_STATES.DASHING) {
		sprite_index = spr_punchman_dash;
	} else if(state == ADD_STATES.PUNCHING && can_damage_player) {
		sprite_index = spr_punchman_punch;
	} else if(state == ADD_STATES.FALLING) {
		sprite_index = spr_punchman_falling;
	} else if(state == ADD_STATES.LOST) {
		sprite_index = spr_punchman_death;
	} else if(state == ADD_STATES.REACTION) {
		sprite_index = spr_punchman_reaction;
	} else {
		sprite_index = spr_punchman_idle;
	}
}

if(!obj_game_manager.is_paused) {
	if(state != ADD_STATES.LOST) {
		can_move = obj_add.x >= run_border_left && obj_add.x <= run_border_right 
			&& obj_add.y >= run_border_up && obj_add.y <= run_border_down;

		if(can_move) {
			if(obj_add.bbox_bottom >= bbox_top + 20) {
				can_dash = able_to_dash && (obj_add.x > x + punch_border_right && obj_add.x < x + dash_border_left 
					|| obj_add.x <= x - punch_border_right && obj_add.x > x - dash_border_left); 
				can_punch = obj_add.x > x + sprite_width / 2 && obj_add.x <= x + punch_border_right 
					|| obj_add.x < x - sprite_width / 2 && obj_add.x >= x - punch_border_right;
			}
			if(!can_punch && !can_dash) {
				run_direction = obj_add.x < x ? -1 : 1;
			}
		} else {
			run_direction = 0;
			h_spd = 0;
		}
	
		move_horizontal();
		move_vertical();
	}
	handle_animation();

	check_existance();
}
