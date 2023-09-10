import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

class CommonNumberPagination extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final dynamic Function(int) onPageChange;

  CommonNumberPagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChange,
  });

  @override
  _CommonNumberPaginationState createState() => _CommonNumberPaginationState();
}

class _CommonNumberPaginationState extends State<CommonNumberPagination> {
  int currentPageValue = 0;
  @override
  void initState() {
    super.initState();
    currentPageValue = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return NumberPaginator(
      numberPages: widget.totalPages,
      onPageChange: (int val) {
        setState(() {
          currentPageValue = val;
          widget.onPageChange(val);
        });
      },
      initialPage: widget.currentPage,
    );
  }
}
