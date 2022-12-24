// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class AddEditCategoryScreen extends StatefulWidget {
//   const AddEditCategoryScreen({super.key});

//   @override
//   State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
// }

// class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:moneygram/utils/custom_text_style.dart';

/// Example for EmojiPickerFlutter
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool emojiShowing = true;
  String _selectedEmoji = "🤑";
  TextEditingController _textEditingController = TextEditingController();
  bool _isKeyboardOpen = false;

  @override
  Widget build(BuildContext context) {
    _isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return GestureDetector(
      onTap: () {
        /*This method here will hide the soft keyboard.*/
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            _selectedEmojiContainer(),
            _inputField(),
            const Spacer(),
            _emojiPicker(),
          ],
        ),
      ),
    );
  }

  Widget _selectedEmojiContainer() {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(_selectedEmoji,
              style: CustomTextStyle.emojiStyle(fontSize: 40))),
    );
  }

  Widget _inputField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: IntrinsicWidth(
        child: TextField(
          controller: _textEditingController,
          cursorColor: Colors.black,
          style: TextStyle(fontSize: 24),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 24),
              border: InputBorder.none,
              hintText: "Add Category Name"),
        ),
      ),
    );
  }

  Widget _emojiPicker() {
    return Offstage(
      offstage: _isKeyboardOpen,
      child: SizedBox(
          height: 400,
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              setState(() {
                _selectedEmoji = emoji.emoji;
              });
            },
            config: Config(
                columns: 7,
                emojiSizeMax: 24 *
                    (foundation.defaultTargetPlatform == TargetPlatform.iOS
                        ? 1.30
                        : 1.0),
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: Colors.black,
                iconColor: Colors.grey,
                iconColorSelected: Colors.black,
                skinToneDialogBgColor: Colors.white,
                enableSkinTones: false,
                showRecentsTab: false,
                emojiTextStyle: CustomTextStyle.emojiStyle(fontSize: 16)),
          )),
    );
  }
}
