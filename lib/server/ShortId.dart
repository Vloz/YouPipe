import 'dart:math';

/*
Quick port of C# => http://kvz.io/blog/2009/06/10/create-short-ids-with-php-like-youtube-or-tinyurl/
!!! NOT TESTED !!!
Wont work on js on 64bit int
*/

class ShortId
{
  static final String _PATTERN = r"^(.+)_(\d+)_(\d+)$|^(.+)_(\d+)$|^([^_]{1,9})$";
  static RegExp _regex = new RegExp(_PATTERN);

  static bool isShortId(String id){
    return _regex.hasMatch(id);
  }

  static String getPipeBaseId(String id){
    return _regex.allMatches(id).first.group(1);
  }

  static String getMajorVers(String id){
    return _regex.allMatches(id).first.group(2);
  }

  static String getMinorVers(String id){
    return _regex.allMatches(id).first.group(3);
  }

  static final String Alphabet = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  static double _BcPow(double a, double b) => pow(a,b).floor() as double;

  static int Decode(String value, [int pad = 0])
  {
    value = ReverseString(value);
    var len = value.length - 1;
    int result = 0;

    for (int t = len; t >= 0; t--)
    {
      int bcp = _BcPow(Alphabet.length as double, len - t) as int;
      result += Alphabet.indexOf(value[t]) * bcp;
    }

    if (pad > 0)
    {
      result -= _BcPow(Alphabet.length as double, pad as double) as int;
    }

    return result;
  }

  static String Encode(int value, [int pad = 0])
  {
    var result = "";

    if (pad > 0)
    {
      value += _BcPow(Alphabet.length as double, pad as double) as int;
    }

    for (var t = (value != 0 ? (log(value) / log(Alphabet.length)).floor() : 0); t >= 0; t--)
    {
      var bcp = _BcPow(Alphabet.length as double, t);
      var a = ((value as double) / (bcp as double)).floor() % Alphabet.length;
      result += Alphabet[a];
      value  = value - (a * bcp);
    }

    return ReverseString(result);
  }


  static String ReverseString(String s) {
    var length = s.length;
    var charCodes = new List(length);
    for(var index = 0; index < length; index++) {
      charCodes[index] = s.codeUnitAt(length - index - 1);
    }

    return new String.fromCharCodes(charCodes);
  }
}