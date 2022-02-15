import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class CSVReader {
  Future<CSVData> fromFile(String filePath) async {
    final input = new File(filePath).openRead();

    List<List> rows = await input
        .transform(utf8.decoder)
        .transform(CsvToListConverter())
        .toList();
    return CSVData(rows);
  }
}

class CSVData {
  final List<List> _rows;

  CSVData(this._rows);

  List<String> get titles{
    return _rows[0].map((title) => title.toString()).toList();
  }

  int get length => _rows.length-1;

  Map<String, dynamic> readRow(int rowNo){
    List<String> titleList = titles;
    List<dynamic> rowDataList = _rows[rowNo+1];
    Map<String, dynamic> rowData = {};

    for(int i = 0; i < titleList.length; i++){
      rowData[titleList[i]] = rowDataList[i];
    }

    return rowData;
  }
}
