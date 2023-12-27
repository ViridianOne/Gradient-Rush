rotation_radius = 64;
rotation_spd = 8;

color = COLORS.GREEN;
image_blend = c_green;

color_interaction = {
	monochromatic: -1,
	split_analogous: -0.67,
	triadic: 0.67,
	complementary: 1,
	relationship: RELATIONSHIPS.MONOCHROMATIC
}

audio_listener_orientation(0, 1, 0, 0, 0, 1);
audio_falloff_set_model(audio_falloff_exponent_distance);
snd = audio_play_sound_at(snd_gear_rotating, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, true, 2);
