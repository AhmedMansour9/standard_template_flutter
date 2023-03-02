import 'package:webview_flutter/data/model/language_model.dart';
import 'package:webview_flutter/utill/images.dart';

class AppConstants {

  static const String APP_NAME = 'web viwer';


  static const String BASE_URL = 'https://positifmobile.com/flyweb/admin/';
  static const String CONFIG_URI = 'api/settings/settings.php';


  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String FIRST_TIME = 'first';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';


  static List<LanguageModel> languages = [
    LanguageModel( languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel( languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),

  ];


}
