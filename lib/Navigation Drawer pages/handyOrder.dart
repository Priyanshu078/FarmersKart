import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/countupTimeforRecording.dart';
import 'package:shellcode2/deliveryAddress.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/sound_recorder.dart';

class HandyOrder extends StatefulWidget {
  const HandyOrder({Key key}) : super(key: key);

  @override
  _HandyOrderState createState() => _HandyOrderState();
}

String title2 = '';
int choice = 0;
final ImagePicker _picker = ImagePicker();
XFile _imageFile;

class _HandyOrderState extends State<HandyOrder> {
  final recorder = new SoundRecorder1();
  final _textController = new TextEditingController();
  Dio dio = new Dio();
  Future getImage() async {
    final XFile photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = photo;
    });
  }

  Future pickImage() async {
    final XFile photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = photo;
    });
  }

  Widget buildStart() {
    // final isRecording = recorder.isRecording;
    // final icon = isRecording ? Icons.stop : Icons.mic;
    // final primary = isRecording ? Colors.red : Colors.purple;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            // child: isRecording ? CountdownPage() : null,
            ),
        IconButton(
          onPressed: () async {
            // final isRecording = await recorder.toggleRecording();
            // print(isRecording);
            setState(() {});
          },
          icon: Icon(
            Icons.mic,
            color: Colors.purple[600],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // recorder.init();
  }

  @override
  void dispose() {
    super.dispose();
    _imageFile = null;
    // recorder.dispose();
  }

  void placeHandyOrder(BuildContext context) async {
    String userId = Provider.of<APIData>(context, listen: false).userId;
    String centerId = Provider.of<APIData>(context, listen: false).centerId;
    String url = "$header/app_api/addHandyOrder.php?apicall=uploadpic";
    FormData formData;
    if (_imageFile != null) {
      formData = new FormData.fromMap({
        "user_id": userId,
        "center_id": centerId,
        "audio_file": "audio",
        "delivery_time": "",
        "image_name": _imageFile.name,
        "product_list": _textController.text,
        "pic": await MultipartFile.fromFile(_imageFile.path,
            filename: _imageFile.name),
        "audio": "",
      });
    } else {
      formData = new FormData.fromMap({
        "user_id": userId,
        "center_id": centerId,
        "audio_file": "audio",
        "delivery_time": "",
        "image_name": "",
        "product_list": _textController.text,
        "pic": "",
        "audio": "",
      });
    }
    Response response = await dio.post(url,
        data: formData,
        options: Options(headers: {
          "Accept": "application/json",
          "Content-Type": "multipart/form-data"
        }));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Handy Order Submitted")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        //brightness: Brightness.light,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
        leading: IconButton(
          onPressed: () {
            _imageFile = null;
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: yellow),
        ),
        title: Text(
          'Handy Order',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Click product list image & Upload',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              // ..camera
              Center(
                child: _imageFile == null
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          color: bgcolor,
                          height: 250,
                          width: 330,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Click product list image & Upload',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    pickImage();
                                  },
                                  icon: Icon(CupertinoIcons.photo),
                                  color: Colors.blueGrey,
                                ),
                                IconButton(
                                  onPressed: () {
                                    getImage();
                                  },
                                  icon: Icon(CupertinoIcons.camera_fill),
                                  color: Colors.blueGrey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: bgcolor,
                        height: 250,
                        width: 300,
                        child: Stack(
                          children: [
                            Image.file(
                              File(_imageFile.path),
                              filterQuality: FilterQuality.high,
                            ),
                            Positioned(
                              top: 5,
                              right:
                                  5, //give the values according to your requirement
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      pickImage();
                                    },
                                    icon: Icon(CupertinoIcons.photo),
                                    color: Colors.blueGrey,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: Icon(CupertinoIcons.camera_fill),
                                    color: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 30,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(color: Colors.purple),
                    cursorColor: Colors.purple,
                    controller: _textController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      hintStyle: TextStyle(color: yellow),
                      hintText: 'Type Your Product List...',
                      labelStyle: new TextStyle(color: yellow),
                    ) // Set Your Own Color
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: buildStart(),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DeliveryAddress.handyOrder(1)));
                    },
                    child: Text(
                      'Select Center List',
                      style: TextStyle(color: Colors.purple),
                    ),
                  )),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          placeHandyOrder(context);
        },
        label: const Text('SUBMIT'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.purple,
      ),
      bottomNavigationBar: Navigate(),
    );
  }
}

const String _heroAddTodo = 'add-todo-hero';

class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    @required WidgetBuilder builder,
    @required RouteSettings settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}

class Navigate extends StatefulWidget {
  const Navigate({Key key}) : super(key: key);

  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: lightbg,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.grey[300],
            //type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey[500],
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Icon(Icons.home)),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Category()));
                    },
                    child: Icon(Icons.list)),
                title: Text('Categories'),
              ),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Wishlist()));
                      },
                      child: Icon(CupertinoIcons.heart)),
                  title: Text('Wishlist')),
            ],
          ),
        ));
  }
}

final pathToSaveAudio = 'audio.aac';

class SoundRecorder {
  FlutterSoundRecorder _audioRecorder;

  Future _record() async {
    await _audioRecorder.startRecorder(toFile: pathToSaveAudio);
  }

  Future _stop() async {
    await _audioRecorder.stopRecorder();
  }

  Future toggleRecording() async {
    if (_audioRecorder.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
