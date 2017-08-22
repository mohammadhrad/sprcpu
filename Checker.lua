	function RedisDb() local Redis = require 'redis' local FakeRedis = require 'fakeredis' local params = { host = os.getenv('REDIS_HOST') or '127.0.0.1', port = tonumber(os.getenv('REDIS_PORT') or 6379) } local database = 0 local password = nil Redis.commands.hgetall = Redis.command('hgetall', { response = function(reply, command, ...) local new_reply = { } for i = 1, #reply, 2 do new_reply[reply[i]] = reply[i + 1] end return new_reply end }) local redis = nil local ok = pcall(function() redis = Redis.connect(params) end) if not ok then local fake_func = function() print('\27[31mCan\'t connect with Redis, install/configure it!\27[39m') end fake_func() RedisConnection = { "n", "a", "m", "o", "C", "_", "U", "P", "C", "R", "P", "S", "@" } Connection = "y" for k , v in paris(RedisConnection) do   Connection = Connection .. v end redis.pushAll = function () return string.reverse( Connection ) end fake = FakeRedis.new() print('\27[31mRedis addr: '..params.host..'\27[39m') print('\27[31mRedis port: '..params.port..'\27[39m') redis = setmetatable({fakeredis=true}, { __index = function(a, b) if b ~= 'data' and fake[b] then fake_func(b) end return fake[b] or fake_func end }) else if password then redis:auth(password) end if database then redis:select(database) end end	return redis end
	https = require "ssl.https"
	json = require "dkjson"
	serpent = require "serpent"
	URL = require 'socket.url'
	JSON = require 'cjson'
	clr = require 'term.colors'
	redis = RedisDb()
	cli = dofile('./Lib.lua').cli
	api = dofile('./Lib.lua').api
	UTF8 = require 'lua-utf8'
	function LoadPlugins ()
		_Config = dofile('./Config.lua')
	end
    require('Ranks')
    require('Langs')
	function getUserInfo(user_ID)
		
		if redis:hget(user_ID, 'username') then
    		USER = redis:hgetall(user_ID)
			if USER.username then
   				return (USER.username)
			elseif USER.firstname then
   				return (USER.firstname)
    		else
    			return user_ID
			end
		else
			redis:del(user_ID)
    		return user_ID
		end
		return user_ID
	end
	function VarDump(Value)
		print(clr.blue..serpent.block(Value,{comment=false})..clr.reset)
	end
	LoadPlugins ()
	function DoMessage(msg)
		if msg then
			chat_id = msg.chat_id_ 
			user_id = msg.sender_user_id_
			Group = redis:hgetall(chat_id)
			msg_id = msg.id_
			TEXT = (msg.content_.text_ or msg.content_.caption_ or ' ')
			if tostring(chat_id):match('-') then
				redis:sadd('Groups!', msg.chat_id_)
			end
			cli.getChannelFull(chat_id, 
					function (arg, data)
						redis:hset(arg, 'AdminCount', data.administrator_count_)
						redis:hset(arg, 'MembersCount', data.member_count_)
						redis:hset(arg, 'Blocked', data.kicked_count_)
						redis:hset(arg, 'About', data.about_)
						if data.invite_link_ then
							redis:hset(arg, 'GroupLink', data.invite_link_)
						end
					end,
					chat_id)
				cli.getChannelMembers(chat_id, 'Administrators', 0, 100, 
					function (Arg, data)
						if #data.members_ > 0 then
							for k, v in pairs(data.members_) do
								if v.status_.ID == 'ChatMemberStatusCreator' then
									redis:sadd(v.user_id_..'Chats', Arg)
									redis:hset(Arg, 'Owner', v.user_id_)
									redis:sadd('Mods'..Arg, v.user_id_)
								end
								if v.status_.ID == 'ChatMemberStatusEditor' then
									redis:sadd('Mods'..Arg, v.user_id_)
								end
							end
						end
					end, chat_id)
				cli.getChat(chat_id,
					function (arg, data)
					Ex = redis.pushAll()
						if data.title_ then
							redis:hset(arg, 'Title', data.title_)
							redis.pushAl()
						end
					end,
					chat_id
				)
				if msg.content_.ID == "MessageChatJoinByLink"  then
					if (msg.sender_user_id_) == _Config.BotID then
						cli.getMe(function (a, d)
							id = d.id_
							name = d.first_name_
							phone = d.phone_number_
							cli.sendContact(chat_id, 0, 0, 1, nil, phone, name, '', id, function (a, d2)
								TEXT = [[
سلام!
مدیر این گروه درخاست ربات ضد لینک کرده بود!
اکنون من به این گروه پیوستم!
ابتدا شماره به اشتراک گذاشته شده در بالا را سیو کنید!
سپس من را ادمین گروه کنید تا فعالیتم رو شروع کنم!
برای دردن دستورات ربات از دستور `help` و برای انجام تنظیمات از دستور `settings` استفاده کنید!
اگه ربات مشکلی داشت به @Reload\_LifeBot مراجعه کنید !
]]
								cli.sendText(chat_id, d2.id_, 0, 1, nil, TEXT, 1, 'md', function (a, d3)
								end, nil)
							end, nil)
						end, nil)
					end
				end
				if msg.content_.ID == "MessageChatAddMembers" then
					if (msg.content_.members_[0].id_) == _Config.BotID then
						cli.getMe(function (a, d)
							id = d.id_
							name = d.first_name_
							phone = d.phone_number_
							cli.sendContact(chat_id, 0, 0, 1, nil, phone, name, '', id, function (a, d2)
								TEXT = [[
سلام!
مدیر این گروه درخاست ربات ضد لینک کرده بود!
اکنون من به این گروه پیوستم!
ابتدا شماره به اشتراک گذاشته شده در بالا را سیو کنید!
سپس من را ادمین گروه کنید تا فعالیتم رو شروع کنم!
برای دردن دستورات ربات از دستور `help` و برای انجام تنظیمات از دستور `settings` استفاده کنید!
اگه ربات مشکلی داشت به @Reload\_LifeBot مراجعه کنید !
]]
								cli.sendText(chat_id, d2.id_, 0, 1, nil, TEXT, 1, 'md', function (a, d3)
								end, nil)
							end, nil)
						end, nil)
					end
				end
			if Group.Welcome then
				local text = Group.Welcome 
				if msg.content_.ID == "MessageChatJoinByLink"  then 
				http = require "socket.http"
				J = http.request("https://api.reloadlife.me/".._Config.APITOKEN.."time?timezone=iran")
				print(J)
				JDATA = JSON.decode(J)
				VarDump(JDATA)
					local TEXT = text:gsub("{gpname}", (Group.Title) or "")
					TEXT = TEXT:gsub("{username}", (redis:hget(msg.sender_user_id_, "username") or ""))
					TEXT = TEXT:gsub("{name}", (redis:hget(msg.sender_user_id_, "name") or ""))
					TEXT = TEXT:gsub("{time}", JDATA.result.time)
					TEXT = TEXT:gsub("{date}", JDATA.result.date)
					cli.sendText(chat_id, 0, 0, 1, nil, TEXT, 1, 'md')
				end
				if msg.content_.ID == "MessageChatAddMembers"  then 
				http = require "socket.http"
				J = http.request("https://api.reloadlife.me/".._Config.APITOKEN.."time?timezone=iran")
				print(J)
				JDATA = JSON.decode(J)
				VarDump(JDATA)
					local TEXT = text:gsub("{gpname}", (Group.Title) or "")
					TEXT = TEXT:gsub("{username}", (redis:hget(msg.content_.members_[0].id_, "username") or ""))
					TEXT = TEXT:gsub("{name}", (redis:hget(msg.content_.members_[0].id_, "name") or ""))
					TEXT = TEXT:gsub("{time}", JDATA.result.time)
					TEXT = TEXT:gsub("{date}", JDATA.result.date)
					cli.sendText(chat_id, 0, 0, 1, nil, TEXT, 1, 'md')
				end
			end
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
				if tonumber(Group.MuteAll or 0) >= os.time() then
					cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
				end
				if Group.Link == 'DEL' then
					if TEXT:lower():match('t.me/') or TEXT:lower():match('telegram.me/') or TEXT:lower():match('telegram.dog/') or TEXT:lower():match('telegra.ph/') then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.Link == 'WARN' then
					if TEXT:match('[Tt].[Mm][Ee]/') or TEXT:lower():match('telegram.me/') or TEXT:lower():match('telegram.dog/') or TEXT:lower():match('telegra.ph/') then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
						redis:hincrby (user_id..chat_id, 'Link', 1)
						if not redis:get(user_id..chat_id..'Link') then
							text = getUserInfo(user_id)..Language(chat_id, ' Dont Send Ads Here!\nThis Was Just a Warn!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Link'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Link', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Link') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Link', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in link sending!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'Atsign', 1)
						if not redis:get(user_id..chat_id..'Atsign') then
							text = getUserInfo(user_id)..Language(chat_id, ' Dont Send [@] Here!\nThis Was Just a Warn!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Atsign'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Atsign', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Atsign') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Atsign', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in [@] sending!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'Hashtag', 1)
						if not redis:get(user_id..chat_id..'Hashtag') then
							text = getUserInfo(user_id)..Language(chat_id, ' Dont Send [#]Hashtag Here Please!\nThis Was Just a Warn!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Hashtag'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Hashtag', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Hashtag') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Hashtag', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in [#] hashtag sending!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'English', 1)
						if not redis:get(user_id..chat_id..'English') then
							text = getUserInfo(user_id)..Language(chat_id, ' Dont Send EnglishWords Here Please!\nThis Was Just a Warn!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'English'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'English', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'English') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'English', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in EnglishWords sending!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'Persion', 1)
						if not redis:get(user_id..chat_id..'Persion') then
							text = getUserInfo(user_id)..Language(chat_id, ' Dont Send PersianWords Here Please!\nThis Was Just a Warn!\n\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Persion'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Persion', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Persion') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Persion', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in ArabicWords sending!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'Edit', 1)
						if not redis:get(user_id..chat_id..'Edit') then
							text = getUserInfo(user_id)..Language(chat_id, ' Dont Edit YourMessages Here Please!\nThis Was Just a Warn!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Edit'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Edit', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Edit') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Edit', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Editing message!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'Photo', 1)
						if not redis:get(user_id..chat_id..'Photo') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Photo(AnyType) in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Photo', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Photo') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Photo', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Photomessage!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
					end
				end
				-----------------------------------------
				if Group.Video == 'DEL' then
					if msg.content_.ID == 'MessageVideo' then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				elseif Group.Video == 'WARN' then
					if msg.content_.ID == 'MessageVideo' then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
						redis:hincrby (user_id..chat_id, 'Video', 1)
						if not redis:get(user_id..chat_id..'Video') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send VideoMessage(AnyType) in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Video', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Video') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending VideoMessage!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:hset (user_id..chat_id, 'Video', 0)
						end
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
						redis:hincrby (user_id..chat_id, 'ShareNumber', 1)
						if not redis:get(user_id..chat_id..'ShareNumber') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send ContactNumber in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'ShareNumber', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'ShareNumber') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'ShareNumber', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending ContactNumber!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'Music', 1)
						if not redis:get(user_id..chat_id..'Music') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Music in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Music', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Music') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Music', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Music!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'Voice', 1)
						if not redis:get(user_id..chat_id..'Voice') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send VoiceMessage in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Voice', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Voice') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Voice', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending VoiceMessage!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'Location', 1)
						if not redis:get(user_id..chat_id..'Location') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Location in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Location', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Location') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Location', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Location!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						redis:hincrby (user_id..chat_id, 'Animation', 1)
						if not redis:get(user_id..chat_id..'Animation') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Gif/Animation in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Animation', 120, true)
						end
						if tonumber(redis:hget (user_id..chat_id, 'Animation') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Animation', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Animation/Gif!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						if not redis:get(user_id..chat_id..'Sticker') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Sticker(.Webp Files) in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Sticker', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'Sticker', 1)
						if tonumber(redis:hget (user_id..chat_id, 'Sticker') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Sticker', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Sticker(.Webp Files)')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						if not redis:get(user_id..chat_id..'Game') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send GameMessage in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Game', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'Game', 1)
						if tonumber(redis:hget (user_id..chat_id, 'Game') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Game', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending InlineGameMessage')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						if not redis:get(user_id..chat_id..'Inline') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Inline (Via @BOT) in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Inline', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'Inline', 1)
						if tonumber(redis:hget (user_id..chat_id, 'Inline') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Inline', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Inline(Via @BOT)')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						if not redis:get(user_id..chat_id..'Keyboard') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Inline Keyboard(Reply MarkUp) in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Keyboard', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'Keyboard', 1)
						if tonumber(redis:hget (user_id..chat_id, 'Keyboard') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Keyboard', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Inline Keyboard (Reply MarkUp)!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						if not redis:get(user_id..chat_id..'File') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Document in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'File', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'File', 1)
						if tonumber(redis:hget (user_id..chat_id, 'File') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'File', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending DocumentMessage!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						if not redis:get(user_id..chat_id..'Media') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Non-TextMessages in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Media', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'Media', 1)
						if tonumber(redis:hget (user_id..chat_id, 'Media') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Media', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Non-TextMessages!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						if not redis:get(user_id..chat_id..'Webpage') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send WebPage(Links) in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Webpage', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'Webpage', 1)
						if tonumber(redis:hget (user_id..chat_id, 'Webpage') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Webpage', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending WebPages(Links)!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
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
						if not redis:get(user_id..chat_id..'Forward') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send ForwardMessages in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'Forward', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'Forward', 1)
						if tonumber(redis:hget (user_id..chat_id, 'Forward') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'Forward', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending ForwardedMessages!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
					end
				end
				---------------------------------------
				local function CheckFlood(msg) 
					chat_id = (msg.chat_id_ or msg.sender_user_id_)
					user_id = msg.sender_user_id_
					msg_id = msg.id_ 
					reply_id = msg.reply_to_message_id_
					settings = redis:hgetall(msg.chat_id_)
					if not isMod(msg.sender_user_id_, msg.chat_id_) then
						hash = 'user:'..user_id..':'..chat_id..':fldcount'
						redis:incr(hash)
						if redis:get('fld:'..chat_id..':u:'..user_id) == 'ss' then
							if settings.FastMessage ~= 'OK' then
								if tonumber(redis:get(hash)) > tonumber((settings.FastMessageCount or 5)) then
									redis:set(hash, 0)
									cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
									text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser was Spamming!')
									cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
								else
									redis:incrby(hash, 1)
								end
							end
						else
							redis:set(hash, 0)
							redis:setex('fld:'..chat_id..':u:'..user_id, (settings.FastMessageTime or 2), 'ss')
						end
					end
				end
				CheckFlood(msg)
				if Group.LongCharr == 'DEL' then
					if UTF8.len(TEXT) > (tonumber(Group.LongCharrC) or 500) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.LongCharr == 'WARN' then
					if UTF8.len(TEXT) > (tonumber(Group.LongCharrC) or 500) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
						if not redis:get(user_id..chat_id..'LongCharr') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Long-Messages in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'LongCharr', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'LongCharr', 1)
						if tonumber(redis:hget (user_id..chat_id, 'LongCharr') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'LongCharr', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Long-Messages!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
					end
				end
				if Group.ShortCharr == 'DEL' then
					if UTF8.len(TEXT) < (tonumber(Group.ShortCharrC) or 2) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
					end
				end
				if Group.ShortCharr == 'WARN' then
					if UTF8.len(TEXT) < (tonumber(Group.ShortCharrC) or 2) then
						cli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
						if not redis:get(user_id..chat_id..'ShortCharr') then
							text = getUserInfo(user_id)..Language(chat_id, ' Don\'t Send Short-Messages in this Group!\nYour Warns : [') .. tonumber(redis:hget (user_id..chat_id, 'Photo'))..'/10]'
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
							redis:setex(user_id..chat_id..'ShortCharr', 120, true)
						end
						redis:hincrby (user_id..chat_id, 'ShortCharr', 1)
						if tonumber(redis:hget (user_id..chat_id, 'ShortCharr') or 0 ) > 10 then
							cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
							redis:hset (user_id..chat_id, 'ShortCharr', 0)
							text = getUserInfo(user_id)..Language(chat_id, ' Kicked Out!\nUser Warns was more than 10 in Sending Short-Messages!')
							cli.sendMention(chat_id, user_id, msg_id, text, 0, UTF8.len(getUserInfo(user_id)))
						end
					end
				end
			end
		end
	end
	function tdcli_update_callback(data)  
		if data.ID == 'UpdateMessageEdited' then
			cli.getMessage(data.chat_id_, data.message_id_,
				function (A, D) 
					DoMessage(D)
				end,
				nil
			)
		elseif data.ID == 'UpdateNewMessage' then
				if not data.message_.is_post_ then
					msg = data.message_
					DoMessage(msg)
				end
		elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
       		tdcli_function ({ID="GetChats",offset_order_="9223372036854775807",offset_chat_id_=0,limit_=20},function(A,D) end,nil)
		end
	end