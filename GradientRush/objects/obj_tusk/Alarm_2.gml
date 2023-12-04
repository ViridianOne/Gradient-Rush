if(!can_rush && state != ADD_STATES.LOST) {
	can_move = false;
	state = is_with_spikes ? ADD_STATES.HIDING_SPIKES : ADD_STATES.SHOWING_SPIKES;
	image_index = 0;
	b = false;
}
