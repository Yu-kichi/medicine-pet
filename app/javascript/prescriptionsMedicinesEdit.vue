<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container">
    <div class="box has-background-white is-shadowless">
      <h1 class="mb-4 is-size-4 has-text-weight-bold">お薬情報編集</h1>
      <div class="form__items">
        <div class="field">
          <label for="medicine_name" class="label">お薬名 *</label>
          <div class="control columns">
            <div class="column is-three-fifths">
              <VueMultiselect v-model="selectedMedicine" :options="medicines" track-by="name" label="name"
                placeholder="お薬を選択してください" id="medicine_name">
              </VueMultiselect>
              <p class="is-size-7">*ひらがなで見つからない時はカタカナで検索してください。</p>
              <p v-if="medicineError !== null">
                <p class="has-text-danger">{{ medicineError }}</p>
              </p>
            </div>
          </div>
        </div>
        <div class="field">
          <label for="unit" class="label">単位</label>
        </div>
        <input v-model="unit" placeholder="5mg" class="input is-small" style="width: 50%;"
         id="unit">
        <div class="field mt-3">
          <label for="dose" class="label">服用回数</label>
        </div>
        <input v-model="dose" placeholder="数字で入力してください" class="input is-small" type="number" style="width: 50%;"
          min="0" id="dose">
        <span>回</span>
        <div class="field mt-3">
          <label for="total_amount" class="label">総量</label>
        </div>
        <input v-model="totalAmount" placeholder="数字で入力してください" class="input is-small" type="number" style="width: 50%;"
          min="0" id="total_amount">
        <span>日分</span>
        <div class="field mt-3">
          <label for="medicine_memo" class="label">メモ</label>
          <textarea v-model="memo" class="textarea" id="medicine_memo"></textarea>
        </div>
        <div class="actions mt-4">
          <button @click="updatePrescriptionsMedicine"
            class="button is-primary is-fullwidth has-text-weight-bold">お薬情報を編集する</button>
        </div>
        <div class="actions mt-4">
          <a :href="`/medicines/new/?prescriptions_medicine_id=${prescriptionsMedicineId}`" class="link">薬の名前が見つからない時はこちら</a>
          <p class="is-size-7">*薬の名前が見つからない場合にはこちらから新しくお薬情報の登録ができます。</p>
        </div>
        <a class="button is-fullwidth mt-4 mb-4"
          :href='`/prescriptions/${prescriptionId}`'>キャンセル
        </a>
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
        medicineError: null,
        selectedMedicine: '',
        medicines: [],
        unit: null,
        dose: null,
        totalAmount: null,
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
      token() {
        const meta = document.querySelector('meta[name="csrf-token"]')
        return meta ? meta.getAttribute('content') : ''
      },
      fetchPrescriptionsMedicine() {
        axios.get(`/api/prescriptions_medicines/${this.prescriptionsMedicineId}/edit`).then(
          response => {
            const responseData = response.data;
            this.selectedMedicine = responseData.medicine
            this.unit = responseData.prescriptions_medicine.unit
            this.dose = responseData.prescriptions_medicine.dose
            this.totalAmount = responseData.prescriptions_medicine.total_amount
            this.memo = responseData.prescriptions_medicine.memo
          })
      },
      fetchMedicines() {
        axios.get("/api/medicines.json").then(
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
        axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest'
        axios.defaults.headers['X-CSRF-TOKEN'] = this.token()
        axios.patch(`/api/prescriptions_medicines/${this.prescriptionsMedicineId}`, {
          prescriptions_medicine: {
            medicine_id: this.selectedMedicine.id,
            prescription_id: this.prescriptionId,
            unit: this.unit,
            dose: this.dose,
            total_amount: this.totalAmount,
            memo: this.memo,
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
