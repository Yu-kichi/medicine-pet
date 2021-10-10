<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container">
    <div class="box has-background-white is-shadowless">
      <div class="has-background-lightseagreen mb-4 p-2">
        <h1 class="title has-text-white has-text-weight-bold has-text-centered">病院情報編集</h1>
      </div>
      <div class="form__items">
        <div class="field">
          <label for="prefecture" class="label">県名 *</label>
        </div>
        <VueMultiselect v-model="selectedPrefecture" :options="prefectures" track-by="name" label="name"
          placeholder="県名を選択してください" id="prefecture">
        </VueMultiselect>
        <p v-if="prefectureError!== null">
          <p class="has-text-danger">{{prefectureError}}</p>
        </p>
        <div class="field">
          <label for="clinic_name" class="label pt-3">病院名 *</label>
          <div class="control">
            <input v-model="name" class="input   is-fullwidth" name="clinic[name]" id="clinic_name">
          </div>  
          <p v-if="clinicError!== null">
            <p class="has-text-danger">{{clinicError}}</p>
          </p>
        </div>  
        <div class="field">
          <label for="clinic_address" class="label ">住所 *</label>
          <div class="control">
            <input v-model="address" class="input is-fullwidth" type="text" name="clinic[address]" id="clinic_address">
          </div> 
          <p v-if="addressError!== null">
            <p class="has-text-danger">{{addressError}}</p>
          </p>
        </div>
        <div class="field">
          <label for="clinic_telephone" class="label">電話番号 *</label>
          <div class="control">
            <input v-model="telephone" class="input is-fullwidth" id="clinic_telephone" name="clinic[telephone_number]">
          </div>
          <p v-if="telephoneError!== null">
            <p class="has-text-danger">{{telephoneError}}</p>
          </p>
        </div>
        <div class="actions pt-3">
          <button @click="updateClinic" class="button is-link is-fullwidth has-text-weight-bold">編集する</button>
        </div>
        <div>
          <a class="button is-fullwidth mt-4 mb-4"
            :href='`/clinics`'>キャンセル</a>
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
      currentUserId: {
        type: Number,
        required: true
      },
      clinicId: {
        type: Number,
        required: true
      }
    },
    created: function () {
      this.fetchPrefectures();
      this.fetchClinics();
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
      fetchClinics() {
        Axios.get(`/api/clinics/${this.clinicId}/edit`).then(
          response => {
            const responseData = response.data;
            console.log(responseData)
            // this.selectedPrefecture = responseData.prefecture
            // this.name = responseData.clinic.name
            // this.address = responseData.clinic.address
            // this.telephone = responseData.telephone_number
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
      updateClinic() {
        if (this.validation()) {}
        Axios.post(`/api/clinics`, {
          clinic: {
            name: this.name,
            prefecture_id: this.selectedPrefecture.id,
            address: this.address,
            telephone_number: this.telephone,
            //user_id: this.currentUserId
          }
        }).then((response) => {
          window.location.href = `/clinics`
        }, (error) => {
          console.log(error, response)
        })
      },
    },
  }
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>