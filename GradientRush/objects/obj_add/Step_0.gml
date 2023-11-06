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
	is_color_hud_open = mouse_check_button(1);
	move_input = right - left;
}

function check_color_input() {	
	hue = point_direction(x, y, mouse_x, mouse_y);
	if(hue < 30 || hue >= 330) {
		color = COLORS.RED;
		color_wheel_image_index = 1;
	} else if(hue >= 30 && hue < 90) {
		color = COLORS.YELLOW;
		color_wheel_image_index = 2;
	} else if(hue >= 90 && hue < 150) {
		color = COLORS.GREEN;
		color_wheel_image_index = 3;
	} else if(hue >= 150 && hue < 210) {
		color = COLORS.CYAN;
		color_wheel_image_index = 4;
	} else if (hue >= 210 && hue < 270) {
		color = COLORS.BLUE;
		color_wheel_image_index = 5;
	} else if (hue >= 270 && hue < 330) {
		color = COLORS.MAGENTA;
		color_wheel_image_index = 6;
	}
}

function change_color() {
	if(is_color_hud_open) {
		check_color_input();
	}
	switch(color) {
		case COLORS.RED:
			image_blend = c_red;
			break;
		case COLORS.YELLOW:
			image_blend = c_yellow;
			break;
		case COLORS.GREEN:
			image_blend = c_lime;
			break;
		case COLORS.CYAN:
			image_blend = c_aqua;
			break;
		case COLORS.BLUE:
			image_blend = c_blue;
			break;
		case COLORS.MAGENTA:
			image_blend = c_fuchsia;
			break;
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
		can_dash = is_on_ground;
		additive_jump_force = 1.5;
		hold_timer = 0;
	}
}

function move_horizontal() {
	if(can_move) {
		if(state != ADD_STATES.DASHING && can_dash) {
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
				state = is_on_ground ? ADD_STATES.MOVING : ADD_STATES.FALLING;
				max_spd = 4;
				mask_index = spr_add_idle;
				decceleration = 0.1;
			}
			spd = min_spd;
		}
	}
	check_h_collision();
	x += h_spd * magenta_interaction.speed_relativity * obj_game_manager.global_speed;
}

function make_jump(_start_condition, _h_bust = false, is_green_inter = false) {
	if(_start_condition) {
		can_jump = true;
		green_interaction.can_jump = false;
		state = ADD_STATES.JUMPING;
		image_index = 0;
		if(_h_bust) {
				can_move = false;
				if(!is_green_inter) {
					jump_force = -15;
				}
				alarm[2] = 10;
			h_spd = max_spd * -image_xscale;
		}
		max_spd = 5;
		spd = max_spd;
		alarm[0] = 3;
		mask_index = spr_add_jump;
	}
	if(jump && can_jump && hold_timer < 18 && !is_green_inter) {
		v_spd -= additive_jump_force;
		additive_jump_force *= jump_force_multiplier;
		if(v_spd < 0) {
			hold_timer++;
		}
	}
	if(jump_end || hold_timer >= 18 || v_spd > 0) {
		if(!_h_bust) {
			v_spd -= v_spd / 10;
		}
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
	if(!green_interaction.more_monochromatic) {
		if(state != ADD_STATES.STICKIED && state != ADD_STATES.SLIDING) {
			state = ADD_STATES.STICKIED;
			alarm[3] = 32;
		}
		if(state == ADD_STATES.STICKIED) {
			v_spd = 0;
		}
		make_jump(jump_start, true);
	}
}

function move_vertical() {	
	if(state != ADD_STATES.DASHING && state != ADD_STATES.STICKIED && magenta_interaction.gravity_multiplier != magenta_interaction.max_gravity) {
		if((state == ADD_STATES.FALLING || state == ADD_STATES.SLIDING) && is_on_ground) {
			state = ADD_STATES.LANDING;
			hold_timer = 0;
			alarm[1] = 3;
			jump_force = -5;
			can_dash = true;
			green_interaction.can_jump = true;
		}
		
		if(state != ADD_STATES.LANDING && !green_interaction.more_monochromatic) {
			make_jump(jump_start && is_on_ground);
		}
	
		if(is_on_ground) {
			make_squat();
		}
	}
	
	if(v_spd < -15) {
		v_spd = v_spd + grv * 15 * magenta_interaction.gravity_multiplier;
	} else if(state == ADD_STATES.SLIDING) {
		v_spd = v_spd + grv / 2 * magenta_interaction.gravity_multiplier;
	} else if (state == ADD_STATES.DASHING) {
		v_spd = 0;
	} else if(v_spd > 2) {
		v_spd = v_spd + grv * 2 * magenta_interaction.gravity_multiplier;
	} else {
		v_spd = v_spd < 2 && v_spd > -2 
			? v_spd + grv / 1.5 * magenta_interaction.gravity_multiplier 
			: v_spd + grv * magenta_interaction.gravity_multiplier;
	}
	
	if(!is_on_ground && state != ADD_STATES.JUMPING && (place_meeting(x + 1, y, obj_ground) && right || place_meeting(x - 1, y, obj_ground) && left)) {
		make_wall_jump();
	}
	
	if((state == ADD_STATES.STICKIED || state == ADD_STATES.SLIDING) 
		&& (place_meeting(x + 1, y, obj_ground) && !right || place_meeting(x - 1, y, obj_ground) && !left)) {
		state = ADD_STATES.MOVING;
	}
	
	check_v_collision();
	y += v_spd * obj_game_manager.global_speed;
}

function is_blinking_state() {
	return state == ADD_STATES.IDLE || state == ADD_STATES.MOVING || ADD_STATES.SQUATED;
}

function check_image_index() {
	if((state == ADD_STATES.MOVING && image_index >= image_number - 4 || image_index >= image_number - 3) 
		&& is_blinking_state() && sprite_index != spr_add_squat) {
		if(blink_time > 0) {
			image_index = 0;
		}
	}
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
		} else if(state != ADD_STATES.DASHING) {
			state = abs(h_spd) < 2 ? ADD_STATES.IDLE : ADD_STATES.MOVING;
			sprite_index = state == ADD_STATES.IDLE ? spr_add_idle : spr_add_running;
		}
		check_image_index();
		image_speed = 1;
	} else if(abs(v_spd) > 2) {
		if (v_spd < 0 && state == ADD_STATES.JUMPING) {
			sprite_index = spr_add_jump;
			//image_speed = round(image_index) >= image_number - 1 ? 0 : 1;
		} else if (v_spd > 0 && state != ADD_STATES.SQUATED && place_meeting(x, y + 16 + v_spd, obj_ground)) {
			if(sprite_index != spr_add_landing) {
				image_index = 0;
			}
			sprite_index = spr_add_landing;
			//image_speed = round(image_index) >= image_number - 1 ? 0 : 1;
		} else if(v_spd > 0) {
			sprite_index = spr_add_falling;
		}
	}
	if(sprite_index == spr_add_jump || sprite_index == spr_add_landing) {
		image_speed = round(image_index) >= image_number - 1 ? 0 : 1;
	}
}

function check_existance() {
	is_active = bbox_top < room_height;
	if(!is_active) {
		state = ADD_STATES.LOST;
		if(alarm[4] <= 0) {
			alarm[4] = 32;
		}
	}
}

function check_green_interaction() {
	if(green_interaction.more_monochromatic) {
		switch(green_interaction.relationship) {
			case RELATIONSHIPS.MONOCHROMATIC:
				green_interaction.additional_jump_force = green_interaction.high_springines;
				break;
			case RELATIONSHIPS.ANALOGOUS:
				green_interaction.additional_jump_force = green_interaction.medium_springiness;
				break;
			case RELATIONSHIPS.SPLIT_ANALOGOUS:
				green_interaction.additional_jump_force = green_interaction.weak_springiness;
				break;
		}
		if(state != ADD_STATES.LANDING) {
			var _a = place_meeting(x + 1, y-5, obj_ground) || place_meeting(x - 1, y-5, obj_ground);
			make_jump(is_on_ground && green_interaction.can_jump || _a, _a, true);
		}
	} else if(green_interaction.more_complementary) {
		switch(green_interaction.relationship) {
			case RELATIONSHIPS.COMPLEMENTARY:
				green_interaction.destroying_time = green_interaction.instant_breaking;
				break;
			case RELATIONSHIPS.SPLIT_COMPLEMENTARY:
				green_interaction.destroying_time = green_interaction.fast_breaking;
				break;
			case RELATIONSHIPS.TRIADIC:
				green_interaction.destroying_time = green_interaction.slow_breaking;
		}
	} else {
		green_interaction.additional_jump_force = 0;
		green_interaction.destroying_time = 10;
	}
}

function check_magenta_interaction() {
	if(magenta_interaction.more_monochromatic) {
		switch(magenta_interaction.relationship) {
			case RELATIONSHIPS.MONOCHROMATIC:
				magenta_interaction.gravity_multiplier = magenta_interaction.min_gravity;
				break;
			case RELATIONSHIPS.ANALOGOUS:
				magenta_interaction.gravity_multiplier = magenta_interaction.very_low_gravity;
				break;
			case RELATIONSHIPS.SPLIT_ANALOGOUS:
				magenta_interaction.gravity_multiplier = magenta_interaction.low_gravity;
		}
		magenta_interaction.speed_relativity = magenta_interaction.normal_gravity;
		obj_game_manager.obj_speed_relativity = magenta_interaction.gravity_multiplier;
	} else if(magenta_interaction.more_complementary) {
		switch(magenta_interaction.relationship) {
			case RELATIONSHIPS.COMPLEMENTARY:
				magenta_interaction.gravity_multiplier = magenta_interaction.max_gravity;
				magenta_interaction.speed_relativity = magenta_interaction.min_gravity;
				break;
			case RELATIONSHIPS.SPLIT_COMPLEMENTARY:
				magenta_interaction.gravity_multiplier = magenta_interaction.very_strong_gravity;
				magenta_interaction.speed_relativity = magenta_interaction.very_low_gravity;
				break;
			case RELATIONSHIPS.TRIADIC:
				magenta_interaction.gravity_multiplier = magenta_interaction.strong_gravity;
				magenta_interaction.speed_relativity = magenta_interaction.low_gravity;
				break;
		}
		obj_game_manager.obj_speed_relativity = magenta_interaction.normal_gravity;
	} else {
		magenta_interaction.gravity_multiplier =  magenta_interaction.normal_gravity;
		magenta_interaction.speed_relativity = magenta_interaction.normal_gravity;
		obj_game_manager.obj_speed_relativity = magenta_interaction.normal_gravity;
	}
}

if(!obj_game_manager.is_paused) {
	check_input();
	change_color();
	if(state != ADD_STATES.LOST) {
		obj_game_manager.global_speed = is_color_hud_open ? 0.25 : 1;
		is_on_ground = place_meeting(x, y + 1, obj_ground);
		if(location == COLORS.GREEN) {
			check_green_interaction();
		} else {
			check_magenta_interaction();
		}
		if(state != ADD_STATES.JUMPING && state != ADD_STATES.LANDING && state != ADD_STATES.SQUATING 
			&& state != ADD_STATES.STICKIED && state != ADD_STATES.SLIDING) {
			move_horizontal();
		}
		move_vertical();
		handle_animation();
	}

	check_existance();
}
