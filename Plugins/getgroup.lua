	--https://api.pwrtelegram.xyz/userTOKEN/madeline?method=
	function Run(msg, matches)
		if #matches > 1 then
		if matches[1] == 'Import' then
			link = matches[2]:gsub('t.me', 'telegram.me')
				tdcli_function ({
   					ID = "ImportChatInviteLink",
    				invite_link_ = link
  				}, function(C,G)  end, nil)
		end
	end
	end

	function ApiRun(msg, matches)
		if matches[1] == 'get gp' then
			if isFull(msg.from.id) then
				reply_markup = {
						inline_keyboard = {
							{ {text = 'Back', callback_data = 'startpage'} }
						}
					}
				TEXT = 'Send Link :|'
				redis:set(msg.from.id..'GettingsGroup!', 'vip')
			else
				TEXT = Language(msg.from.id, "GET_GP_1")
				reply_markup = {
					inline_keyboard = {
						{ {text = Language(msg.from.id, "GET_GP_2"), callback_data = 'get VIPGP'},{text = Language(msg.from.id, "GET_GP_3"), callback_data = 'get FREEGP'} },
						{ {text = Language(msg.from.id, "Back"), callback_data = 'startpage'} }
					}
				}

			end
			api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
		end	
		if matches[1] == 'get FREEGP' then
				TEXT = Language(msg.from.id, "GET_GP_4")
				reply_markup = {
					inline_keyboard = {
						{ {text = Language(msg.from.id, "Back"), callback_data = 'startpage'} }
					}
				}
			api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'get VIPGP' then
				reply_markup = {
					inline_keyboard = { 
						{ {text = Language(msg.from.id, "SPR_PAY"), callback_data = 'SPRPayment'} },
						{ {text = Language(msg.from.id, "View_PAY"), callback_data = 'ViewPayment'} },
						{ {text = Language(msg.from.id, "Back"), callback_data = 'get gp'} }
					}
				}	
				TEXT = Language(msg.from.id, "GET_VIP_GP_1")
			api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'SPRPayment' then
			if tonumber((redis:get(msg.from.id..'SPRs') or 0)) < 50 then
				local TEXT = Language(msg.from.id, "NOT_E_SPR")
				api.answerCallbackQuery(_Config.TOKEN, msg.id, TEXT, true)
			else
					reply_markup = {
						inline_keyboard = { 
							{ {text = Language(msg.from.id, "Back"), callback_data = 'get VIPGP'} }
						}
					}	
					TEXT = Language(msg.from.id, "Send_Link_FOR_J")
				redis:set(msg.from.id..'GettingsGroup!', 'vip')
				api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
			end
		end
		if matches[1] == 'ViewPayment' then
			TEXT = [[ 
*- تبلیغات توی گروهت زیاد شده؟🙁☹️😞
+ اره خیلی بده همش چرتوپرت میفرستن😢😭
- ینی تاالان ربات ضد لینک SprCpu رو ندیدی؟😃🙌
+ نه، چیکار میکنه؟🤔
- معلومه دیگه، میاد تو گروهت لینا و تبلیغاتو اینارو پاک میکنه😨
+ واقعا؟😧😳😱
- اره، تازه میتونی رایگانم ازش استفاده کنی😬
+ واقعا؟😲
- آره، به پیام میده واسشون تبلیغ میکنی و بعدم  گروه میگیری🤐
+ ایدیشو بده زووود باش🤤🤤
- بیا عشخم *[@SprCpu_Bot](telegram.me/SPRCPU_BOT)* برو پیویش و دریافت گروهو بزن، بعدم یا گروه رایگان و بزن و لینکتو بده(البته اگه گروهت بالای 1000 نفره) یا بزن گروه ویژه و براشون تبیغ کن یا پول بده و گروهتو بگیر😇
== زود باشید دیگه 🙂*
[@SprCpu_Bot
@SprCpu_Bot
@SprCpu_Bot
@SprCpu_Bot
@SprCpu_Bot
@SprCpu_Bot
@SprCpu_Bot](telegram.me/SPRCPU_BOT)
[@SprCpu_Company ](https://t.me/joinchat/AAAAAEEwrFQ5hmUpqrnQHA)
[@SprCpu_Company ](https://t.me/joinchat/AAAAAEEwrFQ5hmUpqrnQHA)
[@SprCpu_Company ](https://t.me/joinchat/AAAAAEEwrFQ5hmUpqrnQHA)
[@SprCpu_Company ](https://t.me/joinchat/AAAAAEEwrFQ5hmUpqrnQHA)
[@SprCpu_Company ](https://t.me/joinchat/AAAAAEEwrFQ5hmUpqrnQHA)
]]
			TXT2 = Language(msg.from.id, "ADD_REPLY")
			ID = api.sendMessage(_Config.TOKEN, '-1001064188165', TEXT, 'md', {inline_keyboard={ { {text='2K e',callback_data = 'acspt '..msg.from.id} } } }).result.message_id
			api.sendMessage(_Config.TOKEN, '-1001064188165', getUserInfo(msg.from.id), 'md', nil, ID)
			ID2 = api.forwardMessage(_Config.TOKEN, msg.from.id, '-1001064188165', ID).result.message_id
			api.sendMessage(_Config.TOKEN, msg.from.id, TXT2, 'md', nil, ID2)
			reply_markup = {
					inline_keyboard = { 
						{ {text = Language(msg.from.id, "SPR_PAY"), callback_data = 'SPRPayment'} },
						{ {text = Language(msg.from.id, "Back"), callback_data = 'get gp'} }
					}
				}	
			TEXT = Language(msg.from.id, "GET_VIP_GP_1")
			api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', reply_markup)
		end
		if matches[1] == 'acspt' then
			TEXT = Language(msg.from.id, "GET_LINK_SEEN")
			redis:set(matches[2]..'GettingsGroup!', 'vip')
			redis:set(matches[2]..'GPBYSEEN!', 'true')
			api.sendMessage(_Config.TOKEN, matches[2], TEXt, 'md', nil, 0)
			api.answerCallbackQuery(_Config.TOKEN, msg.id, 'Down !', true)
		end
		
	end
	function ApiPre(msg, Type)
		if msg.text then
			if msg.chat.type == "private" then
				local Gtype = redis:get(msg.from.id.."GettingGroup!")
				local link = { msg.text:gsub('t.me', 'telegram.me'):match('(https://telegram.me/joinchat/%S+)') }
				if Gtype == "vip" or Gtype == "free" then
					if Gtype == "vip" then
						if redis:get(msg.from.id.."GPBUSEEN!") then 
							redis:del(msg.from.id..'GPBYSEEN!')
						else
							redis:incrby(msg.from.id..'SPRs', -50)
						end
						cli.checkChatInviteLink(link[1], function (Arg, Data)
							redis:sadd(msg.from.id..'Chats', data.chat_id_)
							redis:hset(data.chat_id_, 'isVIP', 'VIP')
							tdcli_function ({
   									ID = "ImportChatInviteLink",
    								invite_link_ = link[1]
  								}, function(C, G)  
  									if G.ID == 'Error' then
  										api.sendMessage(_Config.TOKEN, msg.from.id, "Error !\n:"..G.message_, 'md', nil, msg.message_id)
  										redis:hset(msg.from.id, 'SPRs', tonumber( redis:hget(msg.from.id, 'SPRs') ) + 50)
  									end
  							end, nil)
						end, nil)
					-----------------------------
						if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
							return 'وارد لینک شدم !\nربات را در گروه خود مدیر کنید !'
						else
							return 'I Joined This Group!\nMake bot Admin to Start its Work !'
						end
					end
				end
			end
		end 
	end

	return {
		HELP = {
			NAME = { 
				fa = 'دریافت گروه',
				en = 'Get/Buy Group !',
				call = 'getgroup',
			},
			Dec = {
				fa = 'دریافت گروه',
				en = 'Get Group !',
			},
			Usage = {
				fa = 'از دکمه "دریافت گروه" در پیوی ربات @SprCpu\\_Bot برای دریافت ربات برای گروه خود استفاده کنید !',
				en = 'Use Butten "Grt Group" in @SprCpu\\_Bot\'s private to Grt Group :P',
			},
			rank = 'NIL',
		},
		cli = {
			_MSG = {
				'^(Import) (.*)$'
			},
	--		Pre = Pre,
			run = Run
		},
		api = {
			_MSG = {
				--Patterns :)
				'!#MessageCall (get gp)',
				'!#MessageCall (get VIPGP)',
				'!#MessageCall (get FREEGP)',
				'!#MessageCall (SPRPayment)',
				'!#MessageCall (ViewPayment)',
				'!#MessageCall (acspt) (.*)',
			},
			Pre = ApiPre,
			run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}