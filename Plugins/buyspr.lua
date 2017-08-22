
http = require "socket.http"
http = require "socket.http"
ltn12 = require 'ltn12'
multipart = require 'multipart-post'


local function makeRequest(uRL, request_body)
  local response = {}
  local body, boundary = multipart.encode(request_body)

  local success, code, headers, status = https.request{
    url = uRL,
    method = 'POST',
    headers = {
      ['Content-Type'] =  'multipart/form-data; boundary=' .. boundary,
      ['Content-Length'] = string.len(body),
    },
    source = ltn12.source.string(body),
    sink = ltn12.sink.table(response),
  }

  local respbody = table.concat(response or {"no response"})
  local jbody = json.decode(respbody)
  return jbody
end
	function ApiRun(msg, matches)
		AP_KEY = _Config.PayIRKey
		if matches[2] == 'SPR' then
		if matches[1] == '100' then
			SPRC = tonumber(matches[1])
			Coust = tonumber(matches[1]) * 1000
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		elseif matches[1] == '1000' then
			SPRC = tonumber(matches[1])
			Coust = tonumber(matches[1]) * 1000
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		elseif matches[1] == '200' then
			Coust = tonumber(matches[1]) * 1000
			SPRC = tonumber(matches[1])
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		elseif matches[1] == '2000' then
			SPRC = tonumber(matches[1])
			Coust = tonumber(matches[1]) * 1000
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		elseif matches[1] == '300' then
			SPRC = tonumber(matches[1])
			Coust = tonumber(matches[1]) * 1000
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		elseif matches[1] == '3000' then
			SPRC = tonumber(matches[1])
			Coust = tonumber(matches[1]) * 1000
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		elseif matches[1] == '400' then
			SPRC = tonumber(matches[1])
			Coust = tonumber(matches[1]) * 1000
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		elseif matches[1] == '4000' then
			SPRC = tonumber(matches[1])
			Coust = tonumber(matches[1]) * 1000
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		elseif matches[1] == '500' then
			SPRC = tonumber(matches[1])
			Coust = tonumber(matches[1]) * 1000
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		elseif matches[1] == '5000' then
			SPRC = tonumber(matches[1])
			Coust = tonumber(matches[1]) * 1000
			if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
				TEXT = "شما در حال خرید "..SPRC.." تغداد SPR به قیمت "..Coust.."ریال هستید\nبرای ادامه دادن خرید روی دکمه کلیک کنید !"
			else
				TEXT = 'Your Going to buy '..SPRC..', Coust : '.. Coust..' Rials\n Tap to next !'
			end
		else
			TEXT = ':|'
		end
		redis:set('Count:'..msg.from.id, SPRC)
		url = 'https://pay.ir/payment/send'
		JDT = makeRequest(url, {
			amount = tostring(Coust),
			api = AP_KEY,
			redirect = 'http://pay.Tele-fake.ir',
			})
		keyboard = {
			inline_keyboard = {
				{ { text = 'بله ادامه', callback_data = 'PayMent '..JDT.transId } },
				{ { text = 'Back|بازگشت', callback_data = 'buy spr' } }
			}
		}
		api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
		end
		if matches[1] == 'PayMent' then
			URLTOPAY = 'https://pay.ir/payment/gateway/'.. matches[2]
			if (redis:get(msg.message.chat.id..'Lang') or 'fa') == 'fa' then
				TEXT = 'لینک پرداخت شما : [برای پرداخت کلیک کنید !]('..URLTOPAY .. ')\n'
				..'بعد از پرداخت بر روی دکمه ✅ کلیک کنید در غیر این صورت لغو را برنید !'
			else
				TEXT = 'Your Payment link : [Click To Pay]('.. URLTOPAY ..')'
				..'\nAfter pay use Buttens !'
			end
			keyboard = {
			inline_keyboard = {
					{ { text = '✅', callback_data = 'CheckPay '..matches[2] } },
					{ { text = 'Back|بازگشت', callback_data = 'buy spr' } }
				}
			}
			api.editMessageText(_Config.TOKEN, msg.message.chat.id, msg.message.message_id, TEXT, 'md', keyboard)
		end
		if matches[1] == 'CheckPay' then
			JDT = makeRequest('https://pay.ir/payment/verify', {
			transId = matches[2],
			api = AP_KEY,
			})
			if tostring(JDT.status) == tostring('1') then
				redis:set(msg.from.id..'GettingsGroup!', 'vip')
				redis:set(msg.from.id..'GettingsGroup!!', redis:get('Count:'..msg.from.id))

				if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
					TEXT = 'لینک خود را ارسال کنید!'
				else
					TEXT = 'Send Your link!'
				end
			else
				VarDump(JDT)
				if (redis:get(msg.from.id..'Lang') or 'fa') == 'fa' then
					TEXT = 'پرداخت تایید نشد !'
				else
					TEXT = 'unSuccess Payment !'
				end
			end
			keyboard = {
			inline_keyboard = {
					{ { text = 'Back|بازگشت', callback_data = 'buy spr' } }
				}
			}
			api.editMessageText(_Config.TOKEN, msg.from.id, msg.message.message_id, TEXT, 'md', keyboard)
		end

	end



	return {
		HELP = {
			NAME = { 
				fa = 'خرید موجودی !',
				en = 'Buy SPR !',
				call = 'buyspr',
			},
			Dec = {
				fa = 'پلاکینی برای خرید SPR',
				en = 'A plugin for buy SPR!',
			},
			Usage = {
				fa = '*برای خرید SRP ابتدا به* @SPRCPU\\_BOT *مراجعه کرده و سپس به قشمت خرید SPR رفته و تعداد مورد نظر را انتخاب کنید\nسپس به قمت پرداخت رفته و بعد از پرداخت مبلغ مورد نظر پرداهت را تایید کنید !*',
				en = '*fist start* @SPRCPU\\_BOT *and then use Butten "Buy SPR" and then select the amount of SPRs you need and Pay it\n after that Verify it :-)*',
			},
			rank = 'NIL',
		},

		cli = {
			_MSG = {

			},
	--		Pre = Pre,
	--		run = Run
		},
		api = {
			_MSG = {
				'^!#MessageCall (PayMent) (.*)$',
				'^!#MessageCall (CheckPay) (.*)$',
				'^!#MessageCall (100) (SPR)$',
				'^!#MessageCall (1000) (SPR)$',
				'^!#MessageCall (200) (SPR)$',
				'^!#MessageCall (2000) (SPR)$',
				'^!#MessageCall (300) (SPR)$',
				'^!#MessageCall (3000) (SPR)$',
				'^!#MessageCall (400) (SPR)$',
				'^!#MessageCall (4000) (SPR)$',
				'^!#MessageCall (500) (SPR)$',
				'^!#MessageCall (5000) (SPR)$',

			},
	--		Pre = ApiPre,
			run = ApiRun
		},
		CheckMethod = 'f80', -- Also Can use as 'TeleSeed' ! # If use TeleSeed Input Will be msg = { to = {}, from = {}} :))
	--	Cron = Cron
	}