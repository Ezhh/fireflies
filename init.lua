
-- firefly 
minetest.register_node("fireflies:firefly", {
	description = "Firefly",
	drawtype = "plantlike",
	tiles = {{
		name = "fireflies_firefly_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1.5
		},
	}},
	inventory_image = "fireflies_firefly.png",
	wield_image =  "fireflies_firefly.png",
	waving = 1,
	paramtype = "light",
	sunlight_propagates = true,
	buildable_to = true,
	walkable = false,
	groups = {catchable = 1},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	},
	light_source = 6,
})


-- bug net
minetest.register_tool("fireflies:bugnet", {
	description = "Bug Net",
	inventory_image = "fireflies_bugnet.png",
	on_use = function(itemstack, player, pointed_thing)
		if not pointed_thing or pointed_thing.type ~= "node" or 
				minetest.is_protected(pointed_thing.under, player:get_player_name()) then
			return
		end
		local node_name = minetest.get_node(pointed_thing.under).name
		local inv = player:get_inventory()
		if minetest.get_item_group(node_name, "catchable") == 1 then
			minetest.set_node(pointed_thing.under, {name = "air"})
			local stack = ItemStack(node_name.." 1")
			local leftover = inv:add_item("main", stack)
			if leftover:get_count() > 0 then
				minetest.add_item(pointed_thing.under, node_name.." 1")
			end	
		end
		if not minetest.setting_getbool("creative_mode") then
			itemstack:add_wear(256)
			return itemstack
		end
	end
})

minetest.register_craft( {
	output = "fireflies:bugnet 1",
	recipe = {
		{"farming:string", "farming:string", ""},
		{"farming:string", "farming:string", ""},
		{"default:stick", "", ""}
	}
})


-- firefly in a bottle
minetest.register_node("fireflies:firefly_bottle", {
	description = "Firefly in a Bottle",
	inventory_image = "fireflies_bottle.png",
	wield_image = "fireflies_bottle.png",
	tiles = {{
		name = "fireflies_bottle_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1.5
		},
	}},
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 9,
	walkable = false,
	groups = {snappy = 3, attached_node = 1},
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.is_protected(pos, player:get_player_name()) or
				minetest.is_protected(pos_above, player:get_player_name()) then
			return
		end
		if minetest.get_node(pos_above).name == "air" then
			minetest.set_node(pos, {name = "vessels:glass_bottle"})
			minetest.set_node(pos_above, {name = "fireflies:firefly"})
		end
	end
})

minetest.register_craft( {
	output = "fireflies:firefly_bottle 1",
	recipe = {
		{"", "", ""},
		{"", "fireflies:firefly", ""},
		{"", "vessels:glass_bottle", ""}
	}
})


-- register firefly as decorations
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_coniferous_litter", "default:dirt_with_rainforest_litter", "default:dirt"},
	place_offset_y = 2,
	sidelen = 16,
	fill_ratio = 0.001,
	biomes = {"deciduous_forest", "coniferous_forest", "rainforest", "rainforest_swamp"},
	y_min = 1,
	y_max = 31000,
	decoration = "fireflies:firefly",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_coniferous_litter", "default:dirt_with_rainforest_litter", "default:dirt"},
	place_offset_y = 1,
	sidelen = 16,
	fill_ratio = 0.001,
	biomes = {"deciduous_forest", "coniferous_forest", "rainforest", "rainforest_swamp"},
	y_min = 1,
	y_max = 31000,
	decoration = "fireflies:firefly",
})