export default class CEP {
  static find(value) {
    if (value.length < 8) return

    return fetch(`https://viacep.com.br/ws/${value}/json/`).then(raw => raw.json())
  }
}
