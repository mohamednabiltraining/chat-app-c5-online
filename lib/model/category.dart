class Category{
  static String musicId = 'music';
  static String moviesId = 'movies';
  static String sportsId = 'sports';
  String id;
  late String image;
  late String title;
  Category(this.id,this.title,this.image);
  Category.fromId(this.id){
    image = 'assets/images/$id.png';
    title= id;
    // if(id==moviesId){
    //   image = 'assets/images/movies.png';
    //   title= 'movies';
    // }else if (id == sportsId){
    //   image = 'assets/images/sports.png';
    //   title= 'movies';
    // }
  }
  static List<Category> getCategories(){
    return [
      Category.fromId(sportsId),
      Category.fromId(moviesId),
      Category.fromId(musicId),
    ];
  }
}