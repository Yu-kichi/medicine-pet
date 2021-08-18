<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container" >
    <h1 class = "ml-4 is-size-4 mb-4">{{clinic_name}}の処方箋</h1>
    <div class= "card mb-4 ml-4 mr-4">
      <div class="prescription-header">
        <div class="ml-4  mr-4 pb-2">
          <p class="is-size-5 pt-4">{{clinic_name}}</p>
          <p class="is-size-6">{{prescribedDate(prescription_date)}}</p>
          <p>{{clinic_addresss}}</p>
          <p class="">{{clinic_telephone_number}}</p>
          <a class="mb-2 mt-4 button is-fullwidth" data-turbolinks='false' 
          :href='`/pets/${petId}/prescriptions/${prescriptionId}/edit`'>内容修正  </a>
          <div class="has-text-right" @click="showModalPrescription = true">
            <a class="has-text-grey-dark" data-turbolinks='false' >削除する</a>
          </div>
          <modal v-if="showModalPrescription" @cancel="showModalPrescription = false" @ok="deletePrescription(); showModalPrescription = false;">
          <template v-slot:body>本当に削除しますか？</template>
          </modal>
        </div>
      </div>
      <div v-if='medicines.length'>
        <div v-for="medicine in medicines" :key='medicine.id' class="is-size-6 ml-4 mr-4">
          <p class="is-size-5 mt-2">{{medicine.medicine_name}}</p>
          <p class="is-size-6" v-if="`${medicine.dose}`">1日の使用量:{{medicine.dose}}錠</p>
          <p class="is-size-6 ">総量:{{medicine.total_amount}}日分</p>
          <p class="is-size-6 ">メモ:{{medicine.memo}}</p>
          <a class="mb-4 mt-4 button pb-2 is-fullwidth mr-4" data-turbolinks='false' 
           :href='medicine.edit_prescriptions_medicine_path'>内容修正</a>
          <div class="has-text-right" @click="showModal = true, medicineId = medicine.medicine_id">
            <a class="has-text-grey-dark" data-turbolinks='false' >削除する</a>
          </div>
          <modal v-if="showModal" @cancel="showModal = false" @ok="deletePrescriptionsMedicine(); showModal = false;">
            <template v-slot:body>本当に削除しますか？</template>
          </modal>
          <div class="line mt-2"></div>
        </div>
      </div>
    </div>
    <div class="mr-4 ml-4 pb-4 pt-2">
      <a class="button is-fullwidth mt-4 mb-4" data-turbolinks='false' 
        :href='`/pets/${petId}/medicine_notebook`' >お薬手帳に戻る</a>
    </div>
  </div>
</template>

<script>
import Modal from 'Modal.vue'
import Axios from "axios";
import dayjs from 'dayjs';
import ja from 'dayjs/locale/ja'
dayjs.locale(ja)

export default {
  data() {
    return{
      selectedMedicine:'',
      medicines:[],
      dose: null,
      total_amount: null,
      memo:'',
      loaded: false,
      medicines:[],
      clinic_name: null,
      prescription_date: "",
      clinic_addresss:"",
      clinic_telephone_number:"",
      showModal: false,
      showModalPrescription: false,
      medicineId: "",
    }
  },
  components:{
    Modal,
  },
  props: {
    petId:{type: Number, required: true},
    prescriptionId:{type: Number, required: true},
  },
  created: function() {
    this.fetchPrescriptions();
  },
  methods:{
    fetchPrescriptions(){
      Axios.get(`/api/prescriptions/${this.prescriptionId}`).then(
      response => {
        const responseData = response.data;
        this.medicines = responseData["medicines"]
        this.clinic_name = responseData["prescription_clinic"]
        this.clinic_addresss = responseData["clinic_address"]
        this.clinic_telephone_number = responseData["clinic_telephone_number"]
        this.prescription_date = responseData["prescription_date"]
        this.loaded = true
      })
    },
    prescribedDate(date) {
      return dayjs(date).format('YYYY年MM月DD日(dd)')
    },
    deletePrescription: function() {
      Axios.delete(`/api/prescriptions/${this.prescriptionId}`)
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
    deletePrescriptionsMedicine: function() {
      Axios.delete(`/api/prescriptions_medicines/${this.medicineId}`)
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
  },
}
</script>
