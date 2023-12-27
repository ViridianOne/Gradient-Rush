if(can_touch_flash && color != other.color_hue) {
	has_touched_flash = true;
	flash_jump_force = other.jump_force;
	can_touch_flash = false;
	audio_play_sound(snd_flash, 2, false);
}
