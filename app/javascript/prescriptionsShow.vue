<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container" >
    <h1 class = "ml-4 is-size-4 has-text-weight-bold"></h1>
      <div class= "card is-shadowless prescription-header">
        <div class="columns is-mobile ">
          <div class="column ml-4 mr-4 pb-2 is-three-quarters-mobile">
            <p class="is-size-4 has-text-weight-bold pt-4"><i class="far fa-hospital"></i> {{prescribedDate(prescription_date)}}</p>
            <p class="is-size-4 has-text-weight-bold">{{clinic_name}}</p>
            <p>住所:{{clinic_addresss}}</p>
            <p>電話番号:{{clinic_telephone_number}}</p>
            <p>診察料:{{prescription.medical_fee}}円</p>
            <p>処方料:{{prescription.medicine_fee}}円</p>
          </div>
          <div class="column mt-6" @click="showOnClinicButton = !showOnClinicButton" >...</div>
        </div>
          <div v-show="showOnClinicButton" class="pl-4 pr-4">
            <a class="mb-2 mt-4 button is-fullwidth" data-turbolinks='false' 
            :href='`/pets/${petId}/prescriptions/${prescriptionId}/edit`'><i class="fas fa-pen mr-2"></i>内容修正</a>
            <div class="has-text-right pb-2" @click="showModalPrescription = true">
              <i class="fa fa-trash" ></i>
              <a class="has-text-grey-dark" data-turbolinks='false' >削除する</a>
            </div>
            <modal v-if="showModalPrescription" @cancel="showModalPrescription = false" @ok="deletePrescription(); showModalPrescription = false;">
            <template v-slot:body>本当に削除しますか？</template>
            </modal>
          </div> 
      </div>
      <div v-if='medicines.length'>
        <div class= "card mb-4 is-shadowless">
          <div class ="header ml-4 mr-4 mt-2 mb-2 has-text-weight-bold">処方されたお薬
          </div>
        <div v-for="(medicine, index) in medicines" :key='medicine.id' class=" ">
          <div class="columns is-mobile mb-4">
            <div class ="column pb-2 is-three-quarters-mobile ml-4 mr-4">
              <p class="is-size-5 mt-2 has-text-weight-bold"><i class="fas fa-capsules"></i>{{medicine.medicine_name}}</p>
              <p class="is-size-6" v-if="`${medicine.dose}`">1日の使用量:{{medicine.dose}}錠</p>
              <p class="is-size-6 ">総量:{{medicine.total_amount}}日分</p>
              <p class="is-size-6 ">メモ:{{medicine.memo}}</p>
            </div>
            <div class="column mt-6" @click="showOnPrescription(index)" >...</div>
          </div>
          <div v-show="index === clickedPrescription" class="pl-4 pr-4">
            <a class="mb-4 mt-4 button pb-2 is-fullwidth mr-4" data-turbolinks='false' 
              :href='medicine.edit_prescriptions_medicine_path'><i class="fas fa-pen mr-2"></i>内容修正</a>
            <div class="has-text-right" @click="showModal = true, medicineId = medicine.medicine_id">
              <i class="fa fa-trash" ></i>
              <a class="has-text-grey-dark" data-turbolinks='false' >削除する</a>
            <div class="line mt-2"></div>
          </div>
            <modal v-if="showModal" @cancel="showModal = false" @ok="deletePrescriptionsMedicine(); showModal = false;">
              <template v-slot:body>本当に削除しますか？</template>
            </modal>
          </div>  
        </div>
        </div>
      </div>
    <div class="mr-4 ml-4 pb-4 pt-2" >
      <a class="button  mt-4 has-text-white is-fullwidth has-background-primary " data-turbolinks='false'
            :href='`/prescriptions/${prescriptionId}/prescriptions_medicines/new`'>+ お薬追加登録</a>
      <a class="button  mt-4 has-text-white is-fullwidth has-background-primary " data-turbolinks='false' 
          :href='`/pets/${petId}/prescriptions/new/?prescription_id=${prescriptionId}`'>+コピー</a>      
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
      showOnClinicButton: false,
      clickedPrescription: "",
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
      prescription: [],
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
        this.prescription = responseData["prescription"]
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
    showOnPrescription(index){
      if(this.clickedPrescription === ""){
        this.clickedPrescription = index
      }else{
        this.clickedPrescription = ""
      }
    },
  },
}
</script>