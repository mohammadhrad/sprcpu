do
local _ = {
		TOKEN = 'TOKEN', 
		PayIRKey = "", -- GET From https://Pay.IR
		APITOKEN = "", -- GET From https://api.reloadlife.me/#Code
		MainSudo = 0, -- Main SUDO
		BotID = 0, -- CLI BOT ID
		Sudo = {
			0, -- SUDOS
			0 -- API BOT ID
		},
		Plugins = {
			'Checker', -- MUST BE FIRST FOR SPEED :)
			'Sudo',
			'PV',
			'buyspr',
			'stats',
			'moderation',
			'set',
			'bc',
			'getgroup',
			'info',
			'panel',
			'settings',
			'ID',
			'clean',
			'Help'
		}
}
return _
end