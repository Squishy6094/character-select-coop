-- Modifies Behaviors with multiple models to function properly with the replace model feature
-- Internal set_model behaviors replaced with o.oOriginalModel

local function koopa_model_update(o)
    if o.oKoopaMovementType == KOOPA_BP_UNSHELLED then
        o.oOriginalModel = E_MODEL_KOOPA_WITHOUT_SHELL
    else
        o.oOriginalModel = E_MODEL_KOOPA_WITH_SHELL
    end
    set_model(o)
end
hook_behavior(id_bhvKoopa, OBJ_LIST_PUSHABLE, false, nil, koopa_model_update)