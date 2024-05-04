import 'package:flutter/material.dart';
import 'package:codex/data/data_model.dart';
import 'package:codex/domain/repository.dart';
import 'package:codex/presentation/components/loading_widget.dart';
import 'package:codex/presentation/components/song_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> _books = [];
  List<Song> _songs = [];
  List<Song> _songsDisplay = [];

  TextEditingController _searchController = TextEditingController();

  bool _isLoadingBooks = true;
  bool _isLoadingSongs = true;

  String _selectedBookId = 'all_codices';

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
            : const Text('No book selected'),
      ),
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Container(
          child: _isLoadingSongs
              ? const LoadingView()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return index == 0
                        ? _searchBar()
                        : SongTile(song: _songsDisplay[index - 1]);
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
            return const LoadingView();
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

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          TextField(
            controller: _searchController,
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
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _songsDisplay = _songs;
                });
              },
            ),
          ),
        ],
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
