
enum ProductCategory {
  beauty("beauty", "Красота"),
  fragrances("fragrances", "Ароматы"),
  furniture("furniture", "Мебель"),
  groceries("groceries", "Продукты"),
  homeDecoration("home-decoration", "Для дома"),
  kitchenAccessories("kitchen-accessories", "Для кухни"),
  laptops("laptops", "Ноутбуки"),
  mensShirts("mens-shirts", "Мужские рубашки"),
  mensShoes("mens-shoes", "Мужская обувь"),
  mensWatches("mens-watches", "Мужские часы"),
  mobileAccessories("mobile-accessories", "Аксессуары"),
  motorcycle("motorcycle", "Мотоциклы"),
  skincare("skin-care", "Уход за кожей"),
  smartphones("smartphones", "Смартфоны"),
  sportsAccessories("sports-accessories", "Спорт"),
  sunglasses("sunglasses", "Солнцезащитные очки"),
  tablets("tablets", "Планшеты"),
  tops("tops", "Топы"),
  vehicle("vehicle", "Автомобили"),
  womensBags("womens-bags", "Женские сумки"),
  womensDresses("womens-dresses", "Женские платья"),
  womensJewellery("womens-jewellery", "Украшения"),
  womensShoes("womens-shoes", "Женская обувь"),
  womensWatches("womens-watches", "Женские часы"),
  other("other", "Другие");

  const ProductCategory(this. apiValue, this.title);

  final String apiValue;
  final String title;

  static ProductCategory fromApi(String value) => values.firstWhere(
    (c) => c.apiValue == value,
    orElse: () => ProductCategory.other
  );
}
