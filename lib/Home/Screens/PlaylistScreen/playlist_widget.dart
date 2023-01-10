import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/list_item_functions.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

void addToPlayList({required context, required widgetpath}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text("Select playlist"),
        content: playlistDailog(context: context, widgetpath: widgetpath)),
  );
}

void showDetails(
    {required context,
    required title,
    required path,
    required duration,
    required size}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: detailsDailog(path: path, duration: duration, size: size),
      );
    },
  );
}

Widget detailsDailog({required path, required duration, required size}) {
  return Container(
    height: 180.0,
    width: 200.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("path : $path"),
        Text("Duration : $duration"),
        Text("Size : $size")
      ],
    ),
  );
}

Widget playlistDailog({required widgetpath, required context}) {
  return Container(
    height: 180.0,
    width: 200.0,
    color: Colors.blue,
    child: Column(
      children: [
        ValueListenableBuilder(
          valueListenable: playListNotifier,
          builder:
              (BuildContext context, List<PlayList> playlist, Widget? child) {
            return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final listdata = playlist[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        addItemToPlayList(
                            playlistFolderName: listdata.name,
                            context: context,
                            videoPath: widgetpath);
                        snackBar(
                            context: context,
                            content: 'Successfully added',
                            bgcolor: Colors.green);
                      },
                      title: Text(listdata.name),
                    ),
                  );
                },
                itemCount: playlist.length);
          },
        ),
        TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            label: const Text(
              "cancel",
              style: TextStyle(color: Colors.white),
            ))
      ],
    ),
  );
}