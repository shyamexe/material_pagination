import 'package:flutter/material.dart';

class MaterialPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int page) onPageChanged;
  final int visiblePageCount;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? fontStyle;
  final double buttonSize; 
  final double iconSize;
  final double iconGap;  
  final double borderRadius; 
  /// 0-1 
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

  List<int> _calculatePageRange() {
    int halfVisible = (visiblePageCount / 2).floor();
    int startPage = (currentPage - halfVisible).clamp(1, totalPages);
    int endPage = (currentPage + halfVisible).clamp(1, totalPages);

    if (startPage == 1) {
      endPage = visiblePageCount.clamp(1, totalPages);
    } else if (endPage == totalPages) {
      startPage = (totalPages - visiblePageCount + 1).clamp(1, totalPages);
    }

    return [startPage, endPage];
  }

  

  Widget _buildPageButton(int pageIndex, bool isCurrentPage) {
    return SizedBox(
      height: buttonSize,
      width: buttonSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isCurrentPage ? activeColor?.withOpacity(0.2) : inactiveColor?.withOpacity(0.01),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isCurrentPage ?  activeColor?.darken() ?? inactiveColor! : inactiveColor!.withOpacity(0.23),
          ),
        ),
        child: TextButton(
         
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
            padding: EdgeInsets.zero,
            textStyle:   fontStyle?.copyWith( 
              color: isCurrentPage ? activeColor : inactiveColor?.withOpacity(0.5),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: isCurrentPage ? activeColor?.darken() : inactiveColor?.withOpacity(0.5),
            disabledForegroundColor: isCurrentPage ?  activeColor?.darken() : inactiveColor?.withOpacity(0.5),
          ),
          onPressed: isCurrentPage ? null : () => onPageChanged(pageIndex),
          child: Text(
            pageIndex.toString(),
           
          ),
        ),
      ),
    );
  }

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
            foregroundColor : inactiveColor?.withOpacity(0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
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
          if (startPage > (visiblePageCount /2)+1) ...[
            _buildPageButton(1, false),
            SizedBox(width: iconGap),
            Text('...', style: fontStyle?.copyWith(color: inactiveColor?.withOpacity(0.5))),
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
            Text('...', style: fontStyle?.copyWith(color: inactiveColor?.withOpacity(0.5))),
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