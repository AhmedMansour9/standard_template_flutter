import 'package:dio/dio.dart';
import 'package:webview_flutter/data/datasource/remote/dio_connection/interceptor.dart';

import 'package:webview_flutter/data/repository/language_repo.dart';

import 'package:webview_flutter/data/repository/splash_repo.dart';
import 'package:webview_flutter/provider/home_provider.dart';
import 'package:webview_flutter/provider/localization_provider.dart';
import 'package:webview_flutter/provider/language_provider.dart';
import 'package:webview_flutter/provider/splash_provider.dart';
import 'package:webview_flutter/provider/theme_manager.dart';
import 'package:webview_flutter/provider/theme_provider.dart';
import 'package:webview_flutter/utill/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio_connection/dio_base.dart';
import 'localization/AppLanguage.dart';

final sl = GetIt.instance;

Future<void> initalize() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => LanguageRepo());



  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => AppLanguage());
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));
  sl.registerFactory(() => HomeProvider());
  sl.registerFactory(() => ThemeNotifier());


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
