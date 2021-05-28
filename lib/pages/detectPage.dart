// import 'dart:convert';
import 'dart:convert';
import 'dart:io';
// import 'package:async/async.dart';
import 'package:app/models/predict.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart ' as http;
// import 'package:path/path.dart';

class DetectPage extends StatefulWidget {
  @override
  _DetectPageState createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  File _image;
  bool _isButtonDisabled = false;
  final picker = ImagePicker();
  var text = " No Image Selected ";
  var _response;
  bool _isData = false;
  Predict predict;

  Future getImageFromCamera() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _isButtonDisabled = true;
      } else {
        print("no  image selected");
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _isButtonDisabled = true;
      } else {
        print("no  image selected");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
    _isData = false;
  }

  void onPress() async {
    if (_isButtonDisabled) {
      print("attempting to connec to server......");
      var uri = Uri.parse('http://192.168.1.4:5000/predict');
      // var stream = new http.ByteStream(_image.openRead());
      // stream.cast();
      // var length = await _image.length();
      // print(length);
      //     // print(jsonDecode(res.body));
      // var multipartFile = new http.MultipartFile('select_file', stream, length,
      //     filename: basename(_image.path));

      var request = new http.MultipartRequest("POST", uri);
      var pic = await http.MultipartFile.fromPath("select_file", _image.path);
      //add multipart to request
      request.files.add(pic);
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Uploaded!');
        _isData = true;
      }
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      setState(() {
        _response = jsonDecode(responseString);
        predict = Predict.fromJson(_response);
      });
      // print(responseString);
      print(_response);
      print(predict.breed);

      // print(_response['breed']);
    } else {
      setState(() {
        text = "Select an image to Detect ";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                "       Dogs Emotion Classifier   ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 350,
                  child: Center(
                    child: _image == null
                        ? Text(
                            text,
                            style: TextStyle(fontSize: 10),
                          )
                        : Image.file(_image),
                  ),
                ),
              ),
              SizedBox(height: 100),
              Center(
                  child: _isData
                      ? Container(
                          child: Column(
                            children: <Widget>[
                              Text("breed - ${predict.breed}"),
                              Text(
                                  "Emotion - ${predict.emotion} (${predict.percentage.ceilToDouble()} %)"),
                            ],
                          ),
                        )
                      : null),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 85, vertical: 150),
                child: Row(
                  children: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            backgroundColor: Colors.purple[900],
                            onPressed: getImageFromCamera,
                            tooltip: "Pick a image from camera",
                            child: Icon(Icons.camera),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          FloatingActionButton(
                              backgroundColor: Colors.purple[900],
                              onPressed: getImageFromGallery,
                              tooltip: "Pick a image from gallery",
                              child: Icon(Icons.folder)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPress,
        tooltip: _isButtonDisabled ? " Detect " : " select an image ",
        child: const Icon(Icons.send),
        backgroundColor: Colors.purple[900],
      ),
    );
  }
}
