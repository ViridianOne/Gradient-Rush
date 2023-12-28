can_jump = true;
green_interaction.can_jump = false;
can_move = false;
image_index = 0;
magenta_interaction.can_use = false;
magenta_interaction.is_active = false;
magenta_interaction.gravity_multiplier = magenta_interaction.normal_gravity;
magenta_interaction.speed_relativity = magenta_interaction.normal_gravity;
magenta_interaction.relationship = RELATIONSHIPS.NEUTRAL;
obj_game_manager.obj_speed_relativity = magenta_interaction.normal_gravity;
grv = 0.5 * -sign(grv);
if(alarm[2] < 0) {
	alarm[2] = 20;
}
max_spd = 6;
h_spd = vortex_interaction.h_boost;
v_spd = vortex_interaction.v_boost;
mask_index = spr_add_jump;
if(alarm[5] < 0) {
	alarm[5] = 30;
}
state = ADD_STATES.MOVING;
magenta_interaction.can_use = true;
