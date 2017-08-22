	function Run(msg, matches)
if #matches > 0 then
		if matches[1]:lower() == 'info' then
			if tonumber(msg.reply_to_message_id_) == 0 then
				UserID = msg.sender_user_id_
				cli.sendInline('SPRCPU_BOT', msg.chat_id_, msg.id_, 'INFO '..UserID.. ' '..msg.chat_id_, 0)
			else
				cli.getMessage(msg.chat_id_, msg.reply_to_message_id_,
				function (arg, data) 
					UserID = data.sender_user_id_
					cli.sendInline('SPRCPU_BOT', msg.chat_id_, msg.id_, 'INFO '..UserID.. ' '..msg.chat_id_, 0)
				end,
				nil)
			end
			if #matches == 2 then
				if #msg.content_.entities_ > 1 then
					if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
						X = tonumber(msg.content_.entities_[0].user_id_)
					else
						X = nil
					end
				else
					if tonumber(matches[2]) ~= nil then
						X = tonumber(matches[2])
					else
						X = nil
					end
				end
				if type(X) == 'number' then
					UserID = X
					cli.sendInline('SPRCPU_BOT', msg.chat_id_, msg.id_, 'INFO '..UserID.. ' '..msg.chat_id_, 0)
				else
					cli.searchPublicChat(matches[2]:gsub('@', ''),
						function(ARG, DATA)
							UserID = DATA.id_
							cli.sendInline('SPRCPU_BOT', msg.chat_id_, msg.id_, 'INFO '..UserID.. ' '..msg.chat_id_, 0)
						end,
					nil)
				end
			end
		end
end
	end
	function ApiRun(msg, matches)
		CHATID = (matches[3] or '')
		if msg.query then
			if matches[1] == 'INFO' then
			if redis:sismember('Users', matches[2]) then

				CHATID = matches[3]
				LANG = (redis:hget(matches[3], 'Lang') or 'fa'):lower()
				if isOwner(matches[2], CHATID) then
					USERRANK = 'Group Owner !'
				elseif isMod(matches[2], CHATID) then
					USERRANK = 'Group Owner !'
				else
					USERRANK = 'Member !'
				end

				if LANG == 'fa' then
					TEXT = '*کاربر* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* یوزرنیم* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* شماره تلفن* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* ایدی کاربری* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* تعداد گروه ها* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* تعداد SPR* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*اطلاعات کاربر در این چت !*\n'
					..'*حالت سکوت است ؟ : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*مقام : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				else
					TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*UserInfo In This Chat !*\n'
					..'*is Muted ? : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*Rank : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				end
				if isSudo(matches[2]) then
					ISSD = 'desudo'
				else
					ISSD = 'tosudo'
				end
				if isFull(matches[2]) then
					IsSD = 'deadmin'
				else
					IsSD = 'toadmin'
				end
				if redis:sismember('Muted'..CHATID, matches[2]) then
					IsSDM = 'UnMute'
				else
					IsSDM = 'Mute'
				end
				reply_markup = {
					inline_keyboard = {
					{ {text = 'Kick User', callback_data = 'Kick '..matches[2].. ' '..matches[3]}, {text = IsSDM, callback_data = IsSDM..' '..matches[2].. ' '..matches[3]} },
					}
				}

			photos2 = api.getUserProfilePhotos(_Config.TOKEN, matches[2])
              if photos2.result then
                if photos2.result.total_count ~= 0 then
                  if photos2.result.photos[1][3] then
                    filep = api.getFile(_Config.TOKEN, photos2.result.photos[1][3].file_id)
                    if filep then
                    	Photo = 'https://api.telegram.org/file/bot'.. _Config.TOKEN .. '/'..filep.result.file_path
                    else
                    	Photo = 'http://spr-cpu.ir/reloadlife/404imagenotfound.png'
                   	end
                 end
                end
              end
				RESULTS = {
						{
							type = 'photo',
							id = '0',
							description = 'User : '.. getUserInfo(matches[2]):gsub('\\','') ..' Info! ',
							title = 'User : '.. getUserInfo(matches[2]):gsub('\\','') ..' Info! ',
							photo_url = Photo,
							photo_width = 640,
							photo_height = 640,
							caption = 'User : '..getUserInfo(matches[2]):gsub('\\','')
								..'\n Username : '..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
								..'\n PhoneNumber : '..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
								..'\n UserID : '..(matches[2] or '404!'):gsub('\\','')
								..'\n UserGroup Count : '..redis:scard(matches[2]..'Chats')..'\n'
								..'\n SPR Count : '..(redis:get(matches[2]..'SPRs') or 0)..'\n',
							input_message_content = {
								message_text = TEXT,
								parse_mode = 'Markdown',
								disable_web_page_preview = true
							},
							reply_markup = reply_markup,
							thumb_url = Photo,
						}
					}
				api.answerInlineQuery(_Config.TOKEN, msg.id, JSON.encode(RESULTS), 0, true, 'استارت کردن ربات !', 'start')
				else
					RESULTS = {
							{
								type = 'article',
								id = '0',
								description = 'Error!',
								title = 'Error !',
								input_message_content = {
									message_text = 'User Not Found !',
									parse_mode = 'Markdown',
									disable_web_page_preview = true
								},
								--thumb_url = '',
							}
						}
						api.answerInlineQuery(_Config.TOKEN, msg.id, JSON.encode(RESULTS), 0, true, 'استارت کردن ربات !', 'start')
			end
			end

		end
	if msg.inline_message_id then
	if isSudo(msg.from.id) then
		if matches[1] == 'BACKINFO' then
        	user_id = matches[2]
        	CHATID = matches[3]
			LANG = (redis:hget(matches[3], 'Lang') or 'fa'):lower()
        	if LANG == 'fa' then
					TEXT = '*کاربر* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* یوزرنیم* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* شماره تلفن* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* ایدی کاربری* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* تعداد گروه ها* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* تعداد SPR* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*اطلاعات کاربر در این چت !*\n'
					..'*حالت سکوت است ؟ : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*مقام : *`'.. tostring(USERRANK) .. '`\n'
				else
					TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*UserInfo In This Chat !*\n'
					..'*is Muted ? : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*Rank : *`'.. tostring(USERRANK) .. '`\n'
				end
				if isSudo(matches[2]) then
					ISSD = 'desudo'
				else
					ISSD = 'tosudo'
				end
				if isFull(matches[2]) then
					IsSD = 'deadmin'
				else
					IsSD = 'toadmin'
				end
				if redis:sismember('Muted'..CHATID, matches[2]) then
					IsSDM = 'UnMute'
				else
					IsSDM = 'Mute'
				end
				reply_markup = {
					inline_keyboard = {
					{ {text = 'Kick User', callback_data = 'Kick '..matches[2].. ' '..matches[3]}, {text = IsSDM, callback_data = IsSDM..' '..matches[2].. ' '..matches[3]} },
					}
				}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
        end
		if matches[1] == 'SPRSs' then
			if #matches > 2 then
        	user_id = matches[2]
        	TEXT = 'User SPR Info !\n'
        	..'Now SPRS : '..(redis:get(matches[2]..'SPRs') or 0)
        	reply_markup = { 
        		inline_keyboard = { 
        			{{text = 'Add 10 Sprs to User !', callback_data = 'Charge '..user_id }},
        			{{text = 'Set SPRs On 0', callback_data = 'ZeroSprs '..user_id }},
        			{{text = 'Back', callback_data = 'BACKINFO '..user_id  .. ' '..(matches[3] )}}
        		}
        	}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
		end
        end
        if matches[1] == 'Charge' then
			if #matches > 2 then
        	user_id = matches[2]
        	redis:incrby(matches[2]..'SPRs', 10)
        	TEXT = 'User SPR Info !\n'
        	..'Now SPRS : '..(redis:get(matches[2]..'SPRs') or 0)
        	reply_markup = { 
        		inline_keyboard = { 
        			{{text = 'Add 10 Sprs to User !', callback_data = 'Charge '..user_id }},
        			{{text = 'Set SPRs On 0', callback_data = 'ZeroSprs '..user_id }},
        			{{text = 'Back', callback_data = 'BACKINFO '..user_id  .. ' '..(matches[3] )}}
        		}
        	}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
        end
        end
        if matches[1] == 'ZeroSprs' then
			if #matches > 2 then
        	user_id = matches[2]
        	redis:set(matches[2]..'SPRs', 0)
        	TEXT = 'User SPR Info !\n'
        	..'Now SPRS : '..(redis:hget(matches[2], 'SPRs') or 0)
        	reply_markup = { 
        		inline_keyboard = { 
        			{{text = 'Add 10 Sprs to User !', callback_data = 'Charge '..user_id }},
        			{{text = 'Set SPRs On 0', callback_data = 'ZeroSprs '..user_id }},
        			{{text = 'Back', callback_data = 'BACKINFO '..user_id .. ' '..(matches[3] )  }}
        		}
        	}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
        end
        end
        if matches[1] == 'tosudo' then
			redis:sadd('FullAccess', matches[2])
			CHATID = matches[3]
			LANG = (redis:hget(matches[2], 'Lang') or 'fa'):lower()
        	if LANG == 'fa' then
					TEXT = '*کاربر* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* یوزرنیم* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* شماره تلفن* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* ایدی کاربری* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* تعداد گروه ها* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* تعداد SPR* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*اطلاعات کاربر در این چت !*\n'
					..'*حالت سکوت است ؟ : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*مقام : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				else
					TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*UserInfo In This Chat !*\n'
					..'*is Muted ? : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*Rank : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				end
				if isSudo(matches[2]) then
					ISSD = 'desudo'
				else
					ISSD = 'tosudo'
				end
				if isFull(matches[2]) then
					IsSD = 'deadmin'
				else
					IsSD = 'toadmin'
				end
				if redis:sismember('Muted'..CHATID, matches[2]) then
					IsSDM = 'UnMute'
				else
					IsSDM = 'Mute'
				end
				reply_markup = {
					inline_keyboard = {
					{ {text = 'Kick User', callback_data = 'Kick '..matches[2].. ' '..matches[3]}, {text = IsSDM, callback_data = IsSDM..' '..matches[2].. ' '..matches[3]} },
					}
				}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'desudo' then
			redis:srem('FullAccess', matches[2])
			CHATID = matches[3]
			LANG = (redis:hget(matches[2], 'Lang') or 'fa'):lower()
        	if LANG == 'fa' then
					TEXT = '*کاربر* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* یوزرنیم* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* شماره تلفن* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* ایدی کاربری* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* تعداد گروه ها* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* تعداد SPR* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*اطلاعات کاربر در این چت !*\n'
					..'*حالت سکوت است ؟ : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*مقام : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				else
					TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*UserInfo In This Chat !*\n'
					..'*is Muted ? : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*Rank : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				end
				if isSudo(matches[2]) then
					ISSD = 'desudo'
				else
					ISSD = 'tosudo'
				end
				if isFull(matches[2]) then
					IsSD = 'deadmin'
				else
					IsSD = 'toadmin'
				end
				if redis:sismember('Muted'..CHATID, matches[2]) then
					IsSDM = 'UnMute'
				else
					IsSDM = 'Mute'
				end
				reply_markup = {
					inline_keyboard = {
					{ {text = 'Kick User', callback_data = 'Kick '..matches[2].. ' '..matches[3]}, {text = IsSDM, callback_data = IsSDM..' '..matches[2].. ' '..matches[3]} },
					}
				}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'toadmin' then
			redis:sadd('FullAdmins', matches[2])
			CHATID = matches[3]
			LANG = (redis:hget(matches[2], 'Lang') or 'fa'):lower()
        	if LANG == 'fa' then
					TEXT = '*کاربر* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* یوزرنیم* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* شماره تلفن* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* ایدی کاربری* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* تعداد گروه ها* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* تعداد SPR* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*اطلاعات کاربر در این چت !*\n'
					..'*حالت سکوت است ؟ : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*مقام : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				else
					TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*UserInfo In This Chat !*\n'
					..'*is Muted ? : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*Rank : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				end
				if isSudo(matches[2]) then
					ISSD = 'desudo'
				else
					ISSD = 'tosudo'
				end
				if isFull(matches[2]) then
					IsSD = 'deadmin'
				else
					IsSD = 'toadmin'
				end
				if redis:sismember('Muted'..CHATID, matches[2]) then
					IsSDM = 'UnMute'
				else
					IsSDM = 'Mute'
				end
				reply_markup = {
					inline_keyboard = {
					{ {text = 'Kick User', callback_data = 'Kick '..matches[2].. ' '..matches[3]}, {text = IsSDM, callback_data = IsSDM..' '..matches[2].. ' '..matches[3]} },
					}
				}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'deadmin' then
			redis:srem('FullAdmins', matches[2])
			CHATID = matches[3]
			LANG = (redis:hget(matches[2], 'Lang') or 'fa'):lower()
        	if LANG == 'fa' then
					TEXT = '*کاربر* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* یوزرنیم* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* شماره تلفن* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* ایدی کاربری* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* تعداد گروه ها* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* تعداد SPR* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*اطلاعات کاربر در این چت !*\n'
					..'*حالت سکوت است ؟ : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*مقام : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				else
					TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*UserInfo In This Chat !*\n'
					..'*is Muted ? : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*Rank : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				end
				if isSudo(matches[2]) then
					ISSD = 'desudo'
				else
					ISSD = 'tosudo'
				end
				if isFull(matches[2]) then
					IsSD = 'deadmin'
				else
					IsSD = 'toadmin'
				end
				if redis:sismember('Muted'..CHATID, matches[2]) then
					IsSDM = 'UnMute'
				else
					IsSDM = 'Mute'
				end
				reply_markup = {
					inline_keyboard = {
					{ {text = 'Kick User', callback_data = 'Kick '..matches[2].. ' '..matches[3]}, {text = IsSDM, callback_data = IsSDM..' '..matches[2].. ' '..matches[3]} },
					}
				}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'UnMute' then
			CHATID = matches[3]
			redis:srem('Muted'..CHATID, matches[2])
			api.answerCallbackQuery(_Config.TOKEN, msg.id, 'User Unmuted !', false, 20)
			CHATID = matches[3]
			LANG = (redis:hget(matches[2], 'Lang') or 'fa'):lower()
        	if LANG == 'fa' then
					TEXT = '*کاربر* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* یوزرنیم* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* شماره تلفن* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* ایدی کاربری* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* تعداد گروه ها* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* تعداد SPR* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*اطلاعات کاربر در این چت !*\n'
					..'*حالت سکوت است ؟ : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*مقام : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				else
					TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*UserInfo In This Chat !*\n'
					..'*is Muted ? : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*Rank : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				end
				if isSudo(matches[2]) then
					ISSD = 'desudo'
				else
					ISSD = 'tosudo'
				end
				if isFull(matches[2]) then
					IsSD = 'deadmin'
				else
					IsSD = 'toadmin'
				end
				if redis:sismember('Muted'..CHATID, matches[2]) then
					IsSDM = 'UnMute'
				else
					IsSDM = 'Mute'
				end
				reply_markup = {
					inline_keyboard = {
					{ {text = 'Kick User', callback_data = 'Kick '..matches[2].. ' '..matches[3]}, {text = IsSDM, callback_data = IsSDM..' '..matches[2].. ' '..matches[3]} },
					}
				}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'Mute' then
			CHATID = matches[3]
			redis:sadd('Muted'..CHATID, matches[2])
			api.answerCallbackQuery(_Config.TOKEN, msg.id, 'User Muted !', false, 20)
			CHATID = matches[3]
			LANG = (redis:hget(matches[2], 'Lang') or 'fa'):lower()
        	if LANG == 'fa' then
					TEXT = '*کاربر* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* یوزرنیم* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* شماره تلفن* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* ایدی کاربری* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* تعداد گروه ها* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* تعداد SPR* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*اطلاعات کاربر در این چت !*\n'
					..'*حالت سکوت است ؟ : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*مقام : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				else
					TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
					..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
					..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
					..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
					..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
					..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
					..'\n`------------`\n'
					..'*UserInfo In This Chat !*\n'
					..'*is Muted ? : *` '..tostring(redis:sismember('Muted'..CHATID, matches[2])).. '`\n'
					..'*Rank : *`'.. tostring(USERRANK or 'Member') .. '`\n'
				end
				if isSudo(matches[2]) then
					ISSD = 'desudo'
				else
					ISSD = 'tosudo'
				end
				if isFull(matches[2]) then
					IsSD = 'deadmin'
				else
					IsSD = 'toadmin'
				end
				if redis:sismember('Muted'..CHATID, matches[2]) then
					IsSDM = 'UnMute'
				else
					IsSDM = 'Mute'
				end
				reply_markup = {
					inline_keyboard = {
					{ {text = 'Kick User', callback_data = 'Kick '..matches[2].. ' '..matches[3]}, {text = IsSDM, callback_data = IsSDM..' '..matches[2].. ' '..matches[3]} },
					}
				}
			api.editMessageTextII(_Config.TOKEN, msg.inline_message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'Kick' then
			CHATID = matches[3]
			cli.changeChatMemberStatus(matches[3], matches[2], 'Kicked')
			api.answerCallbackQuery(_Config.TOKEN, msg.id, 'User Kicked !', false, 20)
		end
		if matches[1] == 'Block' then
			if redis:sismember('BLCD', matches[2]) then
				cli.unblockUser(matches[2])
				redis:srem('BLCD', matches[2])
				api.answerCallbackQuery(_Config.TOKEN, msg.id, 'User Unblocked', false, 20)
			else
				cli.blockUser(matches[2])
				redis:sadd('BLCD', matches[2])
				api.answerCallbackQuery(_Config.TOKEN, msg.id, 'User Blocked', false, 20)
			end
		end
    end
	else
	if isSudo(msg.from.id) then
		if matches[1] == 'tosudo' then
			redis:sadd('FullAccess', matches[2])
			TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
			..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
			..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
			..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
			..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
			..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
			if isSudo(matches[2]) then
				ISSD = 'desudo'
			else
				ISSD = 'tosudo'
			end
			if isFull(matches[2]) then
				IsSD = 'deadmin'
			else
				IsSD = 'toadmin'
			end
			reply_markup = {
				inline_keyboard = {
				{ {text = ISSD, callback_data = ISSD..' '.. matches[2]} },
				{ {text = IsSD, callback_data = IsSD..' '.. matches[2]} },
				{ {text = 'Block User', callback_data = 'Block '.. matches[2]} },
				{ {text = 'SPR', callback_data = 'SPRSs '.. matches[2]} },
				{ {text = 'Profile', callback_data = 'profile '.. matches[2]} },
				{ {text = 'Back', callback_data = 'panel'} },
				}
			}
			api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'desudo' then
			redis:srem('FullAccess', matches[2])
			TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
			..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
			..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
			..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
			..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
			..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
			if isSudo(matches[2]) then
				ISSD = 'desudo'
			else
				ISSD = 'tosudo'
			end
			if isFull(matches[2]) then
				IsSD = 'deadmin'
			else
				IsSD = 'toadmin'
			end
			reply_markup = {
				inline_keyboard = {
				{ {text = ISSD, callback_data = ISSD..' '.. matches[2]} },
				{ {text = IsSD, callback_data = IsSD..' '.. matches[2]} },
				{ {text = 'Block User', callback_data = 'Block '.. matches[2]} },
				{ {text = 'SPR', callback_data = 'SPRSs '.. matches[2]} },
				{ {text = 'Profile', callback_data = 'profile '.. matches[2]} },
				{ {text = 'Back', callback_data = 'panel'} },
				}
			}
			api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'toadmin' then
			redis:sadd('FullAdmins', matches[2])
			TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
			..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
			..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
			..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
			..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
			..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
			if isSudo(matches[2]) then
				ISSD = 'desudo'
			else
				ISSD = 'tosudo'
			end
			if isFull(matches[2]) then
				IsSD = 'deadmin'
			else
				IsSD = 'toadmin'
			end
			reply_markup = {
				inline_keyboard = {
				{ {text = ISSD, callback_data = ISSD..' '.. matches[2]} },
				{ {text = IsSD, callback_data = IsSD..' '.. matches[2]} },
				{ {text = 'Block User', callback_data = 'Block '.. matches[2]} },
				{ {text = 'SPR', callback_data = 'SPRSs '.. matches[2]} },
				{ {text = 'Profile', callback_data = 'profile '.. matches[2]} },
				{ {text = 'Back', callback_data = 'panel'} },
				}
			}
			api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'deadmin' then
			redis:srem('FullAdmins', matches[2])
			TEXT = '*User* : `'..getUserInfo(matches[2]):gsub('\\','')
			..'`\n* Username* : `'..(redis:hget(matches[2], 'username') or '404!'):gsub('\\','')
			..'`\n* PhoneNumber* : `'..(redis:hget(matches[2], 'phonenumber') or '404!'):gsub('\\','')
			..'`\n* UserID* : `'..(matches[2] or '404!'):gsub('\\','')
			..'`\n* UserGroup Count* : `'..redis:scard(matches[2]..'Chats')..'\n'
			..'`\n* SPR Count* : `'..(redis:get(matches[2]..'SPRs') or 0)..'`\n'
			if isSudo(matches[2]) then
				ISSD = 'desudo'
			else
				ISSD = 'tosudo'
			end
			if isFull(matches[2]) then
				IsSD = 'deadmin'
			else
				IsSD = 'toadmin'
			end
			reply_markup = {
				inline_keyboard = {
				{ {text = ISSD, callback_data = ISSD..' '.. matches[2]} },
				{ {text = IsSD, callback_data = IsSD..' '.. matches[2]} },
				{ {text = 'Block User', callback_data = 'Block '.. matches[2]} },
				{ {text = 'SPR', callback_data = 'SPRSs '.. matches[2]} },
				{ {text = 'Profile', callback_data = 'profile '.. matches[2]} },
				{ {text = 'Back', callback_data = 'panel'} },
				}
			}
			api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'Block' then
			if redis:sismember('BLCD', matches[2]) then
				cli.unblockUser(matches[2])
				redis:srem('BLCD', matches[2])
				api.answerCallbackQuery(_Config.TOKEN, msg.id, 'User Unblocked', false, 20)
			else
				cli.blockUser(matches[2])
				redis:sadd('BLCD', matches[2])
				api.answerCallbackQuery(_Config.TOKEN, msg.id, 'User Blocked', false, 20)
			end

		end
		-------------------------------------------------
		if matches[1] == 'profile' then
			photos2 = api.getUserProfilePhotos(_Config.TOKEN, matches[2])
              if photos2.result then
                if photos2.result.total_count ~= 0 then
                  if photos2.result.photos[1][3] then
                    filep = api.getFile(_Config.TOKEN, photos2.result.photos[1][3].file_id)
                    if filep then
                    	api.sendPhotoId(_Config.TOKEN, msg.from.id, filep.result.file_id, msg.message.message_id, 'User Profile !')
                    else
						api.sendMessage(_Config.TOKEN, msg.from.id, 'No Access to profile !',nil ,nil , msg.message.message_id)	
                    end
                  end
                end
              end
        end
        if matches[1] == 'SPRSs' then
        	user_id = matches[2]
        	TEXT = 'User SPR Info !\n'
        	..'Now SPRS : '..(redis:get(matches[2]..'SPRs') or 0)
        	reply_markup = { 
        		inline_keyboard = { 
        			{{text = 'Add 10 Sprs to User !', callback_data = 'Charge '..user_id }},
        			{{text = 'Set SPRs On 0', callback_data = 'ZeroSprs '..user_id }},
        			{{text = 'Back', callback_data = 'P USER '..user_id  }}
        		}
        	}
        	api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
        end
        if matches[1] == 'Charge' then
        	user_id = matches[2]
        	redis:incrby(matches[2]..'SPRs', 10)
        	TEXT = 'User SPR Info !\n'
        	..'Now SPRS : '..(redis:get(matches[2]..'SPRs') or 0)
        	reply_markup = { 
        		inline_keyboard = { 
        			{{text = 'Add 10 Sprs to User !', callback_data = 'Charge '..user_id }},
        			{{text = 'Set SPRs On 0', callback_data = 'ZeroSprs '..user_id }},
        			{{text = 'Back', callback_data = 'P USER '..user_id }}
        		}
        	}
        	api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
        end
        if matches[1] == 'ZeroSprs' then
        	user_id = matches[2]
        	redis:set(matches[2]..'SPRs', 0)
        	TEXT = 'User SPR Info !\n'
        	..'Now SPRS : '..(redis:hget(matches[2], 'SPRs') or 0)
        	reply_markup = { 
        		inline_keyboard = { 
        			{{text = 'Add 10 Sprs to User !', callback_data = 'Charge '..user_id }},
        			{{text = 'Set SPRs On 0', callback_data = 'ZeroSprs '..user_id }},
        			{{text = 'Back', callback_data = 'P USER '..user_id }}
        		}
        	}
        	api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
        end
    end
	end
	end
	return {
		HELP = {
			NAME = { 
				fa = 'اطلاعات',
				en = 'Info !',
				call = 'info',
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
				'^([Ii]nfo)$',
				'^[/!#]([Ii]nfo)$',
				'^([Ii]nfo) (.*)$',
				'^[/!#]([Ii]nfo) (.*)$',
			},
	--		Pre = Pre,
			run = Run
		},
		api = {
			_MSG = {
				'^!#MessageCall (tosudo) (.*)$',
				'^!#MessageCall (BACKINFO) (.*)$',
				'^!#MessageCall (desudo) (.*)$',
				'^!#MessageCall (toadmin) (.*)$',
				'^!#MessageCall (deadmin) (.*)$',
				'^!#MessageCall (Block) (.*)$',
				'^!#MessageCall (SPRSs) (.*)$',
				'^!#MessageCall (Charge) (.*)$',
				'^!#MessageCall (ZeroSprs) (.*)$',
				'^!#MessageCall (profile) (.*)$',


				'^!#MessageCall (tosudo) (%d+) (.*)$',
				'^!#MessageCall (BACKINFO) (%d+) (.*)$',
				'^!#MessageCall (desudo) (%d+) (.*)$',
				'^!#MessageCall (toadmin) (%d+) (.*)$',
				'^!#MessageCall (deadmin) (%d+) (.*)$',
				'^!#MessageCall (Block) (%d+) (.*)$',
				'^!#MessageQuery (INFO) (%d+) (.*)$',
				'^!#MessageCall (SPRSs) (%d+) (.*)$',
				'^!#MessageCall (Charge) (%d+) (.*)$',
				'^!#MessageCall (ZeroSprs) (%d+) (.*)$',
				'^!#MessageCall (profile) (%d+) (.*)$',
				'^!#MessageCall (Mute) (%d+) (.*)$',
				'^!#MessageCall (UnMute) (%d+) (.*)$',
				'^!#MessageCall (Kick) (%d+) (.*)$',


			},
	--		Pre = ApiPre,
			run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}