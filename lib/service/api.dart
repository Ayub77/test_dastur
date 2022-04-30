class Api {
    static String Base = '192.168.13.54:8080';
    static String apiLogin = "api/user/login";
    static String test = "api/test/get/search";
    static String alltest = "api/question/get";
    static String result = "api/result/create";


  




 static Map<String, dynamic> emptyParams(){
    Map<String, dynamic> params =  Map();
    return params;
  }
  static Map<String, dynamic> testParams(String id){
    Map<String, dynamic> params =  {
      "test_id":id
    };
    return params;
  }
}