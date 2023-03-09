import 'dart:io';

import 'package:bank_application/model/cmnd_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../consts/colors/colors.dart';
import '../viewmodels/home_viewmodel.dart';

class FormWithImg extends StatefulWidget {
  final CMND_Data dataCMND;
  const FormWithImg(this.dataCMND, {super.key});

  @override
  State<FormWithImg> createState() => _FormWithImgState();
}

class _FormWithImgState extends State<FormWithImg> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  final _formKey = GlobalKey<FormState>();
  TextEditingController cmndNumber = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController hometown = TextEditingController();
  TextEditingController regisadd = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cmndNumber.text = "${widget.dataCMND.data?.cmnd_num}";
      name.text = "${widget.dataCMND.data?.cmnd_name}";
      hometown.text = "${widget.dataCMND.data?.cmnd_home}";
      dateinput.text = "${widget.dataCMND.data?.cmnd_dob}";
      regisadd.text = "${widget.dataCMND.data?.cmnd_house}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorStyle.pinkBg,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    'Nhập thông tin CMND',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(File(_homeViewModel.imageFile!.path)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        inputWihtTitle("Số CMND", "000...", "Nhập số CMND", cmndNumber, TextInputType.number),
                        const SizedBox(
                          height: 20,
                        ),
                        inputWihtTitle("Họ và tên", "...", "Nhập họ và tên", name, TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(alignment: Alignment.bottomLeft, child: Text('Ngày sinh')),
                        const SizedBox(
                          height: 7,
                        ),
                        TextField(
                          controller: dateinput, //editing controller of this TextField
                          decoration: InputDecoration(
                            hintText: 'dd-MM-yyyy',
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            isDense: true,
                            contentPadding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
                          ),
                          readOnly: true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

                              setState(() {
                                dateinput.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        inputWihtTitle("Nguyên quán", "...", "Nhập nguyên quán", hometown, TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        inputWihtTitle(
                            "Nơi ĐKHK thường trú", "...", "Nhập nơi ĐKHK thường trú", regisadd, TextInputType.text),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(20), color: ColorStyle.pinkBg),
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  Map<String, dynamic> data = {
                                    "SỐ CMND": cmndNumber.text,
                                    "Họ tên": name.text,
                                    "Sinh ngày": dateinput.text,
                                    "Nguyên quán": hometown.text,
                                    "Nơi ĐKHK thường trú": regisadd.text
                                  };
                                  print(data);
                                }
                              },
                              child: const Center(
                                  child: Text(
                                'Gửi',
                                style: TextStyle(fontSize: 18),
                              )),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputWihtTitle(
      String? title, String? hintext, String? validateText, TextEditingController controller, TextInputType? type) {
    return Column(
      children: [
        Align(alignment: Alignment.bottomLeft, child: Text(title ?? '')),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          keyboardType: type,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validateText;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintext ?? 's',
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
