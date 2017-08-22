		function GpLang(chat_ID)
            if chat_ID then
                return (redis:get(chat_ID..'Lang') or 'FA')
            end
        end
	function Run(msg, matches)
		if #matches > 0 then
			if matches[1]:lower() == 'id' then
				if #matches < 2 then
					if tonumber(msg.reply_to_message_id_) == 0 then
						if msg.USER.user_.profile_photo_ then
							if msg.USER.user_.profile_photo_.big_.path_ then
								local Photo = msg.USER.user_.profile_photo_.big_.path_ 
								local TEXT = Language(msg.chat_id_, "ID_CAPTION"):format(
									tostring(msg.sender_user_id_),
									tostring(msg.chat_id_),
									tostring(msg.USER.user_.first_name_),
									tostring(msg.USER.user_.username_ or "")
								)
								cli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, Photo, TEXT)
							else
								cli.downloadFile(msg.USER.user_.profile_photo_.big_.id_)
								local TEXT = Language(msg.chat_id_, "ID_BEFOR_DL"):format(
									tostring(msg.sender_user_id_),
									tostring(msg.chat_id_),
									tostring(msg.USER.user_.first_name_),
									tostring(msg.USER.user_.username_ or "")
								)
								cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
							end
						else
							local TEXT = Language(msg.chat_id_, "ID_NOTFOUND"):format(
									tostring(msg.sender_user_id_),
									tostring(msg.chat_id_),
									tostring(msg.USER.user_.first_name_),
									tostring(msg.USER.user_.username_ or "")
								)
							cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
						end
					else
						cli.getMessage(msg.chat_id_, msg.reply_to_message_id_,
						function (Arg, Data)
							cli.getUserFull(Data.sender_user_id_, function (A, D)
								if D.user_.profile_photo_ then
									if D.user_.profile_photo_.big_.path_ then
										local Photo = D.user_.profile_photo_.big_.path_ 
										local TEXT = Language(msg.chat_id_, "ID_CAPTION"):format(
											tostring(D.user_.id_),
											tostring(msg.chat_id_),
											tostring(D.user_.first_name_),
											tostring(D.user_.username_ or "")
										)
										cli.sendPhoto(msg.chat_id_, msg.reply_to_message_id_, 0, 1, nil, Photo, TEXT)
									else
										cli.downloadFile(D.user_.profile_photo_.big_.id_)
										local TEXT = Language(msg.chat_id_, "ID_BEFOR_DL"):format(
											tostring(Data.user_.id_),
											tostring(msg.chat_id_),
											tostring(D.user_.first_name_),
											tostring(D.user_.username_ or "")
										)
										cli.sendText(msg.chat_id_, msg.reply_to_message_id_, 0, 1, nil, TEXT, 1, 'MarkDown')
									end
								else
									local TEXT = Language(msg.chat_id_, "ID_NOTFOUND"):format(
											tostring(Data.user_.id_),
											tostring(msg.chat_id_),
											tostring(D.user_.first_name_),
											tostring(D.user_.username_ or "")
										)
									cli.sendText(msg.chat_id_, msg.reply_to_message_id_, 0, 1, nil, TEXT, 1, 'MarkDown')
								end
							end, nil)
						end, nil)
					end
				end
				if #matches > 1 then
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
						cli.getUserFull(
							X,
						function (A, D)
							if D.ID == 'Error' then
								local URL = 'https://id.pwrtelegram.xyz/db/getusername?id='..tostring(X)
								local JDATA = JSON.decode(io.popen("curl "..URL):read("*all"))
								VarDump(JDATA)
								if JDATA.result then
						cli.searchPublicChat(JDATA.result,
							function (A, D)
							print("PWR USERD !!")
								if D.ID == 'Error' then

								end
								if D.type_.ID == 'PrivateChatInfo' then 
									if D.photo_ then
										if D.photo_.big_.path_ then
											local Photo = D.photo_.big_.path_
										local TEXT = Language(msg.chat_id_, "ID_CAPTION"):format(
											tostring(D.id_),
											tostring(msg.chat_id_),
											tostring(D.title_),
											tostring(JDATA.result or "")
										)
											cli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, Photo, TEXT)
										else
											cli.downloadFile(D.photo_.big_.id_)
											local TEXT = Language(msg.chat_id_, "ID_BEFOR_DL"):format(
												tostring(D.id_),
												tostring(msg.chat_id_),
												tostring(D.title_),
												tostring(JDATA.result or "")
											)
											cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
										end
									else
										local TEXT = Language(msg.chat_id_, "ID_NOTFOUND"):format(
											tostring(D.id_),
											tostring(msg.chat_id_),
											tostring(D.title_),
											tostring(JDATA.result or "")
										)
										cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
									end
								else
									local TEXT = Language(msg.chat_id_, "ID_CHANNEL"):format(
											tostring(D.id_),
											tostring(msg.chat_id_),
											tostring(D.title_),
											tostring(JDATA.result or "")
										)
									cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
								end
							end,
						nil)
								else
									local TEXT = Language(msg.chat_id_, "ID_NOTFOUND_USERID"):format(
										tostring(X)
									)
									return TEXT
								end
							else
								if D.user_.profile_photo_ then
									if D.user_.profile_photo_.big_.path_ then
										local Photo = D.user_.profile_photo_.big_.path_ 
										local TEXT = Language(msg.chat_id_, "ID_CAPTION"):format(
											tostring(D.user_.id_),
											tostring(msg.chat_id_),
											tostring(D.user_.first_name_),
											tostring(D.user_.username_ or "")
										)
										cli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, Photo, TEXT)
									else
										cli.downloadFile(D.user_.profile_photo_.big_.id_)
										local TEXT = Language(msg.chat_id_, "ID_BEFOR_DL"):format(
											tostring(D.user_.id_),
											tostring(msg.chat_id_),
											tostring(D.user_.first_name_),
											tostring(D.user_.username_ or "")
										)
										cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
									end
								else
									local TEXT = Language(msg.chat_id_, "ID_NOTFOUND"):format(
											tostring(D.user_.id_),
											tostring(msg.chat_id_),
											tostring(D.user_.first_name_),
											tostring(D.user_.username_ or "")
										)
									cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
								end
							end
						end, nil)
					else
						cli.searchPublicChat(matches[2]:gsub('@', ''),
							function (A, D)
								if D.ID == 'Error' then
									local TEXT = Language(msg.chat_id_, "ID_NOTFOUND_USERNAME"):format(
											tostring(matches[2]:gsub('@', '') or "")
									)
									return TEXT
								end
								if D.type_.ID == 'PrivateChatInfo' then 
									if D.photo_ then
										if D.photo_.big_.path_ then
											local Photo = D.photo_.big_.path_
										local TEXT = Language(msg.chat_id_, "ID_CAPTION"):format(
											tostring(D.id_),
											tostring(msg.chat_id_),
											tostring(D.title_),
											tostring(matches[2]:gsub('@', '') or "")
										)
											cli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, Photo, TEXT)
										else
											cli.downloadFile(D.photo_.big_.id_)
											local TEXT = Language(msg.chat_id_, "ID_BEFOR_DL"):format(
												tostring(D.id_),
												tostring(msg.chat_id_),
												tostring(D.title_),
												tostring(matches[2]:gsub('@', '') or "")
											)
											cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
										end
									else
										local TEXT = Language(msg.chat_id_, "ID_NOTFOUND"):format(
											tostring(D.id_),
											tostring(msg.chat_id_),
											tostring(D.title_),
											tostring(matches[2]:gsub('@', '') or "")
										)
										cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
									end
								else
									local TEXT = Language(msg.chat_id_, "ID_CHANNEL"):format(
											tostring(D.id_),
											tostring(msg.chat_id_),
											tostring(D.title_),
											tostring(matches[2]:gsub('@', '') or "")
										)
									cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, TEXT, 1, 'MarkDown')
								end
							end,
						nil)
					end
				end
			end
		end
	end
	-----------------------------------------
	function ApiRun(msg, matches)
		if #matches > 0 then
			if msg.reply_to_message then
					if msg.reply_to_message.chat.id then
						chid = msg.reply_to_message.chat.id 
					elseif msg.reply_to_message.from.id then
						chid = msg.reply_to_message.from.id 
					end
					if GpLang(chid):lower() == 'fa' then
						TXT =  '> *شناسه کاربری کاربر* : `'.. msg.reply_to_message.from.id..'`\n'
					else
						TXT =  '> *User ID* : `'.. msg.reply_to_message.from.id..'`\n'
					end
				api.sendMessage(_Config.TOKEN, msg.chat.id, TXT, 'md', {['remove_keyboard'] = true}, msg.reply_to_message.message_id, false)
			else
				if matches[1]:lower() == 'id' then
					if msg.chat.id then
						chid = msg.chat.id 
					elseif msg.from.id then
						chid = msg.from.id 
					end
					if GpLang(chid):lower() == 'fa' then
						return '> *شناسه کاربری شما* : `'.. msg.from.id..'`\n'
					else
						return '> *Your ID* : `'.. msg.from.id..'`\n'
					end
				end
			end
		end
	end

	function ApiPre(msg, Type) 
		if msg then
		if msg.chat then
		if msg.chat.type == 'private' then
		if msg.forward_from then
			id = msg.forward_from.id
			name = (msg.forward_from.first_name or '')
			username = (msg.forward_from.username or 'No Username')
			TEXT = '>User ID : '..id..'\n>Name : '..name..'\n>Username : @'..username
			photos2 = api.getUserProfilePhotos(_Config.TOKEN, id)
              if photos2.result then
                if photos2.result.total_count ~= 0 then
                  if photos2.result.photos[1][3] then
                    filep = api.getFile(_Config.TOKEN, photos2.result.photos[1][3].file_id)
                    if filep then
                    	api.sendPhotoId(_Config.TOKEN, msg.from.id, filep.result.file_id, msg.message_id, ('Forward From Info !\n'..TEXT))
                    else
						api.sendMessage(_Config.TOKEN, msg.from.id, ('Forward From Info !\n'..'No Access to profile !\n'..TEXT) ,nil ,nil , msg.message_id)	
                    end

                  end

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
				fa = 'شناسه !',
				en = 'ID !',
				call = 'ID',
			},
			Dec = {
				fa = 'شناسه',
				en = 'ID!',
			},
			Usage = {
				fa = '`id ` : دریافت اظلاهات خود\n'
				..'`id (reply)` : دریافت اطلاعات کاربر ریپلی شده\n'
				..'`id (@Username)` : دریافت اطلاعات (@Username)\n'
				..'`id (Mention)` : دریافت اطلاعات (Mention)\n'
				..'`id (UserID)` : دریافت اطلاعات (UserID)\n'
				..'`فوروارد پیام در پیوی @SPRCPU_BOT و دریافت اطلاعات فرد مورد نظر`\n'
				..'*همه میتوانند از این قابلیت استفاده کنند !*\n',
				en = '`id ` : Get You Information\n'
				..'`id (reply)` : Get Replied Target Information\n'
				..'`id (@Username)` : Get (@Username) Information\n'
				..'`id (Mention)` : Get (Mention) Information\n'
				..'`id (UserID)` : Get (UserID) Information\n'
				..'`Forward Message to @SPRCPU_BOT to get Target Information`\n'
				..'*Any one Can use this plguin :P !*\n',
			},
			rank = 'Member',
		},
		cli = {
			_MSG = {
				--Patterns :)
				'^([Ii][Dd])$',
				'^[/!#]([Ii][Dd])$',
				'^([Ii][Dd]) (.*)$',
				'^[/!#]([Ii][Dd]) (.*)$',
			},
	--		Pre = Pre,
			run = Run
		},
		api = {
			_MSG = {
				--Patterns :)
				'^([Ii][Dd])$',
				'^/([Ii][Dd])$',
			},
			Pre = ApiPre,
			run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}