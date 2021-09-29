<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container">
    <div class="box has-background-white is-shadowless">
      <div class="has-background-lightseagreen mb-4 p-2">
        <h1 class="title has-text-white has-text-weight-bold has-text-centered">病院情報登録</h1>
      </div>
      <div class="form__items">
        <div class="field">
          <div class="label">
            <p>県名 *</p>
          </div>
        </div>
        <VueMultiselect v-model="selectedPrefecture" :options="prefectures" track-by="name" label="name"
          placeholder="県名を選択してください">
        </VueMultiselect>
        <p v-if="prefectureError!== null">
          <p class="has-text-danger">{{prefectureError}}</p>
        </p>
        <div class="label pt-3">
          <p>病院名 *</p>
          <input v-model="name" class="input is-fullwidth">
        </div>
        <p v-if="clinicError!== null">
          <p class="has-text-danger">{{clinicError}}</p>
        </p>
        <div class="field">
          <div class="label pt-3">
            <p>住所 *</p>
            <input v-model="address" class="input is-fullwidth">
          </div>
          <p v-if="addressError!== null">
            <p class="has-text-danger">{{addressError}}</p>
          </p>
        </div>
        <div class="field">
          <div class="label">
            <p>電話番号 *</p>
            <input v-model="telephone" class="input is-fullwidth">
          </div>
          <p v-if="telephoneError!== null">
            <p class="has-text-danger">{{telephoneError}}</p>
          </p>
        </div>
        <div class="actions pt-3">
          <button @click="createClinic" class="button is-link is-fullwidth has-text-weight-bold">登録する</button>
        </div>
        <div>
          <a v-if='prescriptionId !== null' class="button is-fullwidth mt-4 mb-4"
            :href='`/pets/${petId}/prescriptions/${prescriptionId}/edit`'>キャンセル</a>
          <a v-else class="button is-fullwidth mt-4 mb-4"
            :href='`/pets/${petId}/prescriptions/new`'>キャンセル</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import VueMultiselect from 'vue-multiselect'
  import Axios from "axios";

  export default {
    components: {
      VueMultiselect
    },
    data() {
      return {
        clinicError: null,
        prefectureError: null,
        addressError: null,
        telephoneError: null,
        selectedPrefecture: null,
        prefectures: [],
        name: '',
        telephone: '',
        address: '',
        loaded: false,
      }
    },
    props: {
      petId: {
        type: Number,
        required: true
      },
      prescriptionId: {
        type: Number
      }
    },
    created: function () {
      this.fetchPrefectures();
    },
    methods: {
      fetchPrefectures() {
        Axios.get("/api/prefectures/index.json").then(
          response => {
            const responseData = response.data;
            this.prefectures = responseData["prefectures"]
            this.loaded = true
          })
      },
      validation: function () {
        if (!this.name) {
          this.clinicError = '病院名を入力してください';
        }
        if (!this.selectedPrefecture) {
          this.prefectureError = '県名を選んでください';
        }
        if (!this.address) {
          this.addressError = '住所を入力してください'
        }
        if (!this.telephone) {
          this.telephoneError = '電話番号を入力してください'
        }
      },
      createClinic() {
        if (this.validation()) {}
        Axios.post(`/api/clinics`, {
          clinic: {
            name: this.name,
            prefecture_id: this.selectedPrefecture.id,
            address: this.address,
            telephone_number: this.telephone,
          }
        }).then((response) => {
          if(this.prescriptionId){
            window.location.href = `/pets/${this.petId}/prescriptions/${this.prescriptionId}/edit`
          } else {
            window.location.href = `/pets/${this.petId}/prescriptions/new`
          }
        }, (error) => {
          console.log(error, response)
        })
      },
    },
  }
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>