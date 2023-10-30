function AddAnimation(_state, _start_index=0, _is_cycle=true, _blink_start=0, _blink_end=0) constructor {
	state = _state;
	start_index = _start_index;
	is_cycle = _is_cycle;
	blink_start = _blink_start;
	blink_end = _blink_end;
	
	function need_to_blink(_image_index, _is_blinking_state, _time_to_blink) {
		return _image_index >= blink_start - 0.5 && _image_index <= blink_end && _is_blinking_state && _time_to_blink <= 0;
	}
}
