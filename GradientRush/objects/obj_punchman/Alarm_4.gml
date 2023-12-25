if(can_punch) {
	image_xscale = sign(obj_add.x - x);
	state = ADD_STATES.PUNCHING;
	h_spd = max_spd * sign(image_xscale);
	can_punch = false;
	run_direction = 0;
	can_damage_player = true;
	alarm[1] = 32;
	obj_add.is_damaged = get_color_relationship(color, obj_add.color) != RELATIONSHIPS.MONOCHROMATIC;
} else if(can_dash) {
	image_xscale = sign(obj_add.x - x);
	state = ADD_STATES.DASHING;
	max_spd = 15;
	h_spd = max_spd * sign(image_xscale);
	decceleration = 0.05;
	can_dash = is_on_ground;
	additive_jump_force = 1.5;
	run_direction = 0;
	able_to_dash = false;
	alarm[3] = 64;
}
