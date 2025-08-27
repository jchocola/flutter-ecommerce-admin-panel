import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:admin_panel/util/constants/text_strings.dart';
import 'package:admin_panel/util/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart' as pdfLib;
import 'package:pdf/widgets.dart' as pw;

class ProductPdfCreator {
  static Future<Uint8List> generateParcelPdf({
    required String phoneNumber,
    required String name,
    required String address,
    required String billingInfo,
    required Map<String, dynamic> orders,
    required String reviewUrl,
    required List<Map<String, dynamic>> orderedItems,
  }) async {
    final pdf = pw.Document();

    // Load TTF font from assets
    final fontData = await rootBundle.load('assets/fonts/Poppins-Regular.ttf');
    final ttfFont = pw.Font.ttf(fontData);

    // Generate QR image from qr_flutter widget
    final qrValidationResult = QrValidator.validate(
      data: reviewUrl,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    if (qrValidationResult.status != QrValidationStatus.valid) {
      throw Exception('Invalid QR data');
    }
    final qrCode = qrValidationResult.qrCode!;

    // Render QR code to ui.Image
    final painter = QrPainter.withQr(
      qr: qrCode,
      color: const ui.Color(0xFF000000),
      emptyColor: const ui.Color(0xFFFFFFFF),
      gapless: true,
    );

    final image = await painter.toImage(200); // 200x200 px image
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    // Create PDF image from png bytes
    final pdfImage = pw.MemoryImage(pngBytes);

    // Build the PDF page with text and QR image
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(1),
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: pdfLib.PdfColors.black, width: 1),
              ),
              child: pw.Padding(
                padding: pw.EdgeInsets.all(10),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      TText.appName,
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 24),
                    pw.Table.fromTextArray(
                      headers: ['Product', 'Qty', 'Price'],
                      data:
                          orderedItems
                              .map(
                                (item) => [
                                  item['title'].toString(),
                                  item['quantity'].toString(),
                                  '\$${item['price'].toString()}',
                                ],
                              )
                              .toList(),
                      headerStyle: pw.TextStyle(
                        font: ttfFont,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      cellStyle: pw.TextStyle(font: ttfFont, fontSize: 10),
                      cellAlignment: pw.Alignment.centerLeft,
                      border: pw.TableBorder.all(
                        color: pdfLib.PdfColors.grey300,
                      ),
                    ),
                    pw.SizedBox(height: 24),
                    pw.Text(
                      "${orders['orderID']}",
                      style: pw.TextStyle(font: ttfFont, fontSize: 12),
                    ),
                    pw.SizedBox(height: 24),
                    pw.Text(
                      "Name: $name",
                      style: pw.TextStyle(font: ttfFont, fontSize: 10),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      "Address: $address",
                      style: pw.TextStyle(font: ttfFont, fontSize: 10),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      "Phone Number: $phoneNumber",
                      style: pw.TextStyle(font: ttfFont, fontSize: 10),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      "Billing Info:",
                      style: pw.TextStyle(font: ttfFont, fontSize: 13),
                    ),
                     pw.Text(
                      "Sub Total: ${orders['subTotal']}",
                      style: pw.TextStyle(font: ttfFont, fontSize: 10),
                    ),
                    pw.SizedBox(height: 2),
                     pw.Text(
                      "Shipping cost: ${orders['shippingCost']}",
                      style: pw.TextStyle(font: ttfFont, fontSize: 10),
                    ),
                    pw.SizedBox(height: 2),
                     pw.Text(
                      "Total Amount: ${orders['totalPrice']}",
                      style: pw.TextStyle(font: ttfFont, fontSize: 10),
                    ),
                    pw.SizedBox(height: 24),
                    pw.Text(
                      "Scan to Review",
                      style: pw.TextStyle(font: ttfFont, fontSize: 10),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Image(pdfImage, width: 70, height: 70)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
