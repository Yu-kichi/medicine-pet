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
    <div class= "card has-background-white-bis">
      <h1 class="is-size-1 has-background-white-ter mb-4">
        <p>処方箋情報編集</p>
      </h1>
      <div class="form__items">
        <div class="field">
          <div class="label">
            <p>診療日 *</p>
          </div>
          <div class="control ">
            <input v-model="date" class="input" type="date" style="width: 50%;" >
          </div>  
        </div>
        <div class="field">
          <div class="label">
            <p>県名 *</p>
          </div>
        </div>
          <VueMultiselect
              v-model="selectedPrefecture" :options="prefectures" @select="fetchClinics" track-by="name" label="name" placeholder="最初に県名を選択してください" style="width: 50%;">
          </VueMultiselect>
          <div class="label">
            <p>病院名 *</p>
          </div>
          <div class=" control columns">
            <div class="column is-three-fifths">
              <VueMultiselect 
                  v-model="selectedClinic" :options="clinics" track-by="name" label="name" placeholder="県名を選択した後に選択してください" style="width: 85%;">
              </VueMultiselect>
            </div>
            <div class="actions column">
              <a href="/clinics/new" class="button is-outlined" >病院名が見つからない時はこちらで登録できます</a>
            </div>
          </div>
        <div class="field">
          <div class="label">
            <p>診察料</p>
          </div>
          <div class="control">
            <input v-model="medical_fee" placeholder="数字を入力してください" class="input is-small " type="number" style="width: 20%;" min="0">
            <span>円</span>
          </div>
        </div>
        <div class="field">
          <div class="label">
            <p>処方料</p>
          </div>
          <div class="control ">
            <input v-model="medicine_fee" placeholder="数字を入力してください" class="input is-small" type="number" style="width: 20%;" min="0">
            <span>円</span>
          </div>
        </div>
        <div class="columns mt-4 mb-4">
          <div class="column is-three-fifths">
            <div class="actions">
              <button @click="updatePrescription" class="button is-link is-outlined" >編集する</button>
            </div>
          </div>
          <div class="column">
            <div class="actions">
              <button @click="showModal = true" class="button is-outlined">削除する</button>
              <modal v-if="showModal" @cancel="showModal = false" @ok="deletePrescription(); showModal = false;">
                <template v-slot:body>本当に削除しますか？</template>
              </modal>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>  
</template>

<script>
import VueMultiselect from 'vue-multiselect'
import Axios from "axios";
import Modal from 'Modal.vue'

export default {
  components: { 
    VueMultiselect,
    Modal,
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
        showModal: false,
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
        Turbolinks.visit(response.data.location);
      }, (error) => {
        console.log(error, response)
      })
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
  },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>