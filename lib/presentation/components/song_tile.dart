import 'package:flutter/material.dart';
import 'package:codex/data/data_model.dart';
import 'package:codex/presentation/screens/song_details_page.dart';

class SongTile extends StatelessWidget {
  final Song song;

  SongTile({required this.song});

  String songTitle() {
    return song.title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('${songTitle()}'),
            trailing: Text('${song.page}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SongDetailsPage(song: song)));
            },
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}