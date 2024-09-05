import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_pagination/material_pagination.dart'; 

void main() {
  group('MaterialPagination Widget Tests', () {
    testWidgets('renders page buttons correctly', (WidgetTester tester) async {
      // Arrange
      int currentPage = 1;
      int totalPages = 10;

      await tester.pumpWidget(
        MaterialApp(
          home: MaterialPagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: (int page) {},
          ),
        ),
      );

      // Act
      final pageButtonFinder = find.text('1');

      // Assert
      expect(pageButtonFinder, findsOneWidget); // Check if page 1 button is present
    });

    testWidgets('calls onPageChanged when page button is tapped', (WidgetTester tester) async {
      // Arrange
      int currentPage = 1;
      int totalPages = 5;
      int? selectedPage;

      await tester.pumpWidget(
        MaterialApp(
          home: MaterialPagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: (int page) {
              selectedPage = page;
            },
          ),
        ),
      );

      // Act
      await tester.tap(find.text('2')); // Tap on page 2 button
      await tester.pumpAndSettle(); // Wait for widget to update

      // Assert
      expect(selectedPage, equals(2)); // Ensure page 2 was selected
    });

    testWidgets('renders next and previous buttons correctly', (WidgetTester tester) async {
      // Arrange
      int currentPage = 1;
      int totalPages = 10;

      await tester.pumpWidget(
        MaterialApp(
          home: MaterialPagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: (int page) {},
          ),
        ),
      );

      // Act
      final nextButtonFinder = find.byIcon(Icons.arrow_forward_ios_rounded);
      final previousButtonFinder = find.byIcon(Icons.arrow_back_ios_new_rounded);

      // Assert
      expect(nextButtonFinder, findsOneWidget); // Next button should be visible
      expect(previousButtonFinder, findsNothing); // Previous button shouldn't be visible on the first page
    });

    testWidgets('next buttons trigger page changes', (WidgetTester tester) async {
      // Arrange
      int currentPage = 3;
      int totalPages = 5;
      int? selectedPage;

      await tester.pumpWidget(
        MaterialApp(
          home: MaterialPagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: (int page) {
              selectedPage = page;
            },
          ),
        ),
      );

      // Act & Assert
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded)); // Tap on the previous button
      await tester.pumpAndSettle(); // Wait for widget to update
      expect(selectedPage, equals(2)); // Ensure the page was changed to 2

     
    });
    testWidgets('previous buttons trigger page changes', (WidgetTester tester) async {
      // Arrange
      int currentPage = 3;
      int totalPages = 5;
      int? selectedPage;

      await tester.pumpWidget(
        MaterialApp(
          home: MaterialPagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: (int page) {
              selectedPage = page;
            },
          ),
        ),
      );

      // Act & Assert
      await tester.tap(find.byIcon(Icons.arrow_forward_ios_rounded)); // Tap on the next button
      await tester.pumpAndSettle(); // Wait for widget to update
      expect(selectedPage, equals(4)); // Ensure the page was changed back to 3
    });
  });
}
