import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { put } from '@rails/request.js'


// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this)
    })
  }

  onEnd(event) {
    console.log(event.newIndex)
    console.log(event.item.dataset.sortableId)
    put(`/lists/${event.item.dataset.sortableId}/sort`, {
      body: {
        row_order_position: event.newIndex
      }
    })
  }
}


