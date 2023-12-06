import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  static values = { address: String };

  connect() {
    console.log("Connected to GoogleMapsController");
    console.log(this.element.dataset.address);
  }

  getUserLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(this.showPosition.bind(this));
    } else {
      console.error("La géolocalisation n'est pas prise en charge par ce navigateur.");
    }
  }

  showPosition(position) {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;
    const address = this.addressValue;

    this.redirectToGoogleMaps(latitude, longitude, address);
  }

  redirectToGoogleMaps(latitude, longitude, address) {
    const googleMapsUrl = `https://www.google.com/maps/dir/${latitude},${longitude}/${address}${this.element.dataset.address}`;
    window.open(googleMapsUrl, "_blank");
  }
}
