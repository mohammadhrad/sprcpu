	--[[
		#         SPR-CPU 			#
		#       Settings Plugin 	#
		#  	Usable by Bot Mods+     #
		#	 Update : 8/May/2017 	#
	]]

	http = require "socket.http" -- //For Some APIS
		--\\ Requies
		StatsGET = function (X, Chat_ID)
			if X == 'OK' then
		 		return Language(Chat_ID, '🗽Allow')
		 	elseif X == 'DEL' then
				return Language(Chat_ID, '🗑Clean')
			elseif X == 'WARN' then
				return Language(Chat_ID, '⚠️Warn')
			else
				return X
			end
		end
		ChangeStats = function(X, Y)
			chat_id = Y
			Stats = X
			GP = redis:hgetall(chat_id)
			if redis:hget(Y, X) == 'OK' then
				NewStats = 'DEL'
			elseif redis:hget(Y, X) == 'DEL' then
				NewStats = 'WARN'
			elseif redis:hget(Y, X) == 'WARN' then
				NewStats = 'OK'
			else
				NewStats = 'DEL'
			end
			redis:hset(Y, Stats, NewStats)
		end
	-- \\ End
	function Run(msg, matches)
		if matches[1] == 'settings' then 
			if isMod(msg.sender_user_id_, msg.chat_id_) then
				cli.sendInline('BaPal_BOT', msg.chat_id_, msg.id_, 'Group '..(msg.chat_id_ or msg.chat_id_ or msg.to.id or '-100TEST'), 0) -- // To Get Group Settings By CLI Bot!
			else
				return Language('`>` *Error 403!*\n'
			..'`>` *Access is Denied !*')
			end
		end
	end

	function ApiRun(msg, matches)
		if #matches > 0 then
			if msg.query then
				if matches[1] == 'Group' then
					if tonumber(msg.from.id) == (_Config.BotID) or isMod(msg.from.id, matches[2]) then -- is Usable By Group Mods And CLI BOT !!
						chat_id = matches[2]
						user_id = msg.from.id
						GP = redis:hgetall(chat_id)
							TEXT = Language(chat_id, 'SETTTINGS'):format(
								tostring(chat_id),
								tostring(MarkScape(getUserInfo( GP.Owner or 'NoOwner' ))),
								tostring(( GP.AdminCount or '0' )),
								tostring(( GP.MembersCount or '0' )),
								tostring(( GP.Blocked or '0' )),
								tostring(( GP.About or '' )),
								tostring(( GP.Title or '' )),
								tostring(( GP.GroupLink or '' ))
							)
							Desc = Language(chat_id, 'Show Group Info !')
							Title = ( GP.Title or chat_id )
							TEXT_Start = 'Start Bot'
							TEXT_Key = Language(chat_id, 'Open Settings !')
							url =  'http://spr-cpu.ir/reloadlife/404imagenotfound.png'
						RESULTS = {
							{
								type = 'article',
								id = '0',
								description = (Desc),
								title = (Title),
								input_message_content = {
									message_text = (TEXT),
									parse_mode = 'Markdown',
									disable_web_page_preview = true
								},
								reply_markup = {
									inline_keyboard = {
										{
											{ text = TEXT_Key, callback_data = 'settings '..chat_id }
										}
									}
								},
								thumb_url = url,
							}
						}
					--	if isSudo(msg.from.id) then
					--		table.insert(RESULTS[1].reply_markup.inline_keyboard, { { text = 'Delete And Leave Group', callback_data = 'LeavE '..matches[2] } })
					--	end
					-- Leave buttom Disabled 
					-- it will enable after update message by sudo Command!
						api.answerInlineQuery(_Config.TOKEN, msg.id, JSON.encode(RESULTS), 0, true, TEXT_Start, 'start')
					end
				end
			end

			-- Help == '[‮‮‮‮‮‮‮‮‮‮‮‮‮‮‮‮‮‮‮‮⁩](http://telegra.ph/'..  ..')' 

			if msg.text then
				if matches[1] == 'settings' and isMod(msg.from.id, msg.chat.id) then -- Get Settings While API Bot is in your Group !
					chat_id = msg.chat.id
					user_id = msg.from.id
					GP = redis:hgetall(chat_id)
					TEXT_Key = Language(chat_id, 'Open Settings !')
					TXT = Language(chat_id, 'SETTTINGS'):format(tostring(chat_id),tostring(MarkScape(getUserInfo( GP.Owner or 'NoOwner' ))),tostring(( GP.AdminCount or '0' )),tostring(( GP.MembersCount or '0' )),tostring(( GP.Blocked or '0' )),tostring(( GP.About or '' )),tostring(( GP.Title or '' )),tostring(( GP.GroupLink or '' )))
					Rm = {
						inline_keyboard = {
							{
								{ text = TEXT_Key, callback_data = 'settings '..chat_id }
							}
						}
					}

					api.sendMessage(_Config.TOKEN, msg.chat.id, TXT, 'md', Rm, msg.message_id, false)
				end
			end

			if msg.data then
			if matches[1] == 'PLUS' then
					if not isMod(msg.from.id, matches[3]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						local Y = matches[2]
						local chat_id = matches[3]
						local nownum = Y
						if Y == 'FastMessageCount' then
						local NUM = tonumber(redis:hget(chat_id, nownum) or 5)
							if NUM > 9 then	
								api.answerCallbackQuery(_Config.TOKEN, msg.id, 'Error BigNumber !', true)
							else
								redis:hset(chat_id, Y, NUM + 1)	
							end
						end
						if Y == 'FastMessageTime' then
						local NUM = tonumber(redis:hget(chat_id, nownum) or 2)
							if NUM > 5 then	
								api.answerCallbackQuery(_Config.TOKEN, msg.id, 'Error BigNumber !', true)
							else
								redis:hset(chat_id, Y, NUM + 1)
							end
						end
						if Y == 'LongCharrC' then
						local NUM = tonumber(redis:hget(chat_id, nownum) or 400)
							if NUM > 4999 then	
								api.answerCallbackQuery(_Config.TOKEN, msg.id, 'Error BigNumber !', true)
							else
								redis:hset(chat_id, Y, NUM + 25)
							end
						end
						if Y == 'ShortCharrC' then
						local NUM = tonumber(redis:hget(chat_id, nownum) or 2)
							if NUM > 18 then	
								api.answerCallbackQuery(_Config.TOKEN, msg.id, 'Error BigNumber !', true)
							else
								redis:hset(chat_id, Y, NUM + 2)
							end
						end
					Group = redis:hgetall(matches[3])
					TEXT = Language(chat_id, 'FLOOD_S'):format(
							(Group.FastMessageTime or '2'),
							(Group.FastMessageCount or '5'),
							(Group.LongCharrC or '500'),
							(Group.ShortCharrC or '0')
						)
						keyboard = { inline_keyboard = {
							{ 	
								{text = Language(chat_id, 'Flood'), callback_data = 'INFO FLOOD '..chat_id..' F'},
								{text = StatsGET(Group.FastMessage or 'OK', chat_id), callback_data = 'Change FastMessage '..chat_id..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS FastMessageTime '..chat_id..' F'
								},
								{
									text = tostring(Group.FastMessageTime or 2)..' CheckTime',
									callback_data = 'INFO FastMessageTime '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL FastMessageTime '..chat_id..' F'
								},
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS FastMessageCount '..chat_id..' F'
								},
								{
									text = tostring(Group.FastMessageCount or 2)..'MessageCount',
									callback_data = 'INFO FastMessageCount '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL FastMessageCount '..chat_id..' F'
								},
							},
							{ 	
								{text = Language(chat_id, 'LongMessage'), callback_data = 'INFO LongCharr '..chat_id..' F'},
								{text = StatsGET(Group.LongCharr or 'OK', chat_id), callback_data = 'Change LongCharr '..chat_id..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS LongCharrC '..chat_id..' F'
								},
								{
									text = tostring(Group.LongCharrC or 500),
									callback_data = 'INFO LongCharrC '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL LongCharrC '..chat_id..' F'
								},
							},
							{ 
								{text = Language(chat_id, 'ShortMessage'), callback_data = 'INFO ShortCharr '..chat_id..' F'},
								{text = StatsGET(Group.ShortCharr or 'OK', chat_id), callback_data = 'Change ShortCharr '..chat_id..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS ShortCharrC '..chat_id..' F'
								},
								{
									text = tostring(Group.ShortCharrC or 5),
									callback_data = 'INFO ShortCharrC '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL ShortCharrC '..chat_id..' F'
								},
							},
							{ 
								{ text = 'Back', callback_data = 'settings '..chat_id }
							}
						} }
					--------------------------------------------------------------------------------------
					if msg.inline_message_id then
						api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
					else
						api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
					end
					end
				end
				if matches[1] == 'EGUL' then
					if not isMod(msg.from.id, matches[3]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						local Y = matches[2]
						local chat_id = matches[3]
						local nownum = Y
						if Y == 'FastMessageCount' then
						local NUM = tonumber(redis:hget(chat_id, nownum) or 5)
							if NUM < 2 then	
								api.answerCallbackQuery(_Config.TOKEN, msg.id, 'Error SmallNumber !', true)
							else
								redis:hset(chat_id, Y, NUM - 1)	
							end
						end
						if Y == 'FastMessageTime' then
						local NUM = tonumber(redis:hget(chat_id, nownum) or 2)
							if NUM < 2 then	
								api.answerCallbackQuery(_Config.TOKEN, msg.id, 'Error SmallNumber !', true)
							else
								redis:hset(chat_id, Y, NUM - 1)
							end
						end
						if Y == 'LongCharrC' then
						local NUM = tonumber(redis:hget(chat_id, nownum) or 400)
							if NUM < 400 then	
								api.answerCallbackQuery(_Config.TOKEN, msg.id, 'Error SmallNumber !', true)
							else
								redis:hset(chat_id, Y, NUM - 25)
							end
						end
						if Y == 'ShortCharrC' then
						local NUM = tonumber(redis:hget(chat_id, nownum) or 2)
							if NUM < 2 then	
								api.answerCallbackQuery(_Config.TOKEN, msg.id, 'Error SmallNumber !', true)
							else
								redis:hset(chat_id, Y, NUM - 2)
							end
						end
					--end
					Group = redis:hgetall(matches[3])
					TEXT = Language(chat_id, 'FLOOD_S'):format(
							(Group.FastMessageTime or '2'),
							(Group.FastMessageCount or '5'),
							(Group.LongCharrC or '500'),
							(Group.ShortCharrC or '0')
						)
						keyboard = { inline_keyboard = {
							{ 	
								{text = Language(chat_id, 'Flood'), callback_data = 'INFO FLOOD '..chat_id..' F'},
								{text = StatsGET(Group.FastMessage or 'OK', chat_id), callback_data = 'Change FastMessage '..chat_id..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS FastMessageTime '..chat_id..' F'
								},
								{
									text = tostring(Group.FastMessageTime or 2)..' CheckTime',
									callback_data = 'INFO FastMessageTime '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL FastMessageTime '..chat_id..' F'
								},
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS FastMessageCount '..chat_id..' F'
								},
								{
									text = tostring(Group.FastMessageCount or 2)..'MessageCount',
									callback_data = 'INFO FastMessageCount '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL FastMessageCount '..chat_id..' F'
								},
							},
							{ 	
								{text = Language(chat_id, 'LongMessage'), callback_data = 'INFO LongCharr '..chat_id..' F'},
								{text = StatsGET(Group.LongCharr or 'OK', chat_id), callback_data = 'Change LongCharr '..chat_id..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS LongCharrC '..chat_id..' F'
								},
								{
									text = tostring(Group.LongCharrC or 500),
									callback_data = 'INFO LongCharrC '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL LongCharrC '..chat_id..' F'
								},
							},
							{ 
								{text = Language(chat_id, 'ShortMessage'), callback_data = 'INFO ShortCharr '..chat_id..' F'},
								{text = StatsGET(Group.ShortCharr or 'OK', chat_id), callback_data = 'Change ShortCharr '..chat_id..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS ShortCharrC '..chat_id..' F'
								},
								{
									text = tostring(Group.ShortCharrC or 5),
									callback_data = 'INFO ShortCharrC '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL ShortCharrC '..chat_id..' F'
								},
							},
							{ 
								{ text = 'Back', callback_data = 'settings '..chat_id }
							}
						} }
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end

				if matches[1] == 'Ranks' then
					TEXT = Language(matches[2], '__RANKS__')
						keyboard = { 
							inline_keyboard = {
								{ { text = Language(matches[2], 'Mods List !'), callback_data = 'Mods '.. matches[2]} },  
								{ { text = Language(matches[2], 'Muted List !'), callback_data = 'Muted '.. matches[2]} }, 
								{ { text = Language(matches[2], 'Filterd Words List !'), callback_data = 'Filter '.. matches[2]} }, 
								{ 
									{ text = Language(matches[2], 'Back'), callback_data = 'settings '..matches[2] }
								}
							}
						}
					if msg.inline_message_id then
						api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard, true)
					else
						api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard, true)
					end
				end
				--------------------------------------
				if matches[1] == 'Mods' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						TEXT = Language(matches[2], 'Moderators List_ API')
						keyboard = { 
							inline_keyboard = { 
							}
						}
						for k,v in pairs(redis:smembers('Mods'..matches[2])) do
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = getUserInfo(v):gsub('\\',''), 
											callback_data = 'Demote '..v.. ' "'..matches[2]..'"' 
										} 
									}
								)
							if k == 15 then -- To make it More pages while more than 15 Mods!
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = Language(matches[2], '1️⃣'), 
											callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
										},
										{ 
											text = Language(matches[2], 'NextPage >>'), 
											callback_data = 'NextPageMods "'..matches[2]..'" "16"' 
										},
									}
								)
								break
							end
						end
						table.insert(keyboard.inline_keyboard, {{text=Language(matches[2], 'Back'), callback_data = 'Ranks '..matches[2]}})
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				-------------------------
				if matches[1] == 'NextPageMods' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						TEXT = Language(matches[2], 'Moderators List_ API')
						keyboard = { 
							inline_keyboard = { 
							}
						}
						for k,v in pairs(redis:smembers('Mods'..matches[2])) do
						if tonumber(matches[3]) < 1 or tonumber(matches[3]) > redis:scard('Mods'..matches[2]) then
							for k,v in pairs(redis:smembers('Mods'..matches[2])) do
									table.insert(keyboard.inline_keyboard, 
										{ 
											{ 
												text = getUserInfo(v):gsub('\\',''), 
												callback_data = 'Demote '..v.. ' "'..matches[2]..'"' 
											} 
										}
									)
								if k == 15 then
									table.insert(keyboard.inline_keyboard, 
										{ 
											{ 
												text = '1️⃣', 
												callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
											},
											{ 
												text = Language(matches[2], 'NextPage >>'), 
												callback_data = 'NextPageMods "'..matches[2]..'" "16"' 
											},
										}
									)
									break
								end
							end
						else
							if k > tonumber(matches[3]) then
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = getUserInfo(v):gsub('\\',''), 
											callback_data = 'Demote '..v.. ' "'..matches[2]..'"' 
										} 
									}
								)
							end
							if k == (tonumber(matches[3]) + 10) then
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = Language(matches[2], 'BackPage <<'), 
											callback_data = 'NextPageMods "'..matches[2]..'" "'..(tonumber(matches[3]) - 15)..'"' 
										},
										{ 
											text = tostring(math.floor(tonumber(matches[3]) / 15) + 1), 
											callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
										},
										{ 
											text = Language(matches[2], 'NextPage >>'), 
											callback_data = 'NextPageMods "'..matches[2]..'" "'..((tonumber(matches[3]) + 15))..'"' 
										},
									}
								)
								break
							end
						end
						end
						table.insert(keyboard.inline_keyboard, {{text=Language(matches[2], 'Back'), callback_data = 'Ranks '..matches[2]}})
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				-----------------------------------
				if matches[1] == 'Muted' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						TEXT = Language(matches[2], 'Muted List_ API')
						keyboard = { 
							inline_keyboard = { 
							}
						}
						for k,v in pairs(redis:smembers('Muted'..matches[2])) do
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = getUserInfo(v):gsub('\\',''), 
											callback_data = 'Unmute '..v.. ' "'..matches[2]..'"' 
										} 
									}
								)
							if k == 15 then
								table.insert(keyboard.inline_keyboard, 
									{ 	
										{ 
											text = Language(matches[2], '1️⃣'), 
											callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
										},
										{ 
											text = Language(matches[2], 'NextPage >>'), 
											callback_data = 'NextPageMutes "'..matches[2]..'" "16"' 
										},
										
									}
								)
								break
							end
						end
						table.insert(keyboard.inline_keyboard, {{text=Language(matches[2], 'Back'), callback_data = 'Ranks '..matches[2]}})
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				-------------------------
				if matches[1] == 'NextPageMutes' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						TEXT = Language(matches[2], 'Muted List_ API')
						keyboard = { 
							inline_keyboard = { 
							}
						}
						for k,v in pairs(redis:smembers('Muted'..matches[2])) do
						if tonumber(matches[3]) < 1 then
							for k,v in pairs(redis:smembers('Muted'..matches[2])) do
									table.insert(keyboard.inline_keyboard, 
										{ 
											{ 
												text = getUserInfo(v):gsub('\\',''), 
												callback_data = 'Unmute '..v.. ' "'..matches[2]..'"' 
											} 
										}
									)
								if k == 15 then
									table.insert(keyboard.inline_keyboard, 
										{ 	
											{ 
												text = Language(matches[2], '1️⃣'), 
												callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
											},
											{ 
												text = Language(matches[2], 'NextPage >>'), 
												callback_data = 'NextPageMods "'..matches[2]..'" "16"' 
											},
											
										}
									)
									break
								end
							end
						else
							if k >= tonumber(matches[3]) then
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = getUserInfo(v):gsub('\\',''), 
											callback_data = 'Unmute '..v.. ' "'..matches[2]..'"' 
										} 
									}
								)
							end
							if k == (tonumber(matches[3]) + 15) then
								table.insert(keyboard.inline_keyboard, 
									{ 	
										{ 
											text = Language(matches[2], 'BackPage >>'), 
											callback_data = 'NextPageMutes "'..matches[2]..'" "'..(tonumber(matches[3]) - 15)..'"' 
										},
										{ 
											text = Language(matches[2], math.floor(tonumber(matches[3]) / 15) + 1), 
											callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
										},
										
										{ 
											text = Language(matches[2], 'NextPage >>'), 
											callback_data = 'NextPageMutes "'..matches[2]..'" "'..(tonumber(matches[3]) + 15)..'"' 
										},
									}
								)
								break
							end
						end
						end
						table.insert(keyboard.inline_keyboard, {{text=Language(matches[2], 'Back'), callback_data = 'Ranks '..matches[2]}})
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				if matches[1] == 'Filter' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						TEXT = Language(matches[2], 'Filterlist List_ API')
						keyboard = { 
							inline_keyboard = { 
							}
						}
						for k,v in pairs(redis:smembers('Filterlist'..matches[2])) do
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = getUserInfo(v):gsub('\\',''), 
											callback_data = 'Unfilter '..v.. ' "'..matches[2]..'"' 
										} 
									}
								)
							if k == 15 then
								table.insert(keyboard.inline_keyboard, 
									{ 	
										{ 
											text = Language(matches[2], '1️⃣'), 
											callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
										},
										{ 
											text = Language(matches[2], 'NextPage >>'), 
											callback_data = 'NextPageFilterlist "'..matches[2]..'" "16"' 
										},
										
									}
								)
								break
							end
						end
						table.insert(keyboard.inline_keyboard, {{text=Language(matches[2], 'Back'), callback_data = 'Ranks '..matches[2]}})
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				-------------------------
				if matches[1] == 'NextPageFilterlist' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						TEXT = Language(matches[2], 'Filterlist List_ API')
						keyboard = { 
							inline_keyboard = { 
							}
						}
						for k,v in pairs(redis:smembers('Filterlist'..matches[2])) do
						if tonumber(matches[3]) < 1 then
							for k,v in pairs(redis:smembers('Filterlist'..matches[2])) do
									table.insert(keyboard.inline_keyboard, 
										{ 
											{ 
												text = getUserInfo(v):gsub('\\',''), 
												callback_data = 'Unfilter '..v.. ' "'..matches[2]..'"' 
											} 
										}
									)
								if k == 15 then
									table.insert(keyboard.inline_keyboard, 
										{ 
											
											{ 
												text = Language(matches[2], '1️⃣'), 
												callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
											},
											{ 
												text = Language(matches[2], 'NextPage >>'), 
												callback_data = 'NextPageFilterlist "'..matches[2]..'" "16"' 
											},
										}
									)
									break
								end
							end
						else
							if k >= tonumber(matches[3]) then
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = getUserInfo(v):gsub('\\',''), 
											callback_data = 'Unfilter '..v.. ' "'..matches[2]..'"' 
										} 
									}
								)
							end
							if k == (tonumber(matches[3]) + 15) then
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = Language(matches[2], 'BackPage >>'), 
											callback_data = 'NextPageFilterlist "'..matches[2]..'" "'..(tonumber(matches[3]) - 15)..'"' 
										},
										{ 
											text = Language(matches[2], math.floor(tonumber(matches[3]) / 15) + 1), 
											callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
										},
										
										{ 
											text = Language(matches[2], 'NextPage >>'), 
											callback_data = 'NextPageFilterlist "'..matches[2]..'" "'..(tonumber(matches[3]) + 15)..'"' 
										},
									}
								)
								break
							end
						end
						end
						table.insert(keyboard.inline_keyboard, {{text=Language(matches[2], 'Back'), callback_data = 'Ranks '..matches[2]}})
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				------------------------------------
				--Now Do IT (-- Shit Here Bcus its so hard :||||||| --)
				if matches[1] == 'Unfilter' then
					if not isMod(msg.from.id, matches[3]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
					redis:srem('Filterlist'..matches[3],matches[2])

						TEXT = Language(matches[3], 'Filterlist List_ API')
						keyboard = { 
							inline_keyboard = { 
							}
						}
						for k,v in pairs(redis:smembers('Filterlist'..matches[3])) do
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = getUserInfo(v):gsub('\\',''), 
											callback_data = 'Unfilter '..v.. ' "'..matches[3]..'"' 
										} 
									}
								)
							if k == 15 then
								table.insert(keyboard.inline_keyboard, 
									{ 	
										{ 
											text = Language(matches[3], '1️⃣'), 
											callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
										},
										{ 
											text = Language(matches[3], 'NextPage >>'), 
											callback_data = 'NextPageFilterlist "'..matches[3]..'" "16"' 
										},
										
									}
								)
								break
							end
						end
						table.insert(keyboard.inline_keyboard, {{text=Language(matches[2], 'Back'), callback_data = 'Ranks '..matches[2]}})
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				if matches[1] == 'Unmute' then
					if not isMod(msg.from.id, matches[3]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
					redis:srem('Muted'..matches[3],matches[2])

						TEXT = Language(matches[3], 'Muted List_ API')
						keyboard = { 
							inline_keyboard = { 
							}
						}
						for k,v in pairs(redis:smembers('Muted'..matches[3])) do
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = getUserInfo(v):gsub('\\',''), 
											callback_data = 'Unmute '..v.. ' "'..matches[3]..'"' 
										} 
									}
								)
							if k == 15 then
								table.insert(keyboard.inline_keyboard, 
									{ 	
										{ 
											text = Language(matches[3], '1️⃣'), 
											callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
										},
										{ 
											text = Language(matches[3], 'NextPage >>'), 
											callback_data = 'NextPageMutes "'..matches[3]..'" "16"' 
										},
										
									}
								)
								break
							end
						end
						table.insert(keyboard.inline_keyboard, {{text=Language(matches[3], 'Back'), callback_data = 'Ranks '..matches[3]}})
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				if matches[1] == 'Demote' then
					if not isMod(msg.from.id, matches[3]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
					redis:srem('Mods'..matches[3],matches[2])

						TEXT = Language(matches[3], 'Moderators List_ API')
						keyboard = { 
							inline_keyboard = { 
							}
						}
						for k,v in pairs(redis:smembers('Mods'..matches[3])) do
								table.insert(keyboard.inline_keyboard, 
									{ 
										{ 
											text = getUserInfo(v):gsub('\\',''), 
											callback_data = 'Demote '..v.. ' "'..matches[3]..'"' 
										} 
									}
								)
							if k == 15 then
								table.insert(keyboard.inline_keyboard, 
									{ 	
										{ 
											text = Language(matches[3], '1️⃣'), 
											callback_data = 'NULLMESSAGE_PAGE_NUMBER' 
										},
										{ 
											text = Language(matches[3], 'NextPage >>'), 
											callback_data = 'NextPageMods "'..matches[3]..'" "16"' 
										},
										
									}
								)
								break
							end
						end
						table.insert(keyboard.inline_keyboard, {{text=Language(matches[3], 'Back'), callback_data = 'Ranks '..matches[3]}})
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				--------------------------------------
				if matches[1] == 'floods' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						Group = redis:hgetall(matches[2])
						TEXT = Language(matches[2], 'FLOOD_S'):format(
							(Group.FastMessageTime or '2'),
							(Group.FastMessageCount or '5'),
							(Group.LongCharrC or '500'),
							(Group.ShortCharrC or '0')
						)
						keyboard = { inline_keyboard = {
							{ 	
								{text = Language(matches[2], 'Flood'), callback_data = 'INFO FLOOD '..matches[2]..' F'},
								{text = StatsGET(Group.FastMessage or 'OK', matches[2]), callback_data = 'Change FastMessage '..matches[2]..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS FastMessageTime '..matches[2]..' F'
								},
								{
									text = tostring(Group.FastMessageTime or 2)..' CheckTime',
									callback_data = 'INFO FastMessageTime '..matches[2]..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL FastMessageTime '..matches[2]..' F'
								},
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS FastMessageCount '..matches[2]..' F'
								},
								{
									text = tostring(Group.FastMessageCount or 2)..'MessageCount',
									callback_data = 'INFO FastMessageCount '..matches[2]..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL FastMessageCount '..matches[2]..' F'
								},
							},
							{ 	
								{text = Language(matches[2], 'LongMessage'), callback_data = 'INFO LongCharr '..matches[2]..' F'},
								{text = StatsGET(Group.LongCharr or 'OK', matches[2]), callback_data = 'Change LongCharr '..matches[2]..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS LongCharrC '..matches[2]..' F'
								},
								{
									text = tostring(Group.LongCharrC or 500),
									callback_data = 'INFO LongCharrC '..matches[2]..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL LongCharrC '..matches[2]..' F'
								},
							},
							{ 
								{text = Language(matches[2], 'ShortMessage'), callback_data = 'INFO ShortCharr '..matches[2]..' F'},
								{text = StatsGET(Group.ShortCharr or 'OK', matches[2]), callback_data = 'Change ShortCharr '..matches[2]..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS ShortCharrC '..matches[2]..' F'
								},
								{
									text = tostring(Group.ShortCharrC or 5),
									callback_data = 'INFO ShortCharrC '..matches[2]..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL ShortCharrC '..matches[2]..' F'
								},
							},
							{ 
								{ text = 'Back', callback_data = 'settings '..matches[2] }
							}
						} }
						--------------------------------------------------------------------------------------
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end

				if matches[1] == 'settings' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						TEXT = 'Use On of buttems !'
						keyboard2 = {
							inline_keyboard = {
								{ 
									{ text = Language(matches[2], 'SE_1'), callback_data = 'MuteList '..matches[2] },
									{ text = Language(matches[2], 'SE_2'), callback_data = 'settings2 '..matches[2] },
								},
								{ 
									{ text = Language(matches[2], 'SE_3'), callback_data = 'floods '..matches[2] },
									{ text = Language(matches[2], 'SE_4'), callback_data = 'Ranks '..matches[2] },
								},
								{ 
									{ text = Language(matches[2], 'Back'), callback_data = 'P GP '..matches[2] }
								}
							}
						}						
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard2)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard2)
						end
					end
				end
				
				if matches[1] == 'settings2' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						Group = redis:hgetall(matches[2])
						VarDump(Group)
						TEXT = Language(matches[2], 'SE_Settings')
						keyboard = { inline_keyboard = {
							{ 	
								{ text = Language(matches[2], 'S_Link'), callback_data = 'INFO Link '..matches[2]..' M' },
								{ text = StatsGET(Group.Link or 'OK', matches[2]), callback_data = 'Change Link '.. matches[2]..' M' } 
							},
							{ 
								{ text = Language(matches[2], 'S_Username'), callback_data = 'INFO Atsign '..matches[2]..' M' },
								{ text = StatsGET(Group.Atsign or 'OK', matches[2]), callback_data = 'Change Atsign '.. matches[2]..' M' }
							},
							{ 
								{ text = Language(matches[2], 'S_Hashtag'), callback_data = 'INFO Hashtag '..matches[2]..' M' },
								{ text = StatsGET(Group.Hashtag or 'OK', matches[2]), callback_data = 'Change Hashtag '.. matches[2]..' M' }
							},
							{ 
								{ text = Language(matches[2], 'S_English'), callback_data = 'INFO English '..matches[2]..' M' },
								{ text = StatsGET(Group.English or 'OK', matches[2]), callback_data = 'Change English '.. matches[2]..' M' }
							},
							{ 
								{ text = Language(matches[2], 'S_Persian'), callback_data = 'INFO Persion '..matches[2]..' M' },
								{ text = StatsGET(Group.Persion or 'OK', matches[2]), callback_data = 'Change Persion '.. matches[2] ..' M' }
							},
							{ 
								{ text = Language(matches[2], 'Back'), callback_data = 'settings '..matches[2] }
							}
						} }
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end	
					end			
				end

				if matches[1] == 'MuteList' then
					if not isMod(msg.from.id, matches[2]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						Group = redis:hgetall(matches[2])
						TEXT = Language(matches[2], 'M_Text')
						keyboard = { inline_keyboard = {
							{ 
								{ text = Language(matches[2], 'M_Edit')..'🖊', callback_data = 'INFO Edit '..matches[2] ..' D' },
								{ text = StatsGET(Group.Edit or 'OK', matches[2]), callback_data = 'Change Edit '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Photo')..'🖼', callback_data = 'INFO Photo '..matches[2] ..' D' },
								{ text = StatsGET(Group.Photo or 'OK', matches[2]), callback_data = 'Change Photo '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Video')..'📽', callback_data = 'INFO Video '..matches[2] ..' D' },
								{ text = StatsGET(Group.Video or 'OK', matches[2]), callback_data = 'Change Video '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Number')..'☎️', callback_data = 'INFO ShareNumber '..matches[2] ..' D' },
								{ text = StatsGET(Group.ShareNumber or 'OK', matches[2]), callback_data = 'Change ShareNumber '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Music')..'🎶', callback_data = 'INFO Music '..matches[2] ..' D' },
								{ text = StatsGET(Group.Music or 'OK', matches[2]), callback_data = 'Change Music '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Voice')..'🎤', callback_data = 'INFO Voice '..matches[2] ..' D' },
								{ text = StatsGET(Group.Voice or 'OK', matches[2]), callback_data = 'Change Voice '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Loc')..'📌', callback_data = 'INFO Location '..matches[2] ..' D' },
								{ text = StatsGET(Group.Location or 'OK', matches[2]), callback_data = 'Change Location '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Gif')..'🎞', callback_data = 'INFO Animation '..matches[2]  ..' D'},
								{ text = StatsGET(Group.Animation or 'OK', matches[2]), callback_data = 'Change Animation '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Sticker')..'🎫', callback_data = 'INFO Sticker '..matches[2]  ..' D'},
								{ text = StatsGET(Group.Sticker or 'OK', matches[2]), callback_data = 'Change Sticker '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Game')..'🎮', callback_data = 'INFO Game '..matches[2]  ..' D'},
								{ text = StatsGET(Group.Game or 'OK', matches[2]), callback_data = 'Change Game '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Inline')..'➿', callback_data = 'INFO Inline '..matches[2]  ..' D'},
								{ text = StatsGET(Group.Inline or 'OK', matches[2]), callback_data = 'Change Inline '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Keyboard')..'⌨️', callback_data = 'INFO Keyboard '..matches[2] ..' D' },
								{ text = StatsGET(Group.Keyboard or 'OK', matches[2]), callback_data = 'Change Keyboard '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Doc')..'📂', callback_data = 'INFO File '..matches[2] ..' D' },
								{ text = StatsGET(Group.File or 'OK', matches[2]), callback_data = 'Change File '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Media')..'📺', callback_data = 'INFO Media '..matches[2] },
								{ text = StatsGET(Group.Media or 'OK', matches[2]), callback_data = 'Change Media '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Webpage')..'🔗', callback_data = 'INFO Webpage '..matches[2] ..' D' },
								{ text = StatsGET(Group.Webpage or 'OK', matches[2]), callback_data = 'Change Webpage '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'M_Fwd')..'🔗', callback_data = 'INFO Forward '..matches[2] ..' D' },
								{ text = StatsGET(Group.Forward or 'OK', matches[2]), callback_data = 'Change Forward '..matches[2] ..' D' }
							},
							{ 
								{ text = Language(matches[2], 'Back'), callback_data = 'settings '..matches[2] }
							}
						} }
						------------------------------
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end	
					end			
				end
				---------------------------
				if matches[1] == 'Change' then
					if not isMod(msg.from.id, matches[3]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
					chat_id = matches[3]
					ChangeStats(matches[2], chat_id)

					Group = redis:hgetall(matches[3])
					if matches[4] == 'F' then
						TEXT = Language(chat_id, 'FLOOD_S'):format(
							(Group.FastMessageTime or '2'),
							(Group.FastMessageCount or '5'),
							(Group.LongCharrC or '500'),
							(Group.ShortCharrC or '0')
						)
						keyboard = { inline_keyboard = {
							{ 	
								{text = Language(chat_id, 'Flood'), callback_data = 'INFO FLOOD '..chat_id..' F'},
								{text = StatsGET(Group.FastMessage or 'OK', chat_id), callback_data = 'Change FastMessage '..chat_id..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS FastMessageTime '..chat_id..' F'
								},
								{
									text = tostring(Group.FastMessageTime or 2)..' CheckTime',
									callback_data = 'INFO FastMessageTime '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL FastMessageTime '..chat_id..' F'
								},
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS FastMessageCount '..chat_id..' F'
								},
								{
									text = tostring(Group.FastMessageCount or 2)..'MessageCount',
									callback_data = 'INFO FastMessageCount '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL FastMessageCount '..chat_id..' F'
								},
							},
							{ 	
								{text = Language(chat_id, 'LongMessage'), callback_data = 'INFO LongCharr '..chat_id..' F'},
								{text = StatsGET(Group.LongCharr or 'OK', chat_id), callback_data = 'Change LongCharr '..chat_id..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS LongCharrC '..chat_id..' F'
								},
								{
									text = tostring(Group.LongCharrC or 500),
									callback_data = 'INFO LongCharrC '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL LongCharrC '..chat_id..' F'
								},
							},
							{ 
								{text = Language(chat_id, 'ShortMessage'), callback_data = 'INFO ShortCharr '..chat_id..' F'},
								{text = StatsGET(Group.ShortCharr or 'OK', chat_id), callback_data = 'Change ShortCharr '..chat_id..' F'} 
							},
							{ 
								{
									text = '➕',
									callback_data = 'PLUS ShortCharrC '..chat_id..' F'
								},
								{
									text = tostring(Group.ShortCharrC or 5),
									callback_data = 'INFO ShortCharrC '..chat_id..' F'
								},
								{
									text = '➖',
									callback_data = 'EGUL ShortCharrC '..chat_id..' F'
								},
							},
							{ 
								{ text = 'Back', callback_data = 'settings '..chat_id }
							}
						} }
					elseif matches[4] == 'D' then
						TEXT = Language(chat_id, 'M_Text')
						keyboard = { inline_keyboard = {
							{ 
								{ text = Language(chat_id, 'M_Edit')..'🖊', callback_data = 'INFO Edit '..chat_id ..' D' },
								{ text = StatsGET(Group.Edit or 'OK', chat_id), callback_data = 'Change Edit '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Photo')..'🖼', callback_data = 'INFO Photo '..chat_id ..' D' },
								{ text = StatsGET(Group.Photo or 'OK', chat_id), callback_data = 'Change Photo '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Video')..'📽', callback_data = 'INFO Video '..chat_id ..' D' },
								{ text = StatsGET(Group.Video or 'OK', chat_id), callback_data = 'Change Video '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Number')..'☎️', callback_data = 'INFO ShareNumber '..chat_id ..' D' },
								{ text = StatsGET(Group.ShareNumber or 'OK', chat_id), callback_data = 'Change ShareNumber '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Music')..'🎶', callback_data = 'INFO Music '..chat_id ..' D' },
								{ text = StatsGET(Group.Music or 'OK', chat_id), callback_data = 'Change Music '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Voice')..'🎤', callback_data = 'INFO Voice '..chat_id ..' D' },
								{ text = StatsGET(Group.Voice or 'OK', chat_id), callback_data = 'Change Voice '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Loc')..'📌', callback_data = 'INFO Location '..chat_id ..' D' },
								{ text = StatsGET(Group.Location or 'OK', chat_id), callback_data = 'Change Location '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Gif')..'🎞', callback_data = 'INFO Animation '..chat_id  ..' D'},
								{ text = StatsGET(Group.Animation or 'OK', chat_id), callback_data = 'Change Animation '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Sticker')..'🎫', callback_data = 'INFO Sticker '..chat_id  ..' D'},
								{ text = StatsGET(Group.Sticker or 'OK', chat_id), callback_data = 'Change Sticker '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Game')..'🎮', callback_data = 'INFO Game '..chat_id  ..' D'},
								{ text = StatsGET(Group.Game or 'OK', chat_id), callback_data = 'Change Game '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Inline')..'➿', callback_data = 'INFO Inline '..chat_id  ..' D'},
								{ text = StatsGET(Group.Inline or 'OK', chat_id), callback_data = 'Change Inline '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Keyboard')..'⌨️', callback_data = 'INFO Keyboard '..chat_id ..' D' },
								{ text = StatsGET(Group.Keyboard or 'OK', chat_id), callback_data = 'Change Keyboard '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Doc')..'📂', callback_data = 'INFO File '..chat_id ..' D' },
								{ text = StatsGET(Group.File or 'OK', chat_id), callback_data = 'Change File '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Media')..'📺', callback_data = 'INFO Media '..chat_id },
								{ text = StatsGET(Group.Media or 'OK', chat_id), callback_data = 'Change Media '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Webpage')..'🔗', callback_data = 'INFO Webpage '..chat_id ..' D' },
								{ text = StatsGET(Group.Webpage or 'OK', chat_id), callback_data = 'Change Webpage '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'M_Fwd')..'🔗', callback_data = 'INFO Forward '..chat_id ..' D' },
								{ text = StatsGET(Group.Forward or 'OK', chat_id), callback_data = 'Change Forward '..chat_id ..' D' }
							},
							{ 
								{ text = Language(chat_id, 'Back'), callback_data = 'settings '..chat_id }
							}
						} }
					elseif matches[4] == 'M' then
						TEXT = Language(chat_id, 'SE_Settings')
						keyboard = { inline_keyboard = {
							{ 	
								{ text = Language(chat_id, 'S_Link'), callback_data = 'INFO Link '..chat_id..' M' },
								{ text = StatsGET(Group.Link or 'OK', chat_id), callback_data = 'Change Link '.. chat_id..' M' } 
							},
							{ 
								{ text = Language(chat_id, 'S_Username'), callback_data = 'INFO Atsign '..chat_id..' M' },
								{ text = StatsGET(Group.Atsign or 'OK', chat_id), callback_data = 'Change Atsign '.. chat_id..' M' }
							},
							{ 
								{ text = Language(chat_id, 'S_Hashtag'), callback_data = 'INFO Hashtag '..chat_id..' M' },
								{ text = StatsGET(Group.Hashtag or 'OK', chat_id), callback_data = 'Change Hashtag '.. chat_id..' M' }
							},
							{ 
								{ text = Language(chat_id, 'S_English'), callback_data = 'INFO English '..chat_id..' M' },
								{ text = StatsGET(Group.English or 'OK', chat_id), callback_data = 'Change English '.. chat_id..' M' }
							},
							{ 
								{ text = Language(chat_id, 'S_Persian'), callback_data = 'INFO Persion '..chat_id..' M' },
								{ text = StatsGET(Group.Persion or 'OK', chat_id), callback_data = 'Change Persion '.. chat_id ..' M' }
							},
							{ 
								{ text = Language(chat_id, 'Back'), callback_data = 'settings '..chat_id }
							}
						} }
					end
				---------------------------------
					if msg.inline_message_id then
						api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
					else
						api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
					end
				end
				
				---------------
				if matches[1] == 'INFO' then
					if matches[4] == 'M' then
						DSDo = 'settings2'
					elseif matches[4] == 'F' then
						DSDo = 'floods'
					elseif matches[4] == 'D' then
						DSDo = 'MuteList'
					end
					if not isMod(msg.from.id, matches[3]) then
						api.answerCallbackQuery(_Config.TOKEN, msg.id, Language(msg.from.id, 'No Access !'), false, 10)
					else
						TEXT = "Null "
							keyboard = {
								inline_keyboard = {
									{ 
										{ text = Language(matches[3], 'Back'), callback_data = DSDo..' '..matches[3] }
									}
								}
							}
						if matches[2] == 'FLOOD' then

						elseif matches[2] == 'LongCharr' then

						elseif matches[2] == 'ShortCharr' then

						elseif matches[2] == 'Link' then

						elseif matches[2] == 'Mention' then

						elseif matches[2] == 'Atsign' then

						elseif matches[2] == 'Hashtag' then

						elseif matches[2] == 'Persion' then

						elseif matches[2] == 'English' then

						elseif matches[2] == 'Edit' then
							
						elseif matches[2] == 'Photo' then
					
						elseif matches[2] == 'Video' then
							
						elseif matches[2] == 'ShareNumber' then
							
						elseif matches[2] == 'Music' then
							
						elseif matches[2] == 'Voice' then
						
						elseif matches[2] == 'Location' then
							
						elseif matches[2] == 'Animation' then

						elseif matches[2] == 'Sticker' then

						elseif matches[2] == 'Game' then

						elseif matches[2] == 'Inline' then

						elseif matches[2] == 'Keyboard' then

						elseif matches[2] == 'Document' then

						elseif matches[2] == 'Media' then

						elseif matches[2] == 'Webpage' then

						else
						
						end
						--------------
						if msg.inline_message_id then
							api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', keyboard)
						else
							api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
						end
					end
				end
				end
			end
		end
	end



	return {
		HELP = {
			NAME = { 
				fa = 'تنظیمات',
				en = 'Settings!',
				call = 'settings',
			},
			Dec = {
				fa = 'تنظیمات گروه',
				en = 'Group Settings',
			},
			Usage = {
				fa = '`Settings` : دریافت تنظیمات گروه',
				en = '`Settings` : Get Group Info And Options',
			},
			rank = 'Mod',
		},
		cli = {
			_MSG = {
				'^([Ss]ettings)$',
				'^[/!#]([Ss]ettings)$',
			},
	--		Pre = Pre,
			run = Run
		},
		api = {
			_MSG = {
				'^([Ss]ettings)$',
				'^[/!#]([Ss]ettings)$',
				'^!#MessageCall (PLUS) (.*) (.*) F$',
				'^!#MessageCall (EGUL) (.*) (.*) F$',
				'^!#MessageCall (settings) (.*)$',
				'^!#MessageCall (Filter) (.*)$',
				'^!#MessageCall (NextPageFilterlist) "(.*)" "(.*)"$',
				'^!#MessageCall (NextPageMutes) "(.*)" "(.*)"$',
				'^!#MessageCall (NextPageMods) "(.*)" "(.*)"$',
				'^!#MessageCall (Unfilter) (.*) "(.*)"$',
				'^!#MessageCall (Unmute) (.*) "(.*)"$',
				'^!#MessageCall (Demote) (.*) "(.*)"$',
				'^!#MessageCall (Muted) (.*)$',
				'^!#MessageCall (Mods) (.*)$',
				'^!#MessageQuery (Group) (.*)$',
				'^!#MessageCall (settings2) (.*)$',
				'^!#MessageCall (Ranks) (.*)$',
				'^!#MessageCall (MuteList) (.*)$',
				'^!#MessageCall (floods) (.*)$',
				'^!#MessageCall (Change) (%S+) (%S+) ([MFD])$',
				'^!#MessageCall (INFO) (%S+) (%S+) ([MFD])$',


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
