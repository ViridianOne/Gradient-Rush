function change_gravity(_h_boost, _v_boost) {
	obj_add.vortex_interaction.h_boost = _h_boost;
	obj_add.vortex_interaction.v_boost = _v_boost;
	obj_add.vortex_interaction.can_interact = false;
	obj_add.alarm[7] = 60;
	obj_add.grv *= -1;
	obj_add.image_yscale *= -1;
	down_boost *= -1;
}

if(obj_add.vortex_interaction.can_interact && place_meeting(x, y, obj_add)) {
	if(image_angle == 90) {
		if(bbox_left <= obj_add.bbox_right || bbox_right >= obj_add.bbox_left) {
			change_gravity(right_boost * sign(obj_add.image_xscale), 0);
		}
	} else {
		if(bbox_top <= obj_add.bbox_bottom || bbox_bottom >= obj_add.bbox_top) {
			change_gravity(0, down_boost);
		}
	}
}
