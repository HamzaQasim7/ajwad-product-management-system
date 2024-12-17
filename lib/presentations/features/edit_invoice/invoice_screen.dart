import 'package:ajwad/widgets/custom_snack_bar.dart';
import 'package:ajwad/widgets/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../../core/formater/date_time_formater.dart';
import '../../../data/product_provider.dart';

class InvoiceScreen extends StatefulWidget {
  final String? telePhone, userNumber;

  const InvoiceScreen({super.key, this.telePhone = '', this.userNumber});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  Future<void> _downloadInvoice() async {
    final pdf = pw.Document();

    // Load the logo image
    final ByteData logoBytes = await rootBundle.load('assets/icons/Ajwad.png');
    final Uint8List logoImage = logoBytes.buffer.asUint8List();
    final pw.MemoryImage logo = pw.MemoryImage(logoImage);
    // Load the DejaVuSans font
    final fontData = await rootBundle.load('assets/fonts/Amiri-Bold.ttf');
    final ttf = pw.Font.ttf(fontData);
    // Get the provider data
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final billItems = provider.billItems;
    final totalAmount = provider.totalAmount;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Logo
                pw.Image(logo, width: 200),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Ajwad',
                            style: pw.TextStyle(
                                fontSize: 14, fontWeight: pw.FontWeight.bold)),
                        pw.Text('Tel: ${widget.telePhone ?? ''}',
                            style: pw.TextStyle(font: ttf)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('مصنع أجواد للخبز الآلي',
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold),
                            textDirection: pw.TextDirection.rtl),
                        pw.Text('تلفون: ${widget.telePhone ?? ''}',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                            textDirection: pw.TextDirection.rtl),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 20),
                pw.Divider(thickness: 1),
                pw.SizedBox(height: 20),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'User No: ${widget.userNumber ?? ''}',
                          style: const pw.TextStyle(fontSize: 12),
                        ),
                        pw.Text('Tax No: 310659857800003',
                            style: const pw.TextStyle(fontSize: 12)),
                        pw.Text('Bill No:${billItems.length.toString()} ',
                            style: const pw.TextStyle(fontSize: 12)),
                        pw.Text(
                            'Date: ${DateTimeFormatter.formatForPdf(DateTime.now())}',
                            style: const pw.TextStyle(fontSize: 12)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('رقم المستخدم: ${widget.userNumber ?? '0'}',
                            style: pw.TextStyle(font: ttf),
                            textDirection: pw.TextDirection.rtl),
                        pw.Text('رقم  الضريبي: 310659857800003',
                            style: pw.TextStyle(font: ttf),
                            textDirection: pw.TextDirection.rtl),
                        pw.Text('رقم الفاتورة: ${billItems.length.toString()}',
                            style: pw.TextStyle(font: ttf),
                            textDirection: pw.TextDirection.rtl),
                        pw.Text(
                            'التاريخ: ${DateTimeFormatter.format(DateTime.now())}',
                            style: pw.TextStyle(font: ttf),
                            textDirection: pw.TextDirection.rtl),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 20),

                // Table
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: const pw.IntrinsicColumnWidth(),
                    1: const pw.FlexColumnWidth(),
                    2: const pw.IntrinsicColumnWidth(),
                    3: const pw.IntrinsicColumnWidth(),
                    4: const pw.IntrinsicColumnWidth(),
                    5: const pw.IntrinsicColumnWidth(),
                  },
                  children: [
                    // Table Header
                    pw.TableRow(
                      decoration:
                          const pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Column(
                            children: [
                              pw.Text('No', style: pw.TextStyle(font: ttf)),
                              pw.Text('رقم',
                                  style: pw.TextStyle(font: ttf),
                                  textDirection: pw.TextDirection.rtl),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Column(
                            children: [
                              pw.Text('Product Name',
                                  style: pw.TextStyle(font: ttf)),
                              pw.Text('اسم المنتج',
                                  style: pw.TextStyle(font: ttf),
                                  textDirection: pw.TextDirection.rtl),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Column(
                            children: [
                              pw.Text('Qty', style: pw.TextStyle(font: ttf)),
                              pw.Text('الكمية',
                                  style: pw.TextStyle(font: ttf),
                                  textDirection: pw.TextDirection.rtl),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Column(
                            children: [
                              pw.Text('Unit', style: pw.TextStyle(font: ttf)),
                              pw.Text('الوحدة',
                                  style: pw.TextStyle(font: ttf),
                                  textDirection: pw.TextDirection.rtl),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Column(
                            children: [
                              pw.Text('Unit Price',
                                  style: pw.TextStyle(font: ttf)),
                              pw.Text('سعر الوحدة',
                                  style: pw.TextStyle(font: ttf),
                                  textDirection: pw.TextDirection.rtl),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Column(
                            children: [
                              pw.Text('Total', style: pw.TextStyle(font: ttf)),
                              pw.Text('المجموع',
                                  style: pw.TextStyle(font: ttf),
                                  textDirection: pw.TextDirection.rtl),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Table Data
                    ...billItems.map((item) {
                      final index = billItems.indexOf(item) + 1;
                      return pw.TableRow(
                        children: [
                          pw.Center(
                              child: pw.Padding(
                                  padding: const pw.EdgeInsets.all(3),
                                  child: pw.Text('$index'))),
                          pw.Center(
                              child: pw.Padding(
                                  padding: const pw.EdgeInsets.all(3),
                                  child: pw.Text(item['name'],
                                      style: pw.TextStyle(font: ttf),
                                      textDirection: pw.TextDirection.rtl))),
                          pw.Center(
                              child: pw.Padding(
                                  padding: const pw.EdgeInsets.all(3),
                                  child: pw.Text('${item['quantity']}'))),
                          pw.Center(
                              child: pw.Padding(
                                  padding: const pw.EdgeInsets.all(3),
                                  child: pw.Text(item['unit']))),
                          pw.Center(
                              child: pw.Padding(
                                  padding: const pw.EdgeInsets.all(3),
                                  child: pw.Text(
                                      'SAR ${item['unitPrice'].toStringAsFixed(2)}'))),
                          pw.Center(
                              child: pw.Padding(
                                  padding: const pw.EdgeInsets.all(3),
                                  child: pw.Text(
                                      'SAR ${item['totalPrice'].toStringAsFixed(2)}'))),
                        ],
                      );
                    }).toList(),
                  ],
                ),

                pw.SizedBox(height: 20),

                // Total
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                        'Total Amount: SAR ${totalAmount.toStringAsFixed(2)}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save and download the PDF
    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
        name: 'Ajwad_Invoice_${DateTime.now().millisecondsSinceEpoch}.pdf',
      ).then((v) {
        CustomSnackbar.show(context,
            message: 'Save and download successfully',
            backgroundColor: Colors.green,
            durationInSeconds: 2);
      });
    } catch (e) {
      CustomSnackbar.show(
        context,
        message: 'Failed to save file: $e',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/icons/Ajwad.png'),
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 10),
                const Divider(thickness: 1, color: Colors.black54),
                const SizedBox(height: 20),
                _buildSubHeader(),
                const SizedBox(height: 20),
                _buildTable()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
        child: ActionButton(
            height: 50,
            text: 'Download PDF',
            onPressed: _downloadInvoice,
            backgroundColor: Colors.green,
            textColor: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ajwad',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            Text(
              'Tel: ${widget.telePhone ?? ''}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'مصنع أجواد للخبز الآلي',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Amiri'),
              textDirection: TextDirection.rtl,
            ),
            Text(
              'تلفون: ${widget.telePhone ?? ''}',
              style: const TextStyle(fontFamily: 'Amiri', fontSize: 12),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubHeader() {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final billItems = provider.billItems;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User No: ${widget.userNumber ?? ''}',
              style: const TextStyle(fontSize: 12),
            ),
            const Text('Tax NO: \n310659857800003',
                style: TextStyle(fontSize: 12)),
            Text('Bill No:${billItems.length.toString()} ',
                style: const TextStyle(fontSize: 12)),
            Text('Date: ${DateTimeFormatter.format(DateTime.now())}',
                style: const TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'رقم المستخدم: ${widget.userNumber ?? '0'}',
              style: const TextStyle(fontFamily: 'Amiri', fontSize: 12),
              textDirection: TextDirection.rtl,
            ),
            const Text(
              'رقم  الضريبي:\n 310659857800003',
              style: TextStyle(fontFamily: 'Amiri', fontSize: 12),
              textDirection: TextDirection.rtl,
            ),
            Text(
              'رقم الفاتورة: ${billItems.length.toString()}',
              style: const TextStyle(fontFamily: 'Amiri', fontSize: 12),
              textDirection: TextDirection.rtl,
            ),
            Text(
              'التاريخ: ${DateTimeFormatter.format(DateTime.now())}',
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontFamily: 'Amiri', fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTable() {
    final provider = Provider.of<ProductProvider>(context);

    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(),
        4: IntrinsicColumnWidth(),
        5: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          children: const [
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text('No'),
                    Text('رقم',
                        style: TextStyle(fontFamily: 'Amiri'),
                        textDirection: TextDirection.rtl),
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text('Product Name'),
                    Text('اسم المنتج',
                        style: TextStyle(fontFamily: 'Amiri'),
                        textDirection: TextDirection.rtl),
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Qty'),
                    Text('الكمية',
                        style: TextStyle(fontFamily: 'Amiri'),
                        textDirection: TextDirection.rtl),
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text('Unit'),
                    Text('الوحدة',
                        style: TextStyle(fontFamily: 'Amiri'),
                        textDirection: TextDirection.rtl),
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text('Unit Price'),
                    Text('سعر الوحدة',
                        style: TextStyle(fontFamily: 'Amiri'),
                        textDirection: TextDirection.rtl),
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text('Total'),
                    Text('المجموع',
                        style: TextStyle(fontFamily: 'Amiri'),
                        textDirection: TextDirection.rtl),
                  ],
                )),
          ],
        ),
        ...provider.billItems.map(
          (item) {
            final index = provider.billItems.indexOf(item) + 1;
            return TableRow(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text('$index'),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(item['name']),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text('${item['quantity']}'),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(item['unit']),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text('SAR ${item['unitPrice'].toStringAsFixed(2)}'),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text('SAR ${item['totalPrice'].toStringAsFixed(2)}'),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
