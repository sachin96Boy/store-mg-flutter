// import type { Core } from '@strapi/strapi';
import axios from "axios";

import { Core } from "@strapi/strapi";

export default {
  /**
   * An asynchronous register function that runs before
   * your application is initialized.
   *
   * This gives you an opportunity to extend code.
   */
  register(/* { strapi }: { strapi: Core.Strapi } */) { },

  /**
   * An asynchronous bootstrap function that runs before
   * your application gets started.
   *
   * This gives you an opportunity to set up your data model,
   * run jobs, or perform some special logic.
   */
  bootstrap({ strapi }: { strapi: Core.Strapi }) {

    strapi.db.lifecycles.subscribe({
      models: ["plugin::users-permissions.user"],
      async beforeCreate(event) {

        const { data } = event.params;
        try {
          const initCartdata = {
            "data": {
              "locale": "en",
              "products": {
                "connect": []
              }
            }

          };
          const cart = await axios.post('http://localhost:1337/api/carts', initCartdata);
          data.cart_id = cart.data['data']['documentId'];

        } catch (err) {
          console.log(err);
        }

      }
    });

  },
};
