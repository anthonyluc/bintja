import Typed from 'typed.js';

const loadDynamicSearchText = () => {
  new Typed('#home #search_query', {
    strings: ["Beef brocoli", "Pizza 4 fromages", "Flammekueche", "Gâteau au chocolat", "Pasta a la boloñesa", "Bean burger", "Strawberry Rhubarb Pie", "Crepe", "Smoothie fraise kiwi", "watermelon ice cream", "Bugnes", "Steak marinade", "Hamburger", "Grilled asparagus", "Mexican recipes", "Chinese recipes", "Pain au chocolat", "Biscuit", "Forêt noire", "Korean bbq", "BBQ sauce", "Chicken", "Salad corn", "Grilled Shrimp", "Fajita", "Sushi", "Maki", "Bacon", "Grilled Pineapple", "fish", "Bruschetta", "Octopus", "Kebab", "Ribs", "Bread", "Garlic Naan", "Hot dog", "Buns", "Tortillas", "Muffins", "Rolls", "Blueberry Lemon Loaf", "Cake", "Churros", "Chinese buns", "Naan", "Donuts", "Cinnamon Rolls", "Challah", "Bretzel", "Salmon Cardamomo Arce", "Salsa ahumadora", "Espinaca Japonesa", "Salsa de Pollo Teriyaki Salteado", "Patatas dulces sureñas", "Coles de Bruselas balsámicas", "Beef Stroganoff", "Spinach Lasagna", "Mac and cheese", "Caesar salad", "Vietnamese chicken salad", "Tex Mex", "Yakitori", "English Quiche Lorraine", "Mushroom Quich", "Broccoli Quiche", "Vegan Tacos", "Fish Tacos", "Mexican Breakfast", "Calzone", "Savory Pies", "Falafel", "Shakshuka", "Manicotti", "Pesto", "Veggie Burger", "Ravioli", "Turkish Eggs", "Greek Lemon Chicken and Potato Bake", "Spongy Japanese Cheesecake", "Tres Leches", "Okinawan-Style Pad Thai", "Wrap", "Spring rolls", "Indian Chicken curry", "Spanish Flan", "Strawberry Mascarpone Tart", "Classic Mimosa", "Cocktail", "Mojito", "Shamrock Shake", "Mango Lassi", "Paleo Hot Cocoa", "Mai Tai Cocktail", "Lemon Yogurt Cake", "Hummingbird Cake", "Eggnog Pound Cake", "Crumble Pie", "Tapioca Pudding", "Peach Melba", "Piped Raspberry Mousse", "Tarte au Citron", "Fish Chowder", "Corn Chowder", "Potato Soup", "Potatoes", "Eggs Benedict", "Crispy Baked Chicken Wings", "Banana cake", "Chicken Cordon bleu", "Stromboli"],
    typeSpeed: 70,
    loop: true,
    attr: 'value',
    bindInputFocusEvents: true,
    shuffle: true,
    backSpeed: 10
  });
}

export { loadDynamicSearchText };