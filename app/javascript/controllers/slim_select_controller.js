import { Controller } from "@hotwired/stimulus";
import SlimSelect from "slim-select";

export default class extends Controller {
    connect() {
        const limit = this.data.get("limit")
        const placeholderText = this.data.get("placeholder")
        const searchText = this.data.get("no-results")
        const closeOnSelect = this.single
        const allowDeselect = !this.element.required

        this.select = new SlimSelect({
            select: this.element,
            settings: {
                closeOnSelect,
                allowDeselect,
                limit,
                placeholderText,
                searchText
            },
        })
    }

    get single() {
        return !this.element.multiple
    }
    get multi() {
        return this.element.multiple
    }

    disconnect() {
        if (this.select) {
            this.select.destroy()
        }
    }
}
