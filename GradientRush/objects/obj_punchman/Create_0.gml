//horizontal mechanics
spd = 0.5;
max_spd = 4;
min_spd = 0.5;
acceleration = 0.05;
additional_accl = 1.1;
decceleration = 0.1;
h_spd = 0;
can_move = true;
run_direction = 0;

//sprites & colliders
state = ADD_STATES.IDLE;
image_xscale = 1;
sprite_index = spr_punchman_idle;
image_speed = 1;
image_index = 0;
//mask_index = spr_punchman_idle;
blink_time = 5;

//vertical mechanics
grv = 0.5;
v_spd = 0;
carrying_v_spd = 0;
jump_force = -5;
additive_jump_force = 1.5;
jump_force_multiplier = 0.88;
is_on_ground = true;
can_jump = false;

//dash
can_dash = false;
dash_border_left = 224;
able_to_dash = true;

//pucnhing
can_punch = false;
punch_border_right = 40;
punch_border_up = 96;
can_damage_player = false;

//existance
is_active = true;
is_damaged = false;

//color interaction
color = COLORS.BLUE;
relationship = RELATIONSHIPS.NEUTRAL;
