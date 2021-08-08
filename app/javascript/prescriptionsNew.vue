<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container" >
    <div class= "card has-background-white-bis">
      <h1 class="is-size-1 has-background-white-ter mb-4">
        <div v-if="prescriptionId">前回の情報を元に薬を一括登録する
          <div class="is-size-5">
          このページでは過去に貰ったお薬の情報をコピーして新しく登録することができます。<br>
          病院や日付に変更がある場合には再入力をお願い致します。
          </div>
        </div>
        <div v-else>処方箋情報登録</div>
      </h1>
      <div class="form__items">
        <div class="field">
          <div class="label">
            <p>診療日 *</p>
          </div>
          <div class="control ">
            <input v-model="date" class="input" type="date" style="width: 50%;" >
          </div>
          <p v-if="dateErrors.length">
          <ul>
            <li v-for="error in dateErrors" class="has-text-danger">{{ error }}</li>
          </ul>
          </p>
        </div>
        <div class="field">
          <div class="label">
            <p>県名 *</p>
          </div>
        </div>
          <VueMultiselect
              v-model="selectedPrefecture" :options="prefectures" @select="onSelect" track-by="name" label="name" placeholder="最初に県名を選択してください" style="width: 50%;">
          </VueMultiselect>
          <div class="label">
            <p>病院名 *</p>
          </div>
          <div class=" control columns">
            <div class="column is-three-fifths">
              <VueMultiselect 
                  v-model="selectedClinic" :options="clinics" track-by="name" label="name" placeholder="県名を選択した後に選択してください" style="width: 85%;">
              </VueMultiselect>
              <p class="has-text-grey-light">*ひらがなで見つからない時はカタカナで検索してみましょう</p>
              <p v-if="clinicErrors.length">
              <ul>
                <li v-for="error in clinicErrors" class="has-text-danger">{{ error }}</li>
              </ul>
              </p>
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
        <div v-if="prescriptionId" class="actions">
          <button @click="copyPrescription" class="button is-link is-outlined" >薬の情報を一括登録する</button>
        </div>
        <div v-else class="actions">
          <button @click="createPrescription" class="button is-link is-outlined" >お薬登録へ進む</button>
        </div>
      </div>
    </div>
  </div>  
</template>

<script>
import VueMultiselect from 'vue-multiselect'
import Axios from "axios";

export default {
  components: { VueMultiselect },
  data() {
    return{
        dateErrors: [],
        clinicErrors:[],
        selectedPrefecture: null,
        selectedClinic:'',
        prefectures:[],
        clinics:[],
        date: '',
        medical_fee:'',
        medicine_fee: '',
        loaded: false,
        prescriptionId: '',
    }
  },
  props: {
    petId:{type: Number, required: true},
  },
  created: function() {
    this.fetchPrefectures();
    this.fetchPrescriptions();
  },
  methods:{
    fetchPrefectures() {
      Axios.get("/api/prefectures/index.json").then(
      response => {
        const responseData = response.data;
        this.prefectures = responseData["prefectures"]
        this.loaded = true
      })
    },
    fetchPrescriptions(){
      if(location.search){
      this.prescriptionId = location.search.match(/[0-9]+/)
      Axios.get(`/api/prescriptions/${this.prescriptionId}/edit`).then(
      response => {
        const responseData = response.data;
        this.selectedClinic= responseData.clinic
        this.selectedPrefecture = responseData.prefecture
        this.date = responseData.prescription.date
        this.medical_fee = responseData.prescription.medical_fee
        this.medicine_fee = responseData.prescription.medicine_fee
      })
      }
    },
    onSelect(prefecture){
      const id = prefecture.id
      Axios.get(`/api/clinics/index.json/?id=${id}`).then(
      response => {
        const responseData = response.data;
        this.clinics = responseData["clinics"]
      }
    )},
    validationDate: function(e){
      if(!this.date){
        this.dateErrors.push('診療日を選んでください');
      }
      //e.preventDefault();
    },
    validationClinic: function(e){
      if(!this.selectedClinic){
        this.clinicErrors.push('病院名を選んでください');
      }
    },
    createPrescription(){
      if(this.validationDate()){
      }
      if(this.validationClinic()){
      }
      Axios.post('/api/prescriptions', {
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
    copyPrescription(){
      if(this.validationDate()){
      }
      if(this.validationClinic()){
      }
      Axios.post(`/api/prescriptions/?id=${this.prescriptionId}`, {
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