import { Controller } from "stimulus";
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = ['comment', 'btn', 'index_reviews', 'url', 'avatar'];

  clearReview() {
    this.btnTarget.removeAttribute("disabled");
  }

  addReview(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    this.btnTarget.disabled = true;

    if (this.commentTarget.value != ''){
      const index_reviews = this.index_reviewsTarget;
      fetchWithToken("/reviews", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify({review: { comment: this.commentTarget.value, url: this.urlTarget.value }})
      })
      .then(response => response.json())
      .then((data) => {
        const review = `
          <div class="comment">
              <div class="comment_left">
                  <a href="/users/${data.nickname}">
                          <img class="avatar" src="${this.avatarTarget.src}">
                  </a>
              </div>
              <div class="comment_right">
                  <div class="comment_from">
                      <b><a href="/users/${data.nickname}">${data.nickname}</a></b> <span class="time_ago">just now</span>
                  </div>
                  <div class="comment_content">
                      ${this.commentTarget.value}
                  </div>
              </div>
          </div>
        `;
        index_reviews.insertAdjacentHTML("afterbegin", review);
        this.commentTarget.value = '';
      });
    }
    this.clearReview();
  }
}