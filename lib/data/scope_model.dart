import 'package:scopemodelproject/config/config.dart';
import 'package:scopemodelproject/models/models.dart';
import 'package:scopemodelproject/services/api.dart';
import 'package:scoped_model/scoped_model.dart';
  
class NewsModel extends Model{
  List<News> _newsList = [];
  List<News> get newsList => _newsList;
  List<dynamic> ids = [];
  bool loading = false;
  bool get isLoading => loading;

  getNews(i) async {
    _newsList.add(News.fromJson(
        await Api.getRequest(config["BASE_URL"] + "item/${ids[i]}.json")));
        print(config["BASE_URL"] + "item/${ids[i]}.json");
    print(_newsList);
  }

  setIsLoading(bool status) {
    loading = status;
  }

  getId() async {
    ids = await Api.getRequest(config["BASE_URL"] + "topstories.json");
    print(ids);
    for (int i = 0; i < 30; i++) {
      await getNews(i);
    }

    setIsLoading(true);
    notifyListeners();
  }

}