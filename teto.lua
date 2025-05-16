--- STEAMODDED HEADER
--- MOD_NAME: Tetorot
--- MOD_ID: Tetorot
--- MOD_AUTHOR: Arx
--- MOD_DESCRIPTION: Yu!
--- PREFIX: tetorot
----------------------------------------------------------
----------- MOD CODE -------------------------------------

if not Tetomod then
	Tetomod = {}
end

local mod_path = "" .. SMODS.current_mod.path
Tetomod.path = mod_path
Tetomod = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
}

-- Teto joker pool
SMODS.ObjectType({
	key = "Tetorot",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

--Load Teto Files
local files = NFS.getDirectoryItems(mod_path .. "tetos")
for _, file in ipairs(files) do
	print("[TETOROT] Loading lua file.. Yu! " .. file)
	local f, err = SMODS.load_file("tetos/" .. file)
	if err then
		error(err) 
	end
	f()
end

----------------------------------------------------------
----------- MOD CODE END ----------------------------------