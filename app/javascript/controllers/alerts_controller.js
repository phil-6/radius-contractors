import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect(){
        setTimeout(() => this.dismiss(), 5000);
    }

    dismiss () {
        const alert = this.element;
        alert.style.animation = "fade-out .3s ease";
        setTimeout(() => alert.remove(), 300);
    }
}
