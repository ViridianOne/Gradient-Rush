if(is_thrown) {
	if(flask_number == 0) {
		other.damage_boss();
	}

	audio_stop_sound(snd);
	audio_play_sound(snd_flask_breaking, 2, false);
	instance_destroy();
}
