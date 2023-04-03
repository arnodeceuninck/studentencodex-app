import 'package:flutter/material.dart';
import 'package:codex/data/data_model.dart';
import 'package:codex/domain/repository.dart';
import 'package:codex/presentation/components/loading_widget.dart';
import 'package:codex/presentation/components/song_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Song> _songs = <Song>[];
  List<Song> _songsDisplay = <Song>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getSongs().then((value) {
      setState(() {
        _isLoading = false;
        _songs.addAll(value);
        _songsDisplay = _songs;
        //print(_songsDisplay.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rode Codex (oud)'),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0 ? _searchBar() : SongTile(song: this._songsDisplay[index - 1]);
              } else {
                return LoadingView();
              }
            },
            itemCount: _songsDisplay.length + 1,
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _songsDisplay = _songs.where((s) {
              // var fName = u.firstName.toLowerCase();
              // var lName = u.lastName.toLowerCase();
              // var job = u.job.toLowerCase();
              var stitle = s.title.toLowerCase();
              var scontent = s.content.toLowerCase();
              var spage = s.page.toLowerCase();
              return stitle.contains(searchText) || scontent.contains(searchText) || spage.contains(searchText);
            }).toList();
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Search Songs',
        ),
      ),
    );
  }
}