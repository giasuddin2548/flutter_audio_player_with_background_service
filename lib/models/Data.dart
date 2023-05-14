class MusicData {
  MusicData({
      this.contentID, 
      this.image, 
      this.title, 
      this.contentType, 
      this.playUrl, 
      this.artistname, 
      this.duration, 
      this.copyright, 
      this.labelname, 
      this.releaseDate, 
      this.fav, 
      this.albumId, 
      this.artistId, 
      this.totalPlay, 
      this.client,});

  MusicData.fromJson(dynamic json) {
    contentID = json['ContentID'];
    image = json['image'];
    title = json['title'];
    contentType = json['ContentType'];
    playUrl = json['PlayUrl'];
    artistname = json['artistname'];
    duration = json['duration'];
    copyright = json['copyright'];
    labelname = json['labelname'];
    releaseDate = json['releaseDate'];
    fav = json['fav'];
    albumId = json['AlbumId'];
    artistId = json['ArtistId'];
    totalPlay = json['TotalPlay'];
    client = json['Client'];
  }
  String? contentID;
  String? image;
  String? title;
  String? contentType;
  String? playUrl;
  String? artistname;
  String? duration;
  String? copyright;
  String? labelname;
  String? releaseDate;
  String? fav;
  String? albumId;
  String? artistId;
  int? totalPlay;
  int? client;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ContentID'] = contentID;
    map['image'] = image;
    map['title'] = title;
    map['ContentType'] = contentType;
    map['PlayUrl'] = playUrl;
    map['artistname'] = artistname;
    map['duration'] = duration;
    map['copyright'] = copyright;
    map['labelname'] = labelname;
    map['releaseDate'] = releaseDate;
    map['fav'] = fav;
    map['AlbumId'] = albumId;
    map['ArtistId'] = artistId;
    map['TotalPlay'] = totalPlay;
    map['Client'] = client;
    return map;
  }

}