import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/features/dashboard/presentation/widget/pet_profile_card_view.dart';

void main() {
  testWidgets(
      'PetProfileCardView displays correct name, description, and image',
      (tester) async {
    // Arrange: Define sample data
    const name = 'Max';
    const description = 'A friendly dog looking for a home.';
    const image = 'max_image.png'; // Mock image name
    const gender = 'male';
    const age = '3 years old';

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PetProfileCardView(
            name: name,
            description: description,
            image: image,
            gender: gender,
            age: age,
          ),
        ),
      ),
    );

    // Assert: Check if the image widget is found
    final imageWidget = find.byType(Image);
    expect(imageWidget, findsOneWidget);

    // Assert: Check if name, description, and age are displayed
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.text(age), findsOneWidget);

    // Check if gender icon is displayed
    expect(find.byIcon(Icons.male), findsOneWidget);

    // Assert: Check the 'Read More' text
    expect(find.text('Read More'), findsOneWidget);
  });

  testWidgets('PetProfileCardView adjusts for tablet layout', (tester) async {
    // Arrange: Define sample data
    const name = 'Max';
    const description = 'A friendly dog looking for a home.';
    const image = 'max_image.png'; // Mock image name
    const gender = 'male';
    const age = '3 years old';

    // Mock tablet screen width
    tester.binding.window.physicalSizeTestValue =
        const Size(800, 600); // Tablet size
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PetProfileCardView(
            name: name,
            description: description,
            image: image,
            gender: gender,
            age: age,
          ),
        ),
      ),
    );

    // Assert: Check if font size and icon size are adjusted for tablet
    final textWidget = tester.widget<Text>(find.text(name));
    expect(textWidget.style?.fontSize,
        18); // Check if font size is adjusted for tablet

    final iconWidget = tester.widget<Icon>(find.byIcon(Icons.male));
    expect(iconWidget.size, 28); // Check if icon size is adjusted for tablet
  });
}
