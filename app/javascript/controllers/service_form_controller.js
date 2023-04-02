import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slots", "template"]
  
  addSlot(event) {
    event.preventDefault();
  
    const content = this.templateTarget.innerHTML.replace(/TEMPLATE/g, Date.now());
    this.slotsTarget.insertAdjacentHTML("beforeend", content);
  }

  removeSlot(event) {
    event.preventDefault()

    event.target.closest(".js-slot-form").remove()
  }
}