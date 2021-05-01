# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tab = []
tab_ingredient_type_en = ["fruit-juices","alcoholic-drinks-beverages","baking-ingredients","beef-veal","beer","cakes-pies","candy-sweets","canned-fruit","cereal-products","cheese","cold-cuts-lunch-meat","cream-cheese","dishes-meals","fast-food","fish-seafood","fruits","herbs-spices","ice-cream","legumes","meat","milk-dairy-products","non-alcoholic-drinks-beverages","nuts-seeds","oatmeal-muesli-cereals","offal-giblets","oils-fats","pasta-noodles","pastries-breads-rolls","pizza","pork","potato-products","poultry-fowl","sauces-dressings","sausage","sliced-cheese","soda-soft-drinks","soups","spreads","tropical-exotic-fruits","vegetable-oils","vegetables","venison-game","wine","yogurt"]

tab_ingredient_type_fr = ["jus-de-fruits","boissons-alcoolisées-boissons","ingrédients-pour-la-pâtisserie","veau-bœuf","bière","gâteaux-tartes","bonbons-bonbons","fruits-en-conserve","produits-céréaliers","fromage","charcuterie-déjeuner-viande","fromage-à-la-crème","plats-repas","restauration-rapide","poisson-fruits-de-mer","fruits-fr","herbes--épices","glace","légumineuses","viande","lait-produits-laitiers","boissons-non-alcoolisées-boissons","graines-de-noix","gruau-muesli-céréales","abats-abats","huiles-graisses","pâtes-nouilles","pâtisseries-pains-petits-pains","fr_pizza","porc","produits-de-pomme-de-terre","volaille-volaille","sauces-vinaigrettes","saucisse","fromage-en-tranches","fr_soda-soft-drinks","soupes","pâtes-à-tartiner","fruits-tropicaux-exotiques","huiles-végétales","légumes","gibier-de-chevreuil","vin","yaourt", "ingredients-yaourt"]

tab_ingredient_type = [tab_ingredient_type_en, tab_ingredient_type_fr]

tab_ingredient_type.each do |t|
    t.each do |ingredient_type|
        # Récupère les données du fichier puis les affiches
        ingredients = File.read("db/seeds/my_content_#{ingredient_type}.json")
    
        eval(ingredients).each do |v|
            
            tab << v.strip
    
            if tab.count == 2
                Ingredient.create(name: tab[0], calorie: tab[1])
                tab = []
            end
        end
        tab = []
        puts "seeds/my_content_#{ingredient_type}.json terminé"
    end
end