import 'dart:convert';
import 'package:http/http.dart' as http;

/// Sends an order confirmation email via your SMTP backend
class FlutterSide {
  Future<void> sendOrderConfirmationEmail({
  required String to,
  required String orderId,
  required List<Map<String, dynamic>> items,
  required double total,
}) async {
  const String apiUrl = 'http://localhost:56073/send-order-email';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'to': to,
        'orderId': orderId,
        'items': items,
        'total': total,
      }),
    );

    if (response.statusCode == 200) {
      print('✅ Email sent successfully');
    } else {
      print('❌ Failed to send email: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('❌ Error sending email: $e');
  }
}
}
