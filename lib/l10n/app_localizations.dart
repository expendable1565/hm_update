import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// Diagnose text on home menu
  ///
  /// In en, this message translates to:
  /// **'Diagnose'**
  String get diagnose;

  /// Storage text on home menu
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// BMI Calculator title
  ///
  /// In en, this message translates to:
  /// **'BMI Calculator'**
  String get bmiCalculator;

  /// Healthy living title
  ///
  /// In en, this message translates to:
  /// **'Healthy Living'**
  String get healthyLiving;

  /// Choose a body part to diagnose
  ///
  /// In en, this message translates to:
  /// **'Choose Body Part'**
  String get chooseBody;

  /// Diagnoses anterior lungs
  ///
  /// In en, this message translates to:
  /// **'Lungs (front)'**
  String get frontLungs;

  /// Diagnoses posterior lungs
  ///
  /// In en, this message translates to:
  /// **'Lungs (back)'**
  String get backLungs;

  /// Heart Rate
  ///
  /// In en, this message translates to:
  /// **'Heart'**
  String get heartRate;

  /// Tap a Placement to Record
  ///
  /// In en, this message translates to:
  /// **'Tap a Placement to Record'**
  String get tapPlacement;

  /// Records a placement on image
  ///
  /// In en, this message translates to:
  /// **'Recording placement'**
  String get recordPlacement;

  /// Weight input
  ///
  /// In en, this message translates to:
  /// **'Input your weight'**
  String get inputWeight;

  /// Height input
  ///
  /// In en, this message translates to:
  /// **'Input your height'**
  String get inputHeight;

  /// Describles BMI
  ///
  /// In en, this message translates to:
  /// **'Your BMI Is'**
  String get yourBMI;

  /// Healthy!
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get healthy;

  /// Too fat
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get overweight;

  /// Too skinny
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get underweight;

  /// Instructions for operating the heartbeat detector
  ///
  /// In en, this message translates to:
  /// **'Place your finger on the camera until the view turns dark-red'**
  String get heartbeatInstruction;

  /// Your BPM is
  ///
  /// In en, this message translates to:
  /// **'Your BPM is'**
  String get yourBpmIs;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @chatbot.
  ///
  /// In en, this message translates to:
  /// **'Chatbot'**
  String get chatbot;

  /// No description provided for @mealMenu.
  ///
  /// In en, this message translates to:
  /// **'Meal Menu'**
  String get mealMenu;

  /// No description provided for @workoutSchedule.
  ///
  /// In en, this message translates to:
  /// **'Workout Schedule'**
  String get workoutSchedule;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
