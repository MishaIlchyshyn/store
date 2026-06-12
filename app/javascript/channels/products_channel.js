import consumer from "channels/consumer"

document.addEventListener("turbo:before-cache", () => {
  document.getElementById("reload-banner")?.remove()
})

consumer.subscriptions.create("ProductsChannel", {
  connected() {},
  disconnected() {},

  received({ action, product }) {
    // index page
    const list = document.getElementById("products-list")
    if (list) {
      if (action === "create") {
        list.prepend(this.buildRow(product))
      } else if (action === "update") {
        const existing = list.querySelector(`[data-product-id="${product.id}"]`)
        if (existing) existing.replaceWith(this.buildRow(product))
      } else if (action === "destroy") {
        const existing = list.querySelector(`[data-product-id="${product.id}"]`)
        if (existing) existing.remove()
      }
    }

    // show page
    const showEl = document.getElementById("product-show")
    if (showEl && showEl.dataset.productId == product.id && action === "update") {
      if (this.hasChanged(showEl, product)) {
        this.showReloadBanner(showEl)
      }
    }
  },

  hasChanged(el, product) {
    const d = el.dataset
    return (
      d.productName !== product.name ||
      d.productInventoryCount !== String(product.inventory_count) ||
      d.productDescription?.trim() !== (product.description ?? "").trim() ||
      d.productImageAttached !== String(product.featured_image_attached)
    )
  },

  showReloadBanner(showEl) {
    if (document.getElementById("reload-banner")) return
    const banner = document.createElement("div")
    banner.id = "reload-banner"
    banner.className = "mb-6 rounded-md bg-green-50 px-4 py-3 text-sm font-semibold text-green-700 border border-green-200"
    banner.textContent = "Reload to see updates"
    showEl.insertAdjacentElement("beforebegin", banner)
  },

  buildRow(product) {
    const row = document.createElement("div")
    row.dataset.productId = product.id
    row.className = "flex items-center justify-between px-5 py-4 hover:bg-gray-50"
    row.innerHTML = `<a href="/products/${product.id}" class="font-medium text-indigo-600 hover:text-indigo-800">${product.name}</a>`
    return row
  }
})
