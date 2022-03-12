<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container has-background-white contents-body">
    <div class="card is-shadowless prescription-header">
      <div class="columns is-mobile">
        <div class="column ml-4 mr-4 pb-2 is-three-quarters-mobile">
          <h1 class="is-size-4 has-text-weight-bold pt-4"><i class="far fa-hospital"></i>
            {{prescribedDate(prescriptions.date)}}<br>{{clinics.name}}</h1>
          <p>住所:{{clinics.address}}</p>
          <p>電話番号:{{clinics.telephone_number}}</p>
          <p>診察料:{{prescriptions.medical_fee}}円</p>
          <p>処方料:{{prescriptions.medicine_fee}}円</p>
        </div>
        <div class="column mt-6" @click="showOnClinicButton = !showOnClinicButton">...</div>
      </div>
      <div v-show="showOnClinicButton" class="pl-4 pr-4">
        <a class="mb-2 mt-4 button is-fullwidth"
          :href='`/prescriptions/${prescriptionId}/edit`'><i class="fas fa-pen mr-2"></i>内容修正</a>
        <div class="has-text-right pb-2" @click="showModalPrescription = true">
          <i class="fa fa-trash"></i>
          <a class="prescription-delete has-text-grey-dark link">削除する</a>
        </div>
        <modal v-if="showModalPrescription" @cancel="showModalPrescription = false"
          @ok="deletePrescription(); showModalPrescription = false;">
          <template v-slot:body>本当に削除しますか？</template>
        </modal>
      </div>
    </div>
    <div v-if='medicines.length'>
      <div class="card mb-4 is-shadowless">
        <div class="header ml-4 mr-4 mt-2 mb-2 has-text-weight-bold">処方されたお薬
        </div>
        <div v-for="(medicine, index) in medicines" :key='medicine.id'>
          <div class="columns is-mobile mb-4">
            <div class="column pb-2 is-three-quarters-mobile ml-4 mr-4">
              <p class="is-size-5 mt-2 has-text-weight-bold"><i class="fas fa-capsules"></i>{{medicine.medicine_name}}
              </p>
              <p class="is-size-6">単位:{{medicine.unit}}</p>
              <p class="is-size-6" v-if="`${medicine.dose}`">1日の服用回数:{{medicine.dose}}回</p>
              <p class="is-size-6">総量:{{medicine.total_amount}}日分</p>
              <p class="is-size-6">メモ:{{medicine.memo}}</p>
            </div>
            <div id="medicine-show-button" class="column mt-6" @click="showOnPrescription(index)">...</div>
          </div>
          <div v-show="index === clickedPrescription" class="pl-4 pr-4">
            <a class="mb-4 mt-4 button pb-2 is-fullwidth mr-4"
              :href='medicine.edit_prescriptions_medicine_path'><i class="fas fa-pen mr-2"></i>内容修正</a>
            <div class="has-text-right" @click="showModal = true, medicineId = medicine.medicine_id">
              <i class="fa fa-trash"></i>
              <a class="has-text-grey-dark link">削除する</a>
              <div class="line mt-2"></div>
            </div>
            <modal v-if="showModal" @cancel="showModal = false" @ok="deletePrescriptionsMedicine(); showModal = false;">
              <template v-slot:body>本当に削除しますか？</template>
            </modal>
          </div>
        </div>
      </div>
    </div>
    <div class="mr-4 ml-4 pb-4 pt-2">
      <a class="button mt-4 has-text-white is-fullwidth is-primary has-text-weight-bold"
         :href='`/prescriptions/${prescriptionId}/prescriptions_medicines/new`'>+ お薬追加登録</a>
      <a class="button mt-4 is-fullwidth has-text-weight-bold"
         :href='`/prescriptions/new/?prescription_id=${prescriptionId}&pet_id=${petId}`'>+コピー</a>
    </div>
    <div class="ml-4 pb-4 pt-2">
      <a :href='`/pets/${petId}/medicine_notebook`' class="link">お薬手帳に戻る</a>
    </div>
  </div>
</template>

<script>
  import Modal from 'Modal.vue'
  import axios from "axios";
  import dayjs from 'dayjs';
  import ja from 'dayjs/locale/ja'
  dayjs.locale(ja)

  export default {
    data() {
      return {
        showOnClinicButton: false,
        clickedPrescription: "",
        selectedMedicine: '',
        medicines: [],
        clinics: [],
        prescriptions: [],
        loaded: false,
        showModal: false,
        showModalPrescription: false,
        medicineId: "",
      }
    },
    components: {
      Modal,
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
      this.fetchPrescriptions();
    },
    methods: {
      token() {
        const meta = document.querySelector('meta[name="csrf-token"]')
        return meta ? meta.getAttribute('content') : ''
      },
      fetchPrescriptions() {
        axios.get(`/api/prescriptions/${this.prescriptionId}`).then(
          response => {
            const responseData = response.data;
            this.medicines = responseData["medicines"]
            this.clinics = responseData["clinics"]
            this.prescriptions = responseData["prescriptions"]
            this.loaded = true
          })
      },
      prescribedDate(date) {
        return dayjs(date).format('YYYY年MM月DD日(dd)')
      },
      deletePrescription: function () {
        axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest'
        axios.defaults.headers['X-CSRF-TOKEN'] = this.token()
        axios.delete(`/api/prescriptions/${this.prescriptionId}`)
          .then(response => {
            window.location.href = `/pets/${this.petId}/medicine_notebook`
          })
          .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });
      },
      deletePrescriptionsMedicine: function () {
        axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest'
        axios.defaults.headers['X-CSRF-TOKEN'] = this.token()
        axios.delete(`/api/prescriptions_medicines/${this.medicineId}`)
          .then(response => {
            window.location.href = `/prescriptions/${this.prescriptionId}`
          })
          .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });
      },
      showOnPrescription(index) {
        if (this.clickedPrescription === "") {
          this.clickedPrescription = index
        } else {
          this.clickedPrescription = ""
        }
      },
    },
  }
</script>
