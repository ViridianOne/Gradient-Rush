if(pendulum_id != noone) {
	prev_x = x;
	prev_y = y;
	x = pendulum_id.x + lengthdir_x(144, pendulum_id.image_angle-90);
	y = pendulum_id.y + lengthdir_y(144, pendulum_id.image_angle-90);
	h_spd = x - prev_x;
	v_spd = y - prev_y;
	if(place_meeting(x, y-1, obj_add)) {
		obj_add.x += h_spd;
		obj_add.y += v_spd;
	}
}
