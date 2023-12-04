if(!can_jump_after_attack && !can_hold_jump_after_attack) {
	v_spd = !can_touch_flash ? sign(grv) * flash_jump_force : sign(grv) * jump_force - sign(grv) * green_interaction.additional_jump_force;
} else {
	v_spd = -10;
}
green_interaction.additional_jump_force = 0;
flash_jump_force = 0;
can_touch_flash = true;
state = ADD_STATES.MOVING;
