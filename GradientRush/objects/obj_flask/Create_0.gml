spd = 8;
h_spd = 0;
v_spd = 0;

image_speed = 0;
image_index = flask_number;

is_grabbed = false;
is_thrown = false;

audio_listener_orientation(0, 1, 0, 0, 0, 1);
audio_falloff_set_model(audio_falloff_exponent_distance);
snd = audio_play_sound_at(snd_flask_seething, x, y, 0, obj_game_manager.fallof_max, obj_game_manager.fallof_factor, 1, true, 2);

