	--[[
		#         SPR-CPU 			#
		#       Settings Plugin 	#
		#  	Usable by Bot Mods+     #
		#	 Update : 8/May/2017 	#
	]]
		function Run(msg, mathces)
			if mathces[1] == 'set' and isMod(msg.sender_user_id_, msg.chat_id_) then
				if mathces[2] == 'link' then
					redis:hset(msg.chat_id_, 'GroupLink', mathces[3])
					return Language(msg.chat_id_, "LINK_SET")..MarkScape(mathces[3])..''
				end
				if mathces[2] == 'wlc' then
					redis:hset(msg.chat_id_, 'Welcome', mathces[3])
					return Language(msg.chat_id_, "WLC_SET")..MarkScape(mathces[3])..''
				end
				if mathces[2] == 'lang' then
					if mathces[3] == 'en' then
						redis:hset(msg.chat_id_, 'Lang', 'en')
						return Language(msg.chat_id_, "LANG_SET_EN")
					else
						redis:hset(msg.chat_id_, 'Lang', 'fa')
						return Language(msg.chat_id_, "LANG_SET_FA")
					end
				end
			end
			if mathces[1] == 'filter' and isMod(msg.sender_user_id_, msg.chat_id_) then
				redis:sadd('Filterlist'..msg.chat_id_, mathces[2])
				return MarkScape(mathces[2]) .. Language(msg.chat_id_, "FILTER_PLUS")
			end
			if mathces[1] == 'filterlist clean' and isMod(msg.sender_user_id_, msg.chat_id_) then
				redis:del('Filterlist'..msg.chat_id_)
				return MarkScape(mathces[2]) .. Language(msg.chat_id_, "FILTER_CLEAN")
			end
			if mathces[1] == 'unfilter' and isMod(msg.sender_user_id_, msg.chat_id_) then
				redis:srem('Filterlist'..msg.chat_id_, mathces[2])
				return MarkScape(mathces[2]) .. Language(msg.chat_id_, "FILTER_EGUL")
			end
			if mathces[1] == 'muteall' and isMod(msg.sender_user_id_, msg.chat_id_) then
				if not mathces[2] or mathces[2] == '' then
					redis:hset(''..msg.chat_id_, 'MuteAll', 99999999999999)
					return Language(msg.chat_id_, "MUTE_ALL")
				elseif matches[2] then
					redis:hset(''..msg.chat_id_, 'MuteAll', tonumber(mathces[2]))
					return Language(msg.chat_id_, "MUTE_ALL")
				end
			end
			if mathces[1] == 'unmuteall' and isMod(msg.sender_user_id_, msg.chat_id_) then
				redis:hset(msg.chat_id_, 'MuteAll', 0)
				return Language(msg.chat_id_, "MUTE_UNALL")
			end
		end
		function ApiRun(msg, mathces)
			if mathces[1] == 'set' and isMod(msg.from.id, msg.chat.id) then
				if mathces[2] == 'link' then
					redis:hset(msg.chat.id, 'GroupLink', mathces[3])
					return Language(msg.chat.id, "LINK_SET")..MarkScape(mathces[3])..''
				end
				if mathces[2] == 'lang' then
					if mathces[3] == 'en' then
						redis:hset(msg.chat.id, 'Lang', 'en')
						return Language(msg.chat.id, "LANG_SET_EN")
					else
						redis:hset(msg.chat.id, 'Lang', 'fa')
						return Language(msg.chat.id, "LANG_SET_FA")
					end
				end
			end
			if mathces[1] == 'filter' and isMod(msg.from.id, msg.chat.id) then
				redis:sadd('Filterlist'..msg.chat.id, mathces[2])
				return MarkScape(mathces[2]) .. Language(msg.chat.id, "FILTER_PLUS")
			end
			if mathces[1] == 'filterlist clean' and isMod(msg.from.id, msg.chat.id) then
				redis:del('Filterlist'..msg.chat.id)
				return MarkScape(mathces[2]) .. Language(msg.chat.id, "FILTER_CLEAN")
			end
			if mathces[1] == 'unfilter' and isMod(msg.from.id, msg.chat.id) then
				redis:srem('Filterlist'..msg.chat.id, mathces[2])
				return MarkScape(mathces[2]) .. Language(msg.chat.id, "FILTER_EGUL")
			end
			if mathces[1] == 'muteall' and isMod(msg.from.id, msg.chat.id) then
				redis:hset(''..msg.chat.id, 'MuteAll', 9999999999999)
				return Language(msg.chat.id, "MUTE_ALL")
			end
			if mathces[1] == 'unmuteall' and isMod(msg.from.id, msg.chat.id) then
				redis:hset(''..msg.chat.id, 'MuteAll', 0)
				return Language(msg.chat.id, "MUTE_UNALL")
			end
		end
	return {
		HELP = {
			NAME = {
				fa = 'تنظیم',
				en = 'Set Plugin !',
				call = 'set',
			},
			Dec = {
				fa = 'تنظیم تنظیمات',
				en = 'Set Settings ',
			},
			Usage = {
				fa = '`Set Link (GroupLink)` : تنظیم لینک گروه\n'
				..'`Set Lang (FA|EN)` : تنظیم زبان گروه\n'
				..'`Set wlc (text)` : تنظیم پیام خوشامد گویی\n'
				..'`[Un]Filter (Word)` : [حذف] فیلتر (Word)\n'
				..'`Filterlist Clean` : خذف فیلتر لیست\n'
				..'`[Un]Muteall` : سکوت/حذف سکوت گروه\n'
				..'در پیام خوشامد شما میتوانید از {time} برای ساعت و از {date} تاریخ و از  {name} و {username} برای نام و نام کاربری و از {gpname} برای نمایش نام گروه استفاده کنید!',
				en = '`Set Link (GroupLink)` : Save Group Link\n'
				..'`Set Lang (FA|EN)` : set group language\n'
				..'`Set wlc (text)` : set Welcome Message\n'
				..'`[Un]Filter (Word)` : `[Un]filter (Word)`\n'
				..'`Filterlist Clean` : Cleans FilterWords\n'
				..'`[Un]Muteall` : Mute/Unmute Group\n'
				..'in WLC Message you can use {time} as Asia/tehran time\n{date} as Jalali date\n{name} {username} az name or username\nand {gpname} as group name!',
			},
			rank = 'Mod',
		},
		cli = {
			_MSG = {
			'^([Ss]et) (link) (.*)$',
			'^([Ss]et) (wlc) (.*)$',
			'^([Ss]et) (lang) (.*)$',
			'^[/!#]([Ss]et) (link) (.*)$',
			'^[/!#]([Ss]et) (wlc) (.*)$',
			'^[/!#]([Ss]et) (lang) (.*)$',
			'^([Ff]ilter) (.*)$',
			'^[/!#]([Ff]ilter) (.*)$',
			'^([Uu]n[Ff]ilter) (.*)$',
			'^[/!#]([Uu]n[Ff]ilter) (.*)$',
			'^[/!#]([Ff]ilterlist) ([Cc]lean)$',
			'^([Ff]ilterlist) ([Cc]lean)$',
			'^([Uu]n[Mm]uteall)$',
			'^([Mm]uteall)$',
			'^([Mm]uteall) (.*)$',
			'^[/!#]([Uu]n[Mm]uteall)$',
			'^[/!#]([Mm]uteall)$',
			'^[/!#]([Mm]uteall) (.*)$',
			},
	--		Pre = Pre,
			run = Run
		},
		api = {
			_MSG = {
			'^([Ss]et) (link) (.*)$',
			'^([Ss]et) (wlc) (.*)$',
			'^([Ss]et) (lang) (.*)$',
			'^[/!#]([Ss]et) (link) (.*)$',
			'^[/!#]([Ss]et) (wlc) (.*)$',
			'^[/!#]([Ss]et) (lang) (.*)$',
			'^([Ff]ilter) (.*)$',
			'^[/!#]([Ff]ilter) (.*)$',
			'^([Uu]n[Ff]ilter) (.*)$',
			'^[/!#]([Uu]n[Ff]ilter) (.*)$',
			'^[/!#]([Ff]ilterlist) ([Cc]lean)$',
			'^([Ff]ilterlist) ([Cc]lean)$',
			'^([Uu]n[Mm]uteall)$',
			'^([Mm]uteall)$',
			'^[/!#]([Uu]n[Mm]uteall)$',
			'^[/!#]([Mm]uteall)$',
			},
	--		Pre = ApiPre,
			run = ApiRun
		},
		CheckMethod = 'F80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}
	-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	-- Plugin Written By @Reload_Life !
	-- SPR-CPU.IR 					  !
	-- t.me/SPRCPU_Company			  !
	-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!