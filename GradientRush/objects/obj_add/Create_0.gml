//buttons
left_btn = ord("A");
right_btn = ord("D");
jump_btn = vk_space;
squat_btn = ord("S");
dash_btn = vk_shift;

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
min_accl = 1.1;
decceleration = 0.1;
h_spd = 0;
can_move = true;

//sprites & colliders
state = ADD_STATES.IDLE;
image_xscale = 1;
sprite_index = spr_add_idle;
image_speed = 1;
image_index = 0;
mask_index = spr_add_idle;

//vertical mechanics
grv = 0.5;
v_spd = 0;
jump_force = -5;
additive_jump_force = 1.5;
jump_force_multiplier = 0.88;
is_on_ground = true;
is_jumping = false;
is_falling = false;
hold_timer = 0;
is_stopped = false;
can_jump = false;

//squat
is_squated = false;

//wall jump
is_wall_right = false;
is_wall_left = false;
