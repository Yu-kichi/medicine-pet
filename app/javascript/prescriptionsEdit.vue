<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container">
    <div class="box has-background-white is-shadowless">
      <div class="mb-4">
        <h1 class="has-text-weight-bold is-size-4">処方箋編集</h1>
      </div>
      <div class="form__items">
        <div class="field">
          <label for="date" class="label">診療日 *</label>
          <div class="control">
            <input v-model="date" class="input" type="date" id="date" name="prescription[date]">
            <p v-if="dateError !== null ">
              <p class="has-text-danger">{{ dateError }}</p>
            </p>
          </div>
        </div>
        <div class="field">
          <label for="prefecture" class="label">県名 *</label>
        </div>
        <VueMultiselect v-model="selectedPrefecture" :options="prefectures" @select="fetchClinics" track-by="name"
          label="name" placeholder="最初に県名を選択してください" id="prefecture">
        </VueMultiselect>
        <div class="field">
          <label for="clinic_name" class="label mt-3">病院名 *</label>
        </div>
        <div class="control">
          <VueMultiselect v-model="selectedClinic" :options="clinics" track-by="name" label="name"
            placeholder="県名を選択した後に選択してください" id="clinic_name" name="prescription[clinic]">
          </VueMultiselect>
          <p class="is-size-7">*ひらがなで見つからない時はカタカナで検索してください</p>
          <p v-if="clinicError !== null">
            <p class="has-text-danger">{{ clinicError }}</p>
          </p>
        </div>
        <div class="field mt-3">
          <label for="medical_fee" class="label">診察料</label>
        </div>
        <div class="control">
          <input v-model="medicalFee" placeholder="数字を入力してください" class="input is-small " type="number"
            style="width: 50%;" min="0" id="medical_fee" name="prescription[medical_fee]">
          <span>円</span>
        </div>
        <div class="field mt-3">
          <label for="medicine_fee" class="label">処方料</label>
          <div class="control">
            <input v-model="medicineFee" placeholder="数字を入力してください" class="input is-small" type="number"
              style="width: 50%;" min="0" id="medicine_fee" name="prescription[medicine_fee]">
            <span>円</span>
          </div>
        </div>
        <div class="mt-4">
          <button @click="updatePrescription"
            class="button is-primary is-fullwidth mt-4 mb-4 has-text-weight-bold">編集する</button>
        </div>
        <a :href='`/clinics/new/?pet_id=${petId}&prescription_id=${prescriptionId}`' class="mt-4 link">
        病院名が見つからない時はこちら</a>
        <p class="is-size-7">*病院名が見つからない場合にはこちらから新しく病院情報の登録ができます。</p>
        <div>
          <a class="button is-fullwidth mt-4 mb-4"
            :href='`/prescriptions/${prescriptionId}`'>キャンセル</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import VueMultiselect from 'vue-multiselect'
  import axios from "axios";

  export default {
    components: {
      VueMultiselect,
    },
    data() {
      return {
        dateError: null,
        clinicError: null,
        selectedPrefecture: null,
        selectedClinic: '',
        prefectures: [],
        clinics: [],
        date: '',
        medicalFee: '',
        medicineFee: '',
        loaded: false,
      }
    },
    props: {
      petId: {
        type: Number,
        required: true
      },
      prescriptionId: {
        type: Number,
        required: true
      },
    },
    created: function () {
      this.fetchPrescriptions()
      this.fetchPrefectures();
    },
    methods: {
      token() {
        const meta = document.querySelector('meta[name="csrf-token"]')
        return meta ? meta.getAttribute('content') : ''
      },
      fetchPrescriptions() {
        axios.get(`/api/prescriptions/${this.prescriptionId}/edit`).then(
          response => {
            const responseData = response.data;
            this.selectedClinic = responseData.clinic
            this.selectedPrefecture = responseData.prefecture
            this.date = responseData.prescription.date
            this.medicalFee = responseData.prescription.medical_fee
            this.medicineFee = responseData.prescription.medicine_fee
          })
      },
      fetchPrefectures() {
        axios.get("/api/prefectures.json").then(
          response => {
            const responseData = response.data;
            this.prefectures = responseData["prefectures"]
            this.loaded = true
          })
      },
      fetchClinics(prefecture) {
        const id = prefecture.id
        axios.get(`/api/clinics/${id}`).then(
          response => {
            const responseData = response.data;
            this.clinics = responseData["clinics"]
          }
        )
      },
      validation: function () {
        if (!this.date) {
          this.dateError = '診療日を選んでください';
        }
        if (!this.selectedClinic) {
          this.clinicError = '病院名を選んでください';
        }
      },
      updatePrescription() {
        if (this.validation()) {}
        axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest'
        axios.defaults.headers['X-CSRF-TOKEN'] = this.token()
        axios.patch(`/api/prescriptions/${this.prescriptionId}`, {
          prescription: {
            date: this.date,
            clinic_id: this.selectedClinic.id,
            pet_id: this.petId,
            medical_fee: this.medicalFee,
            medicine_fee: this.medicineFee,
          }
        }).then((response) => {
          if (response.data.status == "Success") {
            window.location.href = `/prescriptions/${this.prescriptionId}`
          } else {
            console.warn(response.data)
          }
        }, (error) => {
          console.warn(error.response)
        })
      },
    },
  }
</script>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>
