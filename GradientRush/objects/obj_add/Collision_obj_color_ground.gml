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
