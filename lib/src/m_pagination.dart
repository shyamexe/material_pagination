import 'package:flutter/material.dart';

/// [MaterialPagination] is a custom pagination widget that provides a flexible
/// and customizable way to navigate through pages.
///
/// This widget includes numbered page buttons and next/previous arrow buttons.
/// It allows for extensive customization, including the colors, sizes, and
/// behavior of the pagination controls.
///
/// Example usage:
/// ```dart
/// MaterialPagination(
///   currentPage: 1,
///   totalPages: 10,
///   onPageChanged: (page) {
///     print('Page $page selected');
///   },
///   visiblePageCount: 5,
///   activeColor: Colors.blue,
///   inactiveColor: Colors.grey,
///   fontStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
///   buttonSize: 32.0,
///   iconSize: 16.0,
///   iconGap: 4.0,
///   borderRadius: 8.0,
///   colorDarkness: 0.2,
/// )
/// ```
///
/// ## Parameters:
///
/// * [currentPage] - The current active page in the pagination sequence.
/// * [totalPages] - The total number of pages available for navigation.
/// * [onPageChanged] - A callback function that gets called when the user taps
/// on a page number or the next/previous arrow.
/// * [visiblePageCount] - The number of page buttons visible at once.
/// Default is 5.
/// * [activeColor] - The color of the currently active page button. Default is
/// [Colors.blue].
/// * [inactiveColor] - The color of the inactive page buttons. Default is
/// [Colors.grey].
/// * [fontStyle] - The text style for the page numbers. By default, it follows
/// the default [TextStyle].
/// * [buttonSize] - The size of each page number button (both width and height).
/// Default is 32.0.
/// * [iconSize] - The size of the arrow icons (previous/next). Default is 12.0.
/// * [iconGap] - The gap between page buttons and the next/previous icons.
/// Default is 4.0.
/// * [borderRadius] - The border radius for the page number buttons and icons.
/// Default is 8.0.
/// * [colorDarkness] - A value between 0 and 1, used to darken the active color
/// for the current page button border. Default is 0.3.
///
/// ## Example:
/// This example shows how to create a basic pagination bar with 10 total pages,
/// and a callback to handle page changes:
///
/// ```dart
/// MaterialPagination(
///   currentPage: 3,
///   totalPages: 10,
///   onPageChanged: (page) {
///     setState(() {
///       _currentPage = page;
///     });
///   },
///   visiblePageCount: 5,
///   activeColor: Colors.green,
///   inactiveColor: Colors.grey,
///   fontStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
///   buttonSize: 36.0,
///   borderRadius: 10.0,
/// )
/// ```
///
/// ## Features:
/// * Provides easy navigation through numbered pages.
/// * Customizable button and icon sizes, colors, and styles.
/// * Supports both numbered page buttons and next/previous arrow buttons.
/// * Optionally adjusts the number of visible page buttons.
///
/// The `MaterialPagination` widget gives you flexibility for pagination controls
/// in your Flutter applications, allowing you to adapt its appearance and behavior
/// to suit various design needs.
class MaterialPagination extends StatelessWidget {
  /// The currently active page in the pagination.
  final int currentPage;

  /// The total number of pages in the pagination.
  final int totalPages;

  /// Callback function that is triggered when the user selects a different page.
  /// It passes the selected page index.
  final Function(int page) onPageChanged;

  /// The number of page buttons visible at once.
  /// Defaults to 5.
  final int visiblePageCount;

  /// The color of the active page button.
  /// Defaults to [Colors.blue].
  final Color? activeColor;

  /// The color of inactive page buttons.
  /// Defaults to [Colors.grey].
  final Color? inactiveColor;

  /// Customizable text style for the page numbers.
  final TextStyle? fontStyle;

  /// The size of the page buttons.
  /// Defaults to 32.0.
  final double buttonSize;

  /// The size of the icons (e.g., for next/previous arrows).
  /// Defaults to 12.0.
  final double iconSize;

  /// The gap between the pagination icons and the buttons.
  /// Defaults to 4.0.
  final double iconGap;

  /// The border radius for the page buttons.
  /// Defaults to 8.0.
  final double borderRadius;

  /// The darkness level of the button colors when inactive, represented as a value between 0 and 1.
  /// Defaults to 0.3.
  final double colorDarkness;

  const MaterialPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.visiblePageCount = 5,
    this.fontStyle,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.buttonSize = 32.0,
    this.iconGap = 4.0,
    this.borderRadius = 8.0,
    this.colorDarkness = 0.3,
    this.iconSize = 12.0,
  });

  /// Helper method to calculate the visible range of page numbers to display.
  /// It ensures the range is adjusted correctly based on the current page, total pages,
  /// and the number of visible pages.
  List<int> _calculatePageRange() {
    int halfVisible =
        (visiblePageCount / 2).floor(); // Calculate half of visible pages
    int startPage = (currentPage - halfVisible)
        .clamp(1, totalPages); // Calculate start page
    int endPage =
        (currentPage + halfVisible).clamp(1, totalPages); // Calculate end page

    // Adjust start or end page if they exceed the range
    if (startPage == 1) {
      endPage = visiblePageCount.clamp(1, totalPages);
    } else if (endPage == totalPages) {
      startPage = (totalPages - visiblePageCount + 1).clamp(1, totalPages);
    }

    return [
      startPage,
      endPage
    ]; // Return the range as a list of start and end pages
  }

  /// Helper method to build a button for individual page numbers.
  /// [pageIndex] is the page number displayed on the button, [isCurrentPage] indicates whether it's the active page.
  Widget _buildPageButton(int pageIndex, bool isCurrentPage) {
    return SizedBox(
      height: buttonSize,
      width: buttonSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isCurrentPage
              ? activeColor?.withOpacity(0.2)
              : inactiveColor?.withOpacity(0.01),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isCurrentPage
                ? activeColor?.darken() ?? inactiveColor!
                : inactiveColor!.withOpacity(0.23),
          ),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            padding: EdgeInsets.zero,
            textStyle: fontStyle?.copyWith(
              color:
                  isCurrentPage ? activeColor : inactiveColor?.withOpacity(0.5),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: isCurrentPage
                ? activeColor?.darken()
                : inactiveColor?.withOpacity(0.5),
            disabledForegroundColor: isCurrentPage
                ? activeColor?.darken()
                : inactiveColor?.withOpacity(0.5),
          ),
          onPressed: isCurrentPage ? null : () => onPageChanged(pageIndex),
          child: Text(
            pageIndex.toString(),
          ),
        ),
      ),
    );
  }

  /// Helper method to build the next/previous icon button.
  /// [icon] is the icon to be displayed (next/previous), [isNext] indicates whether it's the 'next' button.
  Widget _buildIconButton(IconData icon, bool isNext) {
    return SizedBox(
      height: buttonSize,
      width: buttonSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: inactiveColor!.withOpacity(0.23),
          ),
        ),
        child: IconButton(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            foregroundColor: inactiveColor?.withOpacity(0.5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
          ),
          padding: EdgeInsets.zero,
          onPressed: isNext
              ? () => onPageChanged(currentPage + 1)
              : () => onPageChanged(currentPage - 1),
          icon: Icon(
            icon,
            size: iconSize,
            color: inactiveColor?.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  /// Builds the widget tree for the pagination control.
  @override
  Widget build(BuildContext context) {
    final range = _calculatePageRange();
    final startPage = range[0];
    final endPage = range[1];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage > 1) ...[
            _buildIconButton(Icons.arrow_back_ios_new_rounded, false),
            SizedBox(width: iconGap),
          ],
          if (startPage > (visiblePageCount / 2) + 1) ...[
            _buildPageButton(1, false),
            SizedBox(width: iconGap),
            Text('...',
                style: fontStyle?.copyWith(
                    color: inactiveColor?.withOpacity(0.5))),
            SizedBox(width: iconGap),
          ],
          ...List.generate(endPage - startPage + 1, (index) {
            int pageIndex = startPage + index;
            return Row(
              children: [
                _buildPageButton(pageIndex, pageIndex == currentPage),
                if (pageIndex != endPage) SizedBox(width: iconGap),
              ],
            );
          }),
          if (endPage < totalPages) ...[
            SizedBox(width: iconGap),
            Text('...',
                style: fontStyle?.copyWith(
                    color: inactiveColor?.withOpacity(0.5))),
            SizedBox(width: iconGap),
            _buildPageButton(totalPages, false),
          ],
          if (currentPage < totalPages) ...[
            SizedBox(width: iconGap),
            _buildIconButton(Icons.arrow_forward_ios_rounded, true),
          ],
        ],
      ),
    );
  }
}

/// Extension to darken a color by a given amount (0 to 1).
extension ColorExtensions on Color {
  Color darken([double amount = 0.1]) {
    // Ensure amount is within valid range
    assert(amount >= 0 && amount <= 1, 'Amount should be between 0 and 1');

    // Convert color to HSV, which makes it easier to adjust brightness
    final hsvColor = HSVColor.fromColor(this);

    // Calculate new value (brightness) of the color
    final newValue = (hsvColor.value - amount).clamp(0.0, 1.0);

    // Return new color with adjusted brightness
    return hsvColor.withValue(newValue).toColor();
  }
}
