import { Controller } from "stimulus";
import Swal from 'sweetalert2';

export default class extends Controller {
  static targets = ['add_recipe_rate', 'add_recipe', 'add_reviews', 'add_ingredient', 'delete_ingredient', 'add_quantity_note', 'update_quantities', 'notice_note', 'recipe_group', 'get_recipe'];

    initSweetalert(message) {
        Swal.fire({
            toast: true,
            icon: 'success',
            title: message,
            animation: true,
            position: 'bottom-right',
            showConfirmButton: false,
            timer: 1500,
            timerProgressBar: true,
            didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        })
    }

    addIngredient(){
        this.initSweetalert('Ingredient has been added successfully.');
    }

    deleteIngredient(){
        this.initSweetalert('Ingredient has been deleted successfully.');
    }

    addQuantityNote(){
        this.initSweetalert('Updated successfully.');
    }

    updateQuantities(){
        this.initSweetalert('Updated successfully.');
    }

    noticeNote(){
        this.initSweetalert('Notes has been saved successfully.');
    }

    recipeGroup(){
        this.initSweetalert('Group has been changed successfully.');
    }
    addReviews(){
        this.initSweetalert('Review added successfully.');
        this.btn_reviewsTarget.removeAttribute("disabled");
    }
    addRecipe(){
        this.initSweetalert('Recipe successfully added to your cookbook.');
    }
    addRecipeRate(){
        this.initSweetalert('Rated successfully.');
    }
    getRecipe(){
        this.initSweetalert('Recipe copied successfully.');
    }
}