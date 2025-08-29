import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../favorites_provider.dart';
import '../settings_provider.dart';
import '../localization_helper.dart';
import 'recipe_page.dart';
import 'favorites_page.dart';
import 'settings_page.dart';
import 'add_recipe_page.dart';
import 'browse_category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All";

  final List<Map<String, dynamic>> recipes = [
    {
      "title": "Chicken Tikka",
      "time": "45m",
      "rating": 5,
      "image": "lib/assets/images/chicken_tikka.jpg",
      "category": "Dinner",
      "description":
      "Chicken Tikka is a popular South Asian dish made with marinated chicken pieces grilled to perfection.",
      "ingredients": [
        "500g chicken (boneless)",
        "1 cup yogurt",
        "2 tbsp lemon juice",
        "2 tbsp ginger-garlic paste",
        "2 tbsp tikka masala",
        "Salt to taste",
      ],
      "instructions": [
        "1) Wash and clean 500g chicken pieces, cut into medium-sized chunks, and pat dry.\n"

            "2) In a large bowl, add ½ cup yogurt, 1 tablespoon ginger-garlic paste, and 1 tablespoon lemon juice.\n"

            "3) Mix in spices: 1 teaspoon red chili powder, ½ teaspoon turmeric, 1 teaspoon cumin powder, 1 teaspoon coriander powder, ½ teaspoon garam masala, and salt to taste.\n"

            "4) Coat the chicken pieces in the marinade, making sure each piece is well covered.\n"

            "5) Cover the bowl and refrigerate for at least 2 hours (overnight for best flavor).\n"

            "6) Preheat the oven to 200°C (390°F) or prepare a grill on medium-high heat.\n"

            "7) Thread the marinated chicken pieces onto skewers (optional) for grilling.\n"

            "8) Place the chicken on a greased baking tray or directly on the grill.\n"

            "9) Cook for 20–25 minutes, turning occasionally, until the chicken is cooked through and slightly charred at the edges.\n"

            "10) Brush with a little butter or oil midway for extra flavor and moisture.\n"

            "11) Remove from the oven or grill, squeeze some lemon juice over the hot chicken.\n"

            "12) Serve immediately with naan, salad, and mint chutney.\n"
      ]
    },
    {
      "title": "Veggie Omelette",
      "time": "12m",
      "rating": 4,
      "image": "lib/assets/images/veggie_omelette.jpg",
      "category": "Breakfast",
      "description":
      "A healthy omelette loaded with fresh vegetables, perfect for a quick breakfast.",
      "ingredients": [
        "3 eggs",
        "1 onion (chopped)",
        "1 tomato (chopped)",
        "1 green chili",
        "Salt and pepper",
        "1 tbsp oil"
      ],
      "instructions": [
        "1) Crack 3 eggs into a mixing bowl and add ¼ teaspoon salt and ¼ teaspoon black pepper.\n"

            "2) Beat the eggs well using a fork or whisk until light and frothy.\n"

            "3) Finely chop 1 small onion, 1 tomato, and 1 green chili.\n"

            "4) Heat 1 tablespoon oil or butter in a non-stick frying pan on medium flame.\n"

            "5) Add the chopped onion, tomato, and green chili to the pan and sauté for 2–3 minutes until slightly softened.\n"

            "6) Lower the flame and pour the beaten eggs evenly over the vegetables.\n"

            "7) Spread the mixture gently with a spatula and let it cook on low heat until the edges set.\n"

            "8) Carefully flip the omelette to the other side and cook for another 1–2 minutes until fully set and golden.\n"

            "9) Transfer to a plate and serve warm with bread, paratha, or toast.\n"
      ]
    },
    {
      "title": "Chicken Pulao",
      "time": "60m",
      "rating": 5,
      "image": "lib/assets/images/chicken_pulao.jpg",
      "category": "Lunch",
      "description":
      "Aromatic rice cooked with chicken and spices, a traditional lunch recipe.",
      "ingredients": [
        "500g chicken",
        "2 cups basmati rice",
        "2 onions (sliced)",
        "2 tbsp ginger-garlic paste",
        "4 cups chicken stock",
        "Whole spices (cinnamon, cardamom, cloves)",
        "Salt to taste"
      ],
      "instructions": [
        "1) Wash and soak 2 cups basmati rice in water for 20–30 minutes, then drain.\n"

            "2) Heat 3 tablespoons oil or ghee in a deep pot.\n"

            "3) Add 2 large sliced onions and fry on medium flame until golden brown.\n"

            "4) Stir in 1 tablespoon ginger-garlic paste and sauté for 1–2 minutes until fragrant.\n"

            "5) Add 500g chicken pieces and cook until they change color and lightly brown.\n"

            "6) Add 2 chopped tomatoes (optional) and cook until soft.\n"

            "7) Mix in spices: 1 teaspoon cumin, 1 teaspoon coriander powder, ½ teaspoon turmeric, 1 teaspoon chili powder, 2–3 whole cloves, 2 cardamoms, 1 cinnamon stick, and salt to taste.\n"

            "8) Pour in 4 cups chicken stock or water, stir well, and bring to a boil.\n"

            "9) Add the soaked and drained rice into the pot, spreading it evenly over the chicken.\n"

            "10) Stir gently once, then cover with a tight lid and cook on medium flame until most of the liquid is absorbed.\n"

            "11) Reduce the flame to low and steam (dum) for another 10–15 minutes until rice is fluffy and chicken is tender.\n"

            "12) Turn off the heat, let it rest covered for 5 minutes, then fluff the rice gently with a fork.\n"

            "13) Serve hot with raita, salad, or chutney.\n"
      ]
    },
    {
      "title": "Chocolate Cake",
      "time": "90m",
      "rating": 5,
      "image": "lib/assets/images/chocolate_cake.jpg",
      "category": "Dessert",
      "description": "Rich and moist chocolate cake perfect for celebrations.",
      "ingredients": [
        "2 cups flour",
        "1 cup cocoa powder",
        "1.5 cups sugar",
        "3 eggs",
        "1 cup milk",
        "1/2 cup butter",
        "1 tbsp baking powder"
      ],
      "instructions": [
        "1) In a large mixing bowl, add 1½ cups flour, ½ cup cocoa powder, 1 cup sugar, and 1 teaspoon baking powder. Mix the dry ingredients well.\n"

            "2) In another bowl, crack 2 eggs and whisk them lightly.\n"

            "3) Add 1 cup milk and ½ cup melted butter to the eggs, whisking until smooth and well combined.\n"

            "4) Gradually pour the wet mixture into the dry ingredients while stirring gently.\n"

            "5) Mix until a smooth, lump-free batter forms. Do not overmix, as it can make the cake dense.\n"

            "6) Grease a cake pan with butter or line it with parchment paper to prevent sticking.\n"

            "7) Pour the batter evenly into the prepared cake pan, spreading it with a spatula if needed.\n"

            "8) Preheat the oven to 180°C (350°F) for 10 minutes.\n"

            "9) Place the pan in the oven and bake at 180°C for 35–40 minutes, or until a toothpick inserted in the center comes out clean.\n"

            "10) Remove the cake from the oven and allow it to cool in the pan for 10 minutes.\n"

            "11) Gently remove the cake from the pan and place it on a wire rack to cool completely.\n"

            "12) Slice and serve plain, or decorate with frosting, chocolate syrup, or powdered sugar as desired.\n"
      ]
    },
    {
      "title": "Pizza",
      "time": "40m",
      "rating": 5,
      "image": "lib/assets/images/pizza.jpg",
      "category": "Dinner",
      "description": "Cheesy homemade pizza with your favorite toppings.",
      "ingredients": [
        "2 cups flour",
        "1 tbsp yeast",
        "1 cup warm water",
        "1/2 cup pizza sauce",
        "1 cup mozzarella cheese",
        "Toppings of choice (chicken, veggies, olives)"
      ],
      "instructions": [
        "1) In a large bowl, add 2 cups flour, 1 teaspoon instant yeast, 1 teaspoon sugar, and ½ teaspoon salt. Mix the dry ingredients well.\n"

            "2) Gradually add ¾ cup warm water and 1 tablespoon olive oil. Knead until a smooth and elastic dough forms.\n"

            "3) Cover the bowl with a damp cloth and let the dough rest in a warm place for 1 hour, or until it doubles in size.\n"

            "4) Once risen, punch down the dough to release air and divide it into desired portions.\n"

            "5) Roll out one portion of dough on a floured surface into a round base about 10–12 inches wide.\n"

            "6) Place the rolled dough on a greased baking tray or pizza pan.\n"

            "7) Spread 3–4 tablespoons of pizza sauce evenly over the base, leaving a small border around the edges.\n"

            "8) Add your favorite toppings such as sliced onions, bell peppers, mushrooms, olives, or cooked chicken.\n"

            "9) Sprinkle generously with shredded mozzarella cheese over the toppings.\n"

            "10) Preheat the oven to 200°C (390°F) for 10 minutes.\n"

            "11) Bake the pizza at 200°C for 15–20 minutes, or until the crust is golden and the cheese is melted and bubbly.\n"

            "12) Remove from the oven, let it cool for 2 minutes, then slice and serve hot.\n"
      ]
    },
    {
      "title": "French Fries",
      "time": "20m",
      "rating": 4,
      "image": "lib/assets/images/fries.jpg",
      "category": "Snacks",
      "description": "Crispy golden French fries, perfect evening snack.",
      "ingredients": [
        "3 potatoes",
        "Oil for frying",
        "Salt to taste",
      ],
      "instructions": [
        "1) Wash 4–5 medium potatoes thoroughly to remove dirt, then peel off the skin.\n"

            "2) Cut the potatoes lengthwise into even strips about ¼ inch thick for uniform cooking.\n"

            "3) Place the potato strips in a bowl of cold water and soak for 20–30 minutes to remove excess starch.\n"

            "4) Drain the water and pat the potatoes completely dry with a clean kitchen towel.\n"

            "5) Heat enough oil in a deep pan or fryer on medium flame until hot (about 170°C / 340°F).\n"

            "6) Fry the potato strips in small batches for 3–4 minutes until slightly soft but not browned. Remove and drain on paper towels.\n"

            "7) Increase the oil temperature to high (about 190°C / 375°F).\n"

            "8) Fry the potatoes a second time in small batches until golden and crispy.\n"

            "9) Remove the fries from the oil and place them on paper towels to absorb extra oil.\n"

            "10) Sprinkle salt evenly over the fries while they are still hot.\n"

            "11) Serve immediately with ketchup, mayonnaise, or your favorite dip.\n"
      ]
    },


    {
      "title": "Chicken Biryani",
      "time": "75m",
      "rating": 5,
      "image": "lib/assets/images/biryani.jpg",
      "category": "Lunch",
      "description":
      "Aromatic rice layered with spicy chicken curry, the king of South Asian dishes.",
      "ingredients": [
        "500g chicken",
        "3 cups basmati rice",
        "2 onions (sliced)",
        "2 tomatoes",
        "1 cup yogurt",
        "Spices (garam masala, cumin, coriander)",
        "Salt to taste"
      ],
      "instructions": [
        "1) Wash and clean 500g chicken pieces, then set aside.\n"

            "2) Heat 3 tablespoons oil or ghee in a deep pan, add 2 sliced onions, and cook until golden brown.\n"

            "3) Add 2 chopped tomatoes and cook until soft and mushy.\n"

            "4) Stir in 1 tablespoon ginger-garlic paste, then add spices: 1 teaspoon turmeric, 1 teaspoon chili powder, 2 teaspoons coriander powder, 1 teaspoon garam masala, and salt to taste.\n"

            "5) Add the chicken pieces and mix well, cooking for 8–10 minutes until they change color and release juices.\n"

            "6) Lower the flame, add ½ cup whisked yogurt, and cook until the chicken is tender and the curry thickens.\n"

            "7) In another pot, boil water with 2–3 cloves, 2–3 green cardamoms, 1 bay leaf, and 1 small cinnamon stick.\n"

            "8) Add 2 cups soaked basmati rice to the boiling water and cook until 70% done (parboiled). Drain and keep aside.\n"

            "9) In a heavy-bottomed pan, spread a thin layer of rice at the bottom, then add a layer of chicken curry.\n"

            "10) Repeat the layers until all rice and curry are used, finishing with rice on top.\n"

            "11) Sprinkle a few saffron strands soaked in warm milk (optional) and drizzle 1 tablespoon ghee over the rice for aroma.\n"

            "12) Cover the pot with a tight lid, place on low flame, and steam (dum) for 20 minutes.\n"

            "13) Turn off the heat and let it rest for 5 minutes before opening.\n"

            "14) Serve the hot biryani with fresh raita or salad.\n"
      ]
    },
    {
      "title": "Pancakes",
      "time": "25m",
      "rating": 4,
      "image": "lib/assets/images/pancakes.jpg",
      "category": "Breakfast",
      "description":
      "Fluffy pancakes perfect for breakfast with syrup or fruits.",
      "ingredients": [
        "1 cup flour",
        "2 tbsp sugar",
        "1 egg",
        "1 cup milk",
        "1 tsp baking powder",
        "Butter for frying"
      ],
      "instructions": [
        "1) In a large mixing bowl, add 1 cup flour, 2 tablespoons sugar, and 1 teaspoon baking powder. Mix the dry ingredients well.\n"

            "2) Crack 1 egg into a separate bowl, add 1 cup milk, and whisk until combined.\n"

            "3) Slowly pour the wet mixture into the dry ingredients while whisking to avoid lumps.\n"

            "4) Mix until a smooth, thick batter forms. Do not overmix, as this can make the pancakes dense.\n"

            "5) Heat a non-stick frying pan or skillet on medium flame and lightly grease it with butter or oil.\n"

            "6) Pour a small ladleful of batter onto the pan, spreading slightly into a round shape.\n"

            "7) Cook for 2–3 minutes until bubbles form on the surface and the edges look set.\n"

            "8) Flip the pancake carefully with a spatula and cook the other side for another 1–2 minutes until golden brown.\n"

            "9) Transfer the pancake to a plate and repeat the process with the remaining batter.\n"

            "10) Stack the pancakes, drizzle with honey or maple syrup, and serve warm.\n"
      ]
    },
    {
      "title": "Fruit Salad",
      "time": "10m",
      "rating": 5,
      "image": "lib/assets/images/fruit_salad.jpg",
      "category": "Dessert",
      "description":
      "A refreshing mix of seasonal fruits with cream and honey.",
      "ingredients": [
        "1 apple",
        "1 banana",
        "1 mango",
        "1 cup grapes",
        "1 cup cream",
        "2 tbsp honey"
      ],
      "instructions": [
        "1) Wash all fruits thoroughly under running water to remove dirt and impurities.\n"

            "2) Peel fruits like mango, apple, banana, or kiwi if needed, and remove seeds or cores.\n"

            "3) Chop all fruits into small bite-sized cubes of even size for easy mixing and serving.\n"

            "4) Place the chopped fruits in a large mixing bowl and set aside.\n"

            "5) In a separate small bowl, add 1 cup fresh cream and 2 tablespoons honey.\n"

            "6) Whisk the cream and honey together until smooth and slightly thickened.\n"

            "7) Pour the cream-honey mixture over the chopped fruits.\n"

            "8) Gently toss everything together using a spoon so the fruits are evenly coated.\n"

            "9) Cover the bowl with plastic wrap or a lid and refrigerate for at least 30 minutes.\n"

            "10) Serve the chilled fruit salad in small bowls or glasses, garnished with nuts or mint leaves if desired.\n"
      ]
    },
    {
      "title": "Cheese Burger",
      "time": "30m",
      "rating": 5,
      "image": "lib/assets/images/burger.jpg",
      "category": "Dinner",
      "description":
      "Juicy homemade beef or chicken burger with melted cheese.",
      "ingredients": [
        "2 burger buns",
        "200g beef patty",
        "2 cheese slices",
        "Lettuce, tomato, onion",
        "Ketchup & mayo"
      ],
      "instructions": [
        "1) Take 200g ground beef, season with salt and black pepper, and shape into a round patty about 1 inch thick.\n"

            "2) Preheat a grill or frying pan on medium-high heat, lightly brush with oil to prevent sticking.\n"

            "3) Place the beef patty on the grill and cook for 4–5 minutes on one side without pressing it down.\n"

            "4) Flip the patty and cook the other side for 4–5 minutes, or until fully cooked and juices run clear.\n"

            "5) In the last minute of cooking, place a cheese slice on the patty and let it melt slightly.\n"

            "6) Slice burger buns in half and lightly toast them on the grill or pan until golden brown.\n"

            "7) Spread mayonnaise on the bottom bun and ketchup on the top bun.\n"

            "8) Place a fresh lettuce leaf on the bottom bun, followed by a slice of tomato.\n"

            "9) Add the grilled beef patty with melted cheese on top of the vegetables.\n"

            "10) Cover with the top bun, press gently, and serve hot with fries or a cold drink.\n"
      ]
    },
    {
      "title": "Samosa",
      "time": "35m",
      "rating": 4,
      "image": "lib/assets/images/samosa.jpg",
      "category": "Snacks",
      "description":
      "Crispy fried snack filled with spiced potatoes or meat.",
      "ingredients": [
        "2 cups flour",
        "2 boiled potatoes",
        "1 onion",
        "Spices (cumin, coriander, chili)",
        "Oil for frying"
      ],
      "instructions": [
        "1) Place 2 cups flour in a bowl, add ½ teaspoon salt and 2 tablespoons oil, then mix until crumbly.\n"

            "2) Add water gradually, kneading into a smooth but firm dough. It should not be sticky or too soft.\n"

            "3) Cover the dough with a damp cloth and let it rest for 20–30 minutes to soften.\n"

            "4) Boil 3–4 medium potatoes until soft, then peel and mash them while warm.\n"

            "5) Heat 2 tablespoons oil in a pan, add 1 teaspoon cumin seeds, and let them crackle.\n"

            "6) Add 1 finely chopped onion, cook until golden brown and fragrant.\n"

            "7) Mix in ½ teaspoon turmeric, ½ teaspoon chili powder, 1 teaspoon coriander powder, ½ teaspoon garam masala, and salt to taste.\n"

            "8) Add mashed potatoes to the pan, mix well with the spices, and cook for 2–3 minutes. Remove from heat and let filling cool.\n"

            "9) Divide the dough into lemon-sized balls, roll each ball into a thin circle of about 6 inches.\n"

            "10) Cut each circle in half, fold one half into a cone shape, sealing the edge with a little water.\n"

            "11) Fill the cone with 2–3 spoonfuls of potato mixture, then press and seal the open edge tightly with water.\n"

            "12) Heat oil in a deep pan on medium flame. Fry samosas in small batches until golden brown and crispy on all sides, then drain on paper towels.\n"
      ]
    },
    {
      "title": "Grilled Sandwich",
      "time": "15m",
      "rating": 4,
      "image": "lib/assets/images/grilled_sandwich.jpg",
      "category": "Snacks",
      "description":
      "Crispy grilled sandwich with vegetables and cheese filling.",
      "ingredients": [
        "4 bread slices",
        "1 onion (chopped)",
        "1 tomato (sliced)",
        "1 cucumber (sliced)",
        "2 cheese slices",
        "Butter for grilling"
      ],
      "instructions": [
        "1) Take 4 slices of bread and spread a thin, even layer of butter on one side of each slice.\n"

            "2) Place 2 slices buttered-side down on a clean surface or plate.\n"

            "3) Layer sliced vegetables such as cucumber, tomato, onion, and capsicum evenly over the bread.\n"

            "4) Add a few slices of cheese or grated cheese on top of the vegetables.\n"

            "5) Sprinkle a little salt and black pepper (optional) for extra flavor.\n"

            "6) Cover with the remaining bread slices, keeping the buttered side on top.\n"

            "7) Preheat a toaster, sandwich maker, or non-stick pan on medium heat.\n"

            "8) Place the sandwich inside the toaster or on the pan, pressing gently.\n"

            "9) Cook for 2–3 minutes per side (or until golden brown and crispy if using a pan).\n"

            "10) Remove the sandwich, cut it diagonally into halves or quarters.\n"

            "11) Serve hot with ketchup, mayonnaise, or chutney.\n"
      ]
    },
    {
      "title": "Mango Smoothie",
      "time": "8m",
      "rating": 5,
      "image": "lib/assets/images/mango_smoothie.jpg",
      "category": "Dessert",
      "description":
      "Refreshing mango smoothie perfect for summer days.",
      "ingredients": [
        "2 ripe mangoes",
        "1 cup milk",
        "1 tbsp honey",
        "Ice cubes"
      ],
      "instructions": [
        "1) Wash 2 ripe mangoes, peel off the skin, and cut the flesh away from the seed.\n"

            "2) Chop the mango flesh into small cubes for easy blending.\n"

            "3) Place the mango cubes into a blender jar.\n"

            "4) Add 2 cups chilled milk to the blender.\n"

            "5) Add 2 tablespoons honey or sugar (adjust to taste).\n"

            "6) Add a few ice cubes for extra chill and thickness.\n"

            "7) Blend the mixture on high speed until smooth and creamy.\n"

            "8) Check the consistency; if too thick, add a little more milk and blend again.\n"

            "9) Pour the milkshake into tall glasses.\n"

            "10) Garnish with mango slices or chopped nuts if desired.\n"

            "11) Serve immediately while chilled.\n"
      ]
    },
    {
      "title": "Chapli Kebab",
      "time": "30m",
      "rating": 5,
      "image": "lib/assets/images/chapli_kebab.jpg",
      "category": "Lunch",
      "description":
      "Traditional spicy minced meat kebabs from Khyber Pakhtunkhwa.",
      "ingredients": [
        "500g minced meat",
        "1 onion (chopped)",
        "2 green chilies",
        "1 tbsp coriander seeds",
        "Salt and spices",
        "Oil for frying"
      ],
      "instructions": [
        "1) Take 500g minced meat (beef, mutton, or chicken) in a large mixing bowl.\n"

            "2) Finely chop 1 medium onion and 2–3 green chilies, then add them to the meat.\n"

            "3) Add spices: 1 teaspoon red chili powder, 1 teaspoon coriander seeds (crushed), ½ teaspoon cumin powder, ½ teaspoon garam masala, and salt to taste.\n"

            "4) Mix in 2 tablespoons chopped fresh coriander leaves and 1 tablespoon ginger-garlic paste.\n"

            "5) Add 1–2 tablespoons gram flour or corn flour to help bind the mixture.\n"

            "6) Combine everything well using your hands until evenly mixed.\n"

            "7) Divide the mixture into equal portions and shape each into flat round patties.\n"

            "8) Heat oil in a frying pan on medium flame.\n"

            "9) Place the patties in the hot oil and fry without moving them for 3–4 minutes.\n"

            "10) Flip carefully and fry the other side for another 3–4 minutes until crispy and cooked through.\n"

            "11) Remove the kebabs from the oil and place them on paper towels to drain excess oil.\n"

            "12) Serve hot with naan, salad, and green chutney.\n"
      ]
    },
    {
      "title": "Milkshake",
      "time": "7m",
      "rating": 4,
      "image": "lib/assets/images/milkshake.jpg",
      "category": "Breakfast",
      "description":
      "Quick and healthy milkshake with banana and milk.",
      "ingredients": [
        "1 banana",
        "1 cup milk",
        "1 tbsp sugar",
        "Ice cubes"
      ],
      "instructions": [
        "1) Take 2 ripe bananas, peel off the skin, and cut them into small slices.\n"

            "2) Place the banana slices into a blender jar.\n"

            "3) Add 2 cups chilled milk to the blender.\n"

            "4) Add 2 tablespoons sugar or honey, adjusting sweetness as desired.\n"

            "5) Add a few ice cubes for extra chill and creaminess.\n"

            "6) Blend the mixture on high speed until smooth and frothy.\n"

            "7) Check the consistency; if too thick, add a little more milk and blend again.\n"

            "8) Pour the milkshake into tall glasses.\n"

            "9) Garnish with banana slices or a sprinkle of cinnamon (optional).\n"

            "10) Serve immediately while chilled.\n"
      ]
    },
    {
      "title": "Shami Kebab",
      "time": "40m",
      "rating": 5,
      "image": "lib/assets/images/shami_kebab.jpg",
      "category": "Lunch",
      "description":
      "Delicious Pakistani kebabs made with minced meat and lentils.",
      "ingredients": [
        "500g minced beef",
        "1/2 cup chana dal (split chickpeas)",
        "1 onion (chopped)",
        "2 green chilies",
        "1 tsp ginger garlic paste",
        "Salt and spices",
        "Oil for frying"
      ],
      "instructions": [
        "1) Take 250g minced beef and ½ cup chana dal (split Bengal gram), wash and soak the dal for 1 hour.\n"

            "2) In a deep pot, add the soaked dal, minced beef, 1 chopped onion, 2–3 green chilies, and 1 tablespoon ginger-garlic paste.\n"

            "3) Add whole spices: 2–3 cloves, 2–3 black peppercorns, 1 cinnamon stick, 2 cardamoms, 1 bay leaf, and salt to taste.\n"

            "4) Pour in about 2 cups water and cook on medium flame until the meat and dal are soft and the water is fully absorbed.\n"

            "5) Remove the cinnamon stick, bay leaf, and cardamoms, then let the mixture cool slightly.\n"

            "6) Transfer the mixture to a grinder and grind into a thick, smooth paste without adding water.\n"

            "7) Add 1 beaten egg, 2 tablespoons chopped fresh coriander, and mix well into the paste.\n"

            "8) Divide the mixture into equal portions and shape into flat round kebabs.\n"

            "9) Heat oil in a frying pan over medium flame.\n"

            "10) Shallow fry the kebabs in batches for 3–4 minutes on each side until golden brown and crispy.\n"

            "11) Remove and drain excess oil on paper towels.\n"

            "12) Serve hot with chutney, salad, or naan.\n"
      ]
    },
    {
      "title": "Club Sandwich",
      "time": "20m",
      "rating": 4,
      "image": "lib/assets/images/club_sandwich.jpg",
      "category": "Snacks",
      "description":
      "Layered sandwich with chicken, egg, and vegetables.",
      "ingredients": [
        "6 bread slices",
        "1 boiled egg (sliced)",
        "1/2 cup shredded chicken",
        "1 tomato (sliced)",
        "Lettuce leaves",
        "Mayonnaise and ketchup"
      ],
      "instructions": [
        "1) Take 3–4 fresh bread slices and lightly toast them until golden brown.\n"

            "2) Spread mayonnaise evenly on one side of each bread slice.\n"

            "3) Place shredded or sliced cooked chicken on the first slice.\n"

            "4) Add a layer of sliced boiled egg on top of the chicken.\n"

            "5) Place fresh tomato slices evenly over the egg.\n"

            "6) Add a crisp lettuce leaf for freshness and crunch.\n"

            "7) Cover with a second slice of bread, spread with mayonnaise on both sides.\n"

            "8) Repeat layering with chicken, egg, tomato, and lettuce if making a triple-decker sandwich.\n"

            "9) Place the final slice of bread on top, mayonnaise side facing down.\n"

            "10) Press the sandwich gently so the layers hold together.\n"

            "11) Use a sharp knife to cut the sandwich diagonally into halves or quarters.\n"

            "12) Insert toothpicks if needed to keep the layers in place.\n"

            "13) Serve on a plate with fries, ketchup, or coleslaw.\n"
      ]
    },
    {
      "title": "Kheer",
      "time": "50m",
      "rating": 5,
      "image": "lib/assets/images/kheer.jpg",
      "category": "Dessert",
      "description":
      "Traditional rice pudding cooked in milk and sugar.",
      "ingredients": [
        "1/2 cup rice",
        "1 liter milk",
        "1/2 cup sugar",
        "Cardamom powder",
        "Dry fruits for garnish"
      ],
      "instructions": [
        "1) Wash ½ cup basmati rice thoroughly and soak it in water for 20–30 minutes.\n"

            "2) In a heavy-bottomed pot, bring 1 liter of full cream milk to a boil on medium flame.\n"

            "3) Drain the soaked rice and add it to the boiling milk.\n"

            "4) Stir continuously to prevent the rice from sticking to the bottom.\n"

            "5) Cook the rice in milk on low flame until the grains turn soft and the mixture starts to thicken.\n"

            "6) Add ½ cup sugar (adjust to taste) and stir until it dissolves completely.\n"

            "7) Mix in ½ teaspoon cardamom powder for aroma and flavor.\n"

            "8) Continue cooking until the kheer reaches a creamy, thick consistency.\n"

            "9) Turn off the heat and let it cool slightly.\n"

            "10) Garnish with chopped almonds, pistachios, or cashews.\n"

            "11) Refrigerate for a few hours if serving chilled, or serve warm as desired.\n"
      ]
    },
    {
      "title": "Paratha",
      "time": "15m",
      "rating": 4,
      "image": "lib/assets/images/paratha.jpg",
      "category": "Breakfast",
      "description":
      "Flaky and crispy Pakistani flatbread cooked with ghee.",
      "ingredients": [
        "2 cups wheat flour",
        "1/2 tsp salt",
        "Water as needed",
        "Ghee or oil for frying"
      ],
      "instructions": [
    "1) Place 2 cups wheat flour in a mixing bowl and add ½ teaspoon salt.\n"

    "2) Gradually add water, kneading into a soft and smooth dough.\n"

    "3) Drizzle 1 teaspoon oil over the dough, cover with a damp cloth, and let it rest for 20–30 minutes.\n"

    "4) After resting, divide the dough into equal lemon-sized balls.\n"

    "5) Lightly flour a surface and roll each ball into a flat, round disc (about 6–7 inches wide).\n"

    "6) Heat a tawa (flat pan) on medium flame until hot.\n"

    "7) Place the rolled paratha on the hot tawa and cook for 30–40 seconds until light bubbles appear.\n"

    "8) Flip it over and spread 1 teaspoon ghee or oil on the surface.\n"

    "9) Flip again, pressing gently with a spatula so it puffs up and turns golden brown.\n"

    "10) Cook both sides until evenly golden and slightly crisp.\n"

    "11) Remove from tawa and keep warm in a covered container.\n"

    "12) Serve hot with yogurt, pickle, or curry of your choice.\n"
    ]
    },
    {
      "title": "Chicken Karahi",
      "time": "45m",
      "rating": 5,
      "image": "lib/assets/images/chicken_karahi.jpg",
      "category": "Dinner",
      "description":
      "Spicy and flavorful chicken curry cooked in a wok (karahi).",
      "ingredients": [
        "500g chicken",
        "2 onions (chopped)",
        "3 tomatoes (chopped)",
        "2 green chilies",
        "1 tsp ginger garlic paste",
        "Spices and salt",
        "Oil"
      ],
      "instructions": [
      "1) Heat 4 tablespoons oil in a karahi (wok) on medium flame.\n"

      "2) Add 2 medium onions, thinly sliced, and fry until they turn light golden brown.\n"

    "3) Stir in 1 tablespoon ginger-garlic paste and sauté for 1–2 minutes until fragrant.\n"

    "4) Add 500 g chicken pieces and cook on medium-high heat until they turn golden on all sides.\n"

    "5) Chop 3 medium tomatoes and add them to the karahi.\n"

    "6) Cook while stirring until the tomatoes soften and release their juices.\n"

    "7) Add 1 teaspoon red chili powder, ½ teaspoon turmeric powder, 1 teaspoon coriander powder, and salt to taste.\n"

    "8) Stir well and cook on medium flame until the oil separates from the masala and the gravy thickens.\n"

    "9) Add a splash of water if needed to prevent burning and help the chicken cook through.\n"

    "10) Once chicken is tender and the gravy has the desired consistency, reduce the flame.\n"

    "11) Garnish with 2 sliced green chilies and freshly chopped coriander leaves.\n"

    "12) Serve hot with naan, roti, or rice.\n"
      ]
    },
    {
      "title": "Mutton Korma",
      "time": "1h 10m",
      "rating": 5,
      "image": "lib/assets/images/mutton_korma.jpg",
      "category": "Dinner",
      "description": "Rich and creamy curry made with tender mutton and aromatic spices.",
      "ingredients": [
        "500g mutton",
        "2 onions (fried and crushed)",
        "1 cup yogurt",
        "1 tbsp ginger garlic paste",
        "Spices and salt",
        "Oil"
      ],
      "instructions": [
        "1) Heat 4 tablespoons oil in a heavy-bottomed pot on medium flame.\n"

            "2) Add 1 tablespoon ginger-garlic paste and sauté for 1–2 minutes until fragrant.\n"

            "3) Add 500 g mutton pieces and fry on medium-high heat until they turn light brown on all sides.\n"

            "4) In a separate bowl, whisk ½ cup yogurt with 1 teaspoon red chili powder, ½ teaspoon turmeric, 1 teaspoon coriander powder, 1 teaspoon garam masala, and salt to taste.\n"

            "5) Pour the yogurt-spice mixture into the pot and mix well with the mutton.\n"

            "6) Cook on medium flame, stirring continuously, until the yogurt blends in and the oil begins to separate from the masala.\n"

            "7) Add 1–2 cups water depending on desired gravy consistency, then cover the pot with a lid.\n"

            "8) Lower the heat and simmer for 40–50 minutes (or until mutton is fully tender), stirring occasionally.\n"

            "9) Once the meat is cooked and the gravy thickens, check seasoning and adjust salt or spices if needed.\n"

            "10) Garnish with freshly chopped coriander and green chilies.\n"

            "11) Serve hot with naan, roti, or steamed rice.\n"
      ]
    },
    {
      "title": "Palak Paneer",
      "time": "40m",
      "rating": 4,
      "image": "lib/assets/images/palak_paneer.jpg",
      "category": "Vegetarian",
      "description": "Creamy spinach curry with cubes of soft paneer.",
      "ingredients": [
        "250g paneer",
        "2 cups spinach (boiled and blended)",
        "1 onion (chopped)",
        "2 tomatoes (chopped)",
        "1 tsp ginger garlic paste",
        "Spices and salt",
        "Oil"
      ],
      "instructions": [
        "1) Heat 3 tablespoons oil or ghee in a pan on medium flame.\n"

            "2) Add 1 large onion, finely chopped, and fry until golden brown.\n"

            "3) Stir in 1 tablespoon ginger-garlic paste and sauté for 1–2 minutes until fragrant.\n"

            "4) Add 2 medium tomatoes, finely chopped (or puréed), and cook until soft and mushy.\n"

            "5) Mix in 1 teaspoon red chili powder, ½ teaspoon turmeric powder, 1 teaspoon coriander powder, and salt to taste. Cook until the oil separates from the masala.\n"

            "6) Add 2 cups spinach puree (boil spinach leaves, then blend into a smooth paste) and mix well with the masala.\n"

            "7) Cook the spinach gravy on low flame for 8–10 minutes, stirring occasionally.\n"

            "8) Add 200 g paneer cubes (you can lightly fry them in ghee before adding for extra flavor) into the spinach gravy.\n"

            "9) Simmer for 5 minutes so the paneer absorbs the flavors.\n"

            "10) Optional: Add 2 tablespoons cream or butter for a rich texture and taste.\n"

            "11) Garnish with a drizzle of cream or a few drops of lemon juice.\n"

            "12) Serve hot with naan, roti, or jeera rice.\n"
      ]
    },
    {
      "title": "Seekh Kebabs",
      "time": "50m",
      "rating": 5,
      "image": "lib/assets/images/seekh_kebab.jpg",
      "category": "Snacks",
      "description": "Juicy minced meat kebabs grilled on skewers.",
      "ingredients": [
        "500g minced beef/lamb",
        "1 onion (finely chopped)",
        "2 green chilies",
        "Fresh coriander",
        "1 tsp ginger garlic paste",
        "Spices and salt"
      ],
      "instructions": [
        "1) Place 500 g minced meat (beef, chicken, or mutton) in a mixing bowl.\n"

            "2) Add 1 finely chopped onion, 2 green chilies, 2 tablespoons fresh coriander, and 1 tablespoon mint leaves.\n"

            "3) Mix in 1 tablespoon ginger-garlic paste, 1 teaspoon red chili powder, 1 teaspoon coriander powder, ½ teaspoon cumin powder, ½ teaspoon garam masala, and salt to taste.\n"

            "4) Crack 1 egg into the mixture and add 2 tablespoons breadcrumbs for binding. Mix everything thoroughly using your hands until well combined.\n"

            "5) Grease your hands with oil, take a portion of the mixture, and shape it evenly around metal or wooden skewers to form long kebabs.\n"

            "6) Preheat a grill, tandoor, or flat pan (tawa). Lightly grease with oil or butter.\n"

            "7) Place the kebabs on the grill or pan, cook on medium heat, turning occasionally, until golden brown and fully cooked (about 10–15 minutes).\n"

            "8) For a smoky flavor, place a small piece of hot charcoal in a bowl, add a few drops of oil, cover the kebabs, and let them absorb the smoke for 2 minutes.\n"

            "9) Remove from skewers carefully and serve hot with mint chutney, salad, and naan.\n"
      ]
    },
    {
      "title": "Halwa Puri",
      "time": "1h",
      "rating": 4,
      "image": "lib/assets/images/halwa_puri.jpg",
      "category": "Breakfast",
      "description": "Traditional Pakistani breakfast with semolina halwa, puris, and chana curry.",
      "ingredients": [
        "2 cups semolina",
        "Sugar and ghee",
        "Chana curry",
        "Flour for puris",
        "Oil"
      ],
      "instructions": [
        "1) Heat 4 tablespoons ghee in a heavy-bottom pan. Add 1 cup semolina (sooji) and roast on medium flame, stirring continuously until it turns golden and aromatic.\n"

            "2) In a separate pot, boil 2 cups water with ½ cup sugar and 2–3 crushed cardamom pods. Once sugar dissolves, slowly pour this syrup into the roasted semolina while stirring to avoid lumps.\n"

            "3) Cook on low flame until the mixture thickens and leaves the sides of the pan. Add 1 tablespoon chopped almonds or cashews (optional). Set halwa aside, keeping it warm.\n"

            "4) To make puri dough, place 2 cups wheat flour in a bowl, add ½ teaspoon salt and 1 tablespoon oil. Mix well, then gradually add water and knead into a soft, smooth dough. Cover and rest for 20 minutes.\n"

            "5) Divide dough into small lemon-sized balls. Roll each ball into a small round disc (about 4–5 inches wide).\n"

            "6) Heat oil in a deep frying pan. Fry each puri one at a time, gently pressing with a slotted spoon so it puffs up. Cook until golden on both sides, then remove and drain on paper towels.\n"

            "7) For spicy chana curry, soak 1 cup chickpeas overnight. Boil until tender, then cook with 2 chopped onions, 2 chopped tomatoes, 1 tablespoon ginger-garlic paste, 1 teaspoon chili powder, ½ teaspoon turmeric, 1 teaspoon coriander powder, and salt to taste. Simmer until curry thickens.\n"

            "8) Serve hot puris with warm sooji halwa and spicy chana curry for a complete meal.\n"
      ]
    },
    {
      "title": "Fried Fish",
      "time": "35m",
      "rating": 5,
      "image": "lib/assets/images/fried_fish.jpg",
      "category": "Snacks",
      "description": "Crispy fried fish marinated in spices.",
      "ingredients": [
        "500g fish fillets",
        "2 tbsp lemon juice",
        "Spices and salt",
        "Gram flour",
        "Oil for frying"
      ],
      "instructions": [
        "1) Clean 500 g fish fillets or pieces, wash well, and pat dry with a kitchen towel.\n"

            "2) In a bowl, add 2 tablespoons lemon juice, 1 teaspoon ginger-garlic paste, 1 teaspoon red chili powder, ½ teaspoon turmeric, 1 teaspoon coriander powder, ½ teaspoon cumin powder, and salt to taste. Mix well to form a marinade.\n"

            "3) Rub the marinade evenly over the fish pieces. Cover and let it rest for 30 minutes to 1 hour so the flavors absorb.\n"

            "4) Prepare a batter by mixing 1 cup gram flour (besan) with ½ teaspoon red chili powder, ½ teaspoon turmeric, ½ teaspoon carom seeds (ajwain), and a pinch of salt. Add water gradually to form a thick, smooth batter.\n"

            "5) Heat oil in a deep frying pan on medium flame. Dip each marinated fish piece into the gram flour batter, ensuring it is well coated.\n"

            "6) Gently slide the coated fish into hot oil and fry in small batches. Cook until golden brown and crispy on both sides (about 4–5 minutes per side).\n"

            "7) Remove fried fish onto paper towels to drain excess oil.\n"

            "8) Serve hot with mint chutney, lemon wedges, and onion slices.\n"
      ]
    },
    {
      "title": "Chicken White Karahi",
      "time": "50m",
      "rating": 5,
      "image": "lib/assets/images/white_karahi.jpg",
      "category": "Dinner",
      "description": "Creamy chicken karahi made with yogurt and cream.",
      "ingredients": [
        "500g chicken",
        "1 cup yogurt",
        "1/2 cup cream",
        "2 green chilies",
        "1 tsp ginger garlic paste",
        "Spices and salt",
        "Oil"
      ],
      "instructions": [
        "1) Take 500 g chicken (bone-in or boneless) and wash it thoroughly. Pat dry with a kitchen towel.\n"

            "2) Heat 3 tablespoons oil or ghee in a pan on medium flame. Add 1 tablespoon ginger-garlic paste and fry until fragrant (about 1 minute).\n"

            "3) Add the chicken pieces to the pan and fry for 6–8 minutes, stirring occasionally, until they turn light golden brown.\n"

            "4) In a small bowl, whisk together ½ cup plain yogurt with 1 teaspoon red chili powder, ½ teaspoon turmeric, 1 teaspoon coriander powder, ½ teaspoon cumin powder, ½ teaspoon garam masala, and salt to taste.\n"

            "5) Add this yogurt-spice mixture to the chicken. Cook on medium heat, stirring continuously, until the oil starts to separate from the masala (about 8–10 minutes).\n"

            "6) Lower the heat and add ½ cup fresh cream along with 3–4 slit green chilies. Mix gently to combine.\n"

            "7) Cover and simmer on low heat for 5–7 minutes until the chicken is fully cooked and the gravy turns creamy.\n"

            "8) Garnish with fresh coriander leaves and serve hot with naan, roti, or steamed rice.\n"
      ]
    },
    {
      "title": "Aloo Gobi",
      "time": "40m",
      "rating": 4,
      "image": "lib/assets/images/aloo_gobi.jpg",
      "category": "Vegetarian",
      "description": "Simple curry made with potatoes and cauliflower.",
      "ingredients": [
        "2 potatoes (chopped)",
        "1 cauliflower (chopped)",
        "2 tomatoes (chopped)",
        "1 onion (chopped)",
        "Spices and salt",
        "Oil"
      ],
      "instructions": [
        "1) Heat 3 tablespoons oil in a pan or wok (karahi) on medium flame. Add 2 medium onions, thinly sliced, and fry until golden brown and slightly crispy.\n"

            "2) Add 2 medium potatoes (peeled and cut into cubes) and 2 cups cauliflower florets. Stir-fry for 3–4 minutes so the vegetables get lightly coated with oil.\n"

            "3) Add 2 medium tomatoes (finely chopped) along with 1 teaspoon ginger-garlic paste. Cook for 2–3 minutes until tomatoes soften.\n"

            "4) Mix in the spices: 1 teaspoon red chili powder, ½ teaspoon turmeric, 1 teaspoon coriander powder, ½ teaspoon cumin powder, and salt to taste. Stir well to coat the vegetables evenly.\n"

            "5) Sprinkle ¼ cup water, cover the pan with a lid, and cook on low heat for 12–15 minutes, stirring occasionally, until the potatoes and cauliflower are tender but not mushy.\n"

            "6) Remove the lid and cook on high heat for 2–3 minutes to evaporate excess moisture, letting the masala cling to the vegetables.\n"

            "7) Garnish with fresh coriander leaves and serve hot with roti, naan, or paratha.\n"
      ]
    },
    {
      "title": "Nihari",
      "time": "6h",
      "rating": 5,
      "image": "lib/assets/images/nihari.jpg",
      "category": "Dinner",
      "description": "Slow-cooked beef stew with aromatic spices.",
      "ingredients": [
        "1 kg beef shank",
        "2 onions (fried and crushed)",
        "2 tbsp nihari masala",
        "1 tbsp ginger garlic paste",
        "Flour for thickening",
        "Oil"
      ],
      "instructions": [
        "1) Heat ½ cup oil or ghee in a large heavy-bottomed pot. Add 2 large onions (thinly sliced) and fry on medium heat until they turn golden brown. Add 2 tablespoons ginger-garlic paste and sauté for 1–2 minutes until fragrant.\n"

            "2) Add 1 kg beef (shank or stew-cut pieces with bone) to the pot. Fry on medium-high heat for 8–10 minutes until the meat changes color and is lightly browned.\n"

            "3) Add 2–3 tablespoons Nihari masala (store-bought or homemade) along with salt to taste. Stir well so the beef is coated in the spices.\n"

            "4) Pour in about 7–8 cups of water. Bring it to a boil, then reduce the heat to very low. Cover and let it simmer gently for 6 hours, stirring occasionally, until the meat becomes tender and the broth develops a rich flavor.\n"

            "5) To thicken: In a small bowl, mix 2 tablespoons wheat flour (atta) with ½ cup water to form a smooth paste. Slowly add this paste into the pot while stirring continuously to avoid lumps. Simmer for another 15–20 minutes until the curry thickens.\n"

            "6) Adjust seasoning if needed, then turn off the heat. Garnish with fresh coriander, sliced ginger, green chilies, and a squeeze of lemon.\n"

            "7) Serve hot with naan or khameeri roti for the authentic taste.\n"
      ]
    },
    {
      "title": "Falooda",
      "time": "25m",
      "rating": 4,
      "image": "lib/assets/images/falooda.jpg",
      "category": "Dessert",
      "description": "Refreshing dessert drink made with milk, vermicelli, basil seeds and ice cream.",
      "ingredients": [
        "2 cups milk",
        "1/2 cup vermicelli",
        "2 tbsp basil seeds (soaked)",
        "Rose syrup",
        "Vanilla ice cream"
      ],
      "instructions": [
        "1) In a saucepan, add 1 cup roasted vermicelli to 3 cups boiling milk. Cook on medium heat for 7–8 minutes until the vermicelli softens. Add 2 tablespoons sugar and stir well. Let it cool completely."

            "2) In a small bowl, soak 2 tablespoons basil seeds (sabja/tukhmalanga) in ½ cup water for 15–20 minutes until they swell and become gelatinous. Keep aside."

            "3) To assemble: Take a tall glass and add 2 tablespoons rose syrup at the bottom. Then add 2–3 tablespoons soaked basil seeds, followed by 3–4 tablespoons cooked vermicelli."

            "4) Pour in ½ cup chilled milk. Add a scoop of vanilla or kulfi ice cream on top. Optionally, garnish with chopped nuts and jelly cubes."

            "5) Serve immediately, chilled with a straw and spoon."
      ]
    },
    {
      "title": "Lassi",
      "time": "10m",
      "rating": 4,
      "image": "lib/assets/images/lassi.jpg",
      "category": "Beverage",
      "description": "Traditional yogurt-based refreshing drink.",
      "ingredients": [
        "2 cups yogurt",
        "1/2 cup sugar",
        "1 cup chilled water",
        "Ice cubes"
      ],
      "instructions": [
        "1) Place 1 cup chilled yogurt in a blender. Add 3 tablespoons sugar (adjust to taste) and ½ cup cold water."

            "2) Blend the mixture for 2–3 minutes until smooth and frothy. The consistency should be slightly thick but drinkable."

            "3) Add 4–5 ice cubes into serving glasses to keep it chilled."

            "4) Pour the lassi into the glasses, garnish with a pinch of cardamom powder or chopped nuts if desired."

            "5) Serve immediately, cold and refreshing."
      ]
    }
  ];

  List<Map<String, dynamic>> getFilteredRecipes() {
    if (selectedCategory == "All") return recipes;
    return recipes.where((r) => r["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final lang = settings.languageCode;
    final filteredRecipes = getFilteredRecipes();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("CookBook",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(recipes),
              );
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),

      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.purple),
              child: Row(
                children: const [
                  Icon(Icons.menu_book, color: Colors.white, size: 32),
                  SizedBox(width: 10),
                  Text("CookBook Menu",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add, color: Colors.white),
              title: const Text("Add Recipe",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddRecipePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.category, color: Colors.white),
              title: const Text("Browse by Category",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BrowseCategoryPage()),
                );
              },
            ),
          ],
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                icon: const Icon(Icons.search, color: Colors.white),
                hintText: LocalizationHelper.getText(lang, 'search_recipe'),
                hintStyle: const TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              onSubmitted: (query) {
                showSearch(
                  context: context,
                  delegate: RecipeSearchDelegate(recipes),
                  query: query,
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategory("All"),
                const SizedBox(width: 10),
                _buildCategory("Breakfast"),
                const SizedBox(width: 10),
                _buildCategory("Lunch"),
                const SizedBox(width: 10),
                _buildCategory("Dinner"),
                const SizedBox(width: 10),
                _buildCategory("Dessert"),
                const SizedBox(width: 10),
                _buildCategory("Snacks"),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Featured
          Text(
            LocalizationHelper.getText(lang, 'featured'),
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "lib/assets/images/featured_banner.jpg",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),

          // Popular recipes
          Text(
            LocalizationHelper.getText(lang, 'popular_recipes'),
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredRecipes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return _buildRecipeCard(filteredRecipes[index], context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String text) {
    final selected = selectedCategory == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.purple : Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe, BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RecipePage(recipe: recipe)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Image full show karegi
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      recipe["image"],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () {
                        favoritesProvider.toggleFavorite(recipe);
                      },
                      child: Icon(
                        favoritesProvider.isFavorite(recipe)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favoritesProvider.isFavorite(recipe)
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text + Stars
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe["title"],
                      style:
                      const TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                recipe["rating"] = index + 1;
                              });
                            },
                            child: Icon(
                              Icons.star,
                              size: 16,
                              color: index < recipe["rating"]
                                  ? Colors.yellow
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.timer,
                          color: Colors.orange, size: 14),
                      Text(recipe["time"],
                          style: const TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// ✅ Search Delegate
class RecipeSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> recipes;

  RecipeSearchDelegate(this.recipes);

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear, color: Colors.white),
      onPressed: () => query = '',
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.orangeAccent),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
    final results = recipes
        .where((recipe) =>
        recipe["title"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final recipe = results[index];
        return ListTile(
          title:
          Text(recipe["title"], style: const TextStyle(color: Colors.white)),
          subtitle: Text("⏱ ${recipe["time"]}",
              style: const TextStyle(color: Colors.white70)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RecipePage(recipe: recipe)),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = recipes
        .where((recipe) =>
        recipe["title"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final recipe = suggestions[index];
        return ListTile(
          title:
          Text(recipe["title"], style: const TextStyle(color: Colors.white)),
          onTap: () {
            query = recipe["title"];
            showResults(context);
          },
        );
      },
    );
  }
}
