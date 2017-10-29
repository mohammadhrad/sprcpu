	--[[
		#         SPR-CPU 			#
		#       PV Plugin 			#
		#  	Usable by Bot All Users #
		#	 Update : 8/May/2017 	#
	]]
	function Pre(msg)
		if not msg.USER.user_.type_.ID == 'UserTypeBot' then
			if not tostring(msg.chat_id_ or msg.sender_user_id_):match('-') then
			cli.deleteChatHistory((msg.chat_id_ or msg.sender_user_id_), 1)
					text = '> `Hello !`\n'
					..'*I\'m Bot\'s GroupManager bot *!\n'
					..'_My Name Is Bot New TG !_\n'
					..'`Message to` @BaPal\\_Bot `to Get More Information !`\n'
					..'`-----------------`\n'
					.."> `سلام !`\n"
					..'*من ربات مدیریت گروه تیم پی وی مسنجر هستم !*\n'
					..'`برای دریافت اطلاعات بیشتر به` @BaPal\\_Bot `پیام دهید !`\n'
					..'@PvMessenger !\n'
				return text
			end
		else
		end
	end
	------------------------------
	function ApiRun(msg, matches)
		if #matches > 0 then
			if matches[1]:lower() == 'start' then
				if msg.chat.type == 'private' then
						TEXT = Language(msg.from.id, "START_P")
						reply_markup = {
							inline_keyboard = {
								{
									{text = Language(msg.from.id, 'About Us'), callback_data = 'aboutus'}, {text= Language(msg.from.id, 'Help'), callback_data = 'Help PV'}
								},
								{
									{text = Language(msg.from.id, 'Charge'), callback_data = 'buy spr'},{text = Language(msg.from.id, 'Get Group'), callback_data = 'get gp'}
								},
								{
									{text = Language(msg.from.id, 'Support'), callback_data = 'ticket'},
								},
								{
									{text = Language(msg.from.id, 'Rules'), callback_data = 'rules'}
								},
								{
									{text = Language(msg.from.id, 'Change Language'), callback_data = 'change lang'}
								}
							}
						}
						if redis:scard(msg.from.id..'Chats') > 0 then
							table.insert(reply_markup.inline_keyboard, {{text=Language(msg.from.id, 'Group_List'), callback_data = 'groups'}})
						end
						if isFull(msg.from.id) then
							table.insert(reply_markup.inline_keyboard, {{text=Language(msg.from.id, 'Panel'), callback_data = 'panel'}})
						end
					api.sendMessage(_Config.TOKEN, msg.chat.id, TEXT, 'md', reply_markup, msg.message_id, false)
				end
			end
		end
		if msg.data then
			if #matches > 0 then
				if matches[1] == 'buy spr' then
					Language(msg.from.id, "BUY_SPR_TEXT")
						keyboard = {
							inline_keyboard = { 
								{
									{ 
										text = '100 SPR',
										callback_data = '100 SPR'
								    },
								    { 
										text = '1000 SPR',
										callback_data = '1000 SPR'
								    }
								},
								{
									{ 
										text = '200 SPR',
										callback_data = '200 SPR'
								    }
								    ,
								    { 
										text = '2000 SPR',
										callback_data = '2000 SPR'
								    }
								},
								{
									{ 
										text = '300 SPR',
										callback_data = '300 SPR'
								    },
								    { 
										text = '3000 SPR',
										callback_data = '3000 SPR'
								    }
								},
								{
									{ 
										text = '400 SPR',
										callback_data = '400 SPR'
								    },
								    { 
										text = '4000 SPR',
										callback_data = '4000 SPR'
								    }
								},
								{
									{ 
										text = '500 SPR',
										callback_data = '500 SPR'
								    },
								    { 
										text = '5000 SPR',
										callback_data = '5000 SPR'
								    }
								},
								{
									{ 
										text = Language(msg.from.id, "Back"),
										callback_data = 'startpage'
									}
								},
							}
						}
					api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, text, 'md', keyboard)
				end
				----------------------------------
				if matches[1] == 'startpage' then
					TEXT = Language(msg.from.id, "START_P")
						reply_markup = {
							inline_keyboard = {
								{
									{text = Language(msg.from.id, 'About Us'), callback_data = 'aboutus'}, {text= Language(msg.from.id, 'Help'), callback_data = 'Help PV'}
								},
								{
									{text = Language(msg.from.id, 'Charge'), callback_data = 'buy spr'},{text = Language(msg.from.id, 'Get Group'), callback_data = 'get gp'}
								},
								{
									{text = Language(msg.from.id, 'Support'), callback_data = 'ticket'}--,{text = Language(msg.from.id, 'TeamInfo'), callback_data = 'team info'}
								},
								{
									{text = Language(msg.from.id, 'Rules'), callback_data = 'rules'}
								},
								{
									{text = Language(msg.from.id, 'Change Language'), callback_data = 'change lang'}
								}
							}
						}
						if redis:scard(msg.from.id..'Chats') > 0 then
							table.insert(reply_markup.inline_keyboard, {{text=Language(msg.from.id, 'Group_List'), callback_data = 'groups'}})
						end
						if isFull(msg.from.id) then
							table.insert(reply_markup.inline_keyboard, {{text=Language(msg.from.id, 'Panel'), callback_data = 'panel'}})
						end
					api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
				end
				----------------------------------
				if matches[1] == 'change lang' then
					if redis:get(msg.from.id..'Lang') then
						if redis:get(msg.from.id..'Lang') == 'fa' then
							redis:set(msg.from.id..'Lang', 'en')
						else
							redis:set(msg.from.id..'Lang', 'fa')
						end
					else
						redis:set(msg.from.id..'Lang', 'en')
					end
					----------------------------------------------------------------
					TEXT = Language(msg.from.id, "START_P")
						reply_markup = {
							inline_keyboard = {
								{
									{text = Language(msg.from.id, 'About Us'), callback_data = 'aboutus'}, {text= Language(msg.from.id, 'Help'), callback_data = 'Help PV'}
								},
								{
									{text = Language(msg.from.id, 'Charge'), callback_data = 'buy spr'},{text = Language(msg.from.id, 'Get Group'), callback_data = 'get gp'}
								},
								{
									{text = Language(msg.from.id, 'Support'), callback_data = 'ticket'}--,{text = Language(msg.from.id, 'TeamInfo'), callback_data = 'team info'}
								},
								{
									{text = Language(msg.from.id, 'Rules'), callback_data = 'rules'}
								},
								{
									{text = Language(msg.from.id, 'Change Language'), callback_data = 'change lang'}
								}
							}
						}
						if redis:scard(msg.from.id..'Chats') > 0 then
							table.insert(reply_markup.inline_keyboard, {{text=Language(msg.from.id, 'Group_List'), callback_data = 'groups'}})
						end
						if isFull(msg.from.id) then
							table.insert(reply_markup.inline_keyboard, {{text=Language(msg.from.id, 'Panel'), callback_data = 'panel'}})
						end
					api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
				end
				if matches[1] == 'rules' then
					if (redis:get(msg.message.chat.id..'Lang') or 'fa') == 'fa' then
						TEXT = Language(msg.from.id, "RULES_TEXT")
						reply_markup = {
							inline_keyboard = {
								{
									{ 
										text = Language(msg.from.id, "Back"),
										callback_data = 'startpage'
									}
								}
							}
						}
					api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
				end
			end
		end
	end
	end
	return {
		HELP = {
			NAME = { 
				fa = 'پیوی',
				en = 'Pv !',
				call = 'PV',
			},
			Dec = {
				fa = 'پیلاگین خصوصی',
				en = 'Private Message',
			},
			Usage = {
				fa = 'از این پلاگین در چت خصوصی @BaPal\\_Bot استفاده کنید !',
				en = 'Use This Plugin in @SprCpu\\_Bot\'s Private :-)',
			},
			rank = 'NIL',
		},
		cli = {
			_MSG = {
				--Patterns :)
				'^(.*)$'
			},
			Pre = Pre,
	--		run = Run
		},
		api = {
			_MSG = {
				--Patterns :)
				'^([Ss]tart)$',
				'^!#MessageCall (startpage)$',
				'^!#MessageCall (buy spr)$',
				'^!#MessageCall (change lang)$',
				'^!#MessageCall (rules)$',
				'^!#MessageCall (ReloadLife)$',
				'^!#MessageCall (DonRabbit)$',
				'^[/!#]([Ss]tart)$',
				'^([Ss]tart) (.*)$',
				'^[/!#]([Ss]tart) (.*)$',
			},
	--		Pre = ApiPre,
			run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}
	-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	-- Plugin Written By @Reload_Life !
	-- SPR-CPU.IR 					  !
	-- t.me/SPRCPU_Company			  !
	-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
