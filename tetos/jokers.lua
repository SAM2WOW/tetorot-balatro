--- STEAMODDED HEADER
--- MOD_NAME: Tetorot
--- MOD_ID: Tetorot
--- MOD_AUTHOR: Arx
--- MOD_DESCRIPTION: Yu!
--- PREFIX: tetorot
----------------------------------------------------------
----------- MOD CODE -------------------------------------

-- Fatass Teto


SMODS.Atlas{
    key = 'fatassteto',
    path = 'fatassteto.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'fatassteto',
    loc_txt= {
        name = 'Fatass Teto',
        -- text = { "Gains {C:blue}+#2#{} Chips for every",
        --             "scoring {V:1}Pearto Seal{} card,",
        --             "and {C:red}CONSUME{} the {V:1}Pearto Seal{}",
        --             "{C:red}SELF EXPLODE{} if over {C:blue}+#3#{} Chips",
        --             "{C:inactive}(Currently {C:blue}+#1# {C:inactive}Chips)"}
        text = { "Gains {C:blue}+#2#{} Chips and {C:red}CONSUME{}",
                    "every scoring {V:1}Pearto Seal{}",
                    "{C:red}SELF EXPLODE{} if over {C:blue}+#3#{} Chips",
                    "{C:inactive}(Currently {C:blue}+#1# {C:inactive}Chips)"}
    },
    atlas = 'fatassteto',
    rarity = 2,
    cost = 4,
    pools = { ["Tetorot"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = {chips = 40, additional = 40, c_max = 1000, }},

    loc_vars = function(self, info_queue, center)
		return { vars = { 
            center.ability.extra.chips, 
            center.ability.extra.additional, 
            center.ability.extra.c_max, 
            colours = { HEX("B9BD5D") } 
        } }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
            -- for i = 1, #context.scoring_hand do
            --     if context.scoring_hand[i].seal == "tetorot_pearseal" then 
            -- end
            return {
                message = "+".. card.ability.extra.chips,
                chip_mod = card.ability.extra.chips
            }
        end

        if context.cardarea == G.play and context.individual then
            if context.other_card.seal == "tetorot_pearseal" then 
                -- destroy if over max chips
                if card.ability.extra.chips + card.ability.extra.additional >= card.ability.extra.c_max then
                    local joker_to_destroy = card
                    card_eval_status_text(joker_to_destroy,'extra',nil,nil,nil,{message = "BOOM!"})

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function()
                            joker_to_destroy:juice_up(0.8, 0.8)
                            joker_to_destroy:explode()
                            -- delay(0.4)
                            message = "BAKA!"
                            colour = G.C.RED
                            play_sound('tetorot_ah')
                            
                        return true end }))
                else
                    -- consume
                    card_eval_status_text(card,'extra',nil,nil,nil,{message = "YUMMYYY"})
                    
                    local sliced_card = context.other_card
                    -- sliced_card.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function()
                            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.additional
                            card:juice_up(0.8, 0.8)
                            -- sliced_card:start_dissolve({G.C.RED}, nil, 1.6)
                            -- card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                            -- message = "YUMMYYY!"
                            play_sound('tetorot_crunch')
                            
                            sliced_card:set_seal()
                    return true end }))
                    -- draw_card(G.play, G.deck, 90, 'up', nil)  
                end
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}


-- Dr Kidori
SMODS.Atlas{
    key = 'drkidori',
    path = 'drkidori.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'drkidori',
    loc_txt= {
        name = 'Dr. Kidori',
        text = { "Apply {V:1}Pearto Seals{} to",
                    "all scoring cards in",
                    "your first hand",
    },},
    atlas = 'drkidori',
    rarity = 3,
    cost = 8,
    pools = {["Tetorot"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},

    loc_vars = function(self, info_queue, center)
		return { vars = { colours = { HEX("B9BD5D") } }  }
	end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and context.other_card.seal ~= "tetorot_pearseal" and G.GAME.current_round.hands_played == 0 then
            -- context.other_card.seal = "tetorot_pearseal"
            card_eval_status_text(card,'extra',nil,nil,nil,{message = "Yu!"})
            
            local seal_card = context.other_card
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                card:juice_up(0.8, 0.8)
                seal_card:set_seal("tetorot_pearseal", nil, true)
                return {
                        -- message = "Yu!",
                        -- card = card,
                        sound = "tetorot_yu",
                        } end }))
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

----------------------------------------------------------
----------- MOD CODE END ---------------------------------