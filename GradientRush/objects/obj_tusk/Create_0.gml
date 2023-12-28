//horizontal mechanics
spd = 0.5;
max_spd = 2;
min_spd = 0.5;
acceleration = 0.05;
additional_accl = 1.1;
decceleration = 0.1;
h_spd = 0;
can_move = false;
run_direction = 0;

//sprites & colliders
state = ADD_STATES.IDLE;
image_xscale = 1;
sprite_index = spr_punchman_idle;
image_speed = 1;
image_index = 0;
/*mask_index = spr_tusk_idle_with_spikes;
blink_time = 5;*/

//vertical mechanics
grv = 0.5;
v_spd = 0;
carrying_v_spd = 0;
jump_force = -5;
additive_jump_force = 1.5;
jump_force_multiplier = 0.88;
is_on_ground = true;
can_jump = false;

//rush
can_rush = false;
rush_spd = 6;
rush_damage_right_border = 16;
can_roar = true;

//spikes
is_with_spikes = true;
b = true;

//existance
is_active = true;
is_damaged = false;

//color interaction
relationship = RELATIONSHIPS.NEUTRAL;

audio_listener_orientation(0, 1, 0, 0, 0, 1);
audio_falloff_set_model(audio_falloff_exponent_distance);
