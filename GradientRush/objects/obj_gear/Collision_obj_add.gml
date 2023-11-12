if(other.can_interact_with_gear) {
	color_interaction.relationship = get_color_relationship(color, other.color);
	other.radius = rotation_radius;
	switch(color_interaction.relationship) {
		case RELATIONSHIPS.MONOCHROMATIC:
			other.rotation_spd = rotation_spd * color_interaction.monochromatic;
			break;
		case RELATIONSHIPS.SPLIT_ANALOGOUS:
			other.rotation_spd = rotation_spd * color_interaction.split_analogous;
			break;
		case RELATIONSHIPS.TRIADIC:
			other.rotation_spd = rotation_spd * color_interaction.triadic;
			break;
		case RELATIONSHIPS.COMPLEMENTARY:
			other.rotation_spd = rotation_spd * color_interaction.complementary;
			break;
		default:
			other.rotation_spd = rotation_spd;
	}
	if(other.rotation_angle > 360) {
		other.rotation_angle = point_direction(x, y, other.x, other.y);
	}
	other.state = ADD_STATES.ROTATING;
	other.gear_x = x;
	other.gear_y = y;
}
