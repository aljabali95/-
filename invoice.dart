
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future printInvoice(Map car) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        children: [
          pw.Text('مغسلة الباب الحديثة'),
          pw.SizedBox(height: 10),
          pw.Text('لوحة: ${car['plate']}'),
          pw.Text('السعر: ${car['price']}'),
          pw.Text('الدفع: ${car['payment']}'),
          pw.Text('التاريخ: ${car['date']}'),
        ],
      ),
    ),
  );

  await Printing.layoutPdf(onLayout: (f) async => pdf.save());
}
