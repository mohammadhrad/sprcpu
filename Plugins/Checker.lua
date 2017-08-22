utf = require 'lua-utf8'
	function DoMessage(msg)
		if msg then
			chat_id = msg.chat_id_ 
			user_id = msg.sender_user_id_
			Group = redis:hgetall(chat_id)
			msg_id = msg.id_
			TEXT = (msg.content_.text_ or msg.content_.caption_ or ' ')
		
			if not isMod(user_id, chat_id) then
				for k,v in pairs(redis:smembers('Filterlist'..chat_id)) do
					if TEXT:find(v) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if redis:sismember('Mutelist'..chat_id, user_id) then
					if not isMod(user_id, chat_id) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.MuteAll == 'true' then
					cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
				end
				if Group.Link == 'DEL' then
					if TEXT:lower():match('t.me/') or TEXT:lower():match('telegram.me/') or TEXT:lower():match('telegram.dog/') or TEXT:lower():match('telegra.ph/') then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Link == 'WARN' then
					if TEXT:lower():match('t.me/') or TEXT:lower():match('telegram.me/') or TEXT:lower():match('telegram.dog/') or TEXT:lower():match('telegra.ph/') then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------
				if Group.Atsign == 'DEL' then
					if TEXT:match('@')  then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Atsign == 'WARN' then
					if TEXT:match('@')  then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Hashtag == 'DEL' then
					if TEXT:lower():match('#')  then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Hashtag == 'WARN' then
					if TEXT:lower():match('#')  then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.English == 'DEL' then
					if TEXT:lower():match('[a-z]')  then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.English == 'WARN' then
					if TEXT:lower():match('[a-z]')  then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Persion == 'DEL' then
					if TEXT:lower():match('[\216-\219][\128-\191]')  then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Persion == 'WARN' then
					if TEXT:lower():match('[\216-\219][\128-\191]')  then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Edit == 'DEL' then
					if msg.edit_date_ ~= 0 then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Edit == 'WARN' then
					if msg.edit_date_ ~= 0 then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Photo == 'DEL' then
					if msg.content_.ID == 'MessagePhoto' or msg.content_.photo_ then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Photo == 'WARN' then
					if msg.content_.ID == 'MessagePhoto' or msg.content_.photo_ then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Video == 'DEL' then
					if msg.content_.ID == 'MessageVideo' then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Video == 'WARN' then
					if msg.content_.ID == 'MessageVideo' then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.ShareNumber == 'DEL' then
					if msg.content_.ID == "MessageContact" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.ShareNumber == 'WARN' then
					if msg.content_.ID == "MessageContact" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Music == 'DEL' then
					if msg.content_.ID == "MessageAudio" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Music == 'WARN' then
					if msg.content_.ID == "MessageAudio" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Voice == 'DEL' then
					if msg.content_.ID == "MessageVoice" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Voice == 'WARN' then
					if msg.content_.ID == "MessageVoice" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Location == 'DEL' then
					if msg.content_.ID == "MessageLocation" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Location == 'WARN' then
					if msg.content_.ID == "MessageLocation" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Animation == 'DEL' then
					if msg.content_.ID == "MessageAnimation" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Animation == 'WARN' then
					if msg.content_.ID == "MessageAnimation" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Sticker == 'DEL' then
					if msg.content_.ID == "MessageSticker" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Sticker == 'WARN' then
					if msg.content_.ID == "MessageSticker" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Game == 'DEL' then
					if msg.content_.ID == "MessageGame" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Game == 'WARN' then
					if msg.content_.ID == "MessageGame" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Inline == 'DEL' then
					if msg.via_bot_user_id_ ~= 0 then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Inline == 'WARN' then
					if msg.via_bot_user_id_ ~= 0 then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Keyboard == 'DEL' then
					if msg.reply_markup_ then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Keyboard == 'WARN' then
					if msg.reply_markup_ then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.File == 'DEL' then
					if msg.content_.ID == "MessageDocument" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.File == 'WARN' then
					if msg.content_.ID == "MessageDocument" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Media == 'DEL' then
					if msg.content_.ID ~= "MessageText" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Media == 'WARN' then
					if msg.content_.ID ~= "MessageText" then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Webpage == 'DEL' then
					if msg.content_.web_page_ then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Webpage == 'WARN' then
					if msg.content_.web_page_ then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				-----------------------------------------
				if Group.Forward == 'DEL' then
					if msg.forward_info_ then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Forward == 'WARN' then
					if msg.forward_info_ then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.LongCharr == 'DEL' then
					if utf.len(TEXT) > (tonumber(Group.LongCharrC) or 500) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.LongCharr == 'WARN' then
					if utf.len(TEXT) > (tonumber(Group.LongCharrC) or 500) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.ShortCharr == 'DEL' then
					if utf.len(TEXT) < (tonumber(Group.ShortCharrC) or 2) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.ShortCharr == 'WARN' then
					if utf.len(TEXT) < (tonumber(Group.ShortCharrC) or 2) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
			end
		end
	end


	function ApiChecker(msg, Type)
		if msg and msg.chat then
	if msg.chat and msg.chat.type == 'supergroup' then
			chat_id = msg.chat.id 
			user_id = msg.from.id
			Group = redis:hgetall(chat_id)
			msg_id = msg.message_id
			TEXT = (msg.text or msg.caption or ' ')
		if msg.from.id == _Config.BotID then
			return false
		end
		if tostring(chat_id):match('-') then
			redis:sadd('Groups!', msg.chat.id)
		end
		-------------Save Data!
		local Result = api.getChatAdministrators(_Config.TOKEN, msg.chat.id)
		if Result.status == "creator" then
			redis:sadd(Result.user.id..'Chats', chat_id)
			redis:hset(chat_id, 'Owner', Result.user.id)
			redis:sadd('Mods'..chat_id, Result.user.id)
		elseif Result.status == "administrator" then
			redis:sadd('Mods'..chat_id, Result.user.id)
		end
		redis:hset(chat_id, 'Title', msg.chat.title)
		-------------------
			if not isMod(user_id, chat_id) then
				for k,v in pairs(redis:smembers('Filterlist'..chat_id)) do
					if TEXT:find(v) then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if redis:sismember('Mutelist'..chat_id, user_id) then
					if not isMod(user_id, chat_id) then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.MuteAll == 'true' then
					api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
				end
				if Group.Link == 'DEL' then
					if TEXT:lower():match('t.me') or TEXT:lower():match('telegram.me') or TEXT:lower():match('telegram.dog') or TEXT:lower():match('telegra.ph') then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Link == 'WARN' then
					if TEXT:lower():match('t.me') or TEXT:lower():match('telegram.me') or TEXT:lower():match('telegram.dog') or TEXT:lower():match('telegra.ph') then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------
				if Group.Atsign == 'DEL' then
					if TEXT:match('@')  then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Atsign == 'WARN' then
					if TEXT:match('@')  then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Hashtag == 'DEL' then
					if TEXT:lower():match('#')  then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Hashtag == 'WARN' then
					if TEXT:lower():match('#')  then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.English == 'DEL' then
					if TEXT:lower():match('[a-z]')  then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.English == 'WARN' then
					if TEXT:lower():match('[a-z]')  then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Persion == 'DEL' then
					if TEXT:lower():match('[\216-\219][\128-\191]')  then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Persion == 'WARN' then
					if TEXT:lower():match('[\216-\219][\128-\191]')  then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Edit == 'DEL' then
					if msg.edit_date then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Edit == 'WARN' then
					if msg.edit_date then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Photo == 'DEL' then
					if msg.photo then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Photo == 'WARN' then
					if msg.photo then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Video == 'DEL' then
					if msg.video then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Video == 'WARN' then
					if msg.video then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.ShareNumber == 'DEL' then
					if msg.contact then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.ShareNumber == 'WARN' then
					if msg.content_.ID == "MessageContact" then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Music == 'DEL' then
					if msg.audio then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Music == 'WARN' then
					if msg.audio then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Voice == 'DEL' then
					if msg.voice then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Voice == 'WARN' then
					if msg.voice then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Location == 'DEL' then
					if msg.location then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Location == 'WARN' then
					if msg.location then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Animation == 'DEL' then
					if msg.gif then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Animation == 'WARN' then
					if msg.gif then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Sticker == 'DEL' then
					if msg.sticker then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Sticker == 'WARN' then
					if msg.sticker then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Game == 'DEL' then
					if msg.game then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Game == 'WARN' then
					if msg.game then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Inline == 'DEL' then
					if msg.via then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Inline == 'WARN' then
					if msg.via then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Keyboard == 'DEL' then
					if msg.reply_markup then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Keyboard == 'WARN' then
					if msg.reply_markup then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.File == 'DEL' then
					if msg.document then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.File == 'WARN' then
					if msg.document then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Media == 'DEL' then
					if not msg.text then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Media == 'WARN' then
					if not msg.text then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Webpage == 'DEL' then
					if msg.webpage then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Webpage == 'WARN' then
					if msg.webpage then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				-----------------------------------------
				if Group.Forward == 'DEL' then
					if msg.forward_from then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.Forward == 'WARN' then
					if msg.forward_from then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.LongCharr == 'DEL' then
					if utf.len(TEXT) > (tonumber(Group.LongCharrC) or 500) then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.LongCharr == 'WARN' then
					if utf.len(TEXT) > (tonumber(Group.LongCharrC) or 500) then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.ShortCharr == 'DEL' then
					if utf.len(TEXT) < (tonumber(Group.ShortCharrC) or 2) then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
				if Group.ShortCharr == 'WARN' then
					if utf.len(TEXT) < (tonumber(Group.ShortCharrC) or 2) then
						api.deleteMessages(_Config.TOKEN, chat_id, msg_id)
					end
				end
			end
		end
	end
	end


	return {
		HELP = {
			NAME = { 
				fa = 'چک کننده',
				en = 'Checker !',
				call = 'Checker',
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
			},
			Pre = DoMessage,
	--		run = Run
		},
		api = {
			_MSG = {
			},
			Pre = ApiChecker,
	--		run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}