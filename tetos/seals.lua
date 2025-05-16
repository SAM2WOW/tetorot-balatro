--- STEAMODDED HEADER
--- MOD_NAME: Tetorot
--- MOD_ID: Tetorot
--- MOD_AUTHOR: Arx
--- MOD_DESCRIPTION: Yu!
--- PREFIX: tetorot
----------------------------------------------------------
----------- MOD CODE -------------------------------------

SMODS.Sound({key = "yu", path = "yu.ogg",})
SMODS.Sound({key = "crunch", path = "crunch.ogg",})
SMODS.Sound({key = "ah", path = "ah.ogg",})

SMODS.Atlas {
    key = "pearseal",
    path = "pearseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "pearseal",
    key = "pearseal",
    badge_colour = HEX("b9bd5d"),
	config = { x_mult = 4.1  },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'Pearto Seal',
        -- Tooltip description
        name = 'Pearto Seal',
        text = {
            'Sigma {X:mult,C:white}X#1#{} Mult',
        }
    },


    sound = { sound = 'tetorot_yu', per = 1, vol = 0.4 },

    loc_vars = function(self, info_queue)
        return { vars = { self.config.x_mult } }
    end,
    atlas = "pearseal",
    pos = {x=0, y=0},

    -- self - this seal
    -- card - card this seal is applied to
    calculate = function(self, card, context)
        -- main_scoring context is used whenever the card is scored
        
        if context.main_scoring and context.cardarea == G.play then
            return {
                G.E_MANAGER:add_event(Event({func = function()
                    -- play_sound('tetorot_yu')
                    card_eval_status_text(card,'extra',nil,nil,nil,{message = "Baka!"})
                    return true end })),

                    -- mult = self.config.mult,
                    -- chips = self.config.chips,
                    -- dollars = self.config.money,
                    x_mult = self.config.x_mult
            }
        end
    end,
}


----------------------------------------------------------
----------- MOD CODE END ---------------------------------