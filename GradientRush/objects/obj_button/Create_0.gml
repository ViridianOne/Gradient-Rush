image_speed = 0;
image_index = 1;

color = c_black;

if(interface_type == INTERFACE_TYPES.SOUND_SWITCHER) {
	label = $"Sounds: {obj_music_manager.is_sound_on ? "ON" : "OFF"}";
}
