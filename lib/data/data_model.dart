class Song {
  String page = "";
  String title = "";
  String note = "";
  String melodie = "";
  String author = "";

  // String editUrl = "";

  String content = "";

  Song(this.page, this.title, this.note, this.melodie, this.author,
      this.content); // this.editUrl

  Song.fromFson(Map<String, dynamic> json) {
    // if element not in json assign empty string, else element
    page = json['page'] ?? "";
    title = json['title'] ?? "";
    note = json['note'] ?? "";
    melodie = json['melodie'] ?? "";
    author = json['author'] ?? "";
    content = json['content'] ?? "";

    // // editUrl is the url from the json, but localhost replaced with github
    // String url = json['url'] ?? "";
    // String githubEditPrefix =
    //     "https://github.com/arnodeceuninck/studentencodex/blob/master/_";
    // editUrl = url.replaceAll("http://localhost:4000/",
    //     githubEditPrefix); // in case codices.json comes from localhost
    // editUrl = editUrl.replaceAll("https://arnodeceuninck.github.io/",
    //     githubEditPrefix); // in case codices.json comes from the github pages
    // editUrl = editUrl.replaceAll(".html", ".md");
  }

  Map<String, dynamic> toJson() {
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

class Book {
  String title = "";
  String id = "";

  Book(this.title, this.id);

  Book.fromFson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    id = json['id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
    };
  }
}
