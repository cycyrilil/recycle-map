import { Controller } from "@hotwired/stimulus";
import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    // Initialize the map
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });

    // Add markers to the map
    this.#addMarkersToMap();

    // Fit the map to the markers
    this.#fitMapToMarkers();

    // Add geocoder control for searching places
    this.map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }));

    // Focus on the user's location and propose a route
    this.#focusOnUserLocation();
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);
      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }

  #focusOnUserLocation() {
    if (navigator.geolocation) {
      // Get user's current location
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const userLocation = [position.coords.longitude, position.coords.latitude];

          // Add a marker for the user's location
          new mapboxgl.Marker()
            .setLngLat(userLocation)
            .addTo(this.map);

          // Set the map center to the user's location
          this.map.setCenter(userLocation);

          // You can also use Mapbox Directions API to propose a route
          // For simplicity, let's just log the user's location
          console.log("User's location:", userLocation);
        },
        (error) => {
          console.error('Error getting user location:', error);
        }
      );
    } else {
      console.error('Geolocation is not supported by this browser.');
    }
  }
}
// gérer les erreurs de manière appropriée et remplacer
// l'espace réservé pour l'itinéraire par l'implémentation réelle à l'aide d'un service de routage
// tel que l'API Mapbox Directions
