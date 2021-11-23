<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container">
    <div class="box has-background-white is-shadowless">
      <h1 class="mb-4 has-text-weight-bold is-size-4">お薬情報登録</h1>
        <div class="box is-shadowless has-background-white-bis">
        <h1 class="has-text-weight-bold">既に登録済み</h1>
        <div v-if='clinic_name'>
          <p>{{prescribedDate(prescription_date)}}</p>
          <p>{{clinic_name}}</p>
        </div>
        <div v-if='registered.length'>
          <div v-for="medicine in registered" :key='medicine.id' class="is-size-5 ml-3">
            <p>{{medicine.medicine_name}}</p>
          </div>
        </div>
    </div>
      <div class="form__items">
        <div class="field">
          <label for="medicine_name" class="label">お薬名 *</label>
          <div class="control columns">
            <div class="column">
              <VueMultiselect v-model="selectedMedicine" :options="medicines" track-by="name" label="name"
                placeholder="お薬を選択してください" id="medicine_name">
              </VueMultiselect>
              <p class="is-size-7">*ひらがなで見つからない時はカタカナで検索してみましょう</p>
              <p v-if="medicineError !== null ">
                <p class="has-text-danger">{{ medicineError }}</p>
              </p>
            </div>
          </div>
        </div>
        <div class="field">
          <label for="dose" class="label">1日の使用量</label>
        </div>
        <input v-model="dose" placeholder="数字で入力してください" class="input is-small " type="number" style="width: 50%;"
          min="0" id="dose">
        <span>錠</span>
        <div class="field">
          <label for="total_amount" class="label pt-3">総量</label>
        </div>
        <input v-model="total_amount" placeholder="数字で入力してください" class="input is-small" type="number" style="width: 50%;"
          min="0" id="total_amount">
        <span>日分</span>
        <div class="field">
          <label for="medicine_memo" class="label pt-3">メモ</label>
          <div class="control">
            <textarea v-model="memo" class="textarea" id="medicine_memo"></textarea>
          </div>
        </div>
        <div class="actions pt-4">
          <button @click="createPrescriptionsMedicines('addition')"
            class="button is-fullwidth has-text-weight-bold">追加でお薬を登録する</button>
        </div>
        <div class="actions pt-3">
          <button @click="createPrescriptionsMedicines()"
            class="button is-primary is-fullwidth has-text-weight-bold">お薬情報を登録する</button>
        </div>
        <div class="mt-4">
          <a :href='`/medicines/new/?prescription_id=${prescriptionId}`' class="link">薬の名前が見つからない時はこちら</a>
          <p class="is-size-7">*薬の名前が見つからない場合にはこちらから新しくお薬情報の登録ができます。</p>
        </div>
        <div class="mt-4 mb-4">
          <a :href='`/pets/${petId}/medicine_notebook`' class="link">お薬手帳に戻る</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import VueMultiselect from 'vue-multiselect'
  import axios from "axios";
  import dayjs from 'dayjs';
  import ja from 'dayjs/locale/ja'
  dayjs.locale(ja)

  export default {
    components: {
      VueMultiselect
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
        registered: [],
        clinic_name: null,
        prescription_date: "",
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
      this.fetchMedicines();
      this.fetchPrescriptionsMedicines();
    },
    methods: {
      token() {
        const meta = document.querySelector('meta[name="csrf-token"]')
        return meta ? meta.getAttribute('content') : ''
      },
      fetchMedicines() {
        axios.get("/api/medicines/index.json").then(
          response => {
            const responseData = response.data;
            this.medicines = responseData["medicines"]
            this.loaded = true
          })
      },
      fetchPrescriptionsMedicines() {
        axios.get(`/api/prescriptions_medicines/${this.prescriptionId}`).then(
          response => {
            const responseData = response.data;
            this.registered = responseData["medicines"]
            this.clinic_name = responseData["prescription_clinic"]
            this.prescription_date = responseData["prescription_date"]
          })
      },
      validation: function () {
        if (!this.selectedMedicine) {
          this.medicineError = 'お薬を選んでください';
        }
      },
      createPrescriptionsMedicines(addition) {
        if (this.validation()) {}
        axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest'
        axios.defaults.headers['X-CSRF-TOKEN'] = this.token()
        axios.post('/api/prescriptions_medicines', {
          prescriptions_medicine: {
            medicine_id: this.selectedMedicine.id,
            prescription_id: this.prescriptionId,
            dose: this.dose,
            total_amount: this.total_amount,
            memo: this.memo,
          }
        }).then((response) => {
          if (addition) {
            window.location.href = `/prescriptions/${this.prescriptionId}/prescriptions_medicines/new`
          } else {
            window.location.href = `/pets/${this.petId}/prescriptions/${this.prescriptionId}`
          }
        }, (error) => {
          console.log(error, response)
        })
      },
      prescribedDate(date) {
        return dayjs(date).format('YYYY年MM月DD日(dd)')
      },
    },
  }
</script>
