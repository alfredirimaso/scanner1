import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_app/Presentation/Components/app_bar.dart';

import '../Components/primary_btn.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarTitle: title),
      body: Center(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PrimaryBtn(
            btnFun: () => _getFromGallery(context),
            btnText: 'Pick Image',
          ),
          ElevatedButton(
          onPressed: () {
            _startScanner();
          },
          child: const Text('Camera'),
        ),
  ],
);
       
      ),
    );
  }
}

/// Get from gallery
_getFromGallery(context) async {
  try {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {}
  } catch (e) {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      if (kDebugMode) {
        print('Access Denied');
      }
      showAlertDialog(context);
    } else {
      if (kDebugMode) {
        print('Exception occurred!');
      }
    }
  }
}

showAlertDialog(context) => showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Permission Denied'),
        content: const Text('Allow access to gallery and photos'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
