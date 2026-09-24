import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generarPdf(String texto) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Text(
            texto, 
            style: const pw.TextStyle(fontSize: 18, 
            ),
        );
      },
    ),
  );

  return pdf.save();
}