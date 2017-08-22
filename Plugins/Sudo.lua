	--[[
		#         SPR-CPU 			#
		#       Sudo Plugin 		#
		#  Usable by Bot Main Admin #
		#	 Update : 8/May/2017 	#
	]]
	function Run(msg, matches)
		if #matches > 0 then
			if isSudo(msg.sender_user_id_) then
				if matches[1]:lower() == 'reload' then -- //Reload Cli Bot
					LoadPlugins ()
					return Language(msg.sender_user_id_,
						'`>` *Bot reloaded Success !*\n'
						..'`>` *See Reload Logs In* @F80\\_Logs\n'
					)
				end
				if matches[1]:lower() == 'reloadapi' then -- //Reload Api Bot !
				--	LoadPlugins ()
					cli.sendInline('SPRCPU_BOT', msg.chat_id_, msg.id_, 'reload', 0)
				end
			else
				return Language(msg.sender_user_id_, 
					'`>` *Error 403!*\n'
					..'`>` *Access is Denied !*'
				)
			end
		end
	end
	function ApiRun(msg, matches)
		if #matches > 0 then
			if msg.query then
				if isSudo(msg.from.id) then
					if matches[1]:lower() == 'reload' then
						RESULTS = {
							{
								type = 'article',
								id = '0',
								description = Language(msg.from.id, 
									'Click To Send Reload Message !'
								),
								title = Language(msg.from.id, 'Reload'),
								input_message_content = {
									message_text = Language(msg.from.id, 
										'If Your Sudo, Touch to Reload Me 🤧.'
									),
									parse_mode = 'Markdown',
									disable_web_page_preview = true
								},
								reply_markup = {
									inline_keyboard = {
										{
											{ text = Language(msg.from.id, 'Reload'), callback_data = 'reload' }
										}
									}
								},
								thumb_url = 'http://spr-cpu.ir/reloadlife/loading.png', -- /A Butful Picture :)
							}
						}
						api.answerInlineQuery(_Config.TOKEN, msg.id, JSON.encode(RESULTS), 0, true, 'Reload In PV', 'reload')
					end
				else
					RESULTS = {
							{
								type = 'article',
								id = '0',
								description = Language(msg.from.id, 
									'`>` *Error 403!*\n'
									..'`>` *Access is Denied !*'
								):gsub('*',''):gusb('`',''),
								title = Language(msg.from.id, 'Reload'),
								input_message_content = {
									message_text = Language(msg.from.id, 
										'`>` *Error 403!*\n'
										..'`>` *Access is Denied !*'
									),
									parse_mode = 'Markdown',
									disable_web_page_preview = true
								},
								thumb_url = 'http://spr-cpu.ir/reloadlife/loading.png',
							}
						}
						api.answerInlineQuery(_Config.TOKEN, msg.id, JSON.encode(RESULTS), 0, true)
				end
			elseif msg.data then
				if isSudo(msg.from.id) then
					if matches[1]:lower() == 'reload' then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'Reloaded Success !'), true)
						LoadPlugins ()
					end
				else
					api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 
						'`>` *Error 403!*\n'
						..'`>` *Access is Denied !*'
					):gsub('*',''):gusb('`',''), true)
				end
			end
		end
	end

	return {
		HELP = {
			NAME = { 
				fa = 'مدیریت کل',
				en = 'Sudo !',
				call = 'Sudo',
			},
			Dec = {
				fa = 'یک افزونه کار آمد برای مدیر کل ربات !',
				en = 'A Professional Plugin For Full Access Admin !',
			},
			Usage = {
				fa = '\n*"InlineMessage"* Reload : _بارگذاری مجدد ربات_\n'
				..'#Reload : _بارگذاری ربات _\n'
				..'#Reloadapi : _بارگذاری مجدد ربات _\n',
				en = '\n*"InlineMessage"* Reload : _Reload _\n'
				..'#Reload : _Reload _\n'
				..'#Reloadapi : _Reload _\n',
			},
			rank = 'sudo',
		},
		cli = {
			_MSG = {
				'^[/!#]([Rr]eload)$',
				'^([Rr]eload)$',
				'^[/!#]([Rr]eloadapi)$',
				'^([Rr]eloadapi)$',
			},
			run = Run
		},
		api = {
			_MSG = {
				'!#MessageQuery ([Rr]eload)$',
				'!#MessageCall ([Rr]eload)$',
			},
			run = ApiRun
		},
		CheckMethod = 'F80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron,
		Rank = 'Sudo'  -- Only is Usable By Bot SUDO!!
	}
	-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	-- Plugin Written By @Reload_Life !
	-- SPR-CPU.IR 					  !
	-- t.me/SPRCPU_Company			  !
	-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!