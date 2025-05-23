class AssetPaths {
  static const String imagePath = 'assets/images/';
  static const String placeholder = '${imagePath}placeholder.svg';
}

class CreationConstants {
  static const String mockImageUrl = AssetPaths.placeholder;
}

class Creation {
  final String uuid;
  final String name;
  final String text;
  final String image;

  Creation({
    required this.uuid,
    required this.name,
    required this.text,
    required this.image,
  });
}
