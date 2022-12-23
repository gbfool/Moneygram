import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/utils/custom_text_style.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String selectedExperience = "";
  bool _isKeyboardOpen = false;
  @override
  Widget build(BuildContext context) {
    _isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(body: _content());
  }

  Widget _content() {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          /*This method here will hide the soft keyboard.*/
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [_header(), const SizedBox(height: 12), _body()]),
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ..._rateYourExperience(),
            const SizedBox(height: 48),
            Text("Anything we could do better?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _inputField(),
            const SizedBox(height: 12),
            _sendFeedback()
          ]),
        ),
      ),
    );
  }

  Widget _header() {
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
                  child: Text("Your Feedback",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                AnimatedOpacity(
                  opacity: _isKeyboardOpen ? 1 : 0,
                  duration: Duration(milliseconds: 100),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          // Navigator.of(context).pop();
                        },
                        child: IntrinsicWidth(
                          child: Container(
                              height: 26,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Text(
                                'Save',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )),
                        )),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Divider(height: 1, thickness: 0)
          ],
        )));
  }

  List<Widget> _rateYourExperience() {
    var textWidget = Text("Rate your experience",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600));

    double gap = 6;
    var emojiRow = Row(children: [
      _emojiWidget("😠", isFirst: true),
      SizedBox(width: gap),
      _emojiWidget("😔"),
      SizedBox(width: gap),
      _emojiWidget("😐"),
      SizedBox(width: gap),
      _emojiWidget("🙂"),
      SizedBox(width: gap),
      _emojiWidget("😃")
    ]);
    return [textWidget, SizedBox(height: 12), emojiRow];
  }

  Widget _emojiWidget(String emoji, {bool isFirst = false}) {
    var isSelected = selectedExperience == emoji;
    return InkWell(
      onTap: isSelected
          ? null
          : () {
              setState(() {
                selectedExperience = emoji;
              });
            },
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.black.withOpacity(0.1) : null,
            borderRadius: BorderRadius.circular(8)),
        padding:
            EdgeInsets.only(left: isFirst ? 0 : 4, right: 4, top: 6, bottom: 6),
        child: Text(
          emoji,
          style: CustomTextStyle.emojiStyle(fontSize: isSelected ? 40 : 32),
        ),
      ),
    );
  }

  Widget _inputField() {
    // return TextField(
    //   cursorColor: Colors.black,
    //   keyboardType: TextInputType.multiline,
    //   decoration: InputDecoration(
    //       border: InputBorder.none, hintText: "Please give your feedback here"),
    // );
    return TextField(
      // controller: textMessa/geController,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 8,
      onChanged: ((value) {
        setState(() {
          // _messageEntrer = value;
        });
      }),
      decoration: InputDecoration(
        hintText: "Tell us what you like, or what you didn't",
        hintMaxLines: 1,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        hintStyle:
            TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.3)),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.black26,
            width: 0.2,
          ),
        ),
      ),
    );
  }

  Widget _sendFeedback() {
    return AnimatedOpacity(
      opacity: _isKeyboardOpen ? 0 : 1,
      duration: Duration(milliseconds: 100),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(top: 12),
          child: Container(
            height: 48,
            alignment: Alignment.center,
            child: Text(
              "Save",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.03),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(24))),
          ),
        ),
      ),
    );
  }
}
