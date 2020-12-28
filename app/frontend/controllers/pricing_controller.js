import { Controller } from "stimulus"
import Rails from '@rails/ujs'

export default class extends Controller {
  static targets = [ ]

  addToCart(e) {
    e.preventDefault();
    const productId = this.data.get('id');

    Rails.ajax({
      url: `/cart/add_item/${productId}`,
      type: 'post',
      success: resp => {
        // 通知右上角演戲
        const event = new CustomEvent('abc', {
          detail: {
            count: resp.count,
            total_price: resp.total_price
          }
        })
        document.dispatchEvent(event)
        // console.log(resp);
      },
      error: err => {
        console.log(err);
      }
    })

    // const productId = e.currentTarget.dataset
  }
}
