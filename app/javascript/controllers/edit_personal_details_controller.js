import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="edit-personal-details"
export default class extends Controller {
  connect() {}

  initialize() {
    this.element.setAttribute("data-action", "edit-personal-details#showModal");
  }

  showModal(event) {
    event.preventDefault();
    this.url = this.element.getAttribute("href");
    fetch(this.url, {
      headers: {
        Accept: "text/vmd.turbo-stream.html",
      },
    })
      .then((response) => response.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }
}
