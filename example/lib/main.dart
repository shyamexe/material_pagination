import 'package:flutter/material.dart';
import 'package:material_pagination/material_pagination.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  int page = 6;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(builder: (context, reload) {
          return Column(
            children: [
              const SizedBox(height: 20),
              MaterialPagination(
                currentPage: page,
                totalPages: 40,
                onPageChanged: (p0) {
                  reload(
                    () {
                      page = p0;
                    },
                  );
                },
                visiblePageCount: 3,
                activeColor: Colors.pink,
              ),
              const SizedBox(height: 20),
              MaterialPagination(
                currentPage: page,
                totalPages: 40,
                onPageChanged: (p0) {
                   reload(
                    () {
                      page = p0;
                    },
                  );
                },
                visiblePageCount: 3,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                borderRadius: 60,
              ),
              const SizedBox(height: 20),
              MaterialPagination(
                currentPage: page,
                totalPages: 40,
                onPageChanged: (p0) {
                   reload(
                    () {
                      page = p0;
                    },
                  );
                },
                iconGap: 10,
                visiblePageCount:5,
                activeColor: Colors.yellow,
                inactiveColor: Colors.grey,
                borderRadius: 3,
              ),
              const SizedBox(height: 20),
               MaterialPagination(
                currentPage: page,
                totalPages: 40,
                onPageChanged: (p0) {
                   reload(
                    () {
                      page = p0;
                    },
                  );
                },
                visiblePageCount: 3,
                buttonSize: 40,
                iconSize: 25,
                colorDarkness: 0,
                iconGap: 10,
                fontStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),


                activeColor: Colors.teal,
                inactiveColor: Colors.grey,
                borderRadius: 6,
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }
}
