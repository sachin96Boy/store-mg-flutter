import axios from "axios";

interface EventParams {
    data: any;
}

interface Event {
    params: EventParams;
    result?: object;
}

export default {
    async beforeCreate(event: Event) {
        const { data } = event.params;

        const cart = await axios.post('http://localhost:1337/carts');

        data.clients_id = cart.data.id;
    },

    afterCreate(event: Event) {
        const { result, params } = event;

        // do something to the result;
    },
};