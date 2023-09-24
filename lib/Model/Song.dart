class Song {
  int Id;
  String Title, ArtistName;
  String ImageUrl;
  String StreamUrl;
  bool isFav = false;

  @override
  bool operator ==(s1) {
    return s1 is Song && Id == s1.Id;
  }

  Song(this.Id, this.Title, this.ArtistName, this.ImageUrl, this.StreamUrl);
}
