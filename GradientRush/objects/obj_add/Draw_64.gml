draw_set_color(c_white);
draw_text(100, 100, !can_touch_flash ? flash_jump_force : sign(grv) * jump_force - sign(grv) * green_interaction.additional_jump_force);
draw_set_color(c_black);
