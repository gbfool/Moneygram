import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:moneygram/category/model/category.dart' as Moneygram;
import 'package:moneygram/utils/custom_text_style.dart';

/// Example for EmojiPickerFlutter
class AddEditCategoryScreen extends StatefulWidget {
  final Moneygram.Category? category;

  const AddEditCategoryScreen({required this.category});

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  bool emojiShowing = true;
  String _selectedEmoji = "🤑";
  TextEditingController _textEditingController = TextEditingController();
  bool _isKeyboardOpen = false;
  String hintText = "";

  @override
  void initState() {
    if (widget.category != null) {
      _selectedEmoji = widget.category!.emoji;
      _textEditingController.text = widget.category!.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    var title = widget.category != null ? "Edit" : "Add";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$title Category'),
        actions: [
          _doneButton(),
        ],
      ),
      body: _body(),
    );
  }

  Widget _doneButton() {
    var color = _textEditingController.text.isEmpty
        ? Colors.black.withOpacity(0.2)
        : Colors.black;
    return InkWell(
        onTap: () {
          // Navigator.of(context).pop();
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.done,
              size: 32,
              color: color,
            )));
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
            Spacer(),
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
              style: CustomTextStyle.emojiStyle(
                  fontSize: 40, fontWeight: FontWeight.bold))),
    );
  }

  Widget _inputField() {
    return IntrinsicWidth(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: IntrinsicWidth(
          child: TextField(
            controller: _textEditingController,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: 24),
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 24, color: Colors.black.withOpacity(0.3)),
                border: InputBorder.none,
                hintText: _textEditingController.text.isEmpty
                    ? "Add Category Name"
                    : null),
          ),
        ),
      ),
    );
  }

  Widget _emojiPicker() {
    return Offstage(
      offstage: _isKeyboardOpen,
      child: Container(
          height: 400,
          color: const Color(0xFFF2F2F2),
          child: SafeArea(
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
            ),
          )),
    );
  }
}
