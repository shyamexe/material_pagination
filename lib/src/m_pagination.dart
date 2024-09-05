import 'package:flutter/material.dart';

class MaterialPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final int visiblePageCount;
  final Color? color;
  final TextStyle? fontStyle;

  const MaterialPagination(
      {super.key,
      required this.currentPage,
      required this.totalPages,
      required this.onPageChanged,
      required this.visiblePageCount,
        this.fontStyle,
        this.color});

  List<int> _calculatePageRange() {
    final int halfVisible = (visiblePageCount / 2).floor();
    int startPage = (currentPage - halfVisible).clamp(1, totalPages);
    int endPage = (currentPage + halfVisible).clamp(1, totalPages);

    if (startPage == 1) {
      endPage = (visiblePageCount).clamp(1, totalPages);
    } else if (endPage == totalPages) {
      startPage = (totalPages - visiblePageCount + 1).clamp(1, totalPages);
    }

    return [startPage, endPage];
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
          if (currentPage > 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                height: 32,
                width: 32,
                child: IconButton.outlined(
                  style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Colors.black.withOpacity(.56),
                      side: BorderSide(color: Colors.black.withOpacity(.23))),
                  onPressed: () => onPageChanged(currentPage - 1),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black.withOpacity(.5),

                    // Icons.chevron_left,
                    size: 14,
                  ),
                ),
              ),
            ),
          if (startPage > 1) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                height: 32,
                width: 32,
                child: IconButton.outlined(
                  style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: BorderSide(color: Colors.black.withOpacity(.23))),
                  onPressed: () => onPageChanged(1),
                  icon: Text(
                    '1',
                    style: fontStyle?.copyWith( 
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                '...',
                style: fontStyle?.copyWith( 
                  color: Colors.black.withOpacity(.5),
                ),
              ),
            ),
          ],
          ...List.generate(endPage - startPage + 1, (index) {
            int pageIndex = startPage + index;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                height: 32,
                width: 32,
                child: IconButton.outlined(
                  style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: pageIndex == currentPage
                          ? color?.withOpacity(.2)
                          : Colors.black.withOpacity(.01),
                      hoverColor: pageIndex == currentPage
                          ? color?.withOpacity(.1)
                          : Colors.black.withOpacity(.1),
                      // hoverColor: color?.withOpacity(.2),
                      side: BorderSide(
                        color: pageIndex == currentPage
                            ? color?.withOpacity(.5) ?? Colors.black
                            : Colors.black.withOpacity(.23),
                      )),
                  onPressed: () => onPageChanged(pageIndex),
                  // style: OutlinedButton.styleFrom(
                  //   backgroundColor:
                  //       pageIndex == currentPage ? Colors.blue : null,
                  // ),
                  icon: Text(
                    pageIndex.toString(),
                    style: fontStyle?.copyWith( 
                      color: pageIndex == currentPage
                          ? color
                          : Colors.black.withOpacity(.5),
                    ),
                  ),
                ),
              ),
            );
          }),
          if (endPage < totalPages) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                '...',
                style: fontStyle?.copyWith( 
                  color: Colors.black.withOpacity(.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                height: 32,
                width: 32,
                child: IconButton.outlined(
                  style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.black.withOpacity(.01),
                      hoverColor: Colors.black.withOpacity(.1),
                      // hoverColor: color?.withOpacity(.2),
                      side: BorderSide(
                        color: Colors.black.withOpacity(.23),
                      )),
                  onPressed: () => onPageChanged(totalPages),
                  icon: Text(
                    totalPages.toString(),
                    style: fontStyle?.copyWith( 
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (currentPage < totalPages)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                height: 32,
                width: 32,
                child: IconButton.outlined(
                  style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Colors.black.withOpacity(.56),
                      side: BorderSide(color: Colors.black.withOpacity(.23))),
                  onPressed: () => onPageChanged(currentPage + 1),
                  icon: Icon(
                    // Icons.chevron_right,
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black.withOpacity(.5),
                    size: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
