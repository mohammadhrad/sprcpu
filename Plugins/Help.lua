	Run = function (msg, matches)
	if #matches > 0 then
		if matches[1]:lower() == 'help' then
			cli.sendInline('SPRCPU_BOT', msg.chat_id_, msg.id_, 'Help', 0)
		end
	end
	end
	ApiRun = function (msg, matches)
		LANG = (redis:get(msg.from.id..'Lang') or 'fa')
		if matches[1] == 'MessageQuery Help' then
			RESULTS = {
				{
					type = 'article',
					id = '0',
					description = 'Help !',
					title = 'Help !',
					input_message_content = {
						message_text = 'Help\nراهنما!',
						parse_mode = 'Markdown',
						disable_web_page_preview = true
					},
					reply_markup = {
						inline_keyboard = {
							{
								{ text='Show|نمایش !', callback_data='Help2' }
							}
						}
					},
					--thumb_url = '',
				}
			}
			api.answerInlineQuery(_Config.TOKEN, msg.id, JSON.encode(RESULTS), 0, true, 'استارت کردن ربات !', 'start')
		end
		
		if matches[1] == 'MessageCall Help' then
				if matches[2] == 'bc' then
					Desc = plugins.bc.HELP.Dec
					Usage= plugins.bc.HELP.Usage
					Name = plugins.bc.HELP.NAME
					Rank = plugins.bc.HELP.rank
				elseif matches[2] == 'buyspr' then
					Desc = plugins.buyspr.HELP.Dec
					Usage= plugins.buyspr.HELP.Usage
					Name = plugins.buyspr.HELP.NAME
					Rank = plugins.buyspr.HELP.rank
				elseif matches[2] == 'Checker' then
					Desc = plugins.Checker.HELP.Dec
					Usage= plugins.Checker.HELP.Usage
					Name = plugins.Checker.HELP.NAME
					Rank = plugins.Checker.HELP.rank
				elseif matches[2] == 'clean' then
					Desc = plugins.clean.HELP.Dec
					Usage= plugins.clean.HELP.Usage
					Name = plugins.clean.HELP.NAME
					Rank = plugins.clean.HELP.rank
				elseif matches[2] == 'getgroup' then
					Desc = plugins.HELP.getgroup.HELP.Dec
					Usage= plugins.HELP.getgroup.HELP.Usage
					Name = plugins.HELP.getgroup.HELP.NAME
					Rank = plugins.HELP.getgroup.HELP.rank
				elseif matches[2] == 'Help' then
					Desc = plugins.Help.HELP.Dec
					Usage= plugins.Help.HELP.Usage
					Name = plugins.Help.HELP.NAME
					Rank = plugins.Help.HELP.rank
				elseif matches[2] == 'ID' then
					Desc = plugins.ID.HELP.Dec
					Usage= plugins.ID.HELP.Usage
					Name = plugins.ID.HELP.NAME
					Rank = plugins.ID.HELP.rank
				elseif matches[2] == 'info' then
					Desc = plugins.info.HELP.Dec
					Usage= plugins.info.HELP.Usage
					Name = plugins.info.HELP.NAME
					Rank = plugins.info.HELP.rank
				elseif matches[2] == 'moderation' then
					Desc = plugins.moderation.HELP.Dec
					Usage= plugins.moderation.HELP.Usage
					Name = plugins.moderation.HELP.NAME
					Rank = plugins.moderation.HELP.rank
				elseif matches[2] == 'panel' then
					Desc = plugins.panel.HELP.Dec
					Usage= plugins.panel.HELP.Usage
					Name = plugins.panel.HELP.NAME
					Rank = plugins.panel.HELP.rank
				elseif matches[2] == 'PV' then
					Desc = plugins.PV.HELP.Dec
					Usage= plugins.PV.HELP.Usage
					Name = plugins.PV.HELP.NAME
					Rank = plugins.PV.HELP.rank
				elseif matches[2] == 'set' then
					Desc = plugins.set.HELP.Dec
					Usage= plugins.set.HELP.Usage
					Name = plugins.set.HELP.NAME
					Rank = plugins.set.HELP.rank
				elseif matches[2] == 'settings' then
					Desc = plugins.settings.HELP.Dec
					Usage= plugins.settings.HELP.Usage
					Name = plugins.settings.HELP.NAME
					Rank = plugins.settings.HELP.rank
				elseif matches[2] == 'stats' then
					Desc = plugins.stats.HELP.Dec
					Usage= plugins.stats.HELP.Usage
					Name = plugins.stats.HELP.NAME
					Rank = plugins.stats.HELP.rank
				elseif matches[2] == 'Sudo' then
					Desc = plugins.Sudo.HELP.Dec
					Usage= plugins.Sudo.HELP.Usage
					Name = plugins.Sudo.HELP.NAME
					Rank = plugins.Sudo.HELP.rank
				else
					Desc = plugins.PV.HELP.Dec
					Usage= plugins.PV.HELP.Usage
					Name = plugins.PV.HELP.NAME
					Rank = plugins.PV.HELP.rank
				end

				if Rank == 'sudo' then
			if msg.message then
				if msg.message.chat then
					if msg.message.chat.type == 'private' then
						reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'startpage' }}}}

					else
						reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'Help2' }}}}
					end
				else
					reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'Help2' }}}}
				end
			else
				reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'Help2' }}}}
			end
					
					if isSudo(msg.from.id) then
						if LANG == 'fa' then
							Text = 'نام پلاگین : '.. Name.fa
							..'\nتوظیحات  : '.. Desc.fa
							..'\nنوع استفاده  : '.. Usage.fa
						else
							Text = 'Plugin Name : '.. Name.en
							..'\nDescription  : '.. Desc.en
							..'\nUsage  : '.. Usage.en
						end
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, Text, 'md', reply_markup)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, Text, 'md', reply_markup)
						end
					else
						if LANG == 'fa' then
							TexT = 'شما به این پلاگین دسترسی ندارید !'
						else
							TexT = 'No Access to this Plugin !'
						end
						api.answerCallbackQuery(_Config.TOKEN, msg.id, TexT, true)
					end
				elseif Rank == 'full' then
			if msg.message then
				if msg.message.chat then
					if msg.message.chat.type == 'private' then
						reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'startpage' }}}}

					else
						reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'Help2' }}}}
					end
				else
					reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'Help2' }}}}
				end
			else
				reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'Help2' }}}}
			end
					if isFull(msg.from.id) then
						if LANG == 'fa' then
							Text = 'نام پلاگین : '.. Name.fa
							..'\nتوظیحات  : '.. Desc.fa
							..'\nنوع استفاده  : '.. Usage.fa
						else
							Text = 'Plugin Name : '.. Name.en
							..'\nDescription  : '.. Desc.en
							..'\nUsage  : '.. Usage.en
						end
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, Text, 'md', reply_markup)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, Text, 'md', reply_markup)
						end
					else
						if LANG == 'fa' then
							TexT = 'شما به این پلاگین دسترسی ندارید !'
						else
							TexT = 'No Access to this Plugin !'
						end
						api.answerCallbackQuery(_Config.TOKEN, msg.id, TexT, true)
					end
				else
			if msg.message then
				if msg.message.chat then
					if msg.message.chat.type == 'private' then
						reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'startpage' }}}}

					else
						reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'Help2' }}}}
					end
				else
					reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'Help2' }}}}
				end
			else
				reply_markup = {inline_keyboard = { {{ text = 'Back', callback_data = 'Help2' }}}}
			end
					if LANG == 'fa' then
						Text = 'نام پلاگین : '.. Name.fa
						..'\nتوظیحات  : '.. Desc.fa
						..'\nنوع استفاده  : '.. Usage.fa
					else
						Text = 'Plugin Name : '.. Name.en
						..'\nDescription  : '.. Desc.en
						..'\nUsage  : '.. Usage.en
					end
					if msg.inline_message_id then
						api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, Text, 'md', reply_markup)
					else
						api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, Text, 'md', reply_markup)
					end
				end
			end

			if matches[1] == 'MessageCall Help2' then
				if (redis:get(msg.from.id..'Lang') or 'fa') == 'en' then
					Text, TexT = 'General Help!\n Use buttens :-)', 'General Help !'
					reply_markup = {
						inline_keyboard = {}
					}
				else
					Text, TexT = 'راهنمای عمومی ربات !\nاز دکمه ها استفاده کنید !', 'راهنمای عمومی ربات !'
					reply_markup = {
						inline_keyboard = {}
					}
				end
				for k, v in pairs(plugins) do
					if v.HELP.rank ~= "NIL" then
						if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then 
							Table = { {text = v.HELP.NAME.fa, callback_data = 'Help '..v.HELP.NAME.call} }
						else
							Table = { {text = v.HELP.NAME.en, callback_data = 'Help '..v.HELP.NAME.call} }
						end
						table.insert(reply_markup.inline_keyboard, Table)
						Table = {}
					end
				end
				api.answerCallbackQuery(_Config.TOKEN, msg.id, TexT, true)
				if msg.inline_message_id then
					api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, Text, 'md', reply_markup)
				else
					api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, Text, 'md', reply_markup)
				end
			end
	end


	return {
		HELP = {
			NAME = { 
				fa = 'راهنما !',
				en = 'Help !',
				call = 'Help',
			},
			Dec = {
				fa = 'راهنمای استفاده از قابلیت ها',
				en = 'Help for Plugins !',
			},
			Usage = {
				fa = '`help` : نمایش این لیست',
				en = '`help` : show this list',
			},
			rank = 'Member',
		},
		----------------------------
		cli = {
			_MSG = {
				'^([Hh]elp)$',
				'^[/!#]([Hh]elp)$',
			},
		--	Pre = Pre,
			run = Run
		},
		api = {
			_MSG = {
				'^!#(MessageCall Help2)$',
				'^!#(MessageCall Help2) (.*)$',
				'^!#(MessageQuery Help)$',
				'^!#(MessageCall Help)$',
				'^!#(MessageCall Help) (.*)$',
			},
		--	Pre = ApiPre,
			run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}