function change_gravity(_h_boost, _v_boost, _x, _y) {
	with(obj_add) {
		vortex_interaction.h_boost = _h_boost;
		vortex_interaction.v_boost = _v_boost;
		vortex_interaction.can_interact = false;
		alarm[7] = 60;
		obj_add.magenta_interaction.can_use = false;
		obj_add.magenta_interaction.is_active = false;
		obj_add.magenta_interaction.gravity_multiplier = obj_add.magenta_interaction.normal_gravity;
		obj_add.magenta_interaction.speed_relativity = obj_add.magenta_interaction.normal_gravity;
		obj_game_manager.obj_speed_relativity = obj_add.magenta_interaction.normal_gravity;
		//grv = 2 * sign(grv) * -1;
		x = _x;
		y = _y - sprite_height / 2;
		image_yscale *= -1;
		color += color < 180 ? 180 : -180;
		switch(color) {
				case 0:
					color = COLORS.RED;
					image_blend = c_red;
					break;
				case 60:
					color = COLORS.YELLOW;
					image_blend = c_yellow;
					break;
				case 120:
					color = COLORS.GREEN;
					image_blend = c_lime;
					break;
				case 180:
					color = COLORS.CYAN;
					image_blend = c_aqua;
					break;
				case 240:
					color = COLORS.BLUE;
					image_blend = c_blue;
					break;
				case 300:
					color = COLORS.MAGENTA;
					image_blend = c_fuchsia;
					break;
			}
	}
}

if(obj_add.vortex_interaction.can_interact && place_meeting(x, y, obj_add)) {
	if(image_angle == 90) {
		if(bbox_left <= obj_add.bbox_right || bbox_right >= obj_add.bbox_left) {
			change_gravity(right_boost * sign(obj_add.image_xscale), 0, x, y);
		}
	} else {
		if(bbox_top <= obj_add.bbox_bottom || bbox_bottom >= obj_add.bbox_top) {
			change_gravity(0, down_boost * sign(obj_add.grv), x, y);
		}
	}
}

audio_listener_position(obj_add.x, obj_add.y, 0);
