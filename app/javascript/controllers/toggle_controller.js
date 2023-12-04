// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="toggle"
// export default class extends Controller {
//   connect() {
//     async function createFavorite() {
//       try {
//         const favorite = new favorite({
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
