import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:codex/data/data_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SongDetailsPage extends StatelessWidget {
  final Song song;

  const SongDetailsPage({super.key, required this.song});

  String songTitle() {
    return song.title;
  }

  @override
  Widget build(BuildContext context) {
    // Keep the screen on while viewing a song
    WakelockPlus.enable();

    return Scaffold(
      appBar: AppBar(
        title: Text(songTitle()),
        actions: [
          if (song.recording.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.headphones),
              onPressed: () {
                // Open default browser on song.editUrl
                launchUrl(Uri.parse(song.recording));
              },
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 22.0,
              ),
              Center(
                child: Text(
                  songTitle(),
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              // show melodie, author, page and note if available
              if (song.page.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Pagina: ${song.page}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ),

              // Same, but left aligned

              if (song.melodie.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Melodie: ${song.melodie}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ),

              if (song.author.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Auteur: ${song.author}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ),

              if (song.note.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Note: ${song.note}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 20.0),
                child: Html(
                  data: song.content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
