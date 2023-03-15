import 'dart:async';
import 'dart:io';
import 'package:bank_application/model/cmnd_data.dart';
import 'package:bank_application/views/admin/scan_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../consts/colors/colors.dart';
import '../../model/listdata_model.dart';
import '../../service/observable_serivce.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BoughtDetail extends StatefulWidget {
  final ListSaveModel? dataDetail;

  const BoughtDetail({super.key, this.dataDetail});

  @override
  State<BoughtDetail> createState() => _BoughtDetailState();
}

class _BoughtDetailState extends State<BoughtDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.black54),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(File(widget.dataDetail?.thongTinCaNhan?.urlFront ?? '')),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.black54),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(File(widget.dataDetail?.thongTinCaNhan?.urlBehind ?? '')),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      inputWihtTitle("Số CMND", "Nhập số CMND", widget.dataDetail?.thongTinCaNhan?.cmndNum ?? '',
                          TextInputType.number),
                      const SizedBox(
                        height: 12,
                      ),
                      inputWihtTitle("Họ và tên", "Nhập họ và tên", widget.dataDetail?.thongTinCaNhan?.cmndName ?? '',
                          TextInputType.text),
                      const SizedBox(
                        height: 12,
                      ),
                      // const Align(alignment: Alignment.bottomLeft, child: Text('Ngày sinh')),
                      // const SizedBox(
                      //   height: 7,
                      // ),
                      TextFormField(
                        initialValue: widget.dataDetail?.thongTinCaNhan?.cmndDob ?? '',
                        //editing controller of this TextField
                        decoration: InputDecoration(
                          labelText: 'Ngày sinh',
                          labelStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          isDense: true,
                          contentPadding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      inputWihtTitle("Giới tính", "Nhập giới tính", widget.dataDetail?.thongTinCaNhan?.cmndGender ?? '',
                          TextInputType.text),
                      const SizedBox(
                        height: 12,
                      ),
                      inputWihtTitle("Quốc tịch", "Nhập quốc tịch", widget.dataDetail?.thongTinCaNhan?.cmndNation ?? '',
                          TextInputType.text),
                      const SizedBox(
                        height: 12,
                      ),
                      inputWihtTitle("Nguyên quán", "Nhập nguyên quán",
                          widget.dataDetail?.thongTinCaNhan?.cmndHome ?? '', TextInputType.text),
                      const SizedBox(
                        height: 12,
                      ),
                      inputWihtTitle("Nơi ĐKHK thường trú", "Nhập nơi ĐKHK thường trú",
                          widget.dataDetail?.thongTinCaNhan?.cmndHouse ?? '', TextInputType.text),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueAccent),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Center(
                          child: Text(
                        'OK',
                        style: TextStyle(fontSize: 18),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputWihtTitle(String? title, String? validateText, String initText, TextInputType? type) {
    return Column(
      children: [
        // Align(alignment: Alignment.bottomLeft, child: Text(title ?? '')),
        // const SizedBox(
        //   height: 7,
        // ),
        TextFormField(
          readOnly: true,
          initialValue: initText,
          keyboardType: type,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validateText;
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: title ?? '',
            labelStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 17,
            ),
            filled: true,
            fillColor: Colors.black.withOpacity(0.1),
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
