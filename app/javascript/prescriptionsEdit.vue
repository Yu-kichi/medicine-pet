<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container" >
    <p v-if="errors.length">
    <b>入力情報に誤りがあります</b>
    <ul>
      <li v-for="error in errors">{{ error }}</li>
    </ul>
    </p>
    <div class= "box has-background-white-bis">
      <h1 class="is-size-3  mb-4">
        <p>処方箋編集</p>
      </h1>
      <div class="form__items">
        <div class="field">
          <div class="label">
            <p>診療日 *</p>
          </div>
          <div class="control">
            <input v-model="date" class="input" type="date" >
          </div>  
        </div>
        <div class="field">
          <div class="label">
            <p>県名 *</p>
          </div>
        </div>
          <VueMultiselect
              v-model="selectedPrefecture" :options="prefectures" @select="fetchClinics" track-by="name" label="name" placeholder="最初に県名を選択してください" >
          </VueMultiselect>
        <div class="field">  
          <div class="label mt-3">
            <p>病院名 *</p>
          </div>
        </div>  
          <div class="control">
            <VueMultiselect 
              v-model="selectedClinic" :options="clinics" track-by="name" label="name" placeholder="県名を選択した後に選択してください" >
            </VueMultiselect>
          </div>
        <div class="field mt-3">
          <div class="label">
            <p>診察料</p>
          </div>
        </div>  
          <div class="control">
            <input v-model="medical_fee" placeholder="数字を入力してください" class="input is-small " type="number" style="width: 50%;" min="0">
            <span>円</span>
          </div>
        <div class="field mt-3">
          <div class="label">
            <p>処方料</p>
          </div>
          <div class="control ">
            <input v-model="medicine_fee" placeholder="数字を入力してください" class="input is-small" type="number" style="width: 50%;" min="0">
            <span>円</span>
          </div>
        </div>
        <div class="mt-4">
          <button @click="updatePrescription" class="button is-link is-fullwidth mt-4 mb-4" >編集する</button>
        </div>  
          <a :href='`/clinics/new/?pet_id=${petId}&prescription_id=${prescriptionId}`' class="button mt-4 is-fullwidth" >病院名が見つからない時はこちら</a>
          <p class="is-size-7">*病院名が見つからない場合にはこちらから新しく病院情報の登録ができます。</p>
          <div>
            <a class="button is-fullwidth mt-4 mb-4" data-turbolinks='false' 
            :href='`/pets/${petId}/prescriptions/${prescriptionId}`' >キャンセル</a>
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
    VueMultiselect,
  },
  data() {
    return{
        errors: [],
        selectedPrefecture: null,
        selectedClinic:'',
        prefectures:[],
        clinics:[],
        date: '',
        medical_fee:'',
        medicine_fee: '',
        loaded: false,
    }
  },
  props: {
    petId:{type: Number, required: true},
    prescriptionId:{type: Number, required: true},
  },
  created: function() {
    this.fetchPrescriptions()
    this.fetchPrefectures();
  },
  methods:{
    fetchPrescriptions(){
      Axios.get(`/api/prescriptions/${this.prescriptionId}/edit`).then(
      response => {
        const responseData = response.data;
        this.selectedClinic= responseData.clinic
        this.selectedPrefecture = responseData.prefecture
        this.date = responseData.prescription.date
        this.medical_fee = responseData.prescription.medical_fee
        this.medicine_fee = responseData.prescription.medicine_fee
      })
    },
    fetchPrefectures() {
      Axios.get("/api/prefectures/index.json").then(
      response => {
        const responseData = response.data;
        this.prefectures = responseData["prefectures"]
        this.loaded = true
      })
    },
    fetchClinics(prefecture){
      const id = prefecture.id
      Axios.get(`/api/clinics/index.json/?id=${id}`).then(
      response => {
        const responseData = response.data;
        this.clinics = responseData["clinics"]
      }
    )},
    validation: function(e){
      this.errors =[]
      if(!this.selectedClinic){
        this.errors.push('病院名を選んでください');
      }if(!this.date){
        this.errors.push('診療日を選んでください');
      }
      //e.preventDefault();
    },
    updatePrescription(){
      if(this.validation()){
      }
      Axios.patch(`/api/prescriptions/${this.prescriptionId}`, {
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
  },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>