import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/model/ProductResult.dart';
import 'package:openfoodfacts/model/ProductImage.dart';
import 'package:openfoodfacts/utils/LanguageHelper.dart';
import 'package:openfoodfacts/utils/ProductFields.dart';
import 'package:openfoodfacts/utils/ProductQueryConfigurations.dart';
import 'package:openfoodfacts/utils/QueryType.dart';

import 'test_constants.dart';

void main() {

  group('$OpenFoodAPIClient get raw products', () {
    test('get product test 1', () async {
      String barcode = "8008698011065";
      ProductResult result = await OpenFoodAPIClient.getProductRaw(
          barcode, OpenFoodFactsLanguage.GERMAN,
          user: TestConstants.TEST_USER, queryType: QueryType.TEST);

      expect(result != null, true);
      expect(result.status, 1);
      expect(result.barcode, barcode);
      expect(result.product != null, true);
      expect(result.product.barcode, barcode);
      expect(result.product.quantity, "350g");
      expect(result.product.productNameDE, "Meisterbäckers Vital");
      expect(result.product.ingredientsTextDE.isNotEmpty, true);
      expect(result.product.ingredients != null, true);
      expect(result.product.ingredients.isNotEmpty, true);
      expect(result.product.ingredients.first.text, "Maisstärke");
      expect(result.product.selectedImages != null, true);
      expect(result.product.selectedImages.length, 15);
      expect(
          result.product.selectedImages
              .singleWhere((image) =>
                  image.field == ImageField.INGREDIENTS &&
                  image.size == ImageSize.DISPLAY &&
                  image.language == OpenFoodFactsLanguage.GERMAN)
              .url,
          "https://static.openfoodfacts.net/images/products/800/869/801/1065/ingredients_de.27.400.jpg");
      expect(result.product.images != null, true);
      expect(result.product.images.length, 20);
      expect(
          result.product.images
              .singleWhere((image) =>
                  image.field == ImageField.INGREDIENTS &&
                  image.size == ImageSize.DISPLAY &&
                  image.language == OpenFoodFactsLanguage.GERMAN)
              .rev,
          27);
      expect(result.product.labelsTags.contains("en:gluten-free"), true);
      expect(result.product.tracesTags != null, true);
      expect(result.product.tracesTags.contains("en:lupin"), true);

      expect(result.product.nutriments != null, true);

      expect(result.product.nutriments.energy, 1099.0);
      expect(result.product.nutriments.sugars, 0.9);
      expect(result.product.nutriments.salt, 1.0);
      expect(result.product.nutriments.fiber, 8.8);
      expect(result.product.nutriments.fat, 9.2);
      expect(result.product.nutriments.saturatedFat, 1.1);
      expect(result.product.nutriments.proteins, 4.5);
      expect(result.product.nutriments.novaGroup, 4);

      expect(result.product.additives.ids.isEmpty, true);

      expect(
          result.product.nutrientLevels.levels[NutrientLevels.NUTRIENT_SUGARS],
          Level.LOW);
      expect(result.product.nutrientLevels.levels[NutrientLevels.NUTRIENT_FAT],
          Level.MODERATE);
      expect(
          result.product.nutrientLevels
              .levels[NutrientLevels.NUTRIENT_SATURATED_FAT],
          Level.LOW);
      expect(result.product.nutrientLevels.levels[NutrientLevels.NUTRIENT_SALT],
          Level.MODERATE);
      expect(result.product.countries,
          "Belgique,France,Allemagne,Pays-Bas,Espagne,Suisse");
    });

    test('get product tiny twists - Rold Gold Pretzels - 16 OZ. (1 LB) 453.6g',
        () async {
      String barcode = '0028400047685';
      ProductQueryConfiguration configurations = ProductQueryConfiguration(
          barcode,
          language: OpenFoodFactsLanguage.ENGLISH,
          fields: [ProductField.ALL]);
      ProductResult result = await OpenFoodAPIClient.getProduct(configurations,
          user: TestConstants.TEST_USER, queryType: QueryType.TEST);
      expect(result != null, true);
      expect(result.status, 1);
      expect(result.barcode, barcode);
      expect(result.product != null, true);
      expect(result.product.barcode, barcode);

      expect(result.product.nutriments.carbohydratesServing != null, true);
      expect(result.product.nutriments.proteinsServing != null, true);
      expect(result.product.nutriments.saltServing != null, true);
      expect(result.product.nutriments.proteinsServing != null, true);
      expect(result.product.nutriments.fatServing != null, true);
    });

    test('get product test 2', () async {
      String barcode = "4388810057787";

      ProductResult result = await OpenFoodAPIClient.getProductRaw(
          barcode, OpenFoodFactsLanguage.GERMAN,
          user: TestConstants.TEST_USER, queryType: QueryType.TEST);

      expect(result != null, true);
      expect(result.status, 1);
      expect(result.barcode, barcode);
      expect(result.product != null, true);
      expect(result.product.barcode, barcode);

      expect(result.product.productName,
          "Natürliches Mineralwasser, Marinus-Quelle, still");
      expect(result.product.productNameDE,
          "Natürliches Mineralwasser, Marinus-Quelle, still");

      expect(result.product.nutriments != null, true);

      expect(result.product.nutriments.energy, null);
      expect(result.product.nutriments.sugars, null);
      expect(result.product.nutriments.salt, 0.0019558);
      expect(result.product.nutriments.fiber, null);
      expect(result.product.nutriments.fat, null);
      expect(result.product.nutriments.saturatedFat, null);
      expect(result.product.nutriments.proteins, null);
      expect(result.product.nutriments.novaGroup, 1);
      expect(result.product.nutriments.fatServing == null, true);
    });
  });
}
