import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['add_recipe_rate', 'add_reviews', 'add_ingredient', 'delete_ingredient', 'add_quantity_note', 'update_quantities', 'notice_note', 'recipe_group'];

    flashDiv(e) {
       return `
        <div class="alert alert-success alert-dismissible fade show m-1" role="alert">
            ${e}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>`;
    }

    closeElement(elementTarget) {
        elementTarget.classList.add('transform', 'opacity-0', 'transition', 'duration-1000');
        setTimeout(() => $(elementTarget).fadeOut(1500), 1500);
        setTimeout(() => elementTarget.innerHTML = '', 3000);
        setTimeout(() => $(elementTarget).css('display', ''), 3050);
    }

    addIngredient(){
        this.add_ingredientTarget.innerHTML = this.flashDiv('Ingredient has been added successfully.');
        this.closeElement(this.add_ingredientTarget);
    }

    deleteIngredient(){
        this.delete_ingredientTarget.innerHTML = this.flashDiv('Ingredient has been deleted successfully.');
        this.closeElement(this.delete_ingredientTarget);
    }

    addQuantityNote(){
        this.add_quantity_noteTarget.innerHTML = this.flashDiv('Note has been saved successfully.');
        this.closeElement(this.add_quantity_noteTarget);
    }

    updateQuantities(){
        this.update_quantitiesTarget.innerHTML = this.flashDiv('Update successfully.');
        this.closeElement(this.update_quantitiesTarget);
    }

    noticeNote(){
        this.notice_noteTarget.innerHTML = this.flashDiv('Notes has been saved successfully.');
        this.closeElement(this.notice_noteTarget);
    }

    recipeGroup(){
        this.recipe_groupTarget.innerHTML = this.flashDiv('Group has been changed successfully.');
        this.closeElement(this.recipe_groupTarget);
    }
    addReviews(){
        this.add_reviewsTarget.innerHTML = this.flashDiv('Review added successfully.');
        this.closeElement(this.add_reviewsTarget);
    }
    addRecipeRate(){
        this.add_recipe_rateTarget.innerHTML = this.flashDiv('Rated successfully.');
        this.closeElement(this.add_recipe_rateTarget);
    }
}