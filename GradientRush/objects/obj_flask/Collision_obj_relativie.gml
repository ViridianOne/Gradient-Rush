if(is_thrown && !is_broken) {
	if(flask_number == 0) {
		other.damage_boss();
	}

	audio_stop_sound(snd);
	audio_play_sound(snd_flask_breaking, 2, false);
	sprite_index = flask_number == 0 ? spr_flask_green_splash : spr_flask_magenta_splash;
	image_speed = 1;
	alarm[1] = 3 * 8;
	is_broken = true;
	is_thrown = false;
}
