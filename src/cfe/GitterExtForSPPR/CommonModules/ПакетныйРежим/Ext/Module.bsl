﻿
Функция ПолучитьТаблицуВерсийХранилища( Знач Хранилище,
											 Приложение,
											 БазаАдрес,
											 БазаПользователь,
											 БазаПароль,
											 ХранилищеАдрес,
											 ХранилищеПользователь,
											 ХранилищеПароль,
											 НачинаяСВерсии     = Неопределено,
											 ЗаканчиваяНаВерсии = Неопределено ) Экспорт
	
	КаталогВременныхФайлов  = КаталогВременныхФайлов();
	ТабличныйДокументВерсий = КаталогВременныхФайлов + "vhistory.mxl";
	
	ТекстКоманды = СоздатьКоманду( Приложение );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/" + ФлагСервернойФайловойБазы(БазаАдрес), БазаАдрес );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/N", БазаПользователь );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/P", БазаПароль );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/ConfigurationRepositoryF", ХранилищеАдрес );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/ConfigurationRepositoryN", ХранилищеПользователь );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/ConfigurationRepositoryP", ХранилищеПароль );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/ConfigurationRepositoryReport", ТабличныйДокументВерсий );
	
	Если ЗначениеЗаполнено( НачинаяСВерсии ) Тогда
		
		ДобавитьВКомандуКлючЗначение( ТекстКоманды, "-NBegin", Формат( НачинаяСВерсии, "ЧН=; ЧГ=0" ) );
		
	КонецЕсли;
	
	Если ЗначениеЗаполнено( ЗаканчиваяНаВерсии ) Тогда
		
		ДобавитьВКомандуКлючЗначение( ТекстКоманды, "-NEnd", Формат( ЗаканчиваяНаВерсии, "ЧН=; ЧГ=0" ) );
		
	КонецЕсли;
	
	КодВозврата = ВыполнитьКоманду1С( ТекстКоманды, Хранилище );
	
	Если КодВозврата <> 0 Тогда
		
		ОписаниеОшибки = "При получении таблицы версий хранилища произошла неизвестная ошибка";
		ВызватьИсключение ИсключениеОшибкаПриВыполненииКоманды( ОписаниеОшибки, ТекстКоманды );
		
	КонецЕсли;
	
	ТабДок = Новый ТабличныйДокумент();
	ТабДок.Прочитать( ТабличныйДокументВерсий );
	ТаблицаВерсий = ПолучитьТаблицуВерсийИзТабличногоДокумента( ТабДок );
	
	УдалитьФайлы( ТабличныйДокументВерсий );
	
	Возврат ТаблицаВерсий;
	
КонецФункции




Процедура ЗагрузитьКонфигурациюИзХранилища( Знач Хранилище,
												 Приложение,
												 БазаАдрес,
												 БазаПользователь,
												 БазаПароль,
												 ХранилищеАдрес,
												 ХранилищеПользователь,
												 ХранилищеПароль,
												 НомерВерсии ) Экспорт
	
	ТекстКоманды = СоздатьКоманду( Приложение );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/" + ФлагСервернойФайловойБазы(БазаАдрес), БазаАдрес );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/N", БазаПользователь );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/P", БазаПароль );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/ConfigurationRepositoryF", ХранилищеАдрес );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/ConfigurationRepositoryN", ХранилищеПользователь );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/ConfigurationRepositoryP", ХранилищеПароль );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/ConfigurationRepositoryUpdateCfg" );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "-v", Формат( НомерВерсии, "ЧГ=" ) );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "-revised" );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "-force" );
	
	КодВозврата = ВыполнитьКоманду1С( ТекстКоманды, Хранилище );
	
	Если КодВозврата <> 0 Тогда
		
		ОписаниеОшибки = "При обновлении основной конфигурации конфигурацией из хранилища произошла неизвестная ошибка";
		ВызватьИсключение ИсключениеОшибкаПриВыполненииКоманды( ОписаниеОшибки, ТекстКоманды );
		
	КонецЕсли;
	
КонецПроцедуры


Процедура ВыгрузитьКонфигурациюВФайлы( Знач Хранилище,
									   Знач Приложение,
									   Знач БазаАдрес,
									   Знач БазаПользователь,
									   Знач БазаПароль,
											Каталог ) Экспорт
	
	выгрузкаСОбновлением = Хранилище.ОбновлениеВыгрузки;
	
	Если выгрузкаСОбновлением Тогда
		
		Если Не ОбщийГитКлиентСервер.ФайлСуществует( Каталог + "\ConfigDumpInfo.xml" ) Тогда
			
			выгрузкаСОбновлением = Ложь;
			
		Иначе
			
			имяФайлаИзменений = Справочники.Хранилища.ИмяФайлаИзменений( Хранилище );
			
			ТекстКоманды = СоздатьКоманду( Приложение );
			ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/" + ФлагСервернойФайловойБазы(БазаАдрес), БазаАдрес );
			ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/N", БазаПользователь );
			ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/P", БазаПароль );
			ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/DumpConfigToFiles", Каталог );
			
			ДобавитьВКомандуКлючЗначение( ТекстКоманды, "-getChanges", имяФайлаИзменений );
			
			ВыполнитьКоманду1С( ТекстКоманды, Хранилище );
			
			выгрузкаСОбновлением = Не ПроверитьФайлИзменений_ТребуетсяПолнаяВыгрузка( Хранилище );
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если Не выгрузкаСОбновлением Тогда
		
		Справочники.Хранилища.УдалитьВсеФайлыВКаталоге( Каталог );
		
	КонецЕсли;
	
	ТекстКоманды = СоздатьКоманду( Приложение );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/" + ФлагСервернойФайловойБазы(БазаАдрес), БазаАдрес );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/N", БазаПользователь );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/P", БазаПароль );
	ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/DumpConfigToFiles", Каталог );
	
	Если выгрузкаСОбновлением Тогда
		
		ДобавитьВКомандуКлючЗначение( ТекстКоманды, "-update" );
		ДобавитьВКомандуКлючЗначение( ТекстКоманды, "-force" );
		
	КонецЕсли;
	
	КодВозврата = ВыполнитьКоманду1С( ТекстКоманды, Хранилище );
	
	Если КодВозврата <> 0 Тогда
		
		ОписаниеОшибки = "При выгрузке основной конфигурации в файлы произошла неизвестная ошибка";
		ВызватьИсключение ИсключениеОшибкаПриВыполненииКоманды( ОписаниеОшибки, ТекстКоманды );
		
	КонецЕсли;
	
КонецПроцедуры


Процедура ВыгрузитьКонфигурациюВCF( Знач Хранилище, Знач Приложение, Знач БазаАдрес, Знач БазаПользователь, Знач БазаПароль, Знач пПутьКCF ) Экспорт
	
	ТекстКоманды = СоздатьКоманду(Приложение);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/" + ФлагСервернойФайловойБазы(БазаАдрес), БазаАдрес);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/N", БазаПользователь);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/P", БазаПароль);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/DumpCfg", пПутьКCF);
	
	КодВозврата = ВыполнитьКоманду1С(ТекстКоманды, Хранилище);
	Если КодВозврата <> 0 Тогда
		ОписаниеОшибки = "При выгрузке основной конфигурации в CF произошла неизвестная ошибка";
		ВызватьИсключение ИсключениеОшибкаПриВыполненииКоманды(ОписаниеОшибки, ТекстКоманды);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбновитьКонфигурациюБазыДанных( Знач Хранилище, Знач Приложение, Знач БазаАдрес, Знач БазаПользователь, Знач БазаПароль ) Экспорт
	
	ТекстКоманды = СоздатьКоманду(Приложение);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/" + ФлагСервернойФайловойБазы(БазаАдрес), БазаАдрес);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/N", БазаПользователь);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/P", БазаПароль);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/UpdateDBCfg");
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "-Dynamic–");
	
	КодВозврата = ВыполнитьКоманду1С(ТекстКоманды, Хранилище);
	Если КодВозврата <> 0 Тогда
		ОписаниеОшибки = "При обновлении конфигурации базы данных произошла неизвестная ошибка";
		ВызватьИсключение ИсключениеОшибкаПриВыполненииКоманды(ОписаниеОшибки, ТекстКоманды);
	КонецЕсли;
	
КонецПроцедуры


Процедура ЗапуститьВРежимеПредприятияПоСтрокеСоединения( Знач Приложение, Знач пСтрокаСоединения, Знач БазаПользователь, Знач БазаПароль, Знач пОжидатьЗавершения = Ложь, Знач пПараметрЗапуска = "") Экспорт

	ТекстКоманды = СоздатьКоманду( Приложение, Ложь );
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/IBConnectionString", пСтрокаСоединения);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/N", БазаПользователь);
	ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/P", БазаПароль);
	
	Если ЗначениеЗаполнено( пПараметрЗапуска ) Тогда
		ДобавитьВКомандуКлючЗначение(ТекстКоманды, "/C" + пПараметрЗапуска);
	КонецЕсли;
	
	Если пОжидатьЗавершения Тогда
		
		КодВозврата = ВыполнитьКоманду1С( ТекстКоманды,, пОжидатьЗавершения );
		Если КодВозврата <> 0 Тогда
			ОписаниеОшибки = "При запуске в режиме предприятия произошла ошибка.";
			ВызватьИсключение ИсключениеОшибкаПриВыполненииКоманды(ОписаниеОшибки, ТекстКоманды);
		КонецЕсли;
		
	Иначе
		
		ВыполнитьКоманду1С( ТекстКоманды,, пОжидатьЗавершения );
		
	КонецЕсли;

КонецПроцедуры


Функция СоздатьКоманду(Знач Приложение, Знач пРежимКонфигуратора = Истина)
	
	Если пРежимКонфигуратора Тогда
		ТекстКоманды = """" + Приложение + """" + " DESIGNER ";
	Иначе
		ТекстКоманды = """" + Приложение + """" + " ENTERPRISE ";
	КонецЕсли;
	Возврат ТекстКоманды;
	
КонецФункции

Функция ВыполнитьКоманду1С( ТекстКоманды, Знач Хранилище = Неопределено, Знач пОжидатьЗавершения = Истина )
	
	Если Хранилище = Неопределено Тогда
		
		КаталогКонфигурации = Неопределено;
		
	Иначе
		
		Если ЗначениеЗаполнено( Хранилище.ФайлВыводаСлужебныхСообщений ) Тогда
			
			ДобавитьВКомандуКлючЗначение( ТекстКоманды, "/Out", Хранилище.ФайлВыводаСлужебныхСообщений );
			ДобавитьВКомандуКлючЗначение( ТекстКоманды, "-NoTruncate" );
			
			ОбщийГитКлиентСервер.ОбеспечитьТекстовыйФайл( Хранилище.ФайлВыводаСлужебныхСообщений );
			
			записьФайла = Новый ЗаписьТекста( Хранилище.ФайлВыводаСлужебныхСообщений, , , Истина );
			записьФайла.ЗаписатьСтроку( "" + ТекущаяДата() );
			записьФайла.ЗаписатьСтроку( ТекстКоманды );
			записьФайла.Закрыть();
			
		КонецЕсли;
		
		КаталогКонфигурации = Справочники.Хранилища.ПолучитьКаталогКонфигурации( Хранилище );
		
	КонецЕсли;
	
	Возврат ОбщийГитКлиентСервер.ВыполнитьКоманду( КаталогКонфигурации, ТекстКоманды, пОжидатьЗавершения );
	
КонецФункции




Процедура ДобавитьВКомандуКлючЗначение(ТекстКоманды, Ключ, Значение = Неопределено)
	
	Если Значение = Неопределено Тогда
		ТекстКоманды = ТекстКоманды + " " + Ключ;
	Иначе	
		ТекстКоманды = ТекстКоманды + " " + Ключ + " """ + ОбщийГитКлиентСервер.Экранировать(Значение) + """";
	КонецЕсли;
		
КонецПроцедуры

Функция ИсключениеОшибкаПриВыполненииКоманды(ОписаниеОшибки, ТекстКоманды)
	
	Возврат ОписаниеОшибки + "(" + ТекстКоманды + ")";	
	
КонецФункции

Функция ПолучитьТаблицуВерсийИзТабличногоДокумента(ТабличныйДокумент)
		
	ТаблицаВерсий = Новый ТаблицаЗначений;
	ТаблицаВерсий.Колонки.Добавить("НомерВерсии", Новый ОписаниеТипов("Число"));
	ТаблицаВерсий.Колонки.Добавить("ИмяПользователя", Новый ОписаниеТипов("Строка"));
	ТаблицаВерсий.Колонки.Добавить("ДатаСоздания", Новый ОписаниеТипов("Дата"));
	ТаблицаВерсий.Колонки.Добавить("Комментарий", Новый ОписаниеТипов("Строка"));
	
	НачинаяСоСтроки = 1;
	Пока ТабличныйДокумент.ВысотаТаблицы >= НачинаяСоСтроки Цикл
		ОбластьПоиска = ТабличныйДокумент.Область(НачинаяСоСтроки,1,ТабличныйДокумент.ВысотаТаблицы,1);
		ОбластьРезультат = ТабличныйДокумент.НайтиТекст("Версия:",,ОбластьПоиска, Истина, Истина, Истина, Ложь); 		
		Если ОбластьРезультат <> Неопределено Тогда
			НоваяСтрока = ТаблицаВерсий.Добавить();
			НоваяСтрока.НомерВерсии = Число(ТабличныйДокумент.Область(ОбластьРезультат.Верх, 2).Текст);
			НоваяСтрока.ИмяПользователя = ТабличныйДокумент.Область(ОбластьРезультат.Верх + 1, 2).Текст;
			ДатаСоздания = ТабличныйДокумент.Область(ОбластьРезультат.Верх + 2, 2).Текст;
			ВремяСоздания = ТабличныйДокумент.Область(ОбластьРезультат.Верх + 3, 2).Текст;
			НоваяСтрока.ДатаСоздания = Дата(ДатаСоздания + " " + ВремяСоздания);
			НоваяСтрока.Комментарий = ТабличныйДокумент.Область(ОбластьРезультат.Верх + 4, 2).Текст;
			
			НачинаяСоСтроки = ОбластьРезультат.Верх + 5;
		Иначе
			Прервать;
	    КонецЕсли;
	КонецЦикла;
	
	Возврат ТаблицаВерсий;
		
КонецФункции



Функция ПроверитьФайлИзменений_ТребуетсяПолнаяВыгрузка( Знач Хранилище )

	Если Не Хранилище.ОбновлениеВыгрузки Тогда
		Возврат Истина;
	КонецЕсли;
	
	имяФайлаИзменений = Справочники.Хранилища.ИмяФайлаИзменений( Хранилище );
	
	Если Не ОбщийГитКлиентСервер.ФайлСуществует(имяФайлаИзменений) Тогда
		Возврат Истина;
	Иначе
		
		чтениеФайла = Новый ЧтениеТекста( имяФайлаИзменений );
		текстПервойСтроки = чтениеФайла.ПрочитатьСтроку();
		чтениеФайла.Закрыть();
		Если Найти( ВРег( текстПервойСтроки ), ВРег( "FullDump" ) ) = 1 Тогда
			Возврат Истина;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Ложь;

КонецФункции


Функция ПроверитьФайлИзменений_ЕстьИзменения( Знач Хранилище ) Экспорт

	Если Не Хранилище.ОбновлениеВыгрузки Тогда
		Возврат Истина;
	КонецЕсли;
	
	имяФайлаИзменений = Справочники.Хранилища.ИмяФайлаИзменений( Хранилище );
	
	Если Не ОбщийГитКлиентСервер.ФайлСуществует(имяФайлаИзменений) Тогда
		Возврат Ложь;
	Иначе
		
		чтениеФайла = Новый ЧтениеТекста( имяФайлаИзменений );
		Если Не ЗначениеЗаполнено( ВРег( чтениеФайла.ПрочитатьСтроку() ) ) Тогда
			Возврат Ложь;
		КонецЕсли;
		чтениеФайла.Закрыть();
		
	КонецЕсли;
	
	Возврат Истина;

КонецФункции

#Область РасширениеСППР

//Костыльная проверка на то, что база файловая или нет
Функция ФлагСервернойФайловойБазы( Знач БазаАдрес )		
	Файл = Новый Файл(БазаАдрес);
	Если Файл.Существует() Тогда
		Возврат "F";
	КонецЕсли;	
	
	Возврат "S";
КонецФункции


#КонецОбласти
