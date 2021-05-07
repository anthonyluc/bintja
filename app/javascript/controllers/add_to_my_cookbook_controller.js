import { Controller } from "stimulus";
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = ['main_content', 'id', 'btn'];

  addRecipe() {
    this.btnTarget.disabled = true;
    this.btnTarget.value = "Recipe added to your cookbook";
    fetchWithToken("/recipes", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({recipe: { id: this.idTarget.value }})
    })
    .then(response => response.text())
    .then((data) => {
      
    });
  }
}