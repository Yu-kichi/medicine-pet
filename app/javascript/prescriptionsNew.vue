<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container">
    <div class="box has-background-white is-shadowless">
      <div v-if="prescriptionId">
        <div class="title has-background-lightseagreen has-text-centered p-2">
          <h1 class="has-text-white has-text-weight-bold">前回の情報を元に薬を一括登録する</h1>
        </div>
        <div class="is-size-6 mb-3">
          <p>このページでは過去に貰ったお薬の情報をコピーして新しく登録することができます。</p>
          <p>病院や日付に変更がある場合には再入力をお願い致します。</p>
        </div>
      </div>
      <div v-else class="title has-background-lightseagreen has-text-white has-text-centered p-2">
        <h1 class="has-text-white has-text-weight-bold">処方箋情報登録</h1>
      </div>
      <div class="form__items">
        <div class="field">
          <label for="date" class="label">診療日 *</label>
          <div class="control">
            <input v-model="date" class="input" type="date" id="date" name="prescription[date]">
          </div>
          <p v-if="dateError !== null ">
            <p class="has-text-danger">{{ dateError }}</p>
          </p>
        </div>
        <div class="field">
          <label for="prefecture" class="label">県名 *</label>
        </div>
        <VueMultiselect v-model="selectedPrefecture" :options="prefectures" @select="onSelect" track-by="name"
          label="name" placeholder="最初に県名を選択してください" id="prefecture">
        </VueMultiselect>
        <div class="field">
          <label for="clinic_name" class="label pt-3">病院名 *</label>
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
        <div class="field">
          <label for="medical_fee" class="label pt-3">診察料</label>
          <div class="control">
            <input v-model="medical_fee" placeholder="数字を入力してください" class="input is-small" type="number"
              style="width: 50%;" min="0" id="medical_fee" name="prescription[medical_fee]">
            <span>円</span>
          </div>
        </div>
        <div class="field">
          <label for="medicine_fee" class="label">処方料</label>
          <div class="control">
            <input v-model="medicine_fee" placeholder="数字を入力してください" class="input is-small" type="number" id="medicine_fee" name="prescription[medicine_fee]"
              style="width: 50%;" min="0">
            <span>円</span>
          </div>
        </div>
        <div v-if="prescriptionId" class="actions pt-3">
          <button @click="copyPrescription" class="button is-link is-fullwidth has-text-weight-bold">一括登録する</button>
        </div>
        <div v-else class="actions pt-3">
          <button @click="createPrescription" class="button is-link is-fullwidth has-text-weight-bold">お薬登録へ進む</button>
        </div>
        <div v-if="!prescriptionId" class="actions">
          <a :href='`/clinics/new/?pet_id=${petId}`' class="button mt-4 is-fullwidth">病院名が見つからない時はこちら</a>
          <p class="is-size-7">*病院名が見つからない場合にはこちらから新しく病院情報の登録ができます。</p>
        </div>
        <div>
          <a class="button is-fullwidth mt-4 mb-4"
            :href='`/pets/${petId}/medicine_notebook`'>戻る</a>
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
      VueMultiselect
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
        medical_fee: '',
        medicine_fee: '',
        loaded: false,
        prescriptionId: '',
      }
    },
    props: {
      petId: {
        type: Number,
        required: true
      },
    },
    created: function () {
      this.fetchPrefectures();
      this.fetchPrescriptions();
    },
    methods: {
      token() {
        const meta = document.querySelector('meta[name="csrf-token"]')
        return meta ? meta.getAttribute('content') : ''
      },
      fetchPrefectures() {
        axios.get("/api/prefectures/index.json").then(
          response => {
            const responseData = response.data;
            this.prefectures = responseData["prefectures"]
            this.loaded = true
          })
      },
      fetchPrescriptions() {
        if (location.search) {
          this.prescriptionId = location.search.match(/[0-9]+/)
          axios.get(`/api/prescriptions/${this.prescriptionId}/edit`).then(
            response => {
              const responseData = response.data;
              this.selectedClinic = responseData.clinic
              this.selectedPrefecture = responseData.prefecture
              this.date = responseData.prescription.date
              this.medical_fee = responseData.prescription.medical_fee
              this.medicine_fee = responseData.prescription.medicine_fee
            })
        }
      },
      onSelect(prefecture) {
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
      createPrescription() {
        if (this.validation()) {}
        axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest'
        axios.defaults.headers['X-CSRF-TOKEN'] = this.token()
        axios.post('/api/prescriptions', {
          prescription: {
            date: this.date,
            clinic_id: this.selectedClinic.id,
            pet_id: this.petId,
            medical_fee: this.medical_fee,
            medicine_fee: this.medicine_fee,
          }
        }).then((response) => {
          window.location.href = response.data.location
        }, (error) => {
          console.log(error, response)
        })
      },
      copyPrescription() {
        if (this.validation()) {}
        axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest'
        axios.defaults.headers['X-CSRF-TOKEN'] = this.token()
        axios.post(`/api/prescriptions/?id=${this.prescriptionId}`, {
          prescription: {
            date: this.date,
            clinic_id: this.selectedClinic.id,
            pet_id: this.petId,
            medical_fee: this.medical_fee,
            medicine_fee: this.medicine_fee,
          }
        }).then((response) => {
          window.location.href = `/pets/${this.petId}/medicine_notebook`
        }, (error) => {
          console.log(error, response)
        })
      }
    },
  }
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>