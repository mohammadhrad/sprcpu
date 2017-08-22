	
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
	require('Ranks')
    require('Langs')
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
					else
					if result then
						api.sendMessage(tostring(_Config.TOKEN), msg.chat.id,  result, 'md', json.decode('{"remove_keyboard":true}'), msg.message_id, true)	
					end
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
					else
					if result then
						api.sendMessage(tostring(_Config.TOKEN), msg.chat.id,  result, 'md', json.decode('{"remove_keyboard":true}'), msg.message_id, true)	
					end
				end
    		end
    	end
    end
------------------------------------------------------------------------------------
    function MarkScape(text)
		Result = text:gsub('_', '\\_')
				 :gsub('`', '\\`')
				 :gsub('*', '\\*')
		return Result
	end

	function VarDump(Value)
		print(clr.red.. '\n------------Start-------------- \n' ..clr.reset)
		print(clr.blue..serpent.block(Value,{comment=false})..clr.reset)
		print(clr.red.. '\n------------Stop -------------- \n' ..clr.reset)
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
	LoadPlugins ()
    function MessageInput(msg, type)
    	MessagePre2(msg, type)
    		redis:sadd('Users', msg.from.id)
    		redis:del(msg.from.id)
    		if msg.from.username then
    			redis:hset(msg.from.id, 'username', msg.from.username)
			end
			if msg.from.first_name then
    			redis:hset(msg.from.id, 'firstname', msg.from.first_name)
			end
    	if type == 'Message' then
    		text = msg.text
    	elseif type == 'Inline' then
    		text = '!#MessageQuery '..msg.query
    	elseif type == 'CallBack' then
    		text = '!#MessageCall '..msg.data
    	else
    		text = msg.text 
    	end
		RunMatches2(msg, text)
    end
    last_update = 0 or last_update
    LastCron = 0 or LastCron
    function tdcli_update_callback(data)  
      if data then
        data = nil
      end
	   cli.setAlarm(1)
			local response = api.getUpdates(_Config.TOKEN, last_update + 1)
			if response then 
    			for i,v in ipairs(response.result) do 
      				last_update = v.update_id 
      				if v.edited_message then 
        				MessageInput(v.edited_message, 'Edited') 
      				elseif v.message then 
        				MessageInput(v.message, 'Message') 
    				elseif v.callback_query then 
    				    MessageInput(v.callback_query, 'CallBack')
    				elseif v.inline_query then 
    				    MessageInput(v.inline_query, 'Inline') 
    				end 
    			end 
  			else 
  			print('Error, Cant Get New Updates !')
  		end 
	end

	--[[ 

		Dont Delete Our Name ;)

	]]