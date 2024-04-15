import 'package:flutter/material.dart';
import 'print_receipt.dart';
import 'package:flutter_sunmi_printer_plus/flutter_sunmi_printer_plus.dart';

void main() {
  runApp(XashVend());
}

class XashVend extends StatefulWidget {
  const XashVend({Key? key}) : super(key: key);

  @override
  _XashVendState createState() => _XashVendState();
}

class _XashVendState extends State<XashVend> {
  bool isConnected = false;
  String errorMessage = '';
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        isConnected = await SunmiPrinter.initPrinter() ?? false;
        setState(() {});
      } catch (err) {
        errorMessage = err.toString();
      }
      setState(() {});
    });
  }

  void showFeedback(String message) {
    setState(() {
      feedbackMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Xash Vend'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(feedbackMessage),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('XV2 to the world!'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showFeedback('Printing...');
            if (!isConnected) {
              showFeedback('Printer not connected');
              return;
            }
            // Call the printReceipt function here
            // Get the printer status
            try {
              await printReceipt();
            } catch (err) {
              String errorMessage = err.toString();
              showFeedback('Printer status: $errorMessage');
              return;
            }
            showFeedback('Printer status:');
          },
          child: const Icon(Icons.print),
        ),
      ),
    );
  }
}
