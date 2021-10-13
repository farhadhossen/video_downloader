
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import 'package:flowder/flowder.dart';
// import 'package:path_provider/path_provider.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late DownloaderUtils options;
//   late DownloaderCore core;
//   late final String path;
//
//     TextEditingController _url = TextEditingController();
//
//   String myurl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   Future<void> initPlatformState() async {
//     _setPath();
//     if (!mounted) return;
//   }
//
//   void _setPath() async {
//     path = (await getExternalStorageDirectory())!.path;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//
//                 TextField(
//                   controller: _url,
//                   decoration: InputDecoration(labelText: 'Url'),
//                 ),
//
//             SizedBox(height: 20,),
//
//             ElevatedButton(
//               onPressed: () async {
//
//                 WidgetsFlutterBinding.ensureInitialized();
//                 String uurrll = _url.text;
//                 print('url is 1 $uurrll');
//                 options = DownloaderUtils(
//                   progressCallback: (current, total) {
//                     final progress = (current / total) * 100;
//                     print('Downloading: $progress');
//                   },
//                   file: File('$path/dd'),
//                   progress: ProgressImplementation(),
//                   onDone: () => print('COMPLETE'),
//                   deleteOnCancel: true,
//                 );
//                 core = await Flowder.download('http://ipv4.download.thinkbroadband.com/200MB.zip',
//                     options);
//                 print('url is 2 $uurrll');
//               },
//               child: Text('DOWNLOAD'),
//             ),
//             ElevatedButton(
//               onPressed: () async => core.resume(),
//               child: Text('RESUME'),
//             ),
//             ElevatedButton(
//               onPressed: () async => core.cancel(),
//               child: Text('CANCEL'),
//             ),
//             ElevatedButton(
//               onPressed: () async => core.pause(),
//               child: Text('PAUSE'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';



void main() {
  runApp(MaterialApp(
    home: MyApp1(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp1 extends StatefulWidget{
  @override
  _State createState() =>  _State();
}

class _State extends State<MyApp1>{

  TextEditingController _url = TextEditingController();

  String myurl = '';



  void onPress() async{
   _requestDownload(_url.text);
  }

  void _requestDownload(String link) async {
    WidgetsFlutterBinding.ensureInitialized();

    String path = (await getExternalStorageDirectory())!.path;

    final taskId = await FlutterDownloader.enqueue(
      url: link,
      savedDir: path,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text('App Name'),
        ),
        body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children:  [
                TextField(
                  controller: _url,
                  decoration: InputDecoration(labelText: 'Url'),
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(onPressed: ()=>onPress(), child: Text('Download'),
                  ),
                ),



              ],
            ),
          ),
        )
    );
  }
}


