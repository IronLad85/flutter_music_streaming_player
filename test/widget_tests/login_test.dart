import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:music_player/widgets/search_bar.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  testWidgets('TrackSearchBar calls onSearch callback correctly',
      (WidgetTester tester) async {
    bool isSearchCalled = false;

    await tester.pumpWidget(
      ThemeProvider(
        defaultThemeId: 'dark_theme',
        themes: appThemes,
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp(
              title: 'Music Player',
              home: TrackSearchBar(
                onSearch: (query) {
                  isSearchCalled = true;
                },
              ),
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.themeOf(themeContext).data,
            ),
          ),
        ),
      ),
    );

    final searchTextFieldFinder = find.byKey(const Key('search-field'));

    expect(searchTextFieldFinder, findsOneWidget);
    await tester.enterText(searchTextFieldFinder, 'Test query');
    expect(isSearchCalled, isTrue);
    await tester.enterText(searchTextFieldFinder, '');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(isSearchCalled, isTrue);
  });
}
