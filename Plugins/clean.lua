		function GpLang(chat_ID)
            if chat_ID then
                return (redis:hget(chat_ID, 'Lang') or 'FA')
            end
        end

    function DelMsgs(ex, result )
    	for k,v in pairs(result.messages_) do
   	 	   	cli.deleteMessages(v.chat_id_, {[0] = v.id_})
   	 	   	i = i + 1
  		end
    end
    function call_cb(extra, result)
		for v,k in pairs(result.members_) do
			cli.deleteMessagesFromUser(extra.chat_id, k.user_id_)
		end
	end
	function Run(msg, matches)
		if #matches > 0 then
			if matches[1]:lower() == 'clean' and isMod(msg.sender_user_id_, msg.chat_id_) then
				if matches[2]:lower() == 'msg' then
						tdcli_function ({
  							  ID = "GetChatHistory",
  							  chat_id_ = msg.chat_id_,
  							  from_message_id_ = msg.id_,
  							  offset_ = 0,
  							  limit_ = (matches[3] or 100)
  						}, DelMsgs, nil)
					if GpLang(msg.chat_id_):lower() == 'fa' then
						return 'تعداد پیام مورد نطر حذف شدند !'
					else
						return 'Messages Cleaned !'
					end
				elseif matches[2]:lower() == 'all' then

					tdcli_function ({
  						  ID = "GetChannelMembers",
  						  channel_id_ = msg.chat_id_:gsub('-100',''),
  						  filter_ = {
  						    ID = "ChannelMembersKicked"
  						  },
  						  offset_ = 0,
  						  limit_ = 10000
  					}, call_cb, {chat_id=msg.chat_id_})
	  				tdcli_function ({
  						  ID = "GetChannelMembers",
  						  channel_id_ = msg.chat_id_:gsub('-100',''),
  						  filter_ = {
  						    ID = "ChannelMembersRecent"
  						  },
  						  offset_ = 0,
  						  limit_ = 200
  					}, call_cb, {chat_id=msg.chat_id_})
					if GpLang(msg.chat_id_):lower() == 'fa' then
						return 'تمامی پیام هایی که به آنها دسترسی داشتم حذف شد !'
					else
						return 'Messages Cleaned Success !'
					end
				elseif matches[2]:lower() == 'bots' then
					tdcli_function ({
  						  ID = "GetChannelMembers",
  						  channel_id_ = msg.chat_id_:gsub('-100',''),
  						  filter_ = {
  						    ID = "ChannelMembersBots"
  						  },
  						  offset_ = 0,
  						  limit_ = 10000
  					}, function (A,D)
  						for v,k in pairs(D.members_) do
							cli.changeChatMemberStatus(msg.chat_id_, k.user_id_, 'Kicked')
						end
  					end, {chat_id=msg.chat_id_})
					if GpLang(msg.chat_id_):lower() == 'fa' then
						return 'تمامی ربات های API اخراج شدند !'
					else
						return 'All Bots Kicked Success !'
					end
				elseif matches[2]:lower() == 'members' then
					tdcli_function ({
  						  ID = "GetChannelMembers",
  						  channel_id_ = msg.chat_id_:gsub('-100',''),
  						  filter_ = {
  						    ID = "ChannelMembersRecent"
  						  },
  						  offset_ = 0,
  						  limit_ = 10000
  					}, function (A,D)
  						for v,k in pairs(D.members_) do
  							if not isMod(k.user_id_, msg.chat_id_) then
								cli.changeChatMemberStatus(msg.chat_id_, k.user_id_, 'Kicked')
							end
						end
  					end, {chat_id=msg.chat_id_})
					if GpLang(msg.chat_id_):lower() == 'fa' then
						return 'تمامی اعضا اخراج شدند !'
					else
						return 'All Members Kicked Success !'
					end
				elseif matches[2]:lower() == 'blocked' then
					tdcli_function ({
  						  ID = "GetChannelMembers",
  						  channel_id_ = msg.chat_id_:gsub('-100',''),
  						  filter_ = {
  						    ID = "ChannelMembersKicked"
  						  },
  						  offset_ = 0,
  						  limit_ = 10000
  					}, function (A,D)
  						for v,k in pairs(D.members_) do
							cli.changeChatMemberStatus(msg.chat_id_, k.user_id_, 'Left')
						end
  					end, {chat_id=msg.chat_id_})
					if GpLang(msg.chat_id_):lower() == 'fa' then
						return '*کاربران بلاک شده گروه ازاد شدند *!'
					else
						return '*Block List Cleaned *!'
					end
				elseif matches[2]:lower() == 'deleted' then
					tdcli_function ({
  						  ID = "GetChannelMembers",
  						  channel_id_ = msg.chat_id_:gsub('-100',''),
  						  filter_ = {
  						    ID = "ChannelMembersRecent"
  						  },
  						  offset_ = 0,
  						  limit_ = 10000
  					}, function (A,D)
  						for v,k in pairs(D.members_) do
  							cli.getUserFull(v.user_id_, 
							function (Arg, data)
  								if data.code_ == 6 then
  									cli.changeChatMemberStatus(Arg.chat_id, k.user_id_, 'kicked')
  								end
  							end,{chat_id = msg.chat_id_})
						end
  					end, {chat_id=msg.chat_id_})
					if GpLang(msg.chat_id_):lower() == 'fa' then
						return '*کاربران دیلیت شده اخراج شدند *!'
					else
						return '*Deleted Account Cleaned *!'
					end
				end
			end
		end
	end
	-----------------------------------------
	function ApiRun(msg, matches)

	end


	return {
		HELP = {
			NAME = { 
				fa = 'پاک کننده !',
				en = 'Cleaner !',
				call = 'clean',
			},
			Dec = {
				fa = 'پاک کننده',
				en = 'Cleaner Plugin!',
			},
			Usage = {
				fa = '`Clean msg [Number]` : حذف [Number] پیام از تاریخچه گروه !\n'
				..'`Clean All` : حذف تمامی پیام های گروه\n'
				..'`Clean Bots` : اخراج کردن تمامی ربات ها از گروه\n'
				..'`Clean Members` : اخراج کردن تمامی اغضای گروه\n'
				..'`Clean Blocked` : ازاد سازی تمامی مسدودین از گروه\n'
				..'`Clean Deleted` : اخراج کردن تمامی اعضای دیلیت اکانت شده از گروه\n'
				..'*تنها مدیران گروه میتوانند از این دستور ها استفادده کنند*',
				en = '`Clean msg [Number]` : Delete [Number] Messages from chat history !\n'
				..'`Clean All` : Clean Group history\n'
				..'`Clean Bots` : kick all of API Bots in group\n'
				..'`Clean Members` : clean Members from group\n'
				..'`Clean Blocked` : Clean Group Blocked List\n'
				..'`Clean Deleted` : Clean Group Deleted Users (Deleted Accounts)\n'
				..'*This Plugin is just usable by group Mods !*',
			},
			rank = 'Mod',
		},

		cli = {
			_MSG = {
				--Patterns :)
				'^([Cc]lean) ([Mm]sg) (%d+)$',
				'^([Cc]lean) ([Aa]ll)$',
				'^([Cc]lean) ([Bb]ots)$',
				'^([Cc]lean) ([Mm]embers)$',
				'^([Cc]lean) ([Bb]locked)$',
				'^([Cc]lean) ([Dd]eleted)$',
				'^[!#/]([Cc]lean) ([Mm]sg) (%d+)$',
				'^[!#/]([Cc]lean) ([Aa]ll)$',
				'^[!#/]([Cc]lean) ([Bb]ots)$',
				'^[/!#]([Cc]lean) ([Mm]embers)$',
				'^[/!#]([Cc]lean) ([Bb]locked)$',
				'^[/!#]([Cc]lean) ([Dd]eleted)$',
			},
	--		Pre = Pre,
			run = Run
		},
		api = {
			_MSG = {
				--Patterns :)

			},
		--	Pre = ApiPre,
		--	run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}