function check_input() {
	left = keyboard_check(left_btn);
	right = keyboard_check(right_btn);
	jump = keyboard_check(jump_btn);
	jump_start = keyboard_check_pressed(jump_btn);
	jump_end = keyboard_check_released(jump_btn);
	squat = keyboard_check(squat_btn);
	squat_start = keyboard_check_pressed(squat_btn);
	squat_end = keyboard_check_released(squat_btn);
	dash = keyboard_check_pressed(dash_btn);
	move_input = right - left;
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
		while(!(place_meeting(x, y + sign(v_spd), obj_ground))) {
			y += sign(v_spd);
		}
	v_spd = 0;
	}
}

function make_dash() {
	if(dash) {
		state = ADD_STATES.DASHING;
		max_spd = 20;
		h_spd = max_spd * sign(image_xscale);
		decceleration = 0.05;
	}
}

function move_horizontal() {
	if(can_move) {
		if(state != ADD_STATES.DASHING) {
			make_dash();
		}
		if(move_input != 0 && (sign(h_spd) == sign(move_input) || h_spd == 0 || !is_on_ground) && state != ADD_STATES.DASHING) {
			spd += max_spd * acceleration;
			if(spd >= max_spd) {
				spd = max_spd;
			}
			h_spd = move_input * spd;
			image_xscale = sign(h_spd);
		} else {
			h_spd -= max_spd * decceleration * sign(h_spd);
			if(abs(h_spd) <= 0.5) {
				h_spd = 0;
			}
			if(state == ADD_STATES.DASHING && abs(h_spd) <= 4) {
				state = ADD_STATES.MOVING;
				max_spd = 4;
				mask_index = spr_add_idle;
				decceleration = 0.1;
			}
			spd = min_spd;
		}
	}
	check_h_collision();
	x += h_spd;
}

function make_jump(_start_condition, _h_bust = false) {
	if(_start_condition) {
		can_jump = true;
		state = ADD_STATES.JUMPING;
		image_index = 0;
		if(_h_bust) {
			can_move = false;
			h_spd = max_spd * -move_input;
			jump_force = -15;
			alarm[2] = 10;
		}
		max_spd *= 1.25;
		spd = max_spd;
		if(alarm[0] <= -1) {
			alarm[0] = 3;
		}
		mask_index = spr_add_jump;
	}
	if(jump && can_jump && hold_timer < 18) {
		v_spd -= additive_jump_force;
		additive_jump_force *= jump_force_multiplier;
		if(v_spd < 0) {
			hold_timer++;
		}
	}
	if(jump_end || hold_timer >= 18) {
		v_spd -= v_spd / 10;
		additive_jump_force = 1.5;
		max_spd = 4;
		mask_index = spr_add_idle;
		if(state != ADD_STATES.STICKIED && state != ADD_STATES.SLIDING) {
			state = ADD_STATES.FALLING;
		}
		can_jump = false;
	}
}

function make_squat() {
	if(squat_start) {
		mask_index = spr_add_squat;
		state = ADD_STATES.SQUATING;
		jump_force = -10;
	} else if(squat && is_on_ground) {
		max_spd = 2;
	} else if (squat_end && is_on_ground) {
		mask_index = spr_add_idle;
		max_spd = 4;
		state = ADD_STATES.MOVING;
		jump_force = -5;
	}
}

function make_wall_jump() {
	if(state != ADD_STATES.STICKIED && state != ADD_STATES.SLIDING) {
		state = ADD_STATES.STICKIED;
		alarm[3] = 32;
	}
	if(state == ADD_STATES.STICKIED) {
		v_spd = 0;
	}
	make_jump(jump_start, true);
}

function move_vertical() {	
	if(state != ADD_STATES.DASHING && state != ADD_STATES.STICKIED) {
		if(state == ADD_STATES.FALLING && is_on_ground) {
			state = ADD_STATES.LANDING;
			hold_timer = 0;
			alarm[1] = 3;
			jump_force = -5;
		}
		
		if(state != ADD_STATES.LANDING) {
			make_jump(jump_start && is_on_ground);
		}
	
		if(is_on_ground) {
			make_squat();
		}
	}
	
	if(state == ADD_STATES.SLIDING) {
		v_spd = v_spd + grv / 2;
	} else if (state == ADD_STATES.DASHING) {
		v_spd = 0;
	} else if(v_spd > 2) {
		v_spd = v_spd + grv * 2;
	} else {
		v_spd = v_spd < 2 && v_spd > -2 ? v_spd + grv / 1.5 : v_spd + grv;
	}
	
	if(!is_on_ground && state != ADD_STATES.JUMPING && (place_meeting(x + 1, y, obj_ground) && right || place_meeting(x - 1, y, obj_ground) && left)) {
		make_wall_jump();
	}
	
	if((state == ADD_STATES.STICKIED || state == ADD_STATES.SLIDING) 
		&& (place_meeting(x + 1, y, obj_ground) && !right || place_meeting(x - 1, y, obj_ground) && !left)) {
		state = ADD_STATES.MOVING;
	}
	
	check_v_collision();
	y += v_spd;
}

function handle_animation() {
	if(is_on_ground && state != ADD_STATES.JUMPING && state != ADD_STATES.LANDING) {
		if(squat) {
			if(sprite_index == spr_add_squat && round(image_index) >= image_number - 1) {
				state = ADD_STATES.SQUATED;
			}
			if(state == ADD_STATES.SQUATED) {
				sprite_index = abs(h_spd) < 1 ? spr_add_squat_idle : spr_add_crawling;
			} else {
				image_index = sprite_index == spr_add_squat ? image_index : 0;
				sprite_index = spr_add_squat;
			}
		} else {
			sprite_index = abs(h_spd) < 2 ? spr_add_idle : spr_add_running;
		}
		image_speed = 1;
	} else if(abs(v_spd) > 2) {
		if (v_spd < 0 && state == ADD_STATES.JUMPING) {
			sprite_index = spr_add_jump;
			image_speed = round(image_index) >= image_number - 1 ? 0 : 1;
		} else if (v_spd > 0 && state != ADD_STATES.SQUATED && place_meeting(x, y + 16 + v_spd, obj_ground)) {
			if(sprite_index != spr_add_landing) {
				image_index = 0;
			}
			sprite_index = spr_add_landing;
			image_speed = round(image_index) >= image_number - 1 ? 0 : 1;
		} else if(v_spd > 0) {
			sprite_index = spr_add_falling;
		}
	}
}

check_input();
is_on_ground = place_meeting(x, y + 1, obj_ground);
if(state != ADD_STATES.JUMPING && state != ADD_STATES.LANDING && state != ADD_STATES.SQUATING 
	&& state != ADD_STATES.STICKIED && state != ADD_STATES.SLIDING) {
	move_horizontal();
}
move_vertical();
handle_animation();
