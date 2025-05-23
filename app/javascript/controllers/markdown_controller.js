import { Controller } from "@hotwired/stimulus"
import { marked } from "marked"

// Connects to data-controller="markdown"
export default class extends Controller {
  static targets = ["content"]

  connect() {
    this.contentTarget.innerHTML = marked.parse(this.contentTarget.innerHTML)
  }
}
