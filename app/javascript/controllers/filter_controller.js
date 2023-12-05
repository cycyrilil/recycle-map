
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  addToInput(event) {

    const datasetValue = event.currentTarget.dataset.value;
const targetValue = this.inputTarget.value;

// Check if datasetValue exists in the targetValue
if (targetValue.includes(datasetValue)) {
  // Remove datasetValue if it exists
  this.inputTarget.value = targetValue.replace(datasetValue, '');


} else {
  // Add datasetValue and separate with a comma
  if (targetValue.length > 0) {
    this.inputTarget.value += ',' + datasetValue;
  } else {
    this.inputTarget.value = datasetValue;
  }

}

if (this.inputTarget.value.slice(-1) === ',') {
  console.log('Last character is a comma');
  this.inputTarget.value = this.inputTarget.value.slice(0, -1);
}


if (this.inputTarget.value.slice(0) === ',') {
  console.log('Last character is a comma');
  this.inputTarget.value = this.inputTarget.value.slice(0, 0);
}
    // Votre code existant pour ajouter ou supprimer des valeurs dans le champ d'entrée

    // Appel à la fonction changeColor
    this.changeColor(event.currentTarget);
  }

  changeColor(element) {
    // Récupère la couleur actuelle

    // Change la couleur en fonction de la couleur actuelle

    // Si la nouvelle couleur est rouge, ajoute une classe, sinon, la supprime
    if (element.classList.contains('selected-color') === false) {
      element.classList.add('selected-color');
    } else {
      element.classList.remove('selected-color');
    }
  }
}
