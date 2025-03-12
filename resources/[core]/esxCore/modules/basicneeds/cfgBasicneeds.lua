return {
    Locale_Basicneeds = {
        ['used_food'] = 'Vous avez mangé 1x %s',
        ['used_drink'] = 'Vous avez bu 1x %s',
        ['got_healed'] = 'Vous avez été soigné.'
    },
    
    Basicneeds = {
		Visible = true,
        Items = {
            ["bread"] = {
                type = "food",
                prop = "prop_cs_burger_01",
                status = 200000,
                remove = true,
                anim = {dict = 'mp_player_inteat@burger', name = 'mp_player_int_eat_burger_fp', settings = {8.0, -8, -1, 49, 0, 0, 0, 0}},
                pos = vector3(0.15, 0.03, 0.0),
                rot = vector3(15.0, 175.0, 5.0)
            },
            ["water"] = {
                type = "drink",
                prop = "prop_ld_flow_bottle",
                status = 100000,
                remove = true,
                anim = {dict = 'mp_player_intdrink', name = 'loop_bottle', settings = {1.0, -1.0, 2000, 0, 1, true, true, true}},
                pos = vector3(0.12, 0.028, 0.001),
                rot = vector3(10.0, 175.0, 0.0)   
            }
        }
    }
}
