import { Controller } from "@hotwired/stimulus";
import CEP from "help/cep";

export default class extends Controller {
  static targets = [
    "value",
    "city",
    "state",
    "neighborhood",
    "address",
    "expireAt",
  ];

  maskMoneyBRL(event) {
    let value = event.target.value;
    if (!value) return;

    value = value
      .replace(".", "")
      .replace(",", "")
      .replace(/[^0-9-]/g, "");

    const options = { minimumFractionDigits: 2 };
    const result = new Intl.NumberFormat("pt-BR", options).format(
      parseFloat(value) / 100
    );

    event.target.value = `R$ ${result}`;
  }

  findZipcode(event) {
    const value = event.target.value;

    if (value.length < 8) return;

    CEP.find(value)
      .then((resp) => {
        this.cityTarget.value = resp.localidade;
        this.stateTarget.value = resp.uf;
        this.neighborhoodTarget.value = resp.bairro;
        this.addressTarget.value = resp.logradouro;
      })
      .catch((_) => {});
  }

  limitState() {
    const value = this.stateTarget.value;

    if (value.length < 2) return;

    this.stateTarget.value = value.slice(0, 2);
  }

  validateDate() {
    const value = this.expireAtTarget.value;

    if (value.length < 0) return;

    const currentDate = new Date();
    const dateForm = new Date(`${value}T23:59`);

    if (dateForm < currentDate) {
      this.expireAtTarget.value = currentDate;
    }
  }
}
