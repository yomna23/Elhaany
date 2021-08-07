
class CategoryModel {

   late String catname ;

   CategoryModel(this.catname);

   CategoryModel.fromJson(Map<String, dynamic> json)
   {
       catname = json['catname'] ;


   }


   Map<String, dynamic> getMap() {
     return
       {
         'catname': catname,


       };
   }

}