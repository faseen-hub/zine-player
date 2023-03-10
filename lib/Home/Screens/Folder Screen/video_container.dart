import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/videoscreen/video_container.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/main.dart';

class FolderVideoContainer extends StatefulWidget {
  final String videoPath;
  final int index;
  final String videotitle;
  final String splittitle;
  const FolderVideoContainer(
      {super.key,
      required this.videoPath,
      required this.index,
      required this.videotitle,
      required this.splittitle});

  @override
  State<FolderVideoContainer> createState() => _FolderVideoContainerState();
}

class _FolderVideoContainerState extends State<FolderVideoContainer> {
  String _duration = '00:00';
  int? durationinSecs = 0;
  @override
  void initState() {
    super.initState();
    recentdbdata();
    getduration();
  }

  getduration() async {
    videoDB = await Hive.openBox<AllVideos>('videoplayer');
    List<AllVideos> data = videoDB.values.toList();
    List<AllVideos> result =
        data.where((element) => element.path == widget.videoPath).toList();
    if (result.isNotEmpty) {
      _duration = result
          .where((element) => element.path == widget.videoPath)
          .first
          .duration;
      setState(() {});
    }
  }

  recentdbdata() async {
    final box = await Hive.openBox<RecentList>('recentlistBox');
    List<RecentList> data = box.values.toList();
    List<RecentList> result = data
        .where((contains) => contains.videoPath == widget.videoPath)
        .toList();
    if (result.isNotEmpty) {
      durationinSecs = result
          .where((element) => element.videoPath == widget.videoPath)
          .first
          ?.durationinSec;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return listTileVideo(
        index: widget.index,
        fileSize: fileSize,
        context: context,
        title: widget.videotitle,
        splittitle: widget.splittitle,
        path: widget.videoPath,
        duration: _duration,
        durinsec: durationinSecs);
  }

  String get fileSize {
    final fileSizeInBytes = File(widget.videoPath).lengthSync();
    return filesizing(fileSizeInBytes);
  }
}
