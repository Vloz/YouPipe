part of server_api;

@Kind()
class User extends Model {

  @StringProperty()
  @ApiProperty(description: 'Google id of the user.')
  String owner;

  @DateTimeProperty(required:true)
  @ApiProperty(description: 'Time stamp, will be added automatically when the profile is recorded.')
  DateTime created;

  @StringProperty(required:true)
  @ApiProperty(description: 'Google+ name of the user.')
  String nick;

  @StringProperty(indexed:false)
  @ApiProperty(description: 'Url of the Google+ profile picture.')
  String picture;

  @StringProperty(required:true)
  @ApiProperty(description: 'Email of the user.')
  String email;

  @StringProperty()
  @ApiProperty(description: 'Url of google+ profile.')
  String plus_url;

  @BoolProperty()
  @ApiProperty(description: 'If true, the user wont be able to log anymore.')
  bool banned;


  User() {
    // Automatically set current date for new messages
    created = new DateTime.now();
    banned = false;
  }
}


@Kind(name: "pipe_header")
class PipeHeader extends Model {
  @StringProperty()
  @ApiProperty(description: 'Owner ID of the pipe.')
  String owner;

  @StringProperty()
  @ApiProperty(description: 'Owner nick for the pipe.')
  String owner_nick;

  @StringProperty()
  @ApiProperty(description: 'Owner picture for the pipe.')
  String owner_picture;

  @StringProperty()
  @ApiProperty(description: 'Shortened id using ASCII char.')
  String short_id;

  @DateTimeProperty()
  @ApiProperty(description: 'Date of the 1st version.')
  DateTime initial_created;

  @DateTimeProperty()
  @ApiProperty(description: 'Date of the last public version.')
  DateTime last_public_created;

  @StringProperty()
  @ApiProperty(description: 'Shortened id of the last public body for this header.')
  String last_public_version_short_id;

  @StringProperty()
  @ApiProperty(description: 'Url to the picture of the last public version.')
  String picture;

  @IntProperty()
  @ApiProperty(description: 'Index of the category of last version of the pipe')
  int category;

  @StringProperty()
  @ApiProperty(description: 'Title of the last version of the pipe.')
  String title;

  @StringProperty()
  @ApiProperty(description: 'Name of the creator.')
  String author_nick;

  @IntProperty()
  @ApiProperty(description: 'Number of time all the version this pipe were ran.')
  int total_uses;

  @IntProperty()
  @ApiProperty(description: 'thumbs up for all versions of this pipe.')
  int total_thumbs_up;

  @IntProperty()
  @ApiProperty(description: 'thumbs down for all versions of this pipe.')
  int total_thumbs_down;

  @BoolProperty()
  @ApiProperty(description: 'If false the pipe is not shown in search.')
  bool indexed;

  @BoolProperty()
  @ApiProperty(description: 'If false the pipe is shown as deleted.')
  bool active;

  @IntProperty()
  @ApiProperty(description: 'How many comments were post for this pipe.')
  int total_comments_count;

  PipeHeader() {
    // Automatically set current date for new messages
    initial_created = new DateTime.now();
    active = true;
    total_thumbs_up = 0;
    total_thumbs_down = 0;
    total_comments_count = 0;
    total_uses = 0;
    category = 0;
  }
}


@Kind(name : "pipe_body")
class PipeBody extends Model {
  @StringProperty()
  @ApiProperty(description: 'Owner ID of the pipe.')
  String owner;

  @StringProperty()
  @ApiProperty(description: 'Complete short id for this version. Following this syntax: {Pipe short id}_{Major}_{Minor}')
  String short_id;

  @DateTimeProperty()
  @ApiProperty(description: 'Date of this version.')
  DateTime created;

  @StringProperty()
  @ApiProperty(description: 'Url to the picture for this version.')
  String picture;

  @BoolProperty()
  @ApiProperty(description: 'Url to the picture for this version.')
  bool public;

  @IntProperty()
  @ApiProperty(description: 'Index of the category for this version.')
  int category;

  @StringProperty()
  @ApiProperty(description: 'Title for this version.')
  String title;

  @StringProperty()
  @ApiProperty(description: 'Description/HowTo/Changelog for this version.')
  String description;

  @IntProperty()
  @ApiProperty(description: 'Nomber of time this version has been ran.')
  int version_uses;

  @IntProperty()
  @ApiProperty(description: 'thumbs up for this version.')
  int version_thumbs_up;

  @IntProperty()
  @ApiProperty(description: 'thumbs down for this version.')
  int version_thumbs_down;

  @IntProperty()
  @ApiProperty(description: 'How many comments were post for this major version.')
  int version_comments_count;

  @BoolProperty()
  @ApiProperty(description: 'If false this version is shown as deleted.')
  bool active;

  @ListProperty(const StringProperty())
  @ApiProperty(description: 'List of sources fullpath for this version.')
  List<String> sources = [];



  PipeBody() {
    // Automatically set current date for new messages
    created = new DateTime.now();
    active = true;
    version_thumbs_up = 0;
    version_thumbs_down = 0;
  }
}

@Kind()
class Source extends Model {
  @StringProperty()
  @ApiProperty(description: 'Unique => /PipeSId+VersionSId/path/filename.ext .')
  String full_path;

  @StringProperty()
  @ApiProperty(description: 'Body of the file. Max size 1MB.')
  String body;

  @IntProperty()
  @ApiProperty(description: 'Size in bytes of the source.')
  int size;

  Source(){

  }
}


