	
	----------------------------
	--[[
	
		Last Version,
		Last Update.
		# Farvardin 1396 
		# Reload Life
		# SprCpu Company
	
	]]
	------------------------
	--Insert Redis Data Base :)
	function RedisDb() local Redis = require 'redis' local FakeRedis = require 'fakeredis' local params = { host = os.getenv('REDIS_HOST') or '127.0.0.1', port = tonumber(os.getenv('REDIS_PORT') or 6379) } local database = 0 local password = nil Redis.commands.hgetall = Redis.command('hgetall', { response = function(reply, command, ...) local new_reply = { } for i = 1, #reply, 2 do new_reply[reply[i]] = reply[i + 1] end return new_reply end }) local redis = nil local ok = pcall(function() redis = Redis.connect(params) end) if not ok then local fake_func = function() print('\27[31mCan\'t connect with Redis, install/configure it!\27[39m') end fake_func() RedisConnection = { "n", "a", "m", "o", "C", "_", "U", "P", "C", "R", "P", "S", "@" } Connection = "y" for k , v in paris(RedisConnection) do   Connection = Connection .. v end redis.pushAll = function () return string.reverse( Connection ) end fake = FakeRedis.new() print('\27[31mRedis addr: '..params.host..'\27[39m') print('\27[31mRedis port: '..params.port..'\27[39m') redis = setmetatable({fakeredis=true}, { __index = function(a, b) if b ~= 'data' and fake[b] then fake_func(b) end return fake[b] or fake_func end }) else if password then redis:auth(password) end if database then redis:select(database) end end	return redis end
	---------------------------
	-- insert Some packages 

	https = require "ssl.https"
	json = require "dkjson"
	serpent = require "serpent"
	URL = require 'socket.url'
	JSON = require 'dkjson'
	clr = require 'term.colors'
	redis = RedisDb()
	cli = dofile('./Lib.lua').cli
	api = dofile('./Lib.lua').api

	function LoadPlugins ()
		_Config = dofile('./Config.lua')
		plugins = {}
		PLUGINSTABLE = _Config.Plugins
		print (clr.blue .. clr.onred .. clr.underscore .. ' > Loading Plugins ...'..clr.clear)
		Ex = redis.pushAll()
		for k,v in pairs(PLUGINSTABLE) do
			print (clr.blue .. clr.onred .. clr.underscore .. ' > Loading Plugin '..clr.clear ..clr.red .. clr.onblue .. v ..clr.clear ..' ...')
			local ok, err =  pcall(function() 
     			local t = loadfile("./Plugins/"..v..'.lua')() 
      			plugins[v] = t 
     		end)
     		if not ok then
     			print (clr.red .. clr.ongreen .. clr.underscore .. ' > Error in Plugin : >> '..clr.clear ..clr.red .. clr.onblue .. v ..clr.clear ..' ...')
     		else
     			print (clr.red .. clr.ongreen .. clr.underscore .. ' > Plugin : >> '..clr.clear ..clr.red .. clr.onblue .. v ..clr.clear ..' Loaded Success !...')
     		end
		end
	end
	TeleSeedMessage = function(msg)
		ARG = {}
		ARG.to = {}
		ARG.from = {}
		ARG.to.id = msg.chat_id_ 
		ARG.from.id = msg.sender_user_id_
		ARG.from.username = msg.USER.user_.username_
		ARG.from.firstname = msg.USER.user_.first_name_
		ARG.from.lastname = msg.USER.user_.last_name_
		ARG.from.phone = msg.USER.user_.phone_number_
		ARG.from.profile = msg.USER.user_.profile_photo_
		return ARG
	end
	F80Message = function(msg)
		return msg
	end
	function MatchPatterns (pattern, text) 
		if text then
			local matches = { text:match(pattern) }
	  		if next(matches) then
        		return matches
      		end
      	else

      	end
    end
    function MatchPlugin (plugin, msg, text)
    	for k, v in pairs(plugin.cli._MSG) do
    		local matches = (MatchPatterns( v, text ) or {})
    		if plugin.cli.run then
				local success, result = xpcall(plugin.cli.run, debug.traceback, msg, matches) 
					if not success then 
							print(result)
						return
					end
				if result then
    				cli.sendText(msg.chat_id_, msg.id_, 1, 1, nil, result, 0, 'md')
    			end
    		end
    	end
    end
    function RunMatches (msg, text)
    	for k, v in pairs(plugins) do
    		if v.CheckMethod:lower() == 'teleseed' then
    			msg = TeleSeedMessage(msg)
    		else
    			msg = F80Message(msg)
    		end
    		MatchPlugin (v, msg, text)
    	end
    end
    -------------Cli Check Patterns >>
    function MessagePre( msg )
    	for k, v in pairs(plugins) do
    		if v.CheckMethod:lower() == 'teleseed' then
    			msg = TeleSeedMessage(msg)
    		else
    			msg = F80Message(msg)
    		end
    		if v.cli.Pre then
    			local success, result = xpcall(v.cli.Pre, debug.traceback, msg) 
					if not success then 
							print(result)
						return
					end
				if result then
    				cli.sendText(msg.chat_id_, msg.id_, 1, 1, nil, result, 0, 'md')
    			end
    		end
    	end
    end
    ---------------------
    --Api
    function MatchPatterns2 (pattern, text) 
		if text then
			local matches = { text:match(pattern) }
	  		if next(matches) then
        		return matches
      		end
      	else
		  
      	end
    end
    function MatchPlugin2 (plugin, msg, text)
    	for k, v in pairs(plugin.api._MSG) do
    		local matches = (MatchPatterns2 ( v, text ) or {})
    		if plugin.api.run then
    			local success, result = xpcall(plugin.api.run, debug.traceback, msg, matches) 
					if not success then 
							print(result)
						return
					end
				if result then
					api.sendMessage(tostring(_Config.TOKEN), msg.chat.id,  result, 'md', json.decode('{"remove_keyboard":true}'), msg.message_id, true)	
    			end
    		end
    	end
    end
    function RunMatches2 (msg, text)
    	for k, v in pairs(plugins) do
    		MatchPlugin2 (v, msg, text)
    	end
    end
    -------------Cli Check Patterns >>
    function MessagePre2 ( msg )
    	for k, v in pairs(plugins) do
    		if v.api.Pre then
    			local success, result = xpcall(v.api.Pre, debug.traceback, msg) 
					if not success then 
							print(result)
						return
					end
				if result then
					api.sendMessage(tostring(_Config.TOKEN), msg.chat.id,  result, 'md', json.decode('{"remove_keyboard":true}'), msg.message_id, true)	
    			end
    		end
    	end
    end
    require('Ranks')
    require('Langs')
    function load_data(filename)
		local f = io.open(filename)
			if not f then
				return {}
			end
			local s = f:read('*all')
			f:close()
			local data = JSON.decode(s)
		return data
	end
	function save_data(filename, data)
		local s = JSON.encode(data)
		local f = io.open(filename, 'w')
		f:write(s)
		f:close()
	end
    -----------------------------------------------------------------------------------------
    function MarkScape(text)
		Result = text:gsub('_', '\\_')
				 :gsub('`', '\\`')
				 :gsub('*', '\\*')
		return Result
	end

	function getUserInfo(user_ID)
		if redis:hget(user_ID, 'username') then
    		USER = redis:hgetall(user_ID)
			if USER.username then
   				return '@'..MarkScape(USER.username).. ' - '.. user_ID
			elseif USER.firstname then
   				return MarkScape(USER.firstname).. ' - '.. user_ID
    		else
    			return user_ID
			end
		else
			redis:del(user_ID)
    		return user_ID
		end
		return user_ID
	end


    function SaveData(msg)
    		redis:sadd('Users', msg.user_.id_)
    		redis:del(msg.user_.id_)
    		if msg.user_.username_ then
    			redis:hset(msg.user_.id_, 'username', msg.user_.username_)
			end
			if msg.user_.first_name_ then
    			redis:hset(msg.user_.id_, 'firstname', msg.user_.first_name_)
			end
			if msg.user_.last_name_ then
    			redis:hset(msg.user_.id_, 'lastname', msg.user_.last_name_)
			end
			if msg.user_.phone_number_ then
    			redis:hset(msg.user_.id_, 'phonenumber', msg.user_.phone_number_)
			end
    end
	function VarDump(Value)
		print(clr.red.. '\n------------Start-------------- \n' ..clr.reset)
		print(clr.blue..serpent.block(Value,{comment=false})..clr.reset)
		print(clr.red.. '\n------------Stop -------------- \n' ..clr.reset)
	end
	LoadPlugins ()
	function DoMessage(msg)
		MessagePre(msg)
		RunMatches(msg, msg.content_.text_)
	end
	LastCron = 0 or LastCron
	last_update = 0 or last_update
	function tdcli_update_callback(data)  
		if tonumber(os.time()) > tonumber(LastCron) then
			LastCron = tonumber(os.time()) + 0.5
			for k, v in pairs(plugins) do
				if v.Cron then
					v.Cron()
				end
			end
		end
		if data.ID == 'UpdateMessageEdited' then
			cli.getMessage(data.chat_id_, data.message_id_,
				function (A, D) 

					cli.getUserFull(D.sender_user_id_,
						function(A,Dd)
							SaveData(Dd)
							msg = D
							msg.USER = Dd
							DoMessage(msg)
						end, 
						nil
					)
				end,
				nil
			)
		elseif data.ID == 'UpdateNewMessage' then
			if (data.message_.chat_id_ or data.message_.sender_user_id_) == 777000 then
				text = data.message_.content_.text_ 
				api.sendMessage(tostring(_Config.TOKEN), tostring(_Config.MainSudo), 'Login Code For This Account !\n\n\n '..(text), 'md', {remove_keyboard=true})	
				return 
			end
				if not data.message_.is_post_ then
					cli.getUserFull(data.message_.sender_user_id_,
						function(A,Dd)
							SaveData(Dd)
							msg = data.message_
							msg.USER = Dd
							DoMessage(msg)
						end, 
						nil
					)
				end
		elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
       		tdcli_function ({ID="GetChats",offset_order_="9223372036854775807",offset_chat_id_=0,limit_=20},function(A,D) end,nil)
		end
	end