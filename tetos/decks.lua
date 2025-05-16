SMODS.Atlas{
    key = 'peardeck',
    path = 'peardeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "teto_deck",
    loc_txt = {
        name = "Teto Deck",
        text={
        "Start with an",
        "{C:attention}Dr. Kidori{}",
        },
    },
	
	config = { hands = 0, discards = 0},
	pos = { x = 0, y = 0 },
	order = 1,
	atlas = "peardeck",
    unlocked = true,

	apply = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				if G.consumeables then
                    local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_tetorot_drkidori", "tetorot_deck")
                    card:add_to_deck()
                    --card:start_materialize()
                    G.jokers:emplace(card)

                    local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_tetorot_fatassteto", "tetorot_deck")
                    card2:add_to_deck()
                    --card:start_materialize()
                    G.jokers:emplace(card2)
                    return true
                end
			end,
		}))
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})