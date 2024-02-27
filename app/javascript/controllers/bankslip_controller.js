import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["value"];

  maskMoneyBRL(event) {
    let value = event.target.value
    if (!value) return

    value = value.replace('.', '').replace(',', '').replace(/[^0-9-]/g, '')

    const options = { minimumFractionDigits: 2 }
    const result = new Intl.NumberFormat('pt-BR', options).format(
      parseFloat(value) / 100
    )

    event.target.value = `R$ ${result}`
  }
}
