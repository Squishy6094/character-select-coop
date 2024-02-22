function after_init(o)
end

function after_loop(o)
	cur_obj_update_floor_and_walls()

    if o.oTimer > 7 then
	    obj_mark_for_deletion(o)
	end
	o.oTimer = o.oTimer + 1
end
id_bhvAfterImage = hook_behavior(nil, OBJ_LIST_DEFAULT, true, after_init, after_loop)