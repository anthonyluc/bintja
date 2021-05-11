// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'bootstrap'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"
import { loadDynamicSearchText } from '../components/recipe_search';
import { removeAvatar, deleteAccount, deleteRecipe } from '../components/sweetalert2';
import { autoCloseAlert } from '../utils/autoclose_alert';
import { cookiesLauncher } from '../components/cookies_launcher';
import { lazyload } from '../utils/lazyload';

document.addEventListener('turbolinks:load', () => {
    // Reload all JS functions here after each load
    if (location.pathname == "/") {
        loadDynamicSearchText();
    }
    if (location.pathname == "/users/edit") {
        removeAvatar();
        deleteAccount();
    }
    if (window.location.href.indexOf("recipes") > -1) {
        deleteRecipe();
    }
    autoCloseAlert();
    cookiesLauncher();
    $("img").lazyload();
  });

  
 