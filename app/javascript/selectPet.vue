<template>
  <div class="mt-1" @click="showPets = !showPets">
    <i class="fas fa-paw is-size-3 ml-5"></i>
    <div class="ml-2 is-size-7">手帳切り替え</div>
    <transition name="fade">
      <div class="menu-pets-bar" v-show="showPets">
        <ul v-for="pet in pets" :key='pet.id' class="mt-2 ml-3 mr-3">
          <li class="pb-2 mt-2">
            <p><a :href='`/pets/${pet.id}/medicine_notebook`'>{{pet.name}}</a></p>
          </li>
        </ul>
      </div>
    </transition>
  </div>
</template>

<script>
  import Axios from "axios";

  export default {
    data() {
      return {
        showPets: false,
        pets: [],
      }
    },
    created: function () {
      this.fetchPets();
    },
    methods: {
      fetchPets() {
        Axios.get(`/api/pets/index`).then(
          response => {
            const responseData = response.data;
            this.pets = responseData["pets"]
          })
      },
    }
  }
</script>
