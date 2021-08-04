<template>
  <div class="box has-background back-color">
    <h1 class="is-size-3 mb-4" >
      <div v-if="petId">
        {{`${name}のお薬手帳`}}
      </div>
      <div v-else>
        <a style="display: block" :href='`/pets/new`' >まずペット情報を登録しましょう！ > </a>
      </div>
    </h1>
      <div v-for="(prescription, index) in prescriptions" :key='prescription.id' class="card mb-4">
        <h2 class="is-size-4 card-content" @click="showOnPrescription(index)">
          <div class="columns">
            <div class="column is-four-fifths ">
              <p>{{prescribedDate(prescription.prescription.date)}}</p>
              <p>{{prescription.clinic_name}}</p>
              <div class="is-size-5" v-show="index === clickedPrescription" >
                <p>{{prescription.clinic_address}}</p>
                <p>{{prescription.clinic_telephone_number}}</p>
                <p v-if="prescription.prescription.medical_fee">診察料：{{prescription.prescription.medical_fee}}円</p>
                <p v-if="prescription.prescription.medical_fee">処方料：{{prescription.prescription.medicine_fee}}円</p>
              </div>
            </div>
            <div class="column">
              <div type="button">...</div>
              <div class="is-size-5" v-show="index === clickedPrescription" >
                <a style="display: block" class="mb-4 mt-4" data-turbolinks='false' 
                :href='`${prescription.edit_prescription_path}`'>処方箋情報編集 > </a>
                <a style="display: block" class="mb-4 mt-4" data-turbolinks='false' 
                :href='`${prescription.new_medicine_path}`'>お薬追加登録 > </a>
                <div class="">コピー</div>
              </div>
            </div>  
          </div>
        </h2>
        <div v-for='(medicine, index) in prescription.medicines' :key='medicine.id'>
          <div class="card">
            <h3 class="is-size-5 card-content" @click="clickedMedicine=!clickedMedicine">
              <div class="columns">
                <div class="column is-four-fifths">
                  <p>{{medicine.medicine_name}}</p>
                  <div class="is-size-5" v-show="clickedMedicine" >
                    <p v-if="medicine.prescriptions_medicines.dose">一回の使用量:{{medicine.prescriptions_medicines.dose}}錠</p>
                    <p v-if="medicine.prescriptions_medicines.total_amount">総量:{{medicine.prescriptions_medicines.total_amount}}日分</p>
                    <p v-if="medicine.prescriptions_medicines.memo">メモ:{{medicine.prescriptions_medicines.memo}}</p>
                  </div>
                </div>
                <div class="column">
                  <div type="button">...</div>
                  <div  class="" v-show="clickedMedicine">
                    <a style="display: block" class="mb-4 mt-4" :href='`${medicine.edit_prescriptions_medicine_path}`' data-turbolinks='false' >お薬情報編集 > </a>
                    <div class="">コピー</div>
                  </div>
                </div>
              </div>
            </h3>
          </div>
        </div>
      </div>
    <div v-if="petId">
      <div class="button mt-4 has-background-primary">
        <a class="mb-4 mt-4 has-text-white" data-turbolinks='false' 
          :href='`/pets/${petId}/prescriptions/new`'>新しくお薬手帳に登録する
        </a>
      </div>
    </div>
  </div>
</template>

<script>
import Axios from "axios";
import dayjs from 'dayjs';
import ja from 'dayjs/locale/ja'
dayjs.locale(ja)

export default {
  data() {
    return{
      name: "",
      loaded: false,
      prescriptions: [],
      show: false,
      clickedPrescription: "",
      clickedMedicine: false,
    }
  },
  props: {
    petId:{type: Number, required: true},
  },
  created: function() {
    this.fetchMedicineNotebook()
  },
  methods:{
    fetchMedicineNotebook(){
      Axios.get(`/api/medicine_notebook/index/?pet_id=${this.petId}`).then(
      response => {
        const responseData = response.data;
        console.log(responseData)
        this.name = responseData.pet.name
        this.prescriptions = responseData.prescriptions
      })
    },
    prescribedDate(date) {
      return dayjs(date).format('YYYY年MM月DD日(dd)')
    },
    showOnPrescription(index){
      if(this.clickedPrescription === ""){
        this.clickedPrescription = index
      }else{
        this.clickedPrescription = ""
      }
    },
    // showOnMedicine(index){
    //   if(this.clickedMedicine === ""){
    //     this.clickedMedicine = index
    //   }else{
    //     this.clickedMedicine = ""
    //   }
    // }
  }
}
</script>

<style>
</style>