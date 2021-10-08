class Hotel_model {

  String id;
 String hotel_name;
  String hotel_type;
  String hotel_location;
  String hotel_detail;
  String hotel_price;
  String picture;

  Hotel_model({this.id, this.hotel_name, this.hotel_type, this.hotel_location, this.hotel_detail,
    this.picture,this.hotel_price});
//
  factory Hotel_model.fromJson(Map<String, dynamic> item) {
    return Hotel_model(
      id: item['id'],
        hotel_name: item['hotel_name'],
        hotel_type: item['hotel_type'],
        hotel_location: item['hotel_location'],
        hotel_detail: item['hotel_detail'],
        hotel_price: item['hotel_detail'],
        picture: item['picture'],

    );
  }
}

/*class Hotel_model(models.Model):
    hotel_name = models.CharField(max_length=20)
    hotel_type = models.CharField(max_length=50)
    hotel_location = models.CharField(max_length=50)
    hotel_detail = models.TextField(max_length=1000)
    hotel_price = models.FloatField(default=0.0)
    picture = models.ImageField(upload_to="Hotel_Image", blank=True)*/