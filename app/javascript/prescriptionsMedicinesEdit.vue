<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container">
    <div class="box has-background-white is-shadowless">
      <h1 class="title has-background-lightseagreen has-text-white has-text-centered mb-4 p-2">
        <p>お薬情報編集</p>
      </h1>
      <div class="form__items">
        <div class="field">
          <div class="label">
            <p>お薬名 *</p>
          </div>
          <div class="control columns">
            <div class="column is-three-fifths">
              <VueMultiselect v-model="selectedMedicine" :options="medicines" track-by="name" label="name"
                placeholder="お薬を選択してください">
              </VueMultiselect>
              <p class="is-size-7">*ひらがなで見つからない時はカタカナで検索してください。</p>
              <p v-if="medicineError !== null">
                <p class="has-text-danger">{{ medicineError }}</p>
              </p>
            </div>
          </div>
        </div>
        <div class="field">
          <div class="label">
            <p>1日の使用量</p>
          </div>
        </div>
        <input v-model="dose" placeholder="数字で入力してください" class="input is-small " type="number" style="width: 50%;"
          min="0">
        <span>錠</span>
        <div class="field mt-3">
          <div class="label">
            <p>総量</p>
          </div>
        </div>
        <input v-model="total_amount" placeholder="数字で入力してください" class="input is-small" type="number" style="width: 50%;"
          min="0">
        <span>日分</span>
        <div class="field mt-3">
          <div class="label">
            <p>メモ</p>
          </div>
          <textarea v-model="memo" class="textarea"></textarea>
        </div>
        <div class="actions mt-4">
          <button @click="updatePrescriptionsMedicine"
            class="button is-link is-fullwidth has-text-weight-bold">お薬情報を編集する</button>
        </div>
        <div class="actions mt-4">
          <a :href="`/medicines/new/?prescriptions_medicine_id=${prescriptionsMedicineId}`"
            class="button is-outlined is-fullwidth">薬の名前が見つからない時はこちら</a>
          <p class="is-size-7">*薬の名前が見つからない場合にはこちらから新しくお薬情報の登録ができます。</p>
        </div>
        <a class="button is-fullwidth mt-4 mb-4" data-turbolinks='false'
          :href='`/pets/${petId}/prescriptions/${prescriptionId}`'>キャンセル
        </a>
      </div>
    </div>
  </div>
</template>

<script>
  import VueMultiselect from 'vue-multiselect'
  import Axios from "axios";

  export default {
    components: {
      VueMultiselect,
    },
    data() {
      return {
        medicineError: null,
        selectedMedicine: '',
        medicines: [],
        dose: null,
        total_amount: null,
        memo: '',
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
      prescriptionsMedicineId: {
        type: Number,
        required: true
      },
    },
    created: function () {
      this.fetchMedicines();
      this.fetchPrescriptionsMedicine();
    },
    methods: {
      fetchPrescriptionsMedicine() {
        Axios.get(`/api/prescriptions_medicines/${this.prescriptionsMedicineId}/edit`).then(
          response => {
            const responseData = response.data;
            this.selectedMedicine = responseData.medicine
            this.dose = responseData.prescriptions_medicine.dose
            this.total_amount = responseData.prescriptions_medicine.total_amount
            this.memo = responseData.prescriptions_medicine.memo
          })
      },
      fetchMedicines() {
        Axios.get("/api/medicines/index.json").then(
          response => {
            const responseData = response.data;
            this.medicines = responseData["medicines"]
            this.loaded = true
          })
      },
      validation: function () {
        if (!this.selectedMedicine) {
          this.medicineError = 'お薬を選んでください';
        }
      },
      updatePrescriptionsMedicine() {
        if (this.validation()) {}
        Axios.patch(`/api/prescriptions_medicines/${this.prescriptionsMedicineId}`, {
          prescriptions_medicine: {
            medicine_id: this.selectedMedicine.id,
            prescription_id: this.prescriptionId,
            dose: this.dose,
            total_amount: this.total_amount,
            memo: this.memo,
          }
        }).then((response) => {
          window.location.href = `/pets/${this.petId}/prescriptions/${this.prescriptionId}`
        }, (error) => {
          console.log(error, response)
        })
      },
    },
  }
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>