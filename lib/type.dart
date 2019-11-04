class WebSiteFavorite {
  var id, nomSite, logo;

  WebSiteFavorite({this.id, this.nomSite, this.logo});

  @override
  String toString() {
    return '{id: $id, nomSite:$nomSite}';
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'NomSite': nomSite,
      'logo': logo,
    };
  }



}



class New {
  var author, title, desc, img, nbLike, time;

  New({this.author, this.title, this.desc, this.img, this.nbLike, this.time});

  @override
  String toString() {
    return '$author' '$title' '$desc' '$img' '$nbLike' '$time';
  }

  Map<String, dynamic> toMap() {
    /*        author: maps[i]['author'],
        title: maps[i]['Title'],
        desc: maps[i]['Desc'],
        img: maps[i]['Image'],
        nbLike: maps[i]['nbLike'],
        time: maps[i]['Time'],
     */
    return {
      'author': author,
      'Title':title,
      'Desc':desc,
      'Image':img,
      'nbLike':nbLike,
      'Time':time,
    };
  }



}