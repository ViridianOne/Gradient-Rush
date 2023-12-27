left_boost = -10;
//right_boost = 10;
up_boost = -50;
//down_boost = 50;

audio_listener_orientation(0, 1, 0, 0, 0, 1);
audio_falloff_set_model(audio_falloff_exponent_distance);
snd = audio_play_sound_at(snd_vortex, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, true, 2);
