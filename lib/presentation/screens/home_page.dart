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
  List<Book> _books = [];
  List<Song> _songs = [];
  List<Song> _songsDisplay = [];

  bool _isLoadingBooks = true;
  bool _isLoadingSongs = true;

  String _selectedBookId = 'antwerpse';

  @override
  void initState() {
    super.initState();

    getBooks().then((value) {
      setState(() {
        _books = value;
        _isLoadingBooks = false;
      });
    });

    fetchSongs(_selectedBookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _books.isNotEmpty && getSelectedBook() != null
            ? Text(getSelectedBook().title)
            : Text('No book selected'),
      ),
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Container(
          child: _isLoadingSongs
              ? LoadingView()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return index == 0
                        ? _searchBar()
                        : SongTile(song: this._songsDisplay[index - 1]);
                  },
                  itemCount: _songsDisplay.length + 1,
                ),
        ),
      ),
    );
  }

  _buildDrawer() {
    return Drawer(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (_isLoadingBooks) {
            return LoadingView();
          } else {
            final book = _books[index];
            return ListTile(
              title: Text(book.title),
              selected: book.id == _selectedBookId,
              onTap: () {
                Navigator.pop(context);
                if (_selectedBookId != book.id) {
                  fetchSongs(book.id);
                }
              },
            );
          }
        },
        itemCount: _books.length,
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
              var stitle = s.title.toLowerCase();
              var scontent = s.content.toLowerCase();
              var spage = s.page.toLowerCase();
              return stitle.contains(searchText) ||
                  scontent.contains(searchText) ||
                  spage.contains(searchText);
            }).toList();
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Search Songs',
        ),
      ),
    );
  }

  fetchSongs(String bookId) {
    setState(() {
      _isLoadingSongs = true;
    });

    getSongs().then((value) {
      setState(() {
        _songs = value[bookId]!;
        _songsDisplay = _songs;
        _selectedBookId = bookId;
        _isLoadingSongs = false;
      });
    });
  }

  getSelectedBook() {
    return _books.firstWhere((book) => book.id == _selectedBookId);
  }
}
