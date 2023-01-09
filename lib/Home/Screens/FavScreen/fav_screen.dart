import 'package:flutter/material.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext ctx, List<Favourite> favList, Widget? child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final listdata = favList[index];
              String splittedtitle = listdata.title;
              if (splittedtitle.length > 20) {
                splittedtitle = "${splittedtitle.substring(0, 20)}...";
              }
              return Card(
                child: ListTile(
                  onTap: () {
                    playVideo(
                      videotitle: listdata.title,
                      context: context,
                      videoPath: listdata.videoPath,
                      splittedvideotitle: splittedtitle,
                    );
                  },
                  // leading: thumbnail(listdata),
                  title: Text(splittedtitle),
                  trailing: popupMenu(index),
                  leading: thumbnail(),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: favList.length);
      },
      valueListenable: favouriteNotifier,
    );
  }

  Widget popupMenu(index) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            deleteFav(index);
            snackBar(
                context: context, content: "Unliked", bgcolor: Colors.green);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.remove, color: Colors.red),
          label: const Text(
            "Unlike",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        ))
      ],
    );
  }
}
