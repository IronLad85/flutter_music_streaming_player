class Track {
  final String id;
  final String name;
  final int duration;
  final String artistId;
  final String artistName;
  final String artistIdstr;
  final String albumName;
  final String albumId;
  final String licenseCcurl;
  final int position;
  final String releasedate;
  final String? albumImage;
  final String audio;
  final String audiodownload;
  final String prourl;
  final String shorturl;
  final String shareurl;
  final bool audiodownloadAllowed;
  final String image;

  Track({
    required this.id,
    required this.name,
    required this.duration,
    required this.artistId,
    required this.artistName,
    required this.artistIdstr,
    required this.albumName,
    required this.albumId,
    required this.licenseCcurl,
    required this.position,
    required this.releasedate,
    required this.albumImage,
    required this.audio,
    required this.audiodownload,
    required this.prourl,
    required this.shorturl,
    required this.shareurl,
    required this.audiodownloadAllowed,
    required this.image,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json['id'],
        name: json['name'],
        duration: json['duration'],
        artistId: json['artist_id'],
        artistName: json['artist_name'],
        artistIdstr: json['artist_idstr'],
        albumName: json['album_name'],
        albumId: json['album_id'],
        licenseCcurl: json['license_ccurl'],
        position: json['position'],
        releasedate: json['releasedate'],
        albumImage: json['album_image'],
        audio: json['audio'],
        audiodownload: json['audiodownload'],
        prourl: json['prourl'],
        shorturl: json['shorturl'],
        shareurl: json['shareurl'],
        audiodownloadAllowed: json['audiodownload_allowed'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'duration': duration,
        'artist_id': artistId,
        'artist_name': artistName,
        'artist_idstr': artistIdstr,
        'album_name': albumName,
        'album_id': albumId,
        'license_ccurl': licenseCcurl,
        'position': position,
        'releasedate': releasedate,
        'album_image': albumImage,
        'audio': audio,
        'audiodownload': audiodownload,
        'prourl': prourl,
        'shorturl': shorturl,
        'shareurl': shareurl,
        'audiodownload_allowed': audiodownloadAllowed,
        'image': image,
      };
}
