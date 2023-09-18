class Music{
  String image;
  String title;
  String subTitle;
  String url;

  Music({required this.image, required this.title, required this.subTitle, required this.url});



  static List<Music> musics = [
    Music(image: 'assets/images/believer.jpg', title: 'Believer', subTitle: 'IMAGINE DRAGON', url: 'audios/believer.mp3'),
    Music(image: 'assets/images/shortwave.jpg', title: 'Shortwave', subTitle: 'RYAN GRIGDRY', url: 'audios/believer.mp3'),
    Music(image: 'assets/images/dream_on.jpg', title: 'Dream On', subTitle: 'ROGER TERRY', url: 'audios/believer.mp3'),
    Music(image: 'assets/images/origins.png', title: 'Origins', subTitle: 'IMAGINE DRAGON', url: 'audios/believer.mp3'),
    Music(image: 'assets/images/tie_me_down.png', title: 'Tie Me Down', subTitle: 'GRYFFIN', url: 'audios/believer.mp3'),
    Music(image: 'assets/images/dust.jpg', title: 'Chaff & Dust', subTitle: 'HYONNA', url: 'audios/believer.mp3'),
  ];

  static List<Music> recommended = [
    Music(image: 'assets/images/monsters.png', title: 'Monsters Go Bump', subTitle: 'ERIKA RECINOS', url: 'audios/believer.mp3'),
    Music(image: 'assets/images/moment.png', title: 'Moment Apart', subTitle: 'ODESZA', url: 'audios/believer.mp3'),
  ];
}


