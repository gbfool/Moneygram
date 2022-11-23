import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

// class _AddTransactionPageState extends State<AddTransactionPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child: Column(children: [Container(child: Text("Submit"))])),
//     );
//   }
// }

class _AddTransactionPageState extends State<AddTransactionPage> {
  var _numberForm = GlobalKey<FormState>();
  RegExp _digitRegex = RegExp("[0-9]+");
  bool isValidForm = false;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _topHeader(),
          const SizedBox(height: 16),
          _amountWidget(),
          Center(
            child: Form(
                key: _numberForm,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (inputValue) {
                        if (inputValue == null ||
                            inputValue.isEmpty ||
                            !_digitRegex.hasMatch(inputValue)) {
                          return "Please enter number";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      validator: (inputValue) {
                        if (inputValue == null || inputValue.isEmpty) {
                          return "Please Fill before";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_numberForm.currentState?.validate() ?? false) {
                            setState(() {
                              isValidForm = true;
                            });
                          } else {
                            setState(() {
                              isValidForm = false;
                            });
                          }
                        },
                        child: Text("Check Number")),
                    Text(isValidForm ? "Nice" : "Please Fix error and Submit ")
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Container _topHeader() {
    return Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
        color: Colors.white,
        child: IntrinsicHeight(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Add transaction",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel')),
                )
              ],
            ),
            const SizedBox(height: 16),
            Divider(height: 1, thickness: 0)
          ],
        )));
  }

  Widget _amountWidget() {
    Color textColor =
        textEditingController.text.isEmpty ? Colors.grey : Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "\$",
          style: TextStyle(color: textColor, fontSize: 32),
        ),
        const SizedBox(width: 2),
        IntrinsicWidth(
          child: TextFormField(
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 32),
            cursorColor: Colors.black,
            controller: textEditingController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (String value) {
              setState(() {});
            },
            validator: (value) {
              // ErrorModel? errorModel = validateField(value);
              // logErrorEvent(errorModel);
              // return validateField(value)?.errorMessage;
            },
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
