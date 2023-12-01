// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="toggle"
// export default class extends Controller {
//   connect() {
//     async function createFavorite() {
//       try {
//         const favorite = new Favorite({
//           favorite_params: getFavoriteParams(),
//           place_id: params.placeId,
//         });

//         const place = await Place.findById(params.placeId);

//         favorite.user = currentUser;
//         favorite.place = place;

//         await favorite.save();

//         // Toggle the favorite status
//         if (favorite.status === false) {
//           favorite.status = true;
//         } else {
//           favorite.status = false;
//         }

//         favorite.place = place;

//         redirect('/favorites/' + place.id);
//       } catch (error) {
//         console.error(error);
//         render('favorites/index', { status: unprocessable_entity });
//       }
//     }
// }}
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button"];

  async toggleFavorite() {
    const placeId = this.data.get("placeId");
    const response = await fetch(`/toggle_favorite/${placeId}`, { method: "POST" });

    if (response.ok) {
      const data = await response.json();
      this.buttonTarget.textContent = data.status ? "Retirer des favoris" : "Ajouter aux favoris";
    } else {
      console.error("Erreur lors de la requête AJAX");
    }
  }
}
