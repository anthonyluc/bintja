import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['ingredient'];

    destroy() {
      this.ingredientTarget.nextElementSibling.remove(); 
      this.ingredientTarget.remove();
    }
}