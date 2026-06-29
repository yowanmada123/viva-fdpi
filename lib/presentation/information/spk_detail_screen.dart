import 'dart:typed_data';

import 'package:fdpi_app/models/fdpi/spk_review/spk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SpkDetailScreen extends StatefulWidget {
  final Spk spk;
  final String employeeName;
  final String contractorName;
  final String spkTypeLabel;

  const SpkDetailScreen({
    super.key,
    required this.spk,
    required this.employeeName,
    required this.contractorName,
    required this.spkTypeLabel,
  });

  @override
  State<SpkDetailScreen> createState() => _SpkDetailScreenState();
}

class _SpkDetailScreenState extends State<SpkDetailScreen> {
  bool _showBadanUsaha = false;

  Spk get spk => widget.spk;
  String get employeeName => widget.employeeName;
  String get contractorName => widget.contractorName;

  // business_name field has a space when empty on the web side
  bool get _hasBadanUsaha {
    final v = spk.businessName.trim();
    return v.isNotEmpty && v != 'null';
  }

  // ── helpers ──────────────────────────────────────────────

  String _safe(String v) {
    final t = v.trim();
    return (t.isEmpty || t == 'null') ? '-' : t;
  }

  String _formatAmount(String amt) {
    final v = double.tryParse(amt);
    if (v == null || amt.isEmpty) return amt;
    return v.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  // Web uses FormatFloat with 3 decimal places, no thousands separator
  String _formatFloat(String qty) {
    final v = double.tryParse(qty);
    if (v == null || qty.isEmpty) return qty;
    final s = v.toStringAsFixed(3);
    return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  static String _toRoman(int month) {
    const r = [
      'I', 'II', 'III', 'IV', 'V', 'VI',
      'VII', 'VIII', 'IX', 'X', 'XI', 'XII',
    ];
    return (month >= 1 && month <= 12) ? r[month - 1] : '';
  }

  DateTime _parseDate(String s) {
    try {
      return DateTime.parse(s);
    } catch (_) {
      return DateTime.now();
    }
  }

  String _formatDate(String s) {
    if (s.isEmpty) return '-';
    final d = _parseDate(s);
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
  }

  String get _docNumber {
    final raw = spk.dtCreated.isNotEmpty ? spk.dtCreated : spk.dateStart;
    final d = _parseDate(raw);
    final num = spk.idCetak.isNotEmpty ? spk.idCetak : spk.idUrut;
    return '$num / PT.FDPI / ${spk.clusterName} / ${_toRoman(d.month)} / ${d.year}';
  }

  String get _footerDate {
    final raw = spk.dtCreated.isNotEmpty ? spk.dtCreated : spk.dateStart;
    final d = _parseDate(raw);
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return 'Semarang, ${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
  }

  // Building area: prefer customLb over buildingArea (matches web)
  String get _buildingArea =>
      spk.customLb.isNotEmpty ? spk.customLb : spk.buildingArea;

  // "Pekerjaan {category} {house_name}" (matches web: category + " " + house_name)
  String get _jenisPekerjaan {
    final parts = <String>['Pekerjaan'];
    if (spk.category.isNotEmpty) parts.add(spk.category);
    parts.add(spk.houseName);
    return parts.join(' ');
  }

  // Web: Keterangan shown for types B, C, T
  bool get _showKeterangan =>
      ['B', 'C', 'T'].contains(spk.spkType) && spk.remarkArticle.isNotEmpty;

  // Web: Cara Pembayaran / Pekerjaan Meliputi shown for types B, T
  bool get _showCaraPembayaran =>
      ['B', 'T'].contains(spk.spkType) && spk.remarkQc.isNotEmpty;

  // Web: remarks_temp = prepend duration li for B/L, else just remarks
  String get _remarksTemp {
    final base = spk.remarks.isNotEmpty ? spk.remarks : spk.remark;
    if (spk.spkType == 'B' || spk.spkType == 'L') {
      final start = _parseDate(spk.dateStart);
      final finish = _parseDate(spk.dateFinish);
      final days = finish.difference(start).inDays + 1;
      String duration;
      if (days >= 7) {
        final weeks = days ~/ 7;
        final rem = days % 7;
        duration = rem == 0 ? '$weeks minggu' : '$weeks minggu $rem hari';
      } else {
        duration = '$days hari';
      }
      final li =
          '<li>Semua pekerjaan (bangunan, plester aci dinding samping luar, dan cat) '
          'dilaksanakan dalam waktu $duration.<br>'
          'Mulai dilaksanakan&nbsp;&nbsp;&nbsp; : <strong>Tgl. ${_formatDate(spk.dateStart)}</strong><br>'
          'Selesai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <strong>Tgl. ${_formatDate(spk.dateFinish)}</strong></li>';
      // mergeString: prepend li inside first <ul>
      if (base.contains('<ul>') || base.contains('<UL>')) {
        return base.replaceFirst(
          RegExp(r'<ul>', caseSensitive: false),
          '<ul>$li',
        );
      }
      return '<ul>$li</ul>$base';
    }
    return base;
  }

  // ── PDF ──────────────────────────────────────────────────

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final document = pw.Document();

    pw.MemoryImage? logo;
    try {
      final bytes = await rootBundle.load('assets/logo/logo-fdpi.png');
      logo = pw.MemoryImage(bytes.buffer.asUint8List());
    } catch (_) {}

    final remarksPlain = _remarksTemp
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    final remarkArticlePlain = spk.remarkArticle
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .trim();
    final remarkQcPlain = spk.remarkQc
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .trim();

    const ts = pw.TextStyle(fontSize: 10);
    final tsBold = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10);
    const tsS = pw.TextStyle(fontSize: 9);
    final tsSB = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9);

    pw.Widget pdRow(String label, String value, {double w = 80}) =>
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 2),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(width: w, child: pw.Text(label, style: ts)),
              pw.Text(': ', style: ts),
              pw.Expanded(
                child: pw.Text(value.isNotEmpty ? value : '-', style: ts),
              ),
            ],
          ),
        );

    final showBU = _showBadanUsaha && _hasBadanUsaha;
    final caraPembayaranLabel =
        spk.remarkArticle.isNotEmpty ? 'Cara Pembayaran' : 'Pekerjaan Meliputi';

    document.addPage(
      pw.MultiPage(
        pageFormat: format,
        margin: const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        build: (ctx) => [
          // Header
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              if (logo != null) pw.Image(logo, width: 56, height: 56),
              pw.SizedBox(width: 12),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('PT. FASINDO PROPERTI INDONESIA',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 13)),
                  pw.Text(
                      'Ruko Soho Jl. Klipang Raya no 8 - 9 Sendangmulyo,',
                      style: tsS),
                  pw.Text(
                      'Tembalang Kota Semarang - Jawa Tengah 50272',
                      style: tsS),
                ],
              ),
            ],
          ),
          pw.Divider(thickness: 1.5),
          pw.SizedBox(height: 6),

          // Title
          pw.Center(
            child: pw.Text('SURAT PERINTAH KERJA',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 13,
                    decoration: pw.TextDecoration.underline)),
          ),
          pw.SizedBox(height: 3),
          pw.Center(
            child: pw.Text('No : $_docNumber',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                    decoration: pw.TextDecoration.underline)),
          ),
          pw.SizedBox(height: 14),

          // Pihak I
          pw.Text('Yang bertanda tangan di bawah ini :', style: ts),
          pw.SizedBox(height: 4),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 16),
            child: pw.Column(children: [
              pdRow('Nama', employeeName),
              pdRow('Jabatan',
                  spk.jabatanEmployee.isNotEmpty
                      ? spk.jabatanEmployee
                      : 'Direktur'),
              pdRow('Alamat', _safe(spk.alamatEmployee)),
            ]),
          ),
          pw.SizedBox(height: 4),
          pw.RichText(
              text: pw.TextSpan(children: [
            pw.TextSpan(text: 'Selanjutnya di sebut ', style: ts),
            pw.TextSpan(text: 'Pihak I (pertama)', style: tsBold),
          ])),
          pw.SizedBox(height: 10),

          // Pihak II
          pw.Text('Yang bertanda tangan di bawah ini :', style: ts),
          pw.SizedBox(height: 4),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 16),
            child: pw.Column(children: [
              pdRow('Nama', contractorName),
              pdRow('Jabatan', 'Sub Kontraktor'),
              if (showBU) pdRow('Nama Badan Usaha', spk.businessName),
              pdRow('Alamat', _safe(spk.alamatContractor)),
              pdRow('NIK/TLP',
                  '${_safe(spk.nik)} / ${_safe(spk.phone)}'),
            ]),
          ),
          pw.SizedBox(height: 4),
          if (showBU)
            pw.RichText(
                text: pw.TextSpan(children: [
              pw.TextSpan(
                  text:
                      'Yang dalam hal ini bertindak untuk dan atas nama badan usaha ',
                  style: ts),
              pw.TextSpan(text: spk.businessName, style: tsBold),
              pw.TextSpan(
                  text:
                      ' sebagai Pemborong, yang selanjutnya dalam perjanjian ini disebut sebagai ',
                  style: ts),
              pw.TextSpan(text: 'PIHAK KEDUA', style: tsBold),
              pw.TextSpan(text: '.', style: ts),
            ]))
          else
            pw.RichText(
                text: pw.TextSpan(children: [
              pw.TextSpan(text: 'Selanjutnya di sebut ', style: ts),
              pw.TextSpan(text: 'Pihak II (kedua)', style: tsBold),
            ])),
          pw.SizedBox(height: 10),

          // Untuk melaksanakan
          pw.Text('Untuk melaksanakan', style: tsBold),
          pw.SizedBox(height: 4),
          pw.Row(children: [
            pw.Text('• ', style: ts),
            pw.SizedBox(width: 90, child: pw.Text('Proyek', style: ts)),
            pw.Text(': ', style: ts),
            pw.Expanded(child: pw.Text(spk.clusterName, style: tsBold)),
          ]),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('• ', style: ts),
              pw.SizedBox(
                  width: 90, child: pw.Text('Jenis Pekerjaan', style: ts)),
              pw.Text(': ', style: ts),
              pw.Expanded(
                child: pw.RichText(
                    text: pw.TextSpan(children: [
                  pw.TextSpan(text: _jenisPekerjaan, style: tsBold),
                  if (spk.remarkSpk.isNotEmpty)
                    pw.TextSpan(text: ' - ${spk.remarkSpk}', style: tsBold),
                ])),
              ),
              if (_buildingArea.isNotEmpty)
                pw.Text('$_buildingArea m²', style: tsBold),
            ],
          ),
          pw.Row(children: [
            pw.Text('• ', style: ts),
            pw.Text('Harga Satuan', style: ts),
          ]),
          ...spk.article.asMap().entries.map((e) {
            final a = e.value;
            final i = e.key;
            return pw.Padding(
              padding: const pw.EdgeInsets.only(left: 14, bottom: 2),
              child: pw.Row(children: [
                pw.SizedBox(
                    width: 14, child: pw.Text('${i + 1}.', style: tsS)),
                pw.Expanded(
                    flex: 3,
                    child: pw.Text(a.description, style: tsS)),
                pw.Expanded(
                    child: pw.Text(_formatFloat(a.qty), style: tsS)),
                pw.Expanded(child: pw.Text(a.uom, style: tsS)),
                pw.Expanded(child: pw.Text('Rp', style: tsS)),
                pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                        'Rp.${_formatAmount(a.hargaSatuan)},-/${a.uom}',
                        style: tsS)),
              ]),
            );
          }),

          // Keterangan (B, C, T)
          if (_showKeterangan) ...[
            pw.SizedBox(height: 6),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 108),
              child: pw.Text('Keterangan:', style: tsSB),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 108),
              child: pw.Text(remarkArticlePlain, style: tsS),
            ),
          ],

          // Cara Pembayaran / Pekerjaan Meliputi (B, T)
          if (_showCaraPembayaran) ...[
            pw.SizedBox(height: 4),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 100,
                  child: pw.Text('• $caraPembayaranLabel', style: tsS),
                ),
                pw.Text(': ', style: tsS),
                pw.Expanded(child: pw.Text(remarkQcPlain, style: tsS)),
              ],
            ),
          ],

          pw.SizedBox(height: 10),

          // Lain-lain
          pw.Text('Lain - Lain :', style: tsBold),
          pw.SizedBox(height: 4),
          if (remarksPlain.isNotEmpty)
            pw.Text(remarksPlain, style: tsS),
          if (spk.sbkName.isNotEmpty || spk.commonName.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 6),
              child: pw.RichText(
                  text: pw.TextSpan(children: [
                pw.TextSpan(text: '• ', style: tsS),
                pw.TextSpan(
                    text:
                        'TIPE ${spk.sbkName.isNotEmpty ? spk.sbkName : spk.commonName}',
                    style: tsSB),
                if (_buildingArea.isNotEmpty)
                  pw.TextSpan(
                      text: ' ($_buildingArea)', style: tsSB),
              ])),
            ),

          pw.SizedBox(height: 24),

          // Footer
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Left: Pihak II
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Pihak II', style: ts),
                  if (showBU)
                    pw.Text(spk.businessName, style: tsBold)
                  else
                    pw.SizedBox(height: 14),
                ],
              ),
              // Right: date + Pihak I
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(_footerDate, style: ts),
                  pw.Text('Pihak I', style: ts),
                  if (showBU)
                    pw.Text('PT. FASINDO PROPERTI INDONESIA',
                        style: tsBold)
                  else
                    pw.SizedBox(height: 14),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 56),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    contractorName.trim().isNotEmpty
                        ? contractorName.trim()
                        : '(..........................................)',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                        decoration: pw.TextDecoration.underline),
                  ),
                  pw.Text('Direktur', style: ts),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    employeeName.trim(),
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                        decoration: pw.TextDecoration.underline),
                  ),
                  pw.Text('Direktur', style: ts),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    return document.save();
  }

  // ── mobile widget helpers ─────────────────────────────────

  Widget _row(String label, String value, {double labelW = 90}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelW.w,
            child: Text(label, style: TextStyle(fontSize: 11.5.sp)),
          ),
          Text(': ', style: TextStyle(fontSize: 11.5.sp)),
          Expanded(
            child: Text(
              _safe(value),
              style: TextStyle(fontSize: 11.5.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ── build ─────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final showBU = _showBadanUsaha && _hasBadanUsaha;
    final caraPembayaranLabel =
        spk.remarkArticle.isNotEmpty ? 'Cara Pembayaran' : 'Pekerjaan Meliputi';

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Surat Perintah Kerja'),
        actions: [
          // Badan Usaha toggle (only when businessName is set)
          if (_hasBadanUsaha)
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Badan Usaha',
                      style: TextStyle(fontSize: 10.sp)),
                  Switch(
                    value: _showBadanUsaha,
                    onChanged: (v) => setState(() => _showBadanUsaha = v),
                  ),
                ],
              ),
            ),
          IconButton(
            tooltip: 'Download PDF',
            icon: const Icon(Icons.download_rounded),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppBar(title: const Text('Preview PDF')),
                  body: PdfPreview(
                    build: _generatePdf,
                    canChangePageFormat: false,
                    allowPrinting: true,
                    allowSharing: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.w),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Company header ──────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo/logo-fdpi.png',
                        width: 52.w, height: 52.w),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PT. FASINDO PROPERTI INDONESIA',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp)),
                          Text(
                              'Ruko Soho Jl. Klipang Raya no 8 - 9 Sendangmulyo,',
                              style: TextStyle(fontSize: 9.sp)),
                          Text(
                              'Tembalang Kota Semarang - Jawa Tengah 50272',
                              style: TextStyle(fontSize: 9.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.w),
                const Divider(thickness: 1.5),
                SizedBox(height: 10.w),

                // ── Title ───────────────────────────────
                Center(
                  child: Text('SURAT PERINTAH KERJA',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          decoration: TextDecoration.underline)),
                ),
                SizedBox(height: 4.w),
                Center(
                  child: Text('No : $_docNumber',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                          decoration: TextDecoration.underline),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 16.w),

                // ── Pihak I ─────────────────────────────
                Text('Yang bertanda tangan di bawah ini :',
                    style: TextStyle(fontSize: 11.5.sp)),
                SizedBox(height: 6.w),
                Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: Column(children: [
                    _row('Nama', employeeName),
                    _row('Jabatan',
                        spk.jabatanEmployee.isNotEmpty
                            ? spk.jabatanEmployee
                            : 'Direktur'),
                    _row('Alamat', spk.alamatEmployee),
                  ]),
                ),
                SizedBox(height: 6.w),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 11.5.sp, color: Colors.black),
                    children: const [
                      TextSpan(text: 'Selanjutnya di sebut '),
                      TextSpan(
                          text: 'Pihak I (pertama)',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 12.w),

                // ── Pihak II ────────────────────────────
                Text('Yang bertanda tangan di bawah ini :',
                    style: TextStyle(fontSize: 11.5.sp)),
                SizedBox(height: 6.w),
                Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: Column(children: [
                    _row('Nama', contractorName),
                    _row('Jabatan', 'Sub Kontraktor'),
                    if (showBU) _row('Nama Badan Usaha', spk.businessName),
                    _row('Alamat', spk.alamatContractor),
                    _row('NIK/TLP',
                        '${_safe(spk.nik)} / ${_safe(spk.phone)}'),
                  ]),
                ),
                SizedBox(height: 6.w),
                if (showBU)
                  RichText(
                    text: TextSpan(
                      style:
                          TextStyle(fontSize: 11.sp, color: Colors.black),
                      children: [
                        const TextSpan(
                            text:
                                'Yang dalam hal ini bertindak untuk dan atas nama badan usaha '),
                        TextSpan(
                            text: spk.businessName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text:
                                ' sebagai Pemborong, yang selanjutnya dalam perjanjian ini disebut sebagai '),
                        const TextSpan(
                            text: 'PIHAK KEDUA',
                            style:
                                TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  )
                else
                  RichText(
                    text: TextSpan(
                      style:
                          TextStyle(fontSize: 11.5.sp, color: Colors.black),
                      children: const [
                        TextSpan(text: 'Selanjutnya di sebut '),
                        TextSpan(
                            text: 'Pihak II (kedua)',
                            style:
                                TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                SizedBox(height: 12.w),

                // ── Untuk melaksanakan ───────────────────
                Text('Untuk melaksanakan',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 11.5.sp)),
                SizedBox(height: 6.w),

                // Proyek
                Row(children: [
                  Text('• ', style: TextStyle(fontSize: 11.5.sp)),
                  SizedBox(
                      width: 90.w,
                      child:
                          Text('Proyek', style: TextStyle(fontSize: 11.5.sp))),
                  Text(': ', style: TextStyle(fontSize: 11.5.sp)),
                  Expanded(
                    child: Text(spk.clusterName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.5.sp)),
                  ),
                ]),
                SizedBox(height: 2.w),

                // Jenis Pekerjaan
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontSize: 11.5.sp)),
                    SizedBox(
                        width: 90.w,
                        child: Text('Jenis Pekerjaan',
                            style: TextStyle(fontSize: 11.5.sp))),
                    Text(': ', style: TextStyle(fontSize: 11.5.sp)),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5.sp,
                              color: Colors.black),
                          children: [
                            TextSpan(text: _jenisPekerjaan),
                            if (spk.remarkSpk.isNotEmpty)
                              TextSpan(text: ' - ${spk.remarkSpk}'),
                          ],
                        ),
                      ),
                    ),
                    if (_buildingArea.isNotEmpty)
                      Text('  $_buildingArea m²',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp)),
                  ],
                ),
                SizedBox(height: 2.w),

                // Harga Satuan
                Row(children: [
                  Text('• ', style: TextStyle(fontSize: 11.5.sp)),
                  Text('Harga Satuan',
                      style: TextStyle(fontSize: 11.5.sp)),
                ]),
                ...spk.article.asMap().entries.map((e) {
                  final a = e.value;
                  final i = e.key;
                  return Padding(
                    padding: EdgeInsets.only(left: 24.w, top: 2.w),
                    child: Row(children: [
                      Text('${i + 1}. ',
                          style: TextStyle(fontSize: 10.sp)),
                      Expanded(
                        flex: 3,
                        child: Text(a.description,
                            style: TextStyle(fontSize: 10.sp)),
                      ),
                      Text(_formatFloat(a.qty),
                          style: TextStyle(fontSize: 10.sp)),
                      SizedBox(width: 4.w),
                      Text(a.uom, style: TextStyle(fontSize: 10.sp)),
                      SizedBox(width: 4.w),
                      Text('Rp', style: TextStyle(fontSize: 10.sp)),
                      SizedBox(width: 4.w),
                      Text(
                        'Rp.${_formatAmount(a.hargaSatuan)},-/${a.uom}',
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    ]),
                  );
                }),

                // Keterangan (B, C, T)
                if (_showKeterangan) ...[
                  SizedBox(height: 6.w),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Keterangan:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp)),
                        HtmlWidget(spk.remarkArticle,
                            textStyle: TextStyle(fontSize: 10.5.sp)),
                      ],
                    ),
                  ),
                ],

                // Cara Pembayaran / Pekerjaan Meliputi (B, T)
                if (_showCaraPembayaran) ...[
                  SizedBox(height: 4.w),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: 11.sp)),
                      SizedBox(
                        width: 100.w,
                        child: Text(caraPembayaranLabel,
                            style: TextStyle(fontSize: 11.sp)),
                      ),
                      Text(': ', style: TextStyle(fontSize: 11.sp)),
                      Expanded(
                        child: HtmlWidget(spk.remarkQc,
                            textStyle: TextStyle(fontSize: 10.5.sp)),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: 14.w),

                // ── Lain-lain ────────────────────────────
                Text('Lain - Lain :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 11.5.sp)),
                SizedBox(height: 4.w),

                if (_remarksTemp.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: HtmlWidget(_remarksTemp,
                        textStyle: TextStyle(fontSize: 10.5.sp)),
                  ),

                // TIPE line
                if (spk.sbkName.isNotEmpty || spk.commonName.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 4.w),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 11.sp, color: Colors.black),
                        children: [
                          const TextSpan(text: '• '),
                          TextSpan(
                            text:
                                'TIPE ${spk.sbkName.isNotEmpty ? spk.sbkName : spk.commonName}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          if (_buildingArea.isNotEmpty)
                            TextSpan(
                              text: ' ($_buildingArea)',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: 20.w),
                const Divider(thickness: 0.5),
                SizedBox(height: 8.w),

                // ── Footer ──────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: Pihak II
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pihak II',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.5.sp)),
                          if (showBU)
                            Text(spk.businessName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp)),
                        ],
                      ),
                    ),
                    // Right: date + Pihak I
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(_footerDate,
                              style: TextStyle(fontSize: 11.sp)),
                          Text('Pihak I',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.5.sp)),
                          if (showBU)
                            Text('PT. FASINDO PROPERTI INDONESIA',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60.w),

                // Signature names
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contractorName.trim().isNotEmpty
                                ? contractorName.trim()
                                : '(..........................................)',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                              color: const Color(0xff1C3FAA),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text('Direktur',
                              style: TextStyle(fontSize: 11.sp)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            employeeName.trim(),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                              color: const Color(0xff1C3FAA),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text('Direktur',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 11.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
