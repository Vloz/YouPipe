part of server_api;

class SigninRequest {
  String nick;
  String picture;
  String plus_url;
}

class IdRequest{
  String id;
  IdRequest([this.id]);
}

class SourceRequest{
  String full_path;
  SourceRequest([this.full_path]);
}


class Pipe{

  @ApiProperty(description: 'Owner ID of the pipe.')
  String owner;

  @ApiProperty(description: 'Owner nick for the pipe.')
  String owner_nick;

  @ApiProperty(description: 'Owner picture for the pipe.')
  String owner_picture;

  @ApiProperty(description: 'Complete short id for this version. Following this syntax: {Pipe short id}_{Major}_{Minor}')
  String short_id;

  @ApiProperty(description: 'Date of the 1st version.')
  DateTime initial_created;

  @ApiProperty(description: 'Date of this version.')
  DateTime version_created;

  @ApiProperty(description: 'Shortened id of the last public body for this pipe.')
  String last_public_version_short_id;

  @ApiProperty(description: 'Url to the picture for this version.')
  String picture;

  @ApiProperty(description: 'Url to the picture for this version.')
  bool public;

  @ApiProperty(description: 'Index of the category for this version.')
  int category;

  @ApiProperty(description: 'Title for this version.')
  String title;

  @ApiProperty(description: 'Description/HowTo/Changelog for this version.')
  String description;

  @ApiProperty(description: 'Number of time this version has been ran.')
  int version_uses;

  @ApiProperty(description: 'Number of time all the version were run.')
  int total_uses;

  @ApiProperty(description: 'thumbs up for this version.')
  int version_thumbs_up;

  @ApiProperty(description: 'thumbs down for this version.')
  int version_thumbs_down;

  @ApiProperty(description: 'thumbs up for this version.')
  int total_thumbs_up;

  @ApiProperty(description: 'thumbs down for this version.')
  int total_thumbs_down;

  @ApiProperty(description: 'How many comments were post for this pipe.')
  int pipe_comments_count;

  @ApiProperty(description: 'How many comments were post for this major version.')
  int version_comments_count;

  @ApiProperty(description: 'If false this version is shown as deleted.')
  bool active;

  @ApiProperty(description: 'List of sources fullpath for this version.')
  List<String> sources = [];

  Pipe(PipeHeader h, PipeBody b){
    owner = h.owner;
    owner_nick  = h.owner_nick;
    owner_picture = h.owner_picture;
    short_id = b.short_id;
    initial_created = h.initial_created;
    version_created = b.created;
    last_public_version_short_id = h.last_public_version_short_id;
    picture = b.picture;
    public = b.public;
    category = b.category;
    title = b.title;
    description = b.description;
    version_uses = b.version_uses;
    total_uses = h.total_uses;
    version_thumbs_up = b.version_thumbs_up;
    version_thumbs_down = b.version_thumbs_down;
    active = true;
    if(!b.active || !h.active)
      throw new Exception("Access to a deleted body/header.");
    sources = b.sources;
  }
}


/*
class PipeShortIdRequest{
String pipe_short_id;
PipeShortIdRequest([this.pipe_short_id]);
}

class VersionNumberRequest{
  String version_number;
  VersionNumberRequest([this.version_number]);
}

class FullPathRequest{
  String full_path;
  FullPathRequest([this.full_path]);
}*/
