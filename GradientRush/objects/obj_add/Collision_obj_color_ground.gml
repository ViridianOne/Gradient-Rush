var _relationship = get_color_relationship(color, other.color_hue);

color_interactions[? location].relationship = _relationship;

color_interactions[? location].more_monochromatic =
	color_interactions[? location].relationship == RELATIONSHIPS.MONOCHROMATIC
	|| color_interactions[? location].relationship == RELATIONSHIPS.ANALOGOUS
	|| color_interactions[? location].relationship == RELATIONSHIPS.SPLIT_ANALOGOUS;
	
color_interactions[? location].more_complementary =
	color_interactions[? location].relationship == RELATIONSHIPS.COMPLEMENTARY
	|| color_interactions[? location].relationship == RELATIONSHIPS.SPLIT_COMPLEMENTARY
	|| color_interactions[? location].relationship == RELATIONSHIPS.TRIADIC;

color_interactions[? location].is_active = color_interactions[? location].more_monochromatic 
	|| color_interactions[? location].more_complementary;

/*if(location == COLORS.GREEN) {
	green_interaction.relationship = _relationship;
	
	green_interaction.more_monochromatic = green_interaction.relationship == RELATIONSHIPS.MONOCHROMATIC
		|| green_interaction.relationship == RELATIONSHIPS.ANALOGOUS
		|| green_interaction.relationship == RELATIONSHIPS.SPLIT_ANALOGOUS;
	
	green_interaction.more_complementary = green_interaction.relationship == RELATIONSHIPS.COMPLEMENTARY
		|| green_interaction.relationship == RELATIONSHIPS.SPLIT_COMPLEMENTARY
		|| green_interaction.relationship == RELATIONSHIPS.TRIADIC;
		
	green_interaction.is_active = green_interaction.more_monochromatic || green_interaction.more_complementary;
} else {
	magenta_interaction.relationship = _relationship;
	magenta_interaction.is_active = magenta_interaction.relationship != RELATIONSHIPS.NEUTRAL
		&& magenta_interaction.relationship != RELATIONSHIPS.TETRADIC;
	
	magenta_interaction.more_monochromatic = magenta_interaction.relationship == RELATIONSHIPS.MONOCHROMATIC
		|| magenta_interaction.relationship == RELATIONSHIPS.ANALOGOUS
		|| magenta_interaction.relationship == RELATIONSHIPS.SPLIT_ANALOGOUS;
	
	magenta_interaction.more_complementary = magenta_interaction.relationship == RELATIONSHIPS.COMPLEMENTARY
		|| magenta_interaction.relationship == RELATIONSHIPS.SPLIT_COMPLEMENTARY
		|| magenta_interaction.relationship == RELATIONSHIPS.TRIADIC;
		
	magenta_interaction.is_active = magenta_interaction.more_monochromatic || magenta_interaction.more_complementary;
}*/
