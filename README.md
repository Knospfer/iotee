# Per Marco

Per buildare un app in Flutter su windows ti servono 3 cose:

- Android Studio: https://developer.android.com/studio
- Flutter SDK: https://docs.flutter.dev/development/tools/sdk/releases?tab=macos

Questa app utilizza la generazioen automatica del codice per alcune cose (AutoRoute)

Per questo, per buidlare l'app devi runnare questi comandi (lo step 2 è per la generazione del codice)

- flutter pub get
- flutter pub run build_runner build --delete-conflicting-outputs

poi se vuoi runnare l'app direttamente sul tuo telefono devi fare

- flutter run android (oppure aprire un file.dart e fare F5)

invece se vuoi buildare l'apk

- flutter build apk

e ti metterà l'apk in build/app/outputs/flutter-apk/app-release.apk

in entrambi i casi darà dei warning che saranno scritti in rosso quindi non ti preoccupare
