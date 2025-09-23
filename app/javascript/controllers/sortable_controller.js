import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { put } from '@rails/request.js'


// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    group: String
  }

  connect() {
    Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      group: this.groupValue
    })
  }

  onEnd(event) {
    let sortableUpdateUrl = event.item.dataset.sortableUpdateUrl
    let sortableListId = event.to.dataset.sortableListId

    put(sortableUpdateUrl, {
      body: {
        row_order_position: event.newIndex,
        list_id: sortableListId
      }
    })
  }
}


