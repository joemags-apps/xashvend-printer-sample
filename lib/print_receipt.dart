// print_receipt.dart
import 'package:flutter_sunmi_printer_plus/column_maker.dart';
import 'package:flutter_sunmi_printer_plus/flutter_sunmi_printer_plus.dart';
import 'package:flutter_sunmi_printer_plus/sunmi_style.dart';
import 'package:flutter_sunmi_printer_plus/enums.dart';
import 'package:flutter/services.dart';

Future<Uint8List> readFileBytes(String path) async {
  try {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  } catch (err) {
    rethrow;
  }
}

Future<Uint8List> _getImageFromAsset(String iconPath) async {
  return await readFileBytes(iconPath);
}

Future<void> printReceipt() async {
  Uint8List bytes = await _getImageFromAsset('assets/images/xash_logo.jpg');
  await SunmiPrinter.printImage(image: bytes, align: SunmiPrintAlign.CENTER);
  await SunmiPrinter.lineWrap(2);

  await SunmiPrinter.printText(
      content: "Josbo Inc. Tuckshop",
      style: SunmiStyle(
          fontSize: 30,
          isUnderLine: false,
          bold: true,
          align: SunmiPrintAlign.CENTER));
  await SunmiPrinter.lineWrap(3);
  await SunmiPrinter.printText(
      content: "Xash Vent to the world",
      style: SunmiStyle(
          fontSize: 20,
          isUnderLine: false,
          bold: true,
          align: SunmiPrintAlign.CENTER));

  await SunmiPrinter.lineWrap(3);

  await SunmiPrinter.printTable(cols: [
    ColumnMaker(text: "1235555 XV1", align: SunmiPrintAlign.LEFT, width: 10),
    ColumnMaker(text: "XV 3333333", align: SunmiPrintAlign.LEFT, width: 10),
    ColumnMaker(text: "Last One", align: SunmiPrintAlign.LEFT, width: 10),
  ]);

  await SunmiPrinter.printTable(cols: [
    ColumnMaker(text: "TESTHERE!", align: SunmiPrintAlign.LEFT, width: 15),
    ColumnMaker(text: "OH-MAN", align: SunmiPrintAlign.LEFT, width: 15),
  ]);

  await SunmiPrinter.lineWrap(2);
  await SunmiPrinter.printBarCode(
      data: "1234567890",
      height: 50,
      width: 2,
      textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
      barcodeType: SunmiBarcodeType.CODE128,
      align: SunmiPrintAlign.CENTER);
  await SunmiPrinter.lineWrap(2);

  await SunmiPrinter.printQr(
      data: "https://vend.xash.co.zw", align: SunmiPrintAlign.CENTER, size: 5);
  await SunmiPrinter.lineWrap(2);

  await SunmiPrinter.feedPaper();
  await SunmiPrinter.cutPaper();
}
