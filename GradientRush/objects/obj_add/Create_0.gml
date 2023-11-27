//buttons
left_btn = ord("A");
right_btn = ord("D");
jump_btn = vk_space;
squat_btn = ord("S");
dash_btn = vk_shift;

//test color buttons
red_btn = ord("I");
yellow_btn = ord("O");
green_btn = ord("L");
cyan_btn = ord("K");
blue_btn = ord("J");
magenta_btn = ord("U");

//inputs
left = false;
right = false;
jump = false;
jump_start = false;
jump_end = false;
squat = false;
squat_start = false;
squat_end = false;
dash = false;
move_input = 0;

//horizontal mechanics
spd = 0.5;
max_spd = 4;
min_spd = 0.5;
acceleration = 0.05;
additional_accl = 1.1;
decceleration = 0.1;
h_spd = 0;
carrying_h_spd = 0;
can_move = true;

//sprites & colliders
state = ADD_STATES.IDLE;
image_xscale = 1;
sprite_index = spr_add_idle;
image_speed = 1;
image_index = 0;
mask_index = spr_add_idle;
image_blend = c_yellow;
blink_time = 5;

//vertical mechanics
grv = 0.5;
v_spd = 0;
carrying_v_spd = 0;
jump_force = -5;
additive_jump_force = 1.5;
jump_force_multiplier = 0.88;
is_on_ground = true;
hold_timer = 0;
can_jump = false;

//dash
can_dash = true;

//wall jump
is_wall_right = false;
is_wall_left = false;

//existance
is_active = true;

//blinks
/*add_blink = ds_map_create();
ds_map_add(add_blink, ADD_STATES.IDLE, new AddAnimation(ADD_STATES.IDLE, 0, true, 4));
ds_map_add(add_blink, ADD_STATES.MOVING, 13);
ds_map_add(add_blink, ADD_STATES.SQUATED, 8);*/

//color
color = COLORS.YELLOW;
color_dif = 0;
relationship = RELATIONSHIPS.NEUTRAL;
is_color_hud_open = false;
hue = 0;
color_wheel_image_index = 2;

//green
green_interaction = {
	is_active: false,
	more_monochromatic: false,
	more_complementary: false,
	relationship: RELATIONSHIPS.NEUTRAL,
	high_springines: 15,
	medium_springiness: 10,
	weak_springiness: 5,
	slow_breaking: 2,
	fast_breaking: 3.4,
	instant_breaking: 10,
	additional_jump_force: 0,
	can_jump: true,
	destroying_time: 10
}

//magenta
magenta_interaction = {
	is_active: false,
	more_monochromatic: false,
	more_complementary: false,
	relationship: RELATIONSHIPS.NEUTRAL,
	min_gravity: 0.25,
	very_low_gravity: 0.5,
	low_gravity: 0.75,
	normal_gravity: 1,
	strong_gravity: 2,
	very_strong_gravity: 3,
	max_gravity: 4,
	speed_relativity: 1,
	gravity_multiplier: 1
}

//location
location = COLORS.MAGENTA;
color_interactions = ds_map_create();
ds_map_add(color_interactions, COLORS.GREEN, green_interaction);
ds_map_add(color_interactions, COLORS.MAGENTA, magenta_interaction);

//rotation
radius = 0;
rotation_spd = 0;
rotation_angle = 361;
gear_x = 0;
gear_y = 0;
a = 0;
can_interact_with_gear = true;

//flash
has_touched_flash = false;
can_touch_flash = true;
flash_jump_force = 0;

//sliding on strings
string_interaction = {
	number: 0,
	relationship: RELATIONSHIPS.NEUTRAL,
	const_sliding_spd: 3,
	sliding_spd: 4,
	h_boost: 0,
	v_boost: 0,
	can_jump: false,
	can_interact: true,
	prev_pos: 0,
	prev_len: 0
}

//vortex
vortex_interaction = {
	h_boost: 0,
	v_boost: 0,
	can_interact: true
}
make_gravity_jump = function() {
	can_jump = true;
	green_interaction.can_jump = false;
	can_move = false;
	image_index = 0;
	alarm[2] = 20;
	max_spd = 6;
	h_spd = vortex_interaction.h_boost;
	v_spd = vortex_interaction.v_boost;
	mask_index = spr_add_jump;
	alarm[5] = 30;
	state = ADD_STATES.MOVING;
}
