library server_api;

import 'package:endpoints/endpoints.dart';
import 'package:gcloud/db.dart';
import 'package:appengine/appengine.dart';
import 'dart:async';
import 'ShortId.dart';
import 'credentials.dart';

part 'server_api_messages.dart';
part 'ndb_models.dart';

DatastoreDB get db => context.services.db;

@ApiClass(
    name: 'youpipe',
    version: 'v1',
    description: 'YouPipe Backend',
    allowedClientIds: const [
      Credentials.secred_ID,
      API_EXPLORER_CLIENT_ID
    ]
)
class YoupipeServerApi {

  @ApiMethod(
      path: 'user',
      name: 'user.sign',
      method: 'POST',
      description: 'User sign using google+ profile informations.'
  )
  Future<User> userSignin(SigninRequest req, ApiUser gUser) async {
    var q = db.query(User)..filter('owner =', gUser.id);
    List<User> existing = await q.run().toList();
    if(!existing.isEmpty)
      return existing.first;
    else{
      var newUser =new User()
        ..owner = gUser.id
        ..email = gUser.email
        ..nick = req.nick
        ..picture = req.picture
        ..plus_url = req.plus_url;
      return context.services.db.commit(inserts: [newUser]).then((_) => newUser);
    }
  }

  @ApiMethod(
      path: 'pipe/{id}',
      name: 'pipe.get',
      method: 'GET',
      description: 'Return a pipe version from it\'s short_id with this form {Header_id}_{Major vers n°}_{Minor vers n°}.'+
      'If no version number specified, the last authorized version is returned'
  )
  Future<Pipe> pipeGet(IdRequest req, [ApiUser gUser]) async {
    if(!ShortId.isShortId(req.id))
      throw new BadRequestError('Wrong id form.');
    String base_id = ShortId.getPipeBaseId(req.id);
    var q = db.query(PipeHeader)..filter('active =',true)..filter('short_id =', base_id);
    PipeHeader h = await q.run().first;
    if(h == null)
      throw new NotFoundError('There is no pipe with the id:'+base_id);
    if(gUser!= null && gUser.id == h.owner)
      q = db.query(PipeBody)..order('short_id')..filter('active =',true)..filter('short_id <=',req.id);
    else
      q = db.query(PipeBody)..order('short_id')..filter('active =',true)..filter('public =',true)..filter('short_id <=',req.id);
    PipeBody b = await q.run().first;
    if(b==null)
      throw new NotFoundError('Can\'t find any version with this id:'+req.id);
    else
      return new Pipe(h,b);
  }


  @ApiMethod(
      path: 'source/{full_path}',
      name: 'source.get',
      method: 'GET',
      description: 'Return a pipe source from it\'s path. Path has this form {Version short id}/{path in the project}'
  )
  Future<Source> sourceGet(SourceRequest req, [ApiUser gUser]) async {
    var q = db.query(PipeBody)..filter('active =',true)..filter('short_id =', req.full_path.split('/').first);
    PipeBody v  = await q.run().first;
    if(v == null || !v.public && gUser != null && v.owner != gUser.id)
      throw new NotFoundError('Can\'t find source with the path:'+req.full_path);
    else{
      q  = db.query(Source)..filter('full_path =',req.full_path);
      Source s = await q.run().first;
      return s;
    }
  }
/*
  //TODO: Remove, not supposed to be queried allone
  @ApiMethod(
      name: 'pipe.get',
      path: 'pipe/{id}',
      method: 'GET',
      description: 'Return last public information about this pipe.'
  )
  Future<Pipe> pipeGet(IdRequest req, [ApiUser gUser]) {
    var query = context.services.db.query(Pipe);
    query.filter('id',req.id);
    return query.run().first;
  }


  //TODO: Implement security (public private acess)
  @ApiMethod(
      name: 'source.get',
      path: 'source/{full_path}',
      method: 'GET',
      description: 'Get the source from its full path.'
  )
  Future<Source> sourceGet(FullPathRequest req, [ApiUser gUser]) {
    var query = context.services.db.query(Source);
    query.filter('full_path',req.full_path);
    return query.run().first;
  }*/
/*  @ApiMethod(
  name: 'version.sources',
  path: 'pipe/{pipe_short_id}/version/{version_number}/sources',
  method: 'GET',
  description: 'Return sources for this version.'
  )
  Future<ListResponse<Source>> sourcesGet(ShortIdRequest siR, VersionNumberRequest vnR , [ApiUser gUser]){
    var query = context.services.db.query(Source);
    query.filter('id',req.id);
  }*/


}