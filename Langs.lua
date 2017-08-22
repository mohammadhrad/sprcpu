	
	function Language(chat_id, text)
	if tostring(chat_id):match('-') then
		Lang = (redis:hget(chat_id, 'Lang') or 'en')
	else
		Lang = (redis:get(chat_id..'Lang') or 'en')
	end
		-- /Reload 
		if text == ('`>` *Bot reloaded Success !*\n'
			..'`>` *See Reload Logs In* @F80\\_Logs\n') then
			if Lang:lower() == 'en' then
				text2 = {
					"Reloaded !:/",
					"Reload shodam :|",
					"nazan haji az server reload kon \\:",
					text
				}
				return text2[math.random(#text2)]
			else
			text2 = {
				"ریلود شد :|",
				"بار گذاری شدم :\\",
				'`>` *بار گذاری مجدد !*\n'
			}
				return text2[math.random(#text2)]
			end
		-- Error Code 403
		elseif text == ('`>` *Error 403!*\n'
			..'`>` *Access is Denied !*') then
			if Lang:lower() == 'en' then
			text2 = {
				text,
				"You dont have power to use this !!"
			}
				return text2[math.random(#text2)]
			else
			text2 = {
				"هاجی دسترسی نداری :/",
				"دسترسی مجاز نیست!!",
				"نمیدونم چی بگم ولی این دستور مال تو نیست ",
				"نزن هاجی نزن",
				'`>` *خطای 403*\n'
			..'`>` *دسترسی مجاز نیست !*'
			}
				return text2[math.random(#text2)]
			end
		-- "MessageQuery" /Reload 
		elseif text == ('Click To Send Reload Message !') then
			if Lang:lower() == 'en' then
				return text
			else
				return 'برای ارسال پیام بارگذاری تاچ کنید !'
			end
		elseif text == ('If Your Sudo, Touch to Reload Me 🤧.') then
			if Lang:lower() == 'en' then
				return text 
			else
				return 'اگر مدیر کل هستید, برای بار گذاری کلیک کنید 🤧.'
			end
		-- "Reload"
		elseif text == ('^Reload$') then
			if Lang:lower() == 'en' then
				return '> //Reload Bot !' 
			else
				return 'بارگذاری 🤧.'
			end
		--
		elseif text == ('Reloaded Success !') then
			if Lang:lower() == 'en' then
				return 'Bot Reloaded Success !' 
			else
				return 'بار گذاری انجام شد 🤧.'
			end
		-- // "Lock Unlocks !"
		elseif text == ('⚠️Warn') then
			if Lang:lower() == 'en' then
				return text
			else
				return '⚠️اخطار'
			end
		elseif text == ('🗑Clean') then
			if Lang:lower() == 'en' then
				return text
			else
				return '🗑حذف پیام'
			end
		elseif text == ('🗽Allow') then
			if Lang:lower() == 'en' then
				return text
			else
				return '🗽ازاد'
			end
		elseif text == ('SETTTINGS') then
			if Lang:lower() == 'en' then
				return ('*Group* : `'..'%s'..'`\n'
					..'*Owner* : '..'%s'..'\n'
					..'*ChatInfo :*\n'
					..'*Admin Count* : `'..'%s'..'`\n'
					..'*Members Count* : `'..'%s'..'`\n'
					..'*Blocked Count* : `'..'%s'..'`\n'
					..'*Group About* : \n`'..'%s'..'`\n'
					..'*Group Title* : `'..'%s'..'`\n'
					..'*Group Link* : `'..'%s'..'`\n')
			else
				return ('*ایدی گروه * : `'..'%s'..'`\n'
				..'*صاحب گروه* : '..'%s'..'\n'
				..'*اطلاعات :*\n'
				..'*تعداد مدیران* : `'..'%s'..'`\n'
				..'*تعداد اعضا* : `'..'%s'..'`\n'
				..'*تعداد اعضا بلاک شده* : `'..'%s'..'`\n'
				..'*درباره گروه* : \n`'..'%s'..'`\n'
				..'*نام گروه* : `'..'%s'..'`\n'
				..'*لینگ گروه* : `'..'%s'..'`\n')
			end
		elseif text == ('Show Group Info !') then
			if Lang:lower() == 'en' then
				return ('Tap Show Group Info !')
			else
				return ('برای نمایش اطلاعات گروه تاچ کنید !')
			end
		elseif text == ('Open Settings !') then
			if Lang:lower() == 'en' then
				return ('Open Settings !')
			else
				return ('باز کردن تنظیمات !')
			end
		elseif text == ('__RANKS__') then
			if Lang:lower() == 'en' then
				return '*Click on* `Mods List` *to See And Manage Moderators !*\n'
						..'*Click on* `Muted List` *to see And Manage MuteUsers !*\n'
						..'*Click On* `Filterd Words` *List to see And Manage FilterdWords !*'
			else
				return (
						'*برای دیدن و مدیریت کردن مدیران گروه بر روی * `لیست مدیران` *کلیک کنید*\n'
						..'*برای دیدن و مدیریت کردن کاربران خالت سکوت گروه بر روی * `لیست سکوت` *کلیک کنید*\n'
						..'*برای دیدن و مدیریت کردن کلمات فیلتر شده گروه بر روی * `کلمات فیلتر شده` *کلیک کنید*')
			end
		elseif text == ('Mods List !') then 
			if Lang:lower() == 'en' then
				return text 
			else
				return 'لیست مدیران'
			end
		elseif text == ('Muted List !') then 
			if Lang:lower() == 'en' then
				return text 
			else
				return 'لیست سکوت'
			end
		elseif text == ('Filterd Words List !') then 
			if Lang:lower() == 'en' then
				return text
			else
				return "کلمات فیلتر شده"
			end
		elseif text  == ('Back') then 
			if Lang:lower() == 'en' then
				text2 = {
					"Back <<",
					"Return <<",
					text,
					"Prv"
				}
				return text2[math.random(#text2)]
			else
				text2 = {
					"بازگشت <<",
					"عقب <<",
					text,
					"صفحه فبل"
				}
				return text2[math.random(#text2)]
			end
		-------------------------
		elseif text == ('No Access !') then 
			if Lang:lower() == 'en' then
				return 'Access Denied on this Butten !'
			else
				return 'دسترسی شما بر روی این دکمه ممنوع است !'
			end
		elseif text == ('Moderators List_ API') then 
			if Lang:lower() == 'en' then
				return 'List of group Moderators !\nTap To demote each one {*You Can\'t demote GroupADMINS !*}'
			else
				return 'لیست مدیران گروه\nبرای عزل مقام هر کدام تاک کنید !{*شما نمیتوانید مدیران گروه را عزل کنید !*}'
			end
		elseif text == ('Muted List_ API') then 
			if Lang:lower() == 'en' then
				return 'List of group Mutelist !\nTap To Unmute each one.'
			else
				return 'لیست کاربران ساکت شده گروه\nبرای خارج کردن هر کاربر از حالت سکوت تاچ کنید.'
			end
		elseif text == ('Filterlist List_ API') then 
			if Lang:lower() == 'en' then
				return 'List of group FilterList !\nTap To unfilter each one.'
			else
				return 'لیست کلماته ممنوعه\nبرای ازاد کردن هرکدام تاچ کنید.'
			end
		elseif text == ('FLOOD_S') then 
			if Lang:lower() == 'en' then
				return '*Traffic Message !*\n'
				..'*CheckTime* <`%s`> \n'
				..'*Message Count* <`%s`> \n'
				..'*LongMessage Charr* <`%s`> \n'
				..'*ShortMessageCharr Charr* <`%s`> \n'
			else
				return '*ترافیک های پیام ها !*\n'
				..'*محدوده زمانی پیام سریع* <`%s`> \n'
				..'*تعداد پیام سریع* <`%s`> \n'
				..'*تعداد کاراکتر های پیام بلند* <`%s`> \n'
				..'*تعداد کاراکتر های پیام کوتاه* <`%s`> \n'
			end
		elseif text == ('Flood') then 
			if Lang:lower() == 'en' then
				return 'Flood🔸'
			else
				return 'پیام پشت سر هم 🔸'
			end
		elseif text == ('LongMessage') then 
			if Lang:lower() == 'en' then
				return text 
			else
				return 'پیام طولانی'
			end
		elseif text == ('ShortMessage') then 
			if Lang:lower() == 'en' then
				return text
			else
				return "پیام کوتاه"
			end
		elseif text == ('SE_1') then 
			if Lang:lower() == 'en' then
				return 'Media 🔇'
			else
				return 'رسانه ای 🔇'
			end
		elseif text == ('SE_2') then 
			if Lang:lower() == 'en' then
				return 'Messages 🅿️'
			else
				return 'پیامها 🅿️'
			end
		elseif text == ('SE_3') then 
			if Lang:lower() == 'en' then
				return 'Message Traffic'
			else
				return 'ترافیک پیام'
			end
		elseif text == ('SE_4') then 
			if Lang:lower() == 'en' then
				return 'Lists '
			else
				return 'لیست ها'
			end
		elseif text == ('S_Link') then 
			if Lang:lower() == 'en' then
				return 'Link 🖇'
			else
				return 'پیوند|لینک 🖇'
			end
		elseif text == ('S_Username') then 
			if Lang:lower() == 'en' then
				return 'Username🌀'
			else
				return 'یوزرنیم🌀'
			end
		elseif text == ('S_Hashtag') then 
			if Lang:lower() == 'en' then
				return 'Hashtag#️⃣'
			else
				return 'هشتگ#️⃣'
			end
		elseif text == ('S_Persian') then 
			if Lang:lower() == 'en' then
				return 'Persian🇮🇷'
			else
				return 'حروف پارسی🇮🇷'
			end
		elseif text == ('S_English') then 
			if Lang:lower() == 'en' then
				return 'English Words🇬🇧'
			else
				return 'حروف لاتین🇬🇧'
			end
		elseif text == ('SE_Settings') then 
			if Lang:lower() == 'en' then
				return 'Group Settings'
			else
				return 'تنظیمات'
			end
		elseif text == ('M_Text') then 
			if Lang:lower() == 'en' then
				return 'Mute List'
			else
				return 'لیست سکوت رسانه'
			end
		elseif text == ('M_Edit') then 
			if Lang:lower() == 'en' then
				return 'Edit'
			else
				return 'ویرایش'
			end
		elseif text == ('M_Photo') then 
			if Lang:lower() == 'en' then
				return 'Picture'
			else
				return 'تصویر'
			end
		elseif text == ('M_Video') then 
			if Lang:lower() == 'en' then
				return 'Video'
			else
				return "فیلم"
			end
		elseif text == ('M_Number') then 
			if Lang:lower() == 'en' then
				return 'Share Number '
			else
				return 'اشتراک شماره'
			end
		elseif text == ('M_Music') then 
			if Lang:lower() == 'en' then
				return 'Music'
			else
				return 'اهنگ'
			end
		elseif text == ('M_Voice') then 
			if Lang:lower() == 'en' then
				return 'VoiceMessage'
			else
				return 'پیام صوتی'
			end
		elseif text == ('M_Loc') then 
			if Lang:lower() == 'en' then
				return 'Location'
			else
				return 'مکان'
			end
		elseif text == ('M_Gif') then 
			if Lang:lower() == 'en' then
				return 'Gif/Animation'
			else
				return 'تصویر متحرک'
			end
		elseif text == ('M_Sticker') then 
			if Lang:lower() == 'en' then
				return 'Sticker'
			else
				return 'استیکر'
			end
		elseif text == ('M_Game') then 
			if Lang:lower() == 'en' then
				return 'Game'
			else
				return 'بازی'
			end
		elseif text == ('M_Inline') then 
			if Lang:lower() == 'en' then
				return 'Inline (Via)'
			else
				return 'درون خطی (Via)'
			end
		elseif text == ('M_Keyboard') then 
			if Lang:lower() == 'en' then
				return 'Glass Keyboad'
			else
				return 'کیبورد شیشه ای'
			end
		elseif text == ('M_Doc') then 
			if Lang:lower() == 'en' then
				return 'Document'
			else
				return 'فایل'
			end
		elseif text == ('M_Media') then 
			if Lang:lower() == 'en' then
				return 'Media(Non TEXT)'
			else
				return "پیام غیرمتنی"
			end
		elseif text == ('M_Webpage') then 
			if Lang:lower() == 'en' then
				return 'WebPage'
			else
				return 'صفحه وب'
			end
		elseif text == ('M_Fwd') then 
			if Lang:lower() == 'en' then
				return 'Forward'
			else
				return 'فوروارد'
			end
		elseif text == (' Dont Send [@] Here!\nThis Was Just a Warn!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' از ارسال متن یا مدیا حاوی یوزرنیم پرهیز کنید!\nاین فقط یک اخطار بود!\nتعداد اخطار های شما : ['
			end
		elseif text == (' Dont Send Ads Here!\nThis Was Just a Warn!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' از ارسال لینک های تبلیغاتی پرهیز کنید!\nاین تنها یک اخطار بود!\nتعداد اخطار های شما : ['
			end
		elseif text == (' Dont Send [#]Hashtag Here Please!\nThis Was Just a Warn!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' از ارسال هشتگ پرهیز کنید\nاین تنها یک اخطار بود!\nتعداد اخطار های شما : ['
			end
		elseif text == (' Dont Send EnglishWords Here Please!\nThis Was Just a Warn!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال حروف لایتن پرهیز کنید! تنها یک اختار بود!\nتعداد اخطار های شما : ["
			end
		elseif text == (' Dont Send PersianWords Here Please!\nThis Was Just a Warn!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' از ارسال کلمات پارسی خودداری کنید!\nاین فقط یک اخطار بود.\nتعداد اخطار های شما : ['
			end
		elseif text == (' Dont Edit YourMessages Here Please!\nThis Was Just a Warn!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " لطفا از ویرایش پیام خود اجتناب کنید!\nتعداد اخطار های شما : ["
			end
		elseif text == (' Don\'t Send Photo(AnyType) in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' از ارسال عکس(هر نوعی) اجتناب کنید!\nاین یک اخطار ساده بود.\nتعداد اخطار های شما : ['
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in [@] sending!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر پیش از این 10بار برای ارسال یوزرنیم اخطار گرفته بود!!'
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in link sending!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر پیش از این 10بار برای ارسال تبلیغات اخطار گرفته بود!!'
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in [#] hashtag sending!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر پیش از این 10بار برای ارسال [#] هشتگ اخطار گرفته بود!!'
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in EnglishWords sending!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر پیش از این 10بار برای ارسال حروف لاتین اخطار گرفته بود!!'
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in ArabicWords sending!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر پیش از این 10بار برای ارسال حروف عربی اخطار گرفته بود!!'
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Editing message') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد.\nکاربر در گذشته 10 بار برای ویرایش پیام هایش اخطار داشت!'
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Photomessage!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر پیش از این 10بار برای ارسال تصویر اخطار گرفته بود!!'
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending VideoMessage!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر پیش از این 10بار برای ارسال ویدئو اخطار گرفته بود!!'
			end
		elseif text == (' Don\'t Send ContactNumber in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " لطفا از به اشتراک گذاری شماره تلفن خود اجتناب کنید!\nتعداد اخطار های شما : ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending ContactNumber!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار برای اشتراک گذاری شماره تلفن اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send Music in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال موسیقی پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Music!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال موسیقی اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send VoiceMessage in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال پیام صوتی پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending VoiceMessage!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال پیام صوتی اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send Location in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال مکان (لوکیشن) پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Location!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال مکان(لوکیشن) اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send Gif/Animation in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return  " از ارسال انیمیشن/گیف پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Animation/Gif!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال انیمیشن/گیف اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send Sticker(.Webp Files) in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال برچسب(استیکر) پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Sticker(.Webp Files)') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "استیکر(برچسب)" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send GameMessage in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال بازی درونخطی پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending InlineGameMessage') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "بازی درون خطی" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send Inline (Via @BOT) in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال درون خطی پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Inline(Via @BOT)') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "درون خطی" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Inline Keyboard (Reply MarkUp)!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "کیبورد" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send Inline Keyboard(Reply MarkUp) in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال کیبورد پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending DocumentMessage!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "فایل" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send Document in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال فایل پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Don\'t Send Non-TextMessages in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال پیام غیرمتنی پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Non-TextMessages!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "پیام غیرمتنی" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send WebPage(Links) in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال صفحات وب پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending WebPages(Links)!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "صفحات وب" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send ForwardMessages in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال پیام فوروارد شده پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending ForwardedMessages!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "پیام فوروارد شده" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send Long-Messages in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال پیام طولانی پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser was Spamming!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' به خاطر اسپم کردن اخراج شد!'
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Long-Messages!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "پیام طولانی" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == (' Don\'t Send Short-Messages in this Group!\nYour Warns : [') then 
			if Lang:lower() == 'en' then
				return text
			else
				return " از ارسال پیام کوتاه پرهیز کنید!\nاین فقط یک اختار بود\nاخطار های شما: ["
			end
		elseif text == (' Kicked Out!\nUser Warns was more than 10 in Sending Short-Messages!') then 
			if Lang:lower() == 'en' then
				return text
			else
				return ' اخراج شد!\nکاربر بیش از 10 بار ارسال '.. "پیام کوتاه" ..' اخطار دریافت کرده بود!!'
			end
		elseif text == ('LINK_SET') then 
			if Lang:lower() == 'en' then
				return "New Link Saved !:\n"
			else
				return "لینک جدید ذهیره شد!:\n"
			end
		elseif text == ('WLC_SET') then 
			if Lang:lower() == 'en' then
				return "New Welcome text seted to :\n"
			else
				return "متن خوشامد گویی جدید تنظیم شد به :\n"
			end
		elseif text == ('LANG_SET_EN') then 
			if Lang:lower() == 'en' then
				return "Group Language Changed to English"
			else
				return "Group Language Changed to English"
			end
		elseif text == ('LANG_SET_FA') then 
			if Lang:lower() == 'en' then
				return "زبان گروه به پارسی تغییر کرد!"
			else
				return "زبان گروه به پارسی تغییر کرد!"
			end
		elseif text == ('FILTER_PLUS') then 
			if Lang:lower() == 'en' then
				return ' Added to Filterd Words List!'
			else
				return ' به لیست کلمات فیلتر شده اظافه شد!'
			end
		elseif text == ('FILTER_EGUL') then 
			if Lang:lower() == 'en' then
				return ' Removed to Filterd Words List!'
			else
				return ' از لیست کلمات فیلتر شده حذف شد!'
			end
		elseif text == ('FILTER_CLEAN') then 
			if Lang:lower() == 'en' then
				return "All Filterd Words Cleand"
			else
				return "تمام کلمات فیلتر شده ازاد شدند !"
			end
		elseif text == ('MUTE_ALL') then 
			if Lang:lower() == 'en' then
				return "Group Muted!\nAll Messages Will Clean ^\\_^\n"
			else
				return "گروه به حالت سکوت رفت!\nتمامی پیام ها حذف خواهند شد ^\\_^\n"
			end
		elseif text == ('MUTE_UNALL') then 
			if Lang:lower() == 'en' then
				return "Group Unmuted !\n"
			else
				return "گروه از حالت سکوت خارج شد!\n"
			end
		elseif text == ('START_P') then 
			if Lang:lower() == 'en' then
				return "*Hello Sir!*\n_IM SPR-CPU\'s Smart bot!_\nUse Me To Secure your Groups ;)'"
			else
				return "سلام!\nمن ربات هوشمند تیم SPR-CPU هستم\nاز من برای امن کردن گروه های خود استفاده کنید!"
			end
		elseif text == ('About Us') then 
			if Lang:lower() == 'en' then
				return text
			else
				return "درباره ما"
			end
		elseif text == ('Help') then 
			if Lang:lower() == 'en' then
				return text
			else
				return "راهنما"
			end
		elseif text == ('Charge') then 
			if Lang:lower() == 'en' then
				return "Charge Your Account"
			else
				return "خرید موجودی"
			end
		elseif text == ('Get Group') then 
			if Lang:lower() == 'en' then
				return text
			else
				return "دریافت گروه"
			end
		elseif text == ('Support') then 
			if Lang:lower() == 'en' then
				return text
			else
				return "پشتیبانی"
			end
		elseif text == ('TeamInfo') then 
			if Lang:lower() == 'en' then
				return text
			else
				return "اعضای رسمی"
			end
		elseif text == ('Rules') then 
			if Lang:lower() == 'en' then
				return text
			else
				return "قوانین و مقررات"
			end
		elseif text == ('Change Language') then 
			if Lang:lower() == 'en' then
				return 'تغییر به زبان پارسی'
			else
				return "Change to English"
			end
		elseif text == ('Group_List') then 
			if Lang:lower() == 'en' then
				return "List of Your Groups"
			else
				return "لیست گروه های شما"
			end
		elseif text == ('Panel') then 
			if Lang:lower() == 'en' then
				return 'Administration Panel'
			else
				return "پنل مدیریت"
			end
		elseif text == ('BUY_SPR_TEXT') then 
			if Lang:lower() == 'en' then
				return "Select Amount of Charge You Need!\nEach `SPR` Cousts as `0.25$`.\n"
			else
				return "مفدار موجودی مورد نظر خود را انتخاب کنید\nهر یک` SPR` معادل` 1000` تومان است\n."
			end
		elseif text == ('RULES_TEXT') then 
			if Lang:lower() == 'en' then
				return '*SPR-CPU Client Bot Rules !*\n'
				..'`1` : _If you add Bot To A Porn Group Your account will be Block and your_ SPR _Will lose!_\n'
			else
				return '*قوانین استفاده از ربات مدیریتی SPRCPU !*\n'
				..'`1` : *افزودن ربات در گروه های ضد اسلامی و پورن ممنوع میباشد !(در صورت دیده شدن چنین گروه هایی اکانت شما همراه با تمامی گروه ها و SPR های شما مسدود میشود !*'
			end
		elseif text == ('ERROR_PROMOTE') then 
			if Lang:lower() == 'en' then
				return "Error in Promation user : "
			else
				return "خطا در ارتقای کاربر : "
			end
		elseif text == ('ERROR_PROMOTE2') then 
			if Lang:lower() == 'en' then
				return "\nError Result : User rank is higher than a Member!"
			else
				return "\nشرح خطا : مقام کاربر بالاتر از یک کاربر سادست."
			end
		elseif text == ('SUCCESS_PROMOTE') then 
			if Lang:lower() == 'en' then
				return "User : "
			else
				return "کاربر : "
			end
		elseif text == ('SUCCESS_PROMOTE2') then 
			if Lang:lower() == 'en' then
				return " Promoted Success!"
			else
				return "با موفقیت ارتقاع یافت!"
			end
		elseif text == ('Error !\n Error Result : ') then 
			if Lang:lower() == 'en' then
				return text
			else
				return "خطا\nخروجی خطا : "
			end
		elseif text == ('CHANNEL_CANT_PROMOTE') then 
			if Lang:lower() == 'en' then
				return "Username That You Send is A Channel or Public SuperGroup!"
			else
				return "نام کاربری ارا=سالی توسط شما یک کانال یا سوپر گروه عمومی است!"
			end
		
		elseif text == ('ERROR_DEMOTE') then 
			if Lang:lower() == 'en' then
				return "Error in Demoteation user : "
			else
				return "خطا در تنزل کاربر : "
			end
		elseif text == ('ERROR_DEMOTE2') then 
			if Lang:lower() == 'en' then
				return "\nError Result : *User rank is lower than a Moderator!*"
			else
				return "\nشرح خطا : *مقام کاربر پایین تر از یک مدیر گروه سادست*."
			end
		elseif text == ('SUCCESS_DEMOTE') then 
			if Lang:lower() == 'en' then
				return "User : "
			else
				return "کاربر : "
			end
		elseif text == ('SUCCESS_DEMOTE2') then 
			if Lang:lower() == 'en' then
				return " Demoted Success!"
			else
				return "با موفقیت تنزل یافت!"
			end
		elseif text == ('CLEAN_MODS_SUCCESS') then 
			if Lang:lower() == 'en' then
				return "Group Moderators List Cleaned !\nGroup Admins Will Add Again in Moderators list!!"
			else
				return "تمامی مدیران تنزل مقام یافتند\nمدیران گروه دوباره در لیست مدیران افزوده میشود!!"
			end
		elseif text == ('NO_MODS') then 
			if Lang:lower() == 'en' then
				return "There Are No Moderators in this Group!"
			else
				return "هیچ مدیری در این گروه وجود ندارد!"
			end
		elseif text == ('LIST_MODS') then 
			if Lang:lower() == 'en' then
				return "Group Moderators for : "
			else
				return "مدیران گروه : "
			end
		elseif text == ('MUTE_ERROR') then 
			if Lang:lower() == 'en' then
				return "Error Mutation User : "
			else
				return "خطا در ساکت کردن کاربر : "
			end
		elseif text == ('MUTE_ERROR2') then 
			if Lang:lower() == 'en' then
				return " User is Already Mute!"
			else
				return " کاربر هم اکنون در لیست سکوت است!"
			end
		elseif text == ('MUTE_ERROR1') then 
			if Lang:lower() == 'en' then
				return "Error Mutation User : "
			else
				return "خطا در ساکت کردن کاربر : "
			end
		elseif text == ('MUTE_ERROR12') then 
			if Lang:lower() == 'en' then
				return " User Rank is Higher!"
			else
				return " مقام کاربر بالا است!"
			end
		elseif text == ('MUTE_SUCCESS') then 
			if Lang:lower() == 'en' then
				return "User : "
			else
				return "کاربر : "
			end
		elseif text == ('MUTE_SUCCESS2') then 
			if Lang:lower() == 'en' then
				return "Muted Success !"
			else
				return " ساکت شد !"
			end
		elseif text == ('UNMUTE_ERROR2') then 
			if Lang:lower() == 'en' then
				return " Error Unmuteation User :"
			else
				return "خطا در خارج کردن کاربر : "
			end
		elseif text == ('UNMUTE_ERROR') then 
			if Lang:lower() == 'en' then
				return " user is not in list!"
			else
				return " از لیست سکوت\nکاربر در لیست نیست!"
			end
		elseif text == ('UNMUTE_SUCCESS') then 
			if Lang:lower() == 'en' then
				return "User : "
			else
				return "کاربر : "
			end
		elseif text == ('UNMUTE_SUCCESS2') then 
			if Lang:lower() == 'en' then
				return " Unmuted Success!"
			else
				return " با موفقیت از لیست سکوت خارج شد!"
			end
		elseif text == ('MUTES_CLEAN') then 
			if Lang:lower() == 'en' then
				return "Muted Users Unmuted!"
			else
				return 
			end
		elseif text == ('KICK_ERROR') then 
			if Lang:lower() == 'en' then
				return "Cant kick user : "
			else
				return "نماتوانم "
			end
		elseif text == ('KICK_ERROR2') then 
			if Lang:lower() == 'en' then
				return " User rank is higher than you!"
			else
				return " را اخراج کنم!\nکاربر مقام دارد"
			end
		elseif text == ('INV_SUCS') then 
			if Lang:lower() == 'en' then
				return " Invited"
			else
				return " دعوت شد"
			end
		elseif text == ('INV_ERROR') then 
			if Lang:lower() == 'en' then
				return "Error :\n"
			else
				return " خطا »"
			end

		elseif text == ('ERROR_FREE_GP') then 
			if Lang:lower() == 'en' then
				return "Error!\n Free Groups Cant use this Command!"
			else
				return "خطا\n این دستور در گروه های رایگان قابل استفاده نیست!"
			end
		elseif text == ('ID_CAPTION') then 
			if Lang:lower() == 'fa' then
				return '> شناسه کاربری : [' .. "%s" .. ']\n'
				..'> شناسه گروه : [' .. "%s" .. ']\n'
				..'> نام : [' .. "%s" .. ']\n'
				..'> نام کاربری : [' .. "%s" .. ']\n'
			else
				return '> UserID : [' .. "%s" .. ']\n'
				..'> Group ID : [' .. "%s" .. ']\n'
				..'> Name : [' .. "%s" .. ']\n'
				..'> Username : [' .. "%s" .. ']\n'
			end
		elseif text == ('ID_BEFOR_DL') then 
			if Lang:lower() == 'fa' then
				return '> *شناسه کاربری *: [`' .. "%s" .. '`]\n'
				..'> *شناسه گروه *: [`' .. "%s" .. '`]\n'
				..'> *نام *: [`' .. "%s" .. '`]\n'
				..'> *نام کاربری *: [`' .. "%s" .. '`]\n'
			else
				return '> *UserID *: [`' .. "%s" .. '`]\n'
				..'> *Group ID *: [`' .. "%s" .. '`]\n'
				..'> *Name *: [`' .. "%s" .. '`]\n'
				..'> *Username *: [`' .. "%s" .. '`]\n'
			end
		elseif text == ('ID_NOTFOUND') then 
			if Lang:lower() == 'fa' then
				return '> *شناسه کاربری *: [`' .. "%s" .. '`]\n'
				..'> *شناسه گروه *: [`' .. "%s" .. '`]\n'
				..'> *نام *: [`' .. "%s" .. '`]\n'
				..'> *نام کاربری *: [`' .. "%s" .. '`]\n'
			else
				return '> *UserID *: [`' .. "%s" .. '`]\n'
				..'> *Group ID *: [`' .. "%s" .. '`]\n'
				..'> *Name *: [`' .. "%s" .. '`]\n'
				..'> *Username *: [`' .. "%s" .. '`]\n'
			end
		elseif text == ('ID_NOTFOUND_USERID') then 
			if Lang:lower() == 'en' then
				return "No user Found with %s user ID!"
			else
				return "هیچ کاربری با یوزرایدی %s یافت نشد!"
			end
		elseif text == ('ID_NOTFOUND_USERNAME') then 
			if Lang:lower() == 'en' then
				return "No Channel|PublicSupergroup|User found with %s username!"
			else
				return "هیچ کاربری با یوزرنیم  %s یافت نشد!"
			end
		elseif text == ('ID_CHANNEL') then 
			if Lang:lower() == 'fa' then
				return '*این نام کاربری برای یک کانال یا سوپرگروه است!:*\n'
				..'> *شناسه کاربری *: [`' .. "%s" .. '`]\n'
				..'> *شناسه گروه *: [`' .. "%s" .. '`]\n'
				..'> *نام *: [`' .. "%s" .. '`]\n'
				..'> *نام کاربری *: [`' .. "%s" .. '`]\n'
			else
				return '*This Username is for A PublicGroup or a Channel*\n'
				..'> *UserID *: [`' .. "%s" .. '`]\n'
				..'> *Group ID *: [`' .. "%s" .. '`]\n'
				..'> *Name *: [`' .. "%s" .. '`]\n'
				..'> *Username *: [`' .. "%s" .. '`]\n'
			end
		elseif text == ('GET_GP_1') then 
			if Lang:lower() == 'en' then
				return 'select A Group Type !\n'
				..'> Free Group has Ads and low speed and services !'
			else
				return [[
نوع گروه مورد نطر خود را انتخاب کنید !
گروه های رایگاه سرعت پایین تری دارند و همچنین تبلیغات نیز در انها ارسال میشود !]]
			end
		elseif text == ('GET_GP_2') then 
			if Lang:lower() == 'en' then
				return "Vip Group"
			else
				return "گروه ویژه"
			end
		elseif text == ('GET_GP_3') then 
			if Lang:lower() == 'en' then
				return "ّFree Group"
			else
				return "گروه ریگان"
			end
		elseif text == ('GET_GP_4') then 
			if Lang:lower() == 'en' then
				return 'Invite Me from This link to your group and Make me as an administrator ! \n link : t.me/SPRCPU_BOT?startgroup=new'
			else
				return 'از طریق لینک زیر مرا به گروه اد کنید و مرا ادمین کنید !\n لینک : t.me/SPRCPU_BOT?startgroup=new'
			end
		elseif text == ('GET_VIP_GP_1') then 
			if Lang:lower() == 'en' then
				return "You have 2 Way to get a VIP Group!\nfirst : Pay `1.25$`\nsecond : forward a message and seen it up to `2K`\n Coise one of them"
			else
				return "شما برای گرفتن گروه ویژه 2 راه دارید\nاول : پرداخت 5000 تومان\nدوم بالا بردن بازدید های یک پیام تا 2000بازدید\nیکی را انتخاب کنید!"
			end
		elseif text == ('SPR_PAY') then 
			if Lang:lower() == 'en' then
				return "Pay 1.25$"
			else
				return "پرداخت 5000"
			end
		elseif text == ('View_PAY') then 
			if Lang:lower() == 'en' then
				return "Forward message"
			else
				return "بالا بردن بازدید"
			end
		elseif text == ('NOT_E_SPR') then 
			if Lang:lower() == 'en' then
				return "not enogh Charge, Go to Mainpage and buy some :)"
			else
				return "موجودی کافی نیست! به صفحه اصلی بازگشته و مقداری خرید کنید!"
			end
		elseif text == ('Send_Link_FOR_J') then 
			if Lang:lower() == 'en' then
				return "Now Send Your Group Link!"
			else
				return "حال لینک گروه خود را ارسال کنید!"
			end
		elseif text == ('ADD_REPLY') then 
			if Lang:lower() == 'en' then
				return "This is Your Banner!\nForward it, when it views reached uper then 2K we'll call you to get your link!"
			else
				return "بنر شما حاظر شد!\nفوروارد کنید، به محض رسیدن بازدید هایش به 2000 ما به شما خبر میدهیم!"
			end
		elseif text == ('GET_LINK_SEEN') then 
			if Lang:lower() == 'en' then
				return "Views Reached up, Send Your Group Link Now (it must be SuperGroup!)"
			else
				return "بازدید ها بالا رفت!\nلینک سوپر گروه خود را ارسال کنید!"
			end
		else
			return text
		end
	end

	