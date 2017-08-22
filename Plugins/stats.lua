	--[[
		#         SPR-CPU 			#
		#       Stats Plugin 		#
		#  Usable by Bot Main Admin #
		#	 Update : 8/May/2017 	#
	]]
	
	function Run(msg, matches)
		if matches[1] == 'stats' and isSudo(msg.sender_user_id_) then
			cli.sendInline('SPRCPU_BOT', msg.chat_id_, msg.id_, 'stats', 0)
		end
	end
	function ApiRun(msg, matches)
		if matches[1] == 'stats' and isFull(msg.from.id) then
			StatS = '\n'
			..'@SPRCPU\\_CLI :\n'
			..'*> UsersCount* : `'.. redis:scard('Users') .. '`\n'
			..'*> GroupsCount* : `'.. redis:scard('Groups!') .. '`\n'
			..'\n*SuperSearchBot*\n'
			..'*> UsersCount* : `'.. redis:scard('SuperSearchBot:Users') .. '`\n'
			..'*Server Stats :*'
			..'\n*Memmory *: \n'
			..'```'..io.popen('free -m'):read('*all')..'```\n\n'
			..'\n*Uptime*:\n```' .. io.popen('uptime'):read('*all') .. '```'
			..'\n\n\n' .. '@SPRCPU\\_Company'
			RESULTS = {
				{
					type = 'article',
					id = '0',
					description = URL.escape('Bot Stats!'),
					title = URL.escape('Stats !'),
					input_message_content = {
						message_text = ('Stats :\n'.. StatS),
						parse_mode = 'Markdown',
						disable_web_page_preview = true
					}
				}
			}
			api.answerInlineQuery(_Config.TOKEN, msg.id, JSON.encode(RESULTS), 0, true)
		end
	end
	return {
		HELP = {
			NAME = { 
				fa = 'Stats',
				en = 'Stats !',
				call = 'stats',
			},
			Dec = {
				fa = 'NIL',
				en = 'NIL',
			},
			Usage = {
				fa = 'NIL',
				en = 'NIL',
			},
			rank = 'NIL',
		},
		cli = {
			_MSG = {
				'^(stats)$',

			},
	--		Pre = Pre,
			run = Run
		},
		api = {
			_MSG = {
			'!#MessageQuery (stats)$',

			},
	--		Pre = ApiPre,
			run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
		Rank = 'Sudo' -- Just Usable By Sudo !
	}
	-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	-- Plugin Written By @Reload_Life !
	-- SPR-CPU.IR 					  !
	-- t.me/SPRCPU_Company			  !
	-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!