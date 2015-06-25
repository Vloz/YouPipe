// This is a generated file (see the discoveryapis_generator project).

library discoveryapis_generator.youpipe.v1;

import 'dart:core' as core;
import 'dart:collection' as collection;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client youpipe/v1';

/** YouPipe Backend */
class YoupipeApi {
  /** View your email address */
  static const UserinfoEmailScope = "https://www.googleapis.com/auth/userinfo.email";

  /** View your basic profile info */
  static const UserinfoProfileScope = "https://www.googleapis.com/auth/userinfo.profile";


  final commons.ApiRequester _requester;

  PipeResourceApi get pipe => new PipeResourceApi(_requester);
  SourceResourceApi get source => new SourceResourceApi(_requester);
  UserResourceApi get user => new UserResourceApi(_requester);

  YoupipeApi(http.Client client, {core.String rootUrl: "http://localhost:8080/_ah/api/", core.String servicePath: "youpipe/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class PipeResourceApi {
  final commons.ApiRequester _requester;

  PipeResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Return a pipe version from it's short_id with this form {Header_id}_{Major
   * vers n°}_{Minor vers n°}.If no version number specified, the last
   * authorized version is returned
   *
   * Request parameters:
   *
   * [id] - null
   *
   * Completes with a [Pipe].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Pipe> get(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'pipe/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Pipe.fromJson(data));
  }

}


class SourceResourceApi {
  final commons.ApiRequester _requester;

  SourceResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Return a pipe source from it's path. Path has this form {Version short
   * id}/{path in the project}
   *
   * Request parameters:
   *
   * [fullPath] - null
   *
   * Completes with a [Source].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Source> get(core.String fullPath) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (fullPath == null) {
      throw new core.ArgumentError("Parameter fullPath is required.");
    }

    _url = 'source/' + commons.Escaper.ecapeVariable('$fullPath');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Source.fromJson(data));
  }

}


class UserResourceApi {
  final commons.ApiRequester _requester;

  UserResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * User sign using google+ profile informations.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [User].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<User> sign(SigninRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'user';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new User.fromJson(data));
  }

}



class Pipe {
  /** If false this version is shown as deleted. */
  core.bool active;
  /** Index of the category for this version. */
  core.int category;
  /** Description/HowTo/Changelog for this version. */
  core.String description;
  /** Date of the 1st version. */
  core.DateTime initialCreated;
  /** Shortened id of the last public body for this pipe. */
  core.String lastPublicVersionShortId;
  /** Owner ID of the pipe. */
  core.String owner;
  /** Owner nick for the pipe. */
  core.String ownerNick;
  /** Owner picture for the pipe. */
  core.String ownerPicture;
  /** Url to the picture for this version. */
  core.String picture;
  /** How many comments were post for this pipe. */
  core.int pipeCommentsCount;
  /** Url to the picture for this version. */
  core.bool public;
  /**
   * Complete short id for this version. Following this syntax: {Pipe short
   * id}_{Major}_{Minor}
   */
  core.String shortId;
  core.List<core.String> sources;
  /** Title for this version. */
  core.String title;
  /** thumbs down for this version. */
  core.int totalThumbsDown;
  /** thumbs up for this version. */
  core.int totalThumbsUp;
  /** Number of time all the version were run. */
  core.int totalUses;
  /** How many comments were post for this major version. */
  core.int versionCommentsCount;
  /** Date of this version. */
  core.DateTime versionCreated;
  /** thumbs down for this version. */
  core.int versionThumbsDown;
  /** thumbs up for this version. */
  core.int versionThumbsUp;
  /** Number of time this version has been ran. */
  core.int versionUses;

  Pipe();

  Pipe.fromJson(core.Map _json) {
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("category")) {
      category = _json["category"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("initial_created")) {
      initialCreated = core.DateTime.parse(_json["initial_created"]);
    }
    if (_json.containsKey("last_public_version_short_id")) {
      lastPublicVersionShortId = _json["last_public_version_short_id"];
    }
    if (_json.containsKey("owner")) {
      owner = _json["owner"];
    }
    if (_json.containsKey("owner_nick")) {
      ownerNick = _json["owner_nick"];
    }
    if (_json.containsKey("owner_picture")) {
      ownerPicture = _json["owner_picture"];
    }
    if (_json.containsKey("picture")) {
      picture = _json["picture"];
    }
    if (_json.containsKey("pipe_comments_count")) {
      pipeCommentsCount = _json["pipe_comments_count"];
    }
    if (_json.containsKey("public")) {
      public = _json["public"];
    }
    if (_json.containsKey("short_id")) {
      shortId = _json["short_id"];
    }
    if (_json.containsKey("sources")) {
      sources = _json["sources"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("total_thumbs_down")) {
      totalThumbsDown = _json["total_thumbs_down"];
    }
    if (_json.containsKey("total_thumbs_up")) {
      totalThumbsUp = _json["total_thumbs_up"];
    }
    if (_json.containsKey("total_uses")) {
      totalUses = _json["total_uses"];
    }
    if (_json.containsKey("version_comments_count")) {
      versionCommentsCount = _json["version_comments_count"];
    }
    if (_json.containsKey("version_created")) {
      versionCreated = core.DateTime.parse(_json["version_created"]);
    }
    if (_json.containsKey("version_thumbs_down")) {
      versionThumbsDown = _json["version_thumbs_down"];
    }
    if (_json.containsKey("version_thumbs_up")) {
      versionThumbsUp = _json["version_thumbs_up"];
    }
    if (_json.containsKey("version_uses")) {
      versionUses = _json["version_uses"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (active != null) {
      _json["active"] = active;
    }
    if (category != null) {
      _json["category"] = category;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (initialCreated != null) {
      _json["initial_created"] = (initialCreated).toIso8601String();
    }
    if (lastPublicVersionShortId != null) {
      _json["last_public_version_short_id"] = lastPublicVersionShortId;
    }
    if (owner != null) {
      _json["owner"] = owner;
    }
    if (ownerNick != null) {
      _json["owner_nick"] = ownerNick;
    }
    if (ownerPicture != null) {
      _json["owner_picture"] = ownerPicture;
    }
    if (picture != null) {
      _json["picture"] = picture;
    }
    if (pipeCommentsCount != null) {
      _json["pipe_comments_count"] = pipeCommentsCount;
    }
    if (public != null) {
      _json["public"] = public;
    }
    if (shortId != null) {
      _json["short_id"] = shortId;
    }
    if (sources != null) {
      _json["sources"] = sources;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (totalThumbsDown != null) {
      _json["total_thumbs_down"] = totalThumbsDown;
    }
    if (totalThumbsUp != null) {
      _json["total_thumbs_up"] = totalThumbsUp;
    }
    if (totalUses != null) {
      _json["total_uses"] = totalUses;
    }
    if (versionCommentsCount != null) {
      _json["version_comments_count"] = versionCommentsCount;
    }
    if (versionCreated != null) {
      _json["version_created"] = (versionCreated).toIso8601String();
    }
    if (versionThumbsDown != null) {
      _json["version_thumbs_down"] = versionThumbsDown;
    }
    if (versionThumbsUp != null) {
      _json["version_thumbs_up"] = versionThumbsUp;
    }
    if (versionUses != null) {
      _json["version_uses"] = versionUses;
    }
    return _json;
  }
}

class SigninRequest {
  core.String nick;
  core.String picture;
  core.String plusUrl;

  SigninRequest();

  SigninRequest.fromJson(core.Map _json) {
    if (_json.containsKey("nick")) {
      nick = _json["nick"];
    }
    if (_json.containsKey("picture")) {
      picture = _json["picture"];
    }
    if (_json.containsKey("plus_url")) {
      plusUrl = _json["plus_url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nick != null) {
      _json["nick"] = nick;
    }
    if (picture != null) {
      _json["picture"] = picture;
    }
    if (plusUrl != null) {
      _json["plus_url"] = plusUrl;
    }
    return _json;
  }
}

class Source {
  /** Body of the file. Max size 1MB. */
  core.String body;
  /** Unique => /PipeSId+VersionSId/path/filename.ext . */
  core.String fullPath;
  /** Size in bytes of the source. */
  core.int size;

  Source();

  Source.fromJson(core.Map _json) {
    if (_json.containsKey("body")) {
      body = _json["body"];
    }
    if (_json.containsKey("full_path")) {
      fullPath = _json["full_path"];
    }
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (body != null) {
      _json["body"] = body;
    }
    if (fullPath != null) {
      _json["full_path"] = fullPath;
    }
    if (size != null) {
      _json["size"] = size;
    }
    return _json;
  }
}

class User {
  /** If true, the user wont be able to log anymore. */
  core.bool banned;
  /** Time stamp, will be added automatically when the profile is recorded. */
  core.DateTime created;
  /** Email of the user. */
  core.String email;
  /** Google+ name of the user. */
  core.String nick;
  /** Google id of the user. */
  core.String owner;
  /** Url of the Google+ profile picture. */
  core.String picture;
  /** Url of google+ profile. */
  core.String plusUrl;

  User();

  User.fromJson(core.Map _json) {
    if (_json.containsKey("banned")) {
      banned = _json["banned"];
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("nick")) {
      nick = _json["nick"];
    }
    if (_json.containsKey("owner")) {
      owner = _json["owner"];
    }
    if (_json.containsKey("picture")) {
      picture = _json["picture"];
    }
    if (_json.containsKey("plus_url")) {
      plusUrl = _json["plus_url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (banned != null) {
      _json["banned"] = banned;
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (nick != null) {
      _json["nick"] = nick;
    }
    if (owner != null) {
      _json["owner"] = owner;
    }
    if (picture != null) {
      _json["picture"] = picture;
    }
    if (plusUrl != null) {
      _json["plus_url"] = plusUrl;
    }
    return _json;
  }
}
