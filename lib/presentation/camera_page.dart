import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecatalog_fic5/themes/app_theme.dart';

class CameraPage extends StatefulWidget {
  final Function(XFile) takePicture;
  final List<CameraDescription>? cameras;

  const CameraPage({
    super.key,
    required this.takePicture,
    this.cameras,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameracontroller;

  XFile? capturedImage;
  Future takePicture() async {
    if (!cameracontroller.value.isInitialized) {
      return null;
    }
    if (cameracontroller.value.isTakingPicture) {
      return null;
    }
    try {
      cameracontroller.setFlashMode(FlashMode.torch);
      XFile image = await cameracontroller.takePicture();
      cameracontroller.setFlashMode(FlashMode.off);

      widget.takePicture(image);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture:$e');
      return null;
    } catch (e) {
      debugPrint('print : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    cameracontroller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    cameracontroller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessedDenied':
            //handle access errors here.
            break;
          default:
            //handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    cameracontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameracontroller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
            actions: const [],
          ),
          body: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CameraPreview(cameracontroller),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, right: 20, left: 20, top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.theme.appColors.primary),
                      child: const Text('Take Picture'),
                      onPressed: () {
                        takePicture();
                      },
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Container(
                color: Colors.grey,
                child: const Center(
                  child: Text('Untuk Iklan'),
                ),
              ))
            ],
          )),
    );
  }
}
