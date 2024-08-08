class Category{
  final String id;
  final String name;
  final String imageUrl;
  final List<Category> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.subCategories});
}