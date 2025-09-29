class LocalizationHelper {
  static final Map<String, Map<String, String>> _localizedValues = {
    // 🔹 English
    'en': {
      'title': 'CookBook',
      'search_recipe': 'Search recipe...',
      'featured': 'Featured',
      'popular_recipes': 'Popular Recipes',
      'recipes': 'Recipes',
      'shopping': 'Shopping',
      'settings': 'Settings',
      'dark_mode': 'Dark Mode',
      'notifications': 'Enable Notifications',
      'language': 'Language',
      'edit_name': 'Edit Name',
      'edit_email': 'Edit Email',
      'save': 'Save',
    },

    // 🔹 Urdu
    'ur': {
      'title': 'کوک بک',
      'search_recipe': 'کھانے کی تلاش کریں...',
      'featured': 'نمایاں',
      'popular_recipes': 'مشہور ترکیبیں',
      'recipes': 'ترکیبیں',
      'shopping': 'خریداری',
      'settings': 'ترتیبات',
      'dark_mode': 'ڈارک موڈ',
      'notifications': 'اطلاعات فعال کریں',
      'language': 'زبان',
      'edit_name': 'نام تبدیل کریں',
      'edit_email': 'ای میل تبدیل کریں',
      'save': 'محفوظ کریں',
    },

    // 🔹 French
    'fr': {
      'title': 'Livre de Cuisine',
      'search_recipe': 'Rechercher une recette...',
      'featured': 'En vedette',
      'popular_recipes': 'Recettes Populaires',
      'recipes': 'Recettes',
      'shopping': 'Achats',
      'settings': 'Paramètres',
      'dark_mode': 'Mode Sombre',
      'notifications': 'Activer les Notifications',
      'language': 'Langue',
      'edit_name': 'Modifier le Nom',
      'edit_email': 'Modifier l’Email',
      'save': 'Enregistrer',
    },

    // 🔹 Spanish
    'es': {
      'title': 'Libro de Cocina',
      'search_recipe': 'Buscar receta...',
      'featured': 'Destacado',
      'popular_recipes': 'Recetas Populares',
      'recipes': 'Recetas',
      'shopping': 'Compras',
      'settings': 'Configuraciones',
      'dark_mode': 'Modo Oscuro',
      'notifications': 'Habilitar Notificaciones',
      'language': 'Idioma',
      'edit_name': 'Editar Nombre',
      'edit_email': 'Editar Correo',
      'save': 'Guardar',
    },
  };

  static String getText(String langCode, String key) {
    return _localizedValues[langCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }
}
