import 'package:country_search/country_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Localizations Tests', () {
    test('English localizations work correctly', () {
      final localizations = CountryLocalizationsEn();

      expect(localizations.getCountryName('US'), equals('United States'));
      expect(localizations.getCountryName('RU'), equals('Russia'));
      expect(localizations.selectCountry, equals('Select Country'));
      expect(localizations.searchCountry, equals('Search country...'));
      expect(localizations.selectYourCountry, equals('Select your country'));
    });

    test('Spanish localizations work correctly', () {
      final localizations = CountryLocalizationsEs();

      expect(localizations.getCountryName('US'), equals('Estados Unidos'));
      expect(localizations.getCountryName('RU'), equals('Rusia'));
      expect(localizations.selectCountry, equals('Seleccionar país'));
      expect(localizations.searchCountry, equals('Buscar país...'));
      expect(localizations.selectYourCountry, equals('Selecciona tu país'));
    });

    test('French localizations work correctly', () {
      final localizations = CountryLocalizationsFr();

      expect(localizations.getCountryName('US'), equals('États-Unis'));
      expect(localizations.getCountryName('RU'), equals('Russie'));
      expect(localizations.selectCountry, equals('Sélectionner un pays'));
      expect(localizations.searchCountry, equals('Rechercher un pays...'));
      expect(
          localizations.selectYourCountry, equals('Sélectionnez votre pays'));
    });

    test('Russian localizations work correctly', () {
      final localizations = CountryLocalizationsRu();

      expect(localizations.getCountryName('US'), equals('США'));
      expect(localizations.getCountryName('RU'), equals('Россия'));
      expect(localizations.selectCountry, equals('Выберите страну'));
      expect(localizations.searchCountry, equals('Поиск страны...'));
      expect(localizations.selectYourCountry, equals('Выберите вашу страну'));
    });

    test('German localizations work correctly', () {
      final localizations = CountryLocalizationsDe();

      expect(localizations.getCountryName('US'), equals('Vereinigte Staaten'));
      expect(localizations.getCountryName('RU'), equals('Russland'));
      expect(localizations.getCountryName('DE'), equals('Deutschland'));
      expect(localizations.selectCountry, equals('Land auswählen'));
      expect(localizations.searchCountry, equals('Land suchen...'));
      expect(localizations.selectYourCountry, equals('Wählen Sie Ihr Land'));
    });

    test('Portuguese localizations work correctly', () {
      final localizations = CountryLocalizationsPt();

      expect(localizations.getCountryName('US'), equals('Estados Unidos'));
      expect(localizations.getCountryName('RU'), equals('Rússia'));
      expect(localizations.getCountryName('PT'), equals('Portugal'));
      expect(localizations.selectCountry, equals('Selecionar país'));
      expect(localizations.searchCountry, equals('Pesquisar país...'));
      expect(localizations.selectYourCountry, equals('Selecione seu país'));
    });

    test('Italian localizations work correctly', () {
      final localizations = CountryLocalizationsIt();

      expect(localizations.getCountryName('US'), equals('Stati Uniti'));
      expect(localizations.getCountryName('RU'), equals('Russia'));
      expect(localizations.getCountryName('IT'), equals('Italia'));
      expect(localizations.selectCountry, equals('Seleziona Paese'));
      expect(localizations.searchCountry, equals('Cerca paese...'));
      expect(localizations.selectYourCountry, equals('Seleziona il tuo paese'));
    });

    test('Japanese localizations work correctly', () {
      final localizations = CountryLocalizationsJa();

      expect(localizations.getCountryName('US'), equals('アメリカ合衆国'));
      expect(localizations.getCountryName('RU'), equals('ロシア'));
      expect(localizations.getCountryName('JP'), equals('日本'));
      expect(localizations.selectCountry, equals('国を選択'));
      expect(localizations.searchCountry, equals('国を検索...'));
      expect(localizations.selectYourCountry, equals('あなたの国を選択してください'));
    });

    test('Chinese localizations work correctly', () {
      final localizations = CountryLocalizationsZh();

      expect(localizations.getCountryName('US'), equals('美国'));
      expect(localizations.getCountryName('RU'), equals('俄罗斯'));
      expect(localizations.getCountryName('CN'), equals('中国'));
      expect(localizations.selectCountry, equals('选择国家'));
      expect(localizations.searchCountry, equals('搜索国家...'));
      expect(localizations.selectYourCountry, equals('选择您的国家'));
    });

    test('Korean localizations work correctly', () {
      final localizations = CountryLocalizationsKo();

      expect(localizations.getCountryName('US'), equals('미국'));
      expect(localizations.getCountryName('RU'), equals('러시아'));
      expect(localizations.getCountryName('KR'), equals('대한민국'));
      expect(localizations.selectCountry, equals('국가 선택'));
      expect(localizations.searchCountry, equals('국가 검색...'));
      expect(localizations.selectYourCountry, equals('국가를 선택하세요'));
    });

    test('Dutch localizations work correctly', () {
      final localizations = CountryLocalizationsNl();

      expect(localizations.getCountryName('US'), equals('Verenigde Staten'));
      expect(localizations.getCountryName('RU'), equals('Rusland'));
      expect(localizations.getCountryName('NL'), equals('Nederland'));
      expect(localizations.selectCountry, equals('Selecteer Land'));
      expect(localizations.searchCountry, equals('Zoek land...'));
      expect(localizations.selectYourCountry, equals('Selecteer uw land'));
    });

    test('Arabic localizations work correctly', () {
      final localizations = CountryLocalizationsAr();

      expect(localizations.getCountryName('US'), equals('الولايات المتحدة'));
      expect(localizations.getCountryName('RU'), equals('روسيا'));
      expect(localizations.getCountryName('SA'),
          equals('المملكة العربية السعودية'));
      expect(localizations.selectCountry, equals('اختر البلد'));
      expect(localizations.searchCountry, equals('البحث عن بلد...'));
      expect(localizations.selectYourCountry, equals('اختر بلدك'));
    });

    test('Turkish localizations work correctly', () {
      final localizations = CountryLocalizationsTr();

      expect(localizations.getCountryName('US'),
          equals('Amerika Birleşik Devletleri'));
      expect(localizations.getCountryName('RU'), equals('Rusya'));
      expect(localizations.getCountryName('TR'), equals('Türkiye'));
      expect(localizations.selectCountry, equals('Ülke Seç'));
      expect(localizations.searchCountry, equals('Ülke ara...'));
      expect(localizations.selectYourCountry, equals('Ülkenizi seçin'));
    });

    test('Indonesian localizations work correctly', () {
      final localizations = CountryLocalizationsId();

      expect(localizations.getCountryName('US'), equals('Amerika Serikat'));
      expect(localizations.getCountryName('RU'), equals('Rusia'));
      expect(localizations.getCountryName('ID'), equals('Indonesia'));
      expect(localizations.selectCountry, equals('Pilih Negara'));
      expect(localizations.searchCountry, equals('Cari negara...'));
      expect(localizations.selectYourCountry, equals('Pilih negara Anda'));
    });

    test('Hindi localizations work correctly', () {
      final localizations = CountryLocalizationsHi();

      expect(
          localizations.getCountryName('US'), equals('संयुक्त राज्य अमेरिका'));
      expect(localizations.getCountryName('RU'), equals('रूस'));
      expect(localizations.getCountryName('IN'), equals('भारत'));
      expect(localizations.selectCountry, equals('देश चुनें'));
      expect(localizations.searchCountry, equals('देश खोजें...'));
      expect(localizations.selectYourCountry, equals('अपना देश चुनें'));
    });

    test('Polish localizations work correctly', () {
      final localizations = CountryLocalizationsPl();

      expect(localizations.getCountryName('US'), equals('Stany Zjednoczone'));
      expect(localizations.getCountryName('RU'), equals('Rosja'));
      expect(localizations.getCountryName('PL'), equals('Polska'));
      expect(localizations.selectCountry, equals('Wybierz kraj'));
      expect(localizations.searchCountry, equals('Szukaj kraju...'));
      expect(localizations.selectYourCountry, equals('Wybierz swój kraj'));
    });

    test('Ukrainian localizations work correctly', () {
      final localizations = CountryLocalizationsUk();

      expect(localizations.getCountryName('US'),
          equals('Сполучені Штати Америки'));
      expect(localizations.getCountryName('RU'), equals('Росія'));
      expect(localizations.getCountryName('UA'), equals('Україна'));
      expect(localizations.selectCountry, equals('Оберіть країну'));
      expect(localizations.searchCountry, equals('Пошук країни...'));
      expect(localizations.selectYourCountry, equals('Оберіть вашу країну'));
    });

    test('Vietnamese localizations work correctly', () {
      final localizations = CountryLocalizationsVi();

      expect(localizations.getCountryName('US'), equals('Hoa Kỳ'));
      expect(localizations.getCountryName('RU'), equals('Nga'));
      expect(localizations.getCountryName('VN'), equals('Việt Nam'));
      expect(localizations.selectCountry, equals('Chọn quốc gia'));
      expect(localizations.searchCountry, equals('Tìm kiếm quốc gia...'));
      expect(localizations.selectYourCountry, equals('Chọn quốc gia của bạn'));
    });

    test('Thai localizations work correctly', () {
      final localizations = CountryLocalizationsTh();

      expect(localizations.getCountryName('US'), equals('สหรัฐอเมริกา'));
      expect(localizations.getCountryName('RU'), equals('รัสเซีย'));
      expect(localizations.getCountryName('TH'), equals('ไทย'));
      expect(localizations.selectCountry, equals('เลือกประเทศ'));
      expect(localizations.searchCountry, equals('ค้นหาประเทศ...'));
      expect(localizations.selectYourCountry, equals('เลือกประเทศของคุณ'));
    });

    test('All localizations have same country codes', () {
      final en = CountryLocalizationsEn();
      final es = CountryLocalizationsEs();
      final fr = CountryLocalizationsFr();
      final ru = CountryLocalizationsRu();
      final de = CountryLocalizationsDe();
      final pt = CountryLocalizationsPt();
      final it = CountryLocalizationsIt();
      final ja = CountryLocalizationsJa();
      final ko = CountryLocalizationsKo();
      final nl = CountryLocalizationsNl();
      final ar = CountryLocalizationsAr();
      final hi = CountryLocalizationsHi();
      final id = CountryLocalizationsId();
      final pl = CountryLocalizationsPl();
      final tr = CountryLocalizationsTr();
      final uk = CountryLocalizationsUk();
      final vi = CountryLocalizationsVi();
      final th = CountryLocalizationsTh();
      final zh = CountryLocalizationsZh();

      expect(en.allCountryNames.keys, equals(es.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(fr.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(ru.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(de.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(pt.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(it.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(ja.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(ko.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(nl.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(ar.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(hi.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(id.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(pl.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(tr.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(uk.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(vi.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(th.allCountryNames.keys));
      expect(en.allCountryNames.keys, equals(zh.allCountryNames.keys));
    });

    test('Localizations delegate works', () {
      expect(CountryLocalizations.delegate, isNotNull);
      expect(CountryLocalizations.supportedLocales, isNotEmpty);
      expect(CountryLocalizations.supportedLocales.length, equals(19));
    });

    test('Fallback to English for unsupported locale', () {
      // Test with unsupported locale (Swedish)
      const unsupportedLocale = Locale('sv');
      final localizations = lookupCountryLocalizations(unsupportedLocale);

      // Should fallback to English
      expect(localizations, isA<CountryLocalizationsEn>());
      expect(localizations.getCountryName('US'), equals('United States'));
      expect(localizations.selectCountry, equals('Select Country'));
    });
  });
}
