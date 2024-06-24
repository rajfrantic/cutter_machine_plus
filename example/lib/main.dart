import 'package:cutter_machine_plus/cutter_machine_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _platformVersion = "";
  final _cutterMachinePlugin = CutterMachinePlus();
  bool connected = false;

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  searchBluetooth() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _cutterMachinePlugin.searchBluetooth() ??
          'Unknown platform version';
      print("Kishan " + platformVersion);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      print("Rohit");
      return;
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Celdon'),
        ),
        body: connected == true
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: textEditingController,
                      maxLines: 8,
                      decoration: InputDecoration(
                          label: Text("Plt File Code"),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          textEditingController.clear();
                        },
                        child: Text("Clear Text")),
                    GestureDetector(
                      onTap: () async {
                        if (textEditingController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Please enter plt code");
                        } else {
                          String file = textEditingController.text
                              .toString()
                              .replaceAll("\n", "");

                          var res =
                              await _cutterMachinePlugin.cutFileBluetooth(file);
                          print(res);
                          if (res == "connected") {
                            Fluttertoast.showToast(msg: "Cutting");
                            print("Printing");
                          } else {
                            Fluttertoast.showToast(msg: "Faild to cut");
                            print("Faild to print");
                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Cut File",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          String file = textEditingController.text
                              .toString()
                              .replaceAll("\n", "");

                          var res = await _cutterMachinePlugin
                              .cutFileWithHeightAndWidthBluetooth(file,
                                  xoffset: 50,
                                  yoffset: 50,
                                  width: 50,
                                  height: 50,
                                  yflip: true,
                                  xflip: true,
                                  section: true);
                          print(res);
                        },
                        child: Text("Print")),
                    ElevatedButton(
                        onPressed: () async {
                          String file = textEditingController.text
                              .toString()
                              .replaceAll("\n", "");

                          var res = await _cutterMachinePlugin.setSpeed("300");
                          print(res);
                        },
                        child: Text("Setpeed")),
                    Text(
                      textEditingController.text
                          .toString()
                          .replaceAll("\n", ""),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          searchBluetooth();
                        },
                        child: Text("Search Blutoth")),
                    _platformVersion.contains("address")
                        ? GestureDetector(
                            onTap: () async {
                              String address = _platformVersion
                                  .toString()
                                  .split("address:")[1]
                                  .split("}")
                                  .first;
                              var res = await _cutterMachinePlugin
                                  .connectBluetooth(address);
                              if (res == "connected") {
                                connected = true;
                              } else {
                                print("Faild to connected");
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                _platformVersion
                                    .toString()
                                    .split("name:")[1]
                                    .split(",")
                                    .first,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
      ),
    );
  }
}
