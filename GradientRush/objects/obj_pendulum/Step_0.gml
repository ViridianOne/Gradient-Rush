if(!can_change_spd) {
	if(image_angle < dir - 45 || image_angle > dir + 45) {
		rotation_spd *= dir == PENDULUM_DITECTIONS.UP ? -0.5 : -2;
		frame = image_angle > dir + 45 ? 1 : 2;
		can_change_spd = true;
	}
} else {
	switch(dir) {
		case PENDULUM_DITECTIONS.DOWN:
			if(image_angle > dir - abs(rotation_spd) && image_angle < dir + abs(rotation_spd)) {
				rotation_spd *= 0.5;
				frame = 0;
				can_change_spd = false;
			}
			break;
		case PENDULUM_DITECTIONS.RIGHT:
			if(image_angle < dir - 45 + abs(rotation_spd)) {
				rotation_spd *= 0.5;
				can_change_spd = false;
			}
			break;
		case PENDULUM_DITECTIONS.UP:
			if(image_angle > dir - abs(rotation_spd) && image_angle < dir + abs(rotation_spd)) {
				rotation_spd *= 2;
				can_change_spd = false;
			}
			break;
		case PENDULUM_DITECTIONS.LEFT:
			if(image_angle > dir + 45 - abs(rotation_spd)) {
				rotation_spd *= 0.5;
				can_change_spd = false;
			}
			break;
	}
}

image_angle += rotation_spd;
