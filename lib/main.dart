import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 191, 235, 247));

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 71, 5, 125));
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((func) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.tertiaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.tertiaryContainer,
              foregroundColor: kDarkColorScheme.onTertiaryContainer,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            foregroundColor: kDarkColorScheme.onTertiaryContainer,
          )),
        ),
        theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorScheme,
            appBarTheme: AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onTertiaryContainer,
              foregroundColor: kColorScheme.tertiaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
              color: kColorScheme.tertiaryContainer,
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.secondaryContainer,
            )),
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 20,
                  ),
                )),
        themeMode: ThemeMode.system,
        home: const Expenses(),
      ),
    );
  // });
}
