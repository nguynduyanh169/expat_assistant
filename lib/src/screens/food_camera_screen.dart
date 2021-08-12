import 'package:camera_camera/camera_camera.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/camera_cubit.dart';
import 'package:expat_assistant/src/repositories/restaurant_repository.dart';
import 'package:expat_assistant/src/screens/restaurant_by_food_screen.dart';
import 'package:expat_assistant/src/states/camera_state.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';

class FoodCameraScreen extends StatefulWidget {
  _FoodCameraState createState() => _FoodCameraState();
}

class _FoodCameraState extends State<FoodCameraScreen>
    with WidgetsBindingObserver {
  List<CameraDescription> _cameras;
  CameraController _controller;
  int _selected = 0;
  File file;
  bool isFlashOff = true;

  Future<void> setupCamera() async {
    await [
      Permission.camera,
    ].request();
    _cameras = await availableCameras();
    var controller = await selectCamera();
    setState(() => _controller = controller);
  }

  selectCamera() async {
    var controller = CameraController(
      _cameras[_selected],
      ResolutionPreset.ultraHigh,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await controller.initialize();
    return controller;
  }

  toggleCamera() async {
    int newSelected = (_selected + 1) % _cameras.length;
    _selected = newSelected;

    var controller = await selectCamera();
    setState(() => _controller = controller);
  }

  switchFlash() async {
    if (isFlashOff == true) {
      setState(() {
        _controller.setFlashMode(FlashMode.always);
        isFlashOff = false;
      });
    } else {
      setState(() {
        _controller.setFlashMode(FlashMode.off);
        isFlashOff = true;
      });
    }
  }

  Future<void> takePicture(BuildContext context) async {
    try {
      XFile xFile = await _controller.takePicture();
      file = File(xFile.path);
      BlocProvider.of<CameraCubit>(context).uploadImage(file);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setupCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_controller == null || !_controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      setupCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (_controller == null) {
      return Scaffold(body: LoadingView(message: 'Loading...'));
    } else {
      return BlocProvider(
        create: (context) => CameraCubit(RestaurantRepository()),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(
              'Camera',
              style: GoogleFonts.lato(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          backgroundColor: Colors.black,
          body: BlocConsumer<CameraCubit, CameraState>(
            listener: (context, state) {
              if (state.status.isUploadedImage) {
                Navigator.pop(context);
                BlocProvider.of<CameraCubit>(context)
                    .detectFood(state.imageUrl);
              } else if (state.status.isUploadingImage) {
                CustomLoadingDialog.loadingDialog(
                    context: context, message: 'Please wait....');
              } else if (state.status.isUploadImageError) {
                Navigator.pop(context);
                print(state.message);
              }else if (state.status.isRecognizeSuccess) {
              Navigator.pop(context);
              Navigator.pushNamed(context, RouteName.RESTAURANTS_BY_FOOD,
                  arguments: RestaurantByFoodArgs(
                      state.foodName, "10.80477002973667, 106.75600530688988", 10.80477002973667, 106.75600530688988, state.imageUrl));
            } else if (state.status.isRecognizeFoodError) {
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'An error occurs while recoginzing food image',
                  color: Colors.red);
            }
            },
            builder: (context, state) {
              return Stack(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: CameraPreview(_controller)),
                  Container(
                    color: Colors.transparent,
                    height: SizeConfig.blockSizeVertical * 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            "Take a food photo to recognize",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              IconButton(
                                onPressed: toggleCamera,
                                icon: Icon(CupertinoIcons.switch_camera_solid,
                                    color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  takePicture(context);
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    switchFlash();
                                  },
                                  icon: Icon(
                                    isFlashOff
                                        ? Ionicons.flash_off
                                        : Ionicons.flash,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
  }

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }
}

class FoodCameraArguments {
  final List<CameraDescription> cameraList;

  FoodCameraArguments(this.cameraList);
}
