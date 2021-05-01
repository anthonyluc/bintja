import { Controller } from "stimulus";
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = ['ingredients', 'video_id', 'quantity', 'unity', 'name', 'btn'];

  clear() {
    this.quantityTarget.value = '';
    this.unityTarget.value = '';
    this.nameTarget.value = '';
    this.btnTarget.removeAttribute("disabled");
  }

  add() {
    this.btnTarget.disabled = true;
    const tbody = this.ingredientsTarget;
    fetchWithToken("/ingredients", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ingredient: { video_id: this.video_idTarget.value, name: this.nameTarget.value, quantity: { quantity: this.quantityTarget.value, unity: this.unityTarget.value} }})
    })
    .then(response => response.json())
    .then((data) => {
      const ingredient = `
      <tr data-controller="destroy-ingredient" data-destroy-ingredient-target="ingredient">
        <td>          
          <a data-action="click->destroy-ingredient#destroy click->flash#deleteIngredient" rel="nofollow" data-method="delete" href="/recipes/${data.added.recipe}/quantities/${data.added.quantity.id}">
            <i class="fas fa-trash-alt"></i>
          </a>
        </td>
        <td>
          <input class="input_resized" type="text" value="${data.added.quantity.quantity}" name="recipe[quantities_attributes][${data.added.counter}][quantity]" id="recipe_quantities_attributes_${data.added.counter}_quantity">
        </td>
        <td colspan="2">
          <input class="input_resized" type="text" value="${data.added.quantity.unity}" name="recipe[quantities_attributes][${data.added.counter}][unity]" id="recipe_quantities_attributes_${data.added.counter}_unity">
        </td>         
        <td colspan="3">
          <input class="input_resized" type="text" value="${data.added.ingredient.name}" name="recipe[quantities_attributes][${data.added.counter}][ingredient_attributes][name]" id="recipe_quantities_attributes_${data.added.counter}_ingredient_attributes_name">
        </td>
        <td colspan="2">
          <input disabled="disabled" class="input_resized" type="text" value="${data.added.ingredient.calorie}" name="recipe[quantities_attributes][${data.added.counter}][ingredient_attributes][calorie]" id="recipe_quantities_attributes_${data.added.counter}_ingredient_attributes_calorie">
        </td>
        <input type="hidden" value="${data.added.ingredient.id}" name="recipe[quantities_attributes][${data.added.counter}][ingredient_attributes][id]" id="recipe_quantities_attributes_${data.added.counter}_ingredient_attributes_id">
        <td>
          <label class="custom-checkbox" for="recipe_quantities_attributes_${data.added.counter}_add_shopping_list">
            <input name="recipe[quantities_attributes][${data.added.counter}][add_shopping_list]" type="hidden" value="0"><input class="input_resized" type="checkbox" value="1" name="recipe[quantities_attributes][${data.added.counter}][add_shopping_list]" id="recipe_quantities_attributes_${data.added.counter}_add_shopping_list">  
            <i class="fa fa-fw fa fa-bell-o unchecked"></i>
            <i class="fas fa-shopping-cart checked"></i>                  
          </label>
        </td>
      </tr>
      <input type="hidden" value="${data.added.quantity.id}" name="recipe[quantities_attributes][${data.added.counter}][id]" id="recipe_quantities_attributes_${data.added.counter}_id"></input>`;
      tbody.insertAdjacentHTML("beforeend", ingredient);
      this.clear();
      this.quantityTarget.focus();
    });
  }
}