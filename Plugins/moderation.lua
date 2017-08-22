	--[[
		#         SPR-CPU 			#
		#       Modertation Plugin 	#
		#  	Usable by Bot Mods+     #
		#	 Update : 9/May/2017 	#
	]]
	local utf8 = require 'lua-utf8' -- Need For Count Chars for Mention !
	local cli = cli
	local api = api
	local redis = redis
	function Run(msg, matches)
		if #matches > 0 then
				if matches[1]:lower() == 'promote' and isOwner(msg.sender_user_id_, msg.chat_id_) then --Just for owners!
					if msg.reply_to_message_id_ ~= 0 then --if is a Replyed Message!
						cli.getMessage(
							msg.chat_id_,
							msg.reply_to_message_id_,
							function (extra, result)
								local user_id = result.sender_user_id_
								local chat_id = msg.chat_id_
								if isMod(user_id, chat_id) then
									local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									local text = Language(chat_id, "ERROR_PROMOTE")
									local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_PROMOTE2")
									cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
								else
									redis:sadd('Mods'..chat_id, user_id)
									local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									local text = Language(chat_id, "SUCCESS_PROMOTE")
									local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_PROMOTE2")
									cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
								end
							end,
							nil
						)
					end
					if #matches > 1 then
						if #msg.content_.entities_ > 0 then
							if msg.content_.entities_[0].ID == "MessageEntityMentionName" then -- if matches[2] is A Mention Name!
								X = tonumber(msg.content_.entities_[0].user_id_)
							else
								X = false
							end
						else
							if tonumber(matches[2]) ~= nil then
								X = tonumber(matches[2])
							else
								X = false
							end
						end
						local X = X
						if X then
							cli.getUserFull(
								X,
								function (extra, result)
									if result.ID == 'Error' then -- if there is a Error in GetUserFull !!
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										local user_id = result.user_.id_
										local chat_id = msg.chat_id_
										if isMod(result.user_.id_, msg.chat_id_) then
											local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
											local text = Language(chat_id, "ERROR_PROMOTE")
											local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_PROMOTE2")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
										else
											redis:sadd('Mods'..chat_id, user_id)
											local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
											local text = Language(chat_id, "SUCCESS_PROMOTE")
											local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_PROMOTE2")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
										end
									end
								end,
								nil
							)
						else
							cli.searchPublicChat(
								matches[2]:gsub('@', ''),
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										if result.type_.ID == 'PrivateChatInfo' then 
											user_id = result.id_ 
											chat_id = msg.chat_id_ 
											if isMod(result.id_, msg.chat_id_) then
												local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
												local text = Language(chat_id, "ERROR_PROMOTE")
												local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_PROMOTE2")
												cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
											else
												redis:sadd('Mods'..chat_id, user_id)
												local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
												local text = Language(chat_id, "SUCCESS_PROMOTE")
												local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_PROMOTE2")
												cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
											end
										else
											return Language(chat_id, "CHANNEL_CANT_PROMOTE")
										end
									end
								end,
							nil)
						end
					end
				end
				if matches[1]:lower() == 'demote' and isOwner(msg.sender_user_id_, msg.chat_id_) then
					if msg.reply_to_message_id_ ~= 0 then
						cli.getMessage(
							msg.chat_id_,
							msg.reply_to_message_id_,
							function (extra, result)
								local user_id = result.sender_user_id_
								local chat_id = msg.chat_id_
								if not isMod(user_id, chat_id) then
									local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									local text = Language(chat_id, "ERROR_DEMOTE")
									local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_DEMOTE2")
									cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
								else
									redis:srem('Mods'..chat_id, user_id)
									local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									local text = Language(chat_id, "SUCCESS_DEMOTE")
									local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_DEMOTE2")
									cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
								end
							end,
							nil
						)
					end
					if #matches > 1 then
						if #msg.content_.entities_ > 0 then
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
						local X = X
						if type(X) == 'number' then
							cli.getUserFull(
								X,
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										local user_id = result.user_.id_
										local chat_id = msg.chat_id_
										if not isMod(user_id, chat_id) then
											local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
											local text = Language(chat_id, "ERROR_DEMOTE")
											local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_DEMOTE2")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
										else
											redis:srem('Mods'..chat_id, user_id)
											local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
											local text = Language(chat_id, "SUCCESS_DEMOTE")
											local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_DEMOTE2")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
										end
									end
								end,
								nil
							)
						else
							cli.searchPublicChat(
								matches[2]:gsub('@', ''),
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										if result.type_.ID == 'PrivateChatInfo' then 
											local user_id = result.id_ 
											local chat_id = msg.chat_id_ 
											if not isMod(user_id, chat_id) then
												local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
												local text = Language(chat_id, "ERROR_DEMOTE")
												local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_DEMOTE2")
												cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
											else
												redis:srem('Mods'..chat_id, user_id)
												local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
												local text = Language(chat_id, "SUCCESS_DEMOTE")
												local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_DEMOTE2")
												cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
											end
										else
											return Language(chat_id, "CHANNEL_CANT_PROMOTE")
										end
									end
								end,
							nil)
						end
					end
				end
				if matches[1]:lower() == 'mods' then
					if matches[2] :lower() == 'clean' and isOwner(msg.sender_user_id_, msg.chat_id_)  then
						redis:del('Mods'..msg.chat_id_)
						return Language(msg.chat_id_, "CLEAN_MODS_SUCCESS")
					elseif matches[2] :lower() == 'list' then
						if redis:scard('Mods'..msg.chat_id_) == 0 then -- If no moderators!
							return Language(msg.chat_id_, "NO_MODS")
						else
							local Mods = Language(msg.chat_id_, "LIST_MODS") .. (redis:hget(msg.chat_id_, 'Title') or msg.chat_id_).. '\n'
							for k, v in pairs(redis:smembers('Mods'..msg.chat_id_)) do
								Mods = Mods.. k ..') '..getUserInfo(v) .. '\n'
							end
							return Mods
						end
					end
				end
				if matches[1]:lower() == 'muteuser' and isMod(msg.sender_user_id_, msg.chat_id_) then
					if msg.reply_to_message_id_ ~= 0 then
						cli.getMessage(
							msg.chat_id_,
							msg.reply_to_message_id_,
							function (extra, result)
								local user_id = result.sender_user_id_
								local chat_id = msg.chat_id_
								if redis:sismember('Mutelist'..chat_id, user_id) then
									local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									local text = Language(chat_id, "MUTE_ERROR")
									local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR2")
									cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
								else
									if isMod(user_id, chat_id) then
										local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
										local text = Language(chat_id, "MUTE_ERROR1")
										local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR12")
										cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
									else
										redis:sadd('Mutelist'..chat_id, user_id)
										local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
										local text = Language(chat_id, "MUTE_SUCCESS")
										local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_SUCCESS2")
										cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
									end
								end
							end,
						nil)
					end
					if #matches > 1 then
						if #msg.content_.entities_ > 0 then
							if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
								X = tonumber(msg.content_.entities_[0].user_id_)
							else
								X = false
							end
						else
							if tonumber(matches[2]) ~= nil then
								X = tonumber(matches[2])
							else
								X = false
							end
						end
						if X then
							cli.getUserFull(
								X,
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										user_id = result.user_.id_
										chat_id = msg.chat_id_
										if redis:sismember('Mutelist'..chat_id, user_id) then
											local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
											local text = Language(chat_id, "MUTE_ERROR")
											local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR2")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
										else
											if isMod(user_id, chat_id) then
												local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
												local text = Language(chat_id, "MUTE_ERROR1")
												local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR12")
												cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
											else
												redis:sadd('Mutelist'..chat_id, user_id)
												local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
												local text = Language(chat_id, "MUTE_SUCCESS")
												local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_SUCCESS2")
												cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
											end
										end
									end
								end,
								nil
							)
						else
							cli.searchPublicChat(
								matches[2]:gsub('@', ''),
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										if result.type_.ID == 'PrivateChatInfo' then 
											local user_id = result.id_ 
											local chat_id = msg.chat_id_ 
											if redis:sismember('Mutelist'..chat_id, user_id) then
												local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
												local text = Language(chat_id, "MUTE_ERROR")
												local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR2")
												cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
											else
												if isMod(user_id, chat_id) then
													local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
													local text = Language(chat_id, "MUTE_ERROR1")
													local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR12")
													cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
												else
													redis:sadd('Mutelist'..chat_id, user_id)
													local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
													local text = Language(chat_id, "MUTE_SUCCESS")
													local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_SUCCESS2")
													cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user)) 
												end
											end

										else
											return Language(chat_id, "CHANNEL_CANT_PROMOTE")
										end
									end
								end,
								nil
							)
						end
					end
				end
				if matches[1]:lower() == 'unmuteuser' and isMod(msg.sender_user_id_, msg.chat_id_) then
					if msg.reply_to_message_id_ ~= 0 then
						cli.getMessage(
							msg.chat_id_,
							msg.reply_to_message_id_,
							function (extra, result)
								local user_id = result.sender_user_id_
								local chat_id = msg.chat_id_
								if not redis:sismember('Mutelist'..chat_id, user_id) then
									local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									local text = Language(chat_id, "UNMUTE_ERROR")
									local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_ERROR2")
									cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
								else
									redis:srem('Mutelist'..chat_id, user_id)
									local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									local text = Language(chat_id, "UNMUTE_SUCCESS")
									local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_SUCCESS2")
									cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
								end
							end,
							nil
						)
					end
					if #matches > 1 then
						if #msg.content_.entities_ > 0 then
							if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
								X = tonumber(msg.content_.entities_[0].user_id_)
							else
								X = false
							end
						else
							if tonumber(matches[2]) ~= nil then
								X = tonumber(matches[2])
							else
								X = false
							end
						end
						if X then
							cli.getUserFull(
								X,
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										local user_id = result.user_.id_
										local chat_id = msg.chat_id_
										if not redis:sismember('Mutelist'..chat_id, user_id) then
											local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
											local text = Language(chat_id, "UNMUTE_ERROR")
											local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_ERROR2")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
										else
											redis:srem('Mutelist'..chat_id, user_id)
											local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
											local text = Language(chat_id, "UNMUTE_SUCCESS")
											local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_SUCCESS2")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
										end
									end
								end,
								nil
							)
						else
							cli.searchPublicChat(
								matches[2]:gsub('@', ''),
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										if result.type_.ID == 'PrivateChatInfo' then 
											user_id = result.id_ 
											chat_id = msg.chat_id_ 
											if not redis:sismember('Mutelist'..chat_id, user_id) then
												local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
												local text = Language(chat_id, "UNMUTE_ERROR")
												local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_ERROR2")
												cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
											else
												redis:srem('Mutelist'..chat_id, user_id)
												local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
												local text = Language(chat_id, "UNMUTE_SUCCESS")
												local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_SUCCESS2")
												cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
											end
										else
											return Language(chat_id, "CHANNEL_CANT_PROMOTE")
										end
									end
								end,
								nil
							)
						end
					end
				end
				if matches[1]:lower() == 'mutes' then
					if matches[2] :lower() == 'clean' and isOwner(msg.sender_user_id_, msg.chat_id_)  then
						redis:del('Mutelist'..msg.chat_id_)
						return Language(msg.chat_id_, "MUTES_CLEAN")
					elseif matches[2] :lower() == 'list' then
						if redis:scard('Mutelist'..msg.chat_id_) == 0 then
							return Language(msg.chat_id_, "NULL_MUTELIST")
						else
							local Mutelist = Language(msg.chat_id_, "MUTE_LIST") .. (redis:hget(msg.chat_id_, 'Title') or msg.chat_id_).. '\n'
							for k, v in pairs(redis:smembers('Mutelist'..msg.chat_id_)) do
								Mutelist = Mutelist.. k ..') '..getUserInfo(v) .. '\n'
							end
							return Mutelist
						end
					end
				end
				if matches[1]:lower() == 'kick' and isMod(msg.sender_user_id_, msg.chat_id_) then
					if msg.reply_to_message_id_ ~= 0 then
						cli.getMessage(
							msg.chat_id_,
							msg.reply_to_message_id_,
							function (extra, result)
								local user_id = result.sender_user_id_
								local chat_id = msg.chat_id_
								if isMod(user_id, chat_id) then
									local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									local text = Language(chat_id, "KICK_ERROR")
									local TEXTtoSend = text .. user .. Language(chat_id, "KICK_ERROR2")
									cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
								else
									cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
									local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									local text = Language(chat_id, "KICK_SUCCESS")
									local TEXTtoSend = text .. user .. Language(chat_id, "KICK_SUCCESS2")
									cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
								end
							end,
							nil
						)
					end
					if #matches > 1 then
						if #msg.content_.entities_ > 0 then
							if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
								X = tonumber(msg.content_.entities_[0].user_id_)
							else
								X = false
							end
						else
							if tonumber(matches[2]) ~= nil then
								X = tonumber(matches[2])
							else
								X = false
							end
						end
						if X then
							cli.getUserFull(
								X,
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										user_id = result.user_.id_
										chat_id = msg.chat_id_
									if isMod(user_id, chat_id) then
										local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
										local text = Language(chat_id, "KICK_ERROR")
										local TEXTtoSend = text .. user .. Language(chat_id, "KICK_ERROR2")
										cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
									else
										cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
										local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
										local text = Language(chat_id, "KICK_SUCCESS")
										local TEXTtoSend = text .. user .. Language(chat_id, "KICK_SUCCESS2")
										cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
									end
								end
								end,
								nil
							)
						else
							cli.searchPublicChat(
								matches[2]:gsub('@', ''),
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										if result.type_.ID == 'PrivateChatInfo' then 
											user_id = result.id_ 
											chat_id = msg.chat_id_ 
											user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
										if isMod(user_id, chat_id) then
											local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
											local text = Language(chat_id, "KICK_ERROR")
											local TEXTtoSend = text .. user .. Language(chat_id, "KICK_ERROR2")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
										else
											cli.changeChatMemberStatus(chat_id, user_id, 'Kicked')
											local user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
											local text = Language(chat_id, "KICK_SUCCESS")
											local TEXTtoSend = text .. user .. Language(chat_id, "KICK_SUCCESS2")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, TEXTtoSend, utf8.len(text), utf8.len(user))
										end
										else
											return Language(chat_id, "CHANNEL_CANT_PROMOTE")
										end
									end
								end,
							nil)
						end
					end
				end
				if matches[1]:lower() == 'invite' and isMod(msg.sender_user_id_, msg.chat_id_) then
					if msg.reply_to_message_id_ ~= 0 then
						cli.getMessage(
							msg.chat_id_,
							msg.reply_to_message_id_,
							function (extra, result)
								local user_id = result.sender_user_id_
								local chat_id = msg.chat_id_
									user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
									cli.addChatMember(chat_id, user_id, 50, function (Arg, Data)
										if Data.ID == 'Ok' then
											text = user .. Language(chat_id, "INV_SUCS")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, text, 0, utf8.len(user))
										elseif Data.ID == 'Error' then
											Text = Language(chat_id, "INV_ERROR")..MarkScape(Data.message_)
											cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, Text, 1, 'MarkDown')
										end
									end, nil) 
							end,
							nil
						)
					end
					if #matches > 1 then
						if #msg.content_.entities_ > 0 then
							if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
								X = tonumber(msg.content_.entities_[0].user_id_)
							else
								X = false
							end
						else
							if tonumber(matches[2]) ~= nil then
								X = tonumber(matches[2])
							else
								X = false
							end
						end
						if X then
							cli.getUserFull(
								X,
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										user_id = result.user_.id_
										chat_id = msg.chat_id_
										user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
										cli.addChatMember(chat_id, user_id, 50, function (Arg, Data)
										if Data.ID == 'Ok' then
											text = user .. Language(chat_id, "INV_SUCS")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, text, 0, utf8.len(user))
										elseif Data.ID == 'Error' then
											Text = Language(chat_id, "INV_ERROR")..MarkScape(Data.message_)
											cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, Text, 1, 'MarkDown')
										end
									end, nil) 
									end
								end,
								nil
							)
						else
							cli.searchPublicChat(
								matches[2]:gsub('@', ''),
								function (extra, result)
									if result.ID == 'Error' then
										return Language(msg.chat_id_, "Error !\n Error Result : ")
									else
										if result.type_.ID == 'PrivateChatInfo' then 
											user_id = result.id_ 
											chat_id = msg.chat_id_ 
										user = tostring(getUserInfo(user_id)):gsub('\\', ''):gsub('@','')
										cli.addChatMember(chat_id, user_id, 50, function (Arg, Data)
										if Data.ID == 'Ok' then
											text = user .. Language(chat_id, "INV_SUCS")
											cli.sendMention(chat_id, user_id, msg.reply_to_message_id_, text, 0, utf8.len(user))
										elseif Data.ID == 'Error' then
											Text = Language(chat_id, "INV_ERROR")..MarkScape(Data.message_)
											cli.sendText(msg.chat_id_, msg.id_, 0, 1, nil, Text, 1, 'MarkDown')
										end
									end, nil) 
										else
											return Language(chat_id, "CHANNEL_CANT_PROMOTE")
										end
									end
								end,
								nil
							)
						end
					end
				end
		end
	end
	
	function ApiRun(msg, matches)
		if #matches > 0 then
				if matches[1]:lower() == 'promote' and isOwner(msg.from.id, msg.chat.id) then --Just for owners!
					if msg.reply_to_message then --if is a Replyed Message!
						local user_id = msg.reply_to_message.from.id
						local chat_id = msg.chat.id
						if isMod(user_id, chat_id) then
							local user = tostring(getUserInfo(user_id)):gsub('\\', '')
							local text = Language(chat_id, "ERROR_PROMOTE")
							local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_PROMOTE2")
                            api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false)
						else
							redis:sadd('Mods'..chat_id, user_id)
							local user = tostring(getUserInfo(user_id)):gsub('\\', '')
							local text = Language(chat_id, "SUCCESS_PROMOTE")
							local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_PROMOTE2")
							api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false)
						end
					end
					if #matches > 1 then
							if tonumber(matches[2]) ~= nil then
								X = tonumber(matches[2])
							else
								X = false
							end
						local X = X
						if X then
							local user_id = X
							local chat_id = msg.chat.id
							if isMod(user_id, msg.chat.id) then
								local user = tostring(getUserInfo(user_id)):gsub('\\', '')
								local text = Language(chat_id, "ERROR_PROMOTE")
								local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_PROMOTE2")
								api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.message_id, false)
							else
								redis:sadd('Mods'..chat_id, user_id)
								local user = tostring(getUserInfo(user_id)):gsub('\\', '')
								local text = Language(chat_id, "SUCCESS_PROMOTE")
								local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_PROMOTE2")
								api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.message_id, false)
							end
						else
						end
					end
				end
				if matches[1]:lower() == 'demote' and isOwner(msg.from.id, msg.chat.id) then
					if msg.reply_to_message then
								local user_id = msg.reply_to_message.from.id
								local chat_id = msg.chat.id
								if not isMod(user_id, chat_id) then
									local user = tostring(getUserInfo(user_id)):gsub('\\', '')
									local text = Language(chat_id, "ERROR_DEMOTE")
									local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_DEMOTE2")
									api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false) 
								else
									redis:srem('Mods'..chat_id, user_id)
									local user = tostring(getUserInfo(user_id)):gsub('\\', '')
									local text = Language(chat_id, "SUCCESS_DEMOTE")
									local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_DEMOTE2")
									api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false)
								end
					end
						if tonumber(matches[2]) ~= nil then
							X = tonumber(matches[2])
						else
							X = nil
						end
						local X = X
						if type(X) == 'number' then
							local user_id = X
							local chat_id = msg.chat.id
							if not isMod(user_id, chat_id) then
								local user = tostring(getUserInfo(user_id)):gsub('\\', '')
								local text = Language(chat_id, "ERROR_DEMOTE")
								local TEXTtoSend = text .. user .. Language(chat_id, "ERROR_DEMOTE2")
								api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.message_id, false) 
							else
								redis:srem('Mods'..chat_id, user_id)
								local user = tostring(getUserInfo(user_id)):gsub('\\', '')
								local text = Language(chat_id, "SUCCESS_DEMOTE")
								local TEXTtoSend = text .. user .. Language(chat_id, "SUCCESS_DEMOTE2")
								api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.message_id, false)
							end
						else
						end
				end
				if matches[1]:lower() == 'mods' then
					if matches[2] :lower() == 'clean' and isOwner(msg.from.id, msg.chat.id)  then
						redis:del('Mods'..msg.chat.id)
						return Language(msg.chat.id, "CLEAN_MODS_SUCCESS")
					elseif matches[2] :lower() == 'list' then
						if redis:scard('Mods'..msg.chat.id) == 0 then -- If no moderators!
							return Language(msg.chat.id, "NO_MODS")
						else
							local Mods = Language(msg.chat.id, "LIST_MODS") .. (redis:hget(msg.chat.id, 'Title') or msg.chat.id).. '\n'
							for k, v in pairs(redis:smembers('Mods'..msg.chat.id)) do
								Mods = Mods.. k ..') '..getUserInfo(v) .. '\n'
							end
							return Mods
						end
					end
				end
				if matches[1]:lower() == 'muteuser' and isMod(msg.from.id, msg.chat.id) then
					        if msg.reply_to_message then
								local user_id = msg.reply_to_message.from.id
								local chat_id = msg.chat.id
								if redis:sismember('Mutelist'..chat_id, user_id) then
									local user = tostring(getUserInfo(user_id)):gsub('\\', '')
									local text = Language(chat_id, "MUTE_ERROR")
									local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR2")
									api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false) 
								else
									if isMod(user_id, chat_id) then
										local user = tostring(getUserInfo(user_id)):gsub('\\', '')
										local text = Language(chat_id, "MUTE_ERROR1")
										local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR12")
										api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false) 
									else
										redis:sadd('Mutelist'..chat_id, user_id)
										local user = tostring(getUserInfo(user_id)):gsub('\\', '')
										local text = Language(chat_id, "MUTE_SUCCESS")
										local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_SUCCESS2")
										api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false) 
									end
								end
					        end
							if tonumber(matches[2]) ~= nil then
								X = tonumber(matches[2])
							else
								X = false
							end
						if X then
								user_id = X
								chat_id = msg.chat.id
							if redis:sismember('Mutelist'..chat_id, user_id) then
									local user = tostring(getUserInfo(user_id)):gsub('\\', '')
									local text = Language(chat_id, "MUTE_ERROR")
									local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR2")
									api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.message_id, false) 
							else
								if isMod(user_id, chat_id) then
									local user = tostring(getUserInfo(user_id)):gsub('\\', '')
									local text = Language(chat_id, "MUTE_ERROR1")
									local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_ERROR12")
									api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.message_id, false) 
								else
									redis:sadd('Mutelist'..chat_id, user_id)
								    local user = tostring(getUserInfo(user_id)):gsub('\\', '')
							    	local text = Language(chat_id, "MUTE_SUCCESS")
								    local TEXTtoSend = text .. user .. Language(chat_id, "MUTE_SUCCESS2")
								    api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.message_id, false) 
								end
							end
						else
						end
				end
				if matches[1]:lower() == 'unmuteuser' and isMod(msg.from.id, msg.chat.id) then
					if msg.reply_to_message then
							local user_id = msg.reply_to_message.from.id
							local chat_id = msg.chat.id
						if not redis:sismember('Mutelist'..chat_id, user_id) then
							local user = tostring(getUserInfo(user_id)):gsub('\\', '')
							local text = Language(chat_id, "UNMUTE_ERROR")
							local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_ERROR2")
							api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false)
						else
							redis:srem('Mutelist'..chat_id, user_id)
							local user = tostring(getUserInfo(user_id)):gsub('\\', '')
							local text = Language(chat_id, "UNMUTE_SUCCESS")
							local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_SUCCESS2")
							api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false)
						end
					end
					if #matches > 1 then
						if tonumber(matches[2]) ~= nil then
							X = tonumber(matches[2])
						else
							X = false
						end
						if X then
							local user_id = X
							local chat_id = msg.chat.id
							if not redis:sismember('Mutelist'..chat_id, user_id) then
								local user = tostring(getUserInfo(user_id)):gsub('\\', '')
								local text = Language(chat_id, "UNMUTE_ERROR")
								local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_ERROR2")
								api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.message_id, false)
							else
								redis:srem('Mutelist'..chat_id, user_id)
								local user = tostring(getUserInfo(user_id)):gsub('\\', '')
								local text = Language(chat_id, "UNMUTE_SUCCESS")
								local TEXTtoSend = text .. user .. Language(chat_id, "UNMUTE_SUCCESS2")
								api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.message_id, false)
							end
						else
							
						end
					end
				end
				if matches[1]:lower() == 'mutes' then
					if matches[2] :lower() == 'clean' and isOwner(msg.from.id, msg.chat.id)  then
						redis:del('Mutelist'..msg.chat.id)
						return Language(msg.chat.id, "MUTES_CLEAN")
					elseif matches[2] :lower() == 'list' then
						if redis:scard('Mutelist'..msg.chat.id) == 0 then
							return Language(msg.chat.id, "NULL_MUTELIST")
						else
							local Mutelist = Language(msg.chat.id, "MUTE_LIST") .. (redis:hget(msg.chat.id, 'Title') or msg.chat.id).. '\n'
							for k, v in pairs(redis:smembers('Mutelist'..msg.chat.id)) do
								Mutelist = Mutelist.. k ..') '..getUserInfo(v) .. '\n'
							end
							return Mutelist
						end
					end
				end
				if matches[1]:lower() == 'kick' and isMod(msg.from.id, msg.chat.id) then
					if msg.reply_to_message then
						local user_id = msg.reply_to_message.from.id
						local chat_id = msg.chat.id
						if isMod(user_id, chat_id) then
							local user = tostring(getUserInfo(user_id)):gsub('\\', '')
							local text = Language(chat_id, "KICK_ERROR")
							local TEXTtoSend = text .. user .. Language(chat_id, "KICK_ERROR2")
							api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false)
						else
							api.kickUser(_Config.TOKEN, chat_id, user_id)
							local user = tostring(getUserInfo(user_id)):gsub('\\', '')
							local text = Language(chat_id, "KICK_SUCCESS")
							local TEXTtoSend = text .. user .. Language(chat_id, "KICK_SUCCESS2")
							api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false)
						end
					end
					if #matches > 1 then
						if tonumber(matches[2]) ~= nil then
							X = tonumber(matches[2])
						else
							X = false
						end
						if X then
							user_id = X
							chat_id = msg.chat.id
							if isMod(user_id, chat_id) then
								local user = tostring(getUserInfo(user_id)):gsub('\\', '')
								local text = Language(chat_id, "KICK_ERROR")
								local TEXTtoSend = text .. user .. Language(chat_id, "KICK_ERROR2")
								api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false)
							else
								api.kickUser(_Config.TOKEN, chat_id, user_id)
								local user = tostring(getUserInfo(user_id)):gsub('\\', '')
								local text = Language(chat_id, "KICK_SUCCESS")
								local TEXTtoSend = text .. user .. Language(chat_id, "KICK_SUCCESS2")
								api.sendMessage(_Config.TOKEN, msg.chat.id, TEXTtoSend, false, nil, msg.reply_to_message.message_id, false)
							end
						else
							
						end
					end
				end
			end
		end 
	return {
		HELP = {
			NAME = { 
				fa = 'مدیریت',
				en = 'Moderation !',
				call = 'moderation',
			},
			Dec = {
				fa = 'مدیریت اعضا !',
				en = 'Group Moderation !',
			},
			Usage = {
				fa = '`Promote (reply)` : ارتقاه فرد مورد نضر\n'
				..'`Promote (@Username)` : ارتقاه (@Username)\n'
				..'`Promote (Mention)` : ارتقاه (Mention)\n'
				..'`Promote (UserID)` : ارتقاه (UserID)\n'
				..'`Demote (reply)` : عزل مقام فرد مورد نضر\n'
				..'`Demote (@Username)` : عزل مقام (@Username)\n'
				..'`Demote (Mention)` : عزل مقام (Mention)\n'
				..'`Demote (UserID)` : عزل مقام (UserID)\n'
				..'`Mods Clean` : خذف مدیران\n'
				..'`Mods List` : لیست مدیران\n'
				..'`[Un]Muteuser (reply)` : [حذف] سکوت فرد مورد نظر\n'
				..'`[Un]Muteuser (@Username)` : [حذف] سکوت (@Username)\n'
				..'`[Un]Muteuser (Mention)` : [حذف] سکوت (Mention)\n'
				..'`[Un]Muteuser (UserID)` : [حذف] سکوت (UserID)\n'
				..'`Mutes Clean` : خذف لیست سکوت\n'
				..'`Mutes List` : لیست سکوت\n'
				..'`Invite (reply)` : دعوت فرد مورد نظر\n'
				..'`Invite (@Username)` : دعوت (@Username)\n'
				..'`Invite (Mention)` : دعوت (Mention)\n'
				..'`Invite (UserID)` : دعوت (UserID)\n'
				..'`Kick (reply)` : اخراج فرد مورد نضر\n'
				..'`Kick (@Username)` : اخراج (@Username)\n'
				..'`Kick (Mention)` : اخراج (Mention)\n'
				..'`Kick (UserID)` : اخراج (UserID)\n'
				..'*این پلاگین برای مدیران گروه است !*',
				en = '`Promote (reply)` : Promote Target\n'
				..'`Promote (@Username)` : Promote (@Username)\n'
				..'`Promote (Mention)` : Promote (Mention)\n'
				..'`Promote (UserID)` : Promote (UserID)\n'
				..'`Demote (reply)` : Demote Target\n'
				..'`Demote (@Username)` : Demote (@Username)\n'
				..'`Demote (Mention)` : Demote (Mention)\n'
				..'`Demote (UserID)` : Demote (UserID)\n'
				..'`Mods Clean` : Clean Moderator List\n'
				..'`Mods List` : Show Mods List\n'
				..'`[Un]Muteuser (reply)` : [Un]Muteuser Target\n'
				..'`[Un]Muteuser (@Username)` : [Un]Muteuser (@Username)\n'
				..'`[Un]Muteuser (Mention)` : [Un]Muteuser (Mention)\n'
				..'`[Un]Muteuser (UserID)` : [Un]Muteuser (UserID)\n'
				..'`Mutes Clean` : Clean Muted Users\n'
				..'`Mutes List` : Show Muted List\n'
				..'`Invite (reply)` : Invite Target\n'
				..'`Invite (@Username)` : Invite (@Username)\n'
				..'`Invite (Mention)` : Invite (Mention)\n'
				..'`Invite (UserID)` : Invite (UserID)\n'
				..'`Kick (reply)` : Kick Target\n'
				..'`Kick (@Username)` : Kick (@Username)\n'
				..'`Kick (Mention)` : Kick (Mention)\n'
				..'`Kick (UserID)` : Kick (UserID)\n'
				..'*This Plugin is Only usable by Moderators !*',
			},
			rank = 'Mod',
		},
		cli = {
			_MSG = {
				'^([Pp]romote) (.*)$',
				'^([Pp]romote)$',
				'^([Dd]emote)$',
				'^([Dd]emote) (.*)$',
				'^([Mm]ods) ([Cc]lean)$',
				'^([Mm]ods) ([Ll]ist)$',
				'^[/!#]([Pp]romote) (.*)$',
				'^[/!#]([Pp]romote)$',
				'^[/!#]([Dd]emote)$',
				'^[/!#]([Dd]emote) (.*)$',
				'^[/!#]([Mm]ods) ([Cc]lean)$',
				'^[/!#]([Mm]ods) ([Ll]ist)$',
				'^([Mm]uteuser) (.*)$',
				'^([Mm]uteuser)$',
				'^([Uu]nmuteuser)$',
				'^([Uu]nmuteuser) (.*)$',
				'^([Mm]utes) ([Cc]lean)$',
				'^([Mm]utes) ([Ll]ist)$',
				'^[/!#]([Mm]uteuser) (.*)$',
				'^[/!#]([Mm]uteuser)$',
				'^[/!#]([Uu]nmuteuser)$',
				'^[/!#]([Uu]nmuteuser) (.*)$',
				'^[/!#]([Mm]utes) ([Cc]lean)$',
				'^[/!#]([Mm]utes) ([Ll]ist)$',
				'^([Ii]nvite) (.*)$',
				'^([Ii]nvite)$',
				'^([Kk]ick)$',
				'^([Kk]ick) (.*)$',
			},
	--		Pre = Pre,
			run = Run
		},
		api = {
			_MSG = {
				'^([Pp]romote) (.*)$',
				'^([Pp]romote)$',
				'^([Dd]emote)$',
				'^([Dd]emote) (.*)$',
				'^([Mm]ods) ([Cc]lean)$',
				'^([Mm]ods) ([Ll]ist)$',
				'^[/!#]([Pp]romote) (.*)$',
				'^[/!#]([Pp]romote)$',
				'^[/!#]([Dd]emote)$',
				'^[/!#]([Dd]emote) (.*)$',
				'^[/!#]([Mm]ods) ([Cc]lean)$',
				'^[/!#]([Mm]ods) ([Ll]ist)$',
				'^([Mm]uteuser) (.*)$',
				'^([Mm]uteuser)$',
				'^([Uu]nmuteuser)$',
				'^([Uu]nmuteuser) (.*)$',
				'^([Mm]utes) ([Cc]lean)$',
				'^([Mm]utes) ([Ll]ist)$',
				'^[/!#]([Mm]uteuser) (.*)$',
				'^[/!#]([Mm]uteuser)$',
				'^[/!#]([Uu]nmuteuser)$',
				'^[/!#]([Uu]nmuteuser) (.*)$',
				'^[/!#]([Mm]utes) ([Cc]lean)$',
				'^[/!#]([Mm]utes) ([Ll]ist)$',
				'^([Ii]nvite) (.*)$',
				'^([Ii]nvite)$',
				'^([Kk]ick)$',
				'^([Kk]ick) (.*)$',
			},
	--		Pre = ApiPre,
			run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}