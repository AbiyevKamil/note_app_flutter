class NoteModel {
  int? id;
  late String title;
  late String body;
  late DateTime date;

  NoteModel(
      {this.id, required this.title, required this.body, required this.date});

  Map<String, dynamic> toMap() {
    var map = {'title': title, 'body': body, 'creation_date': date.toString()};

    // birseyi anlamaq lazimdiki biz db-da id-ni primary key kimi tanimlamisiq,
    // primary key ise her objecte biri olmalidi, yeni bir id-den 2 yerde ola bilmez.
    // indi bu idni increment eliyen db-nin ozudu yeni ilk defe biz NoteModel yaradib
    // db-ya yazanda id vermemeliyik cunki o oz daxilinde en axirinci id hansi olubsa
    // bir sonraki idni goturur ama senin sehvin o idiki sen NoteModel yaradanda
    // id olaraq hemise 1 verirdin ona gore de birden cox NoteModel yaratmaq olmurdu.
    // indi burda ilk defe obyekt yaranib dbya save olunmaq isdiyende bizdeki id = null olur
    // biz NoteModeli idsiz yazdiririq, db oz daxilinde id yazdiracaq, sora biz bu obyekti cekende
    // goturub assign edirik (NoteModel.fromMap-a bax!) onnan sora bu biz nese deyisiklik edib
    // tezden dbya yazdirmaq isdesek(update) onda asagidaki if isdemiyecek cunki artiq idmiz var
    if (id != null) {
      map['id'] = id.toString();
    }
    return map;
  }

  // mapdeki uygun fieldleri goturub ona uygun yeni NoteModel obyekti yaradib geri qaytaririrq
  // bu named constructor olaraq gedir
  NoteModel.fromMap(Map<String, dynamic> map)
      : title = map['title'].toString(),
        body = map['body'].toString(),
        id = int.parse(map['id'].toString()),
        date = DateTime.parse(map['creation_date'].toString());
}
