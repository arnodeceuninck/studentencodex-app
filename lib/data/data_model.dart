class Song {
  String page="";
  String title="";
  String note="";
  String melodie="";
  String author="";

  String content="";

  Song(this.page, this.title, this.note, this.melodie, this.author, this.content);

  Song.fromFson(Map<String, dynamic> json) {
    // if element not in json assign empty string, else element
    page = json['page'] ?? "";
    title = json['title'] ?? "";
    note = json['note'] ?? "";
    melodie = json['melodie'] ?? "";
    author = json['author'] ?? "";
    content = json['content'] ?? "";
  }

  Map<String, dynamic> toJson(){
    return {
      'page': page,
      'title': title,
      'note': note,
      'melodie': melodie,
      'author': author,
      'content': content,
    };
  }
}