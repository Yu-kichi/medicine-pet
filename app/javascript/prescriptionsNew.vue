<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container">
    <div class= "box has-background-white is-shadowless">
      <div v-if="prescriptionId">
        <div class="title has-background-lightseagreen has-text-centered p-2">
          <h1 class="has-text-white has-text-weight-bold">前回の情報を元に薬を一括登録する</h1>
        </div>
          <div class="is-size-6 mb-3"> 
            <p>このページでは過去に貰ったお薬の情報をコピーして新しく登録することができます。</p>
            <p>病院や日付に変更がある場合には再入力をお願い致します。</p>
          </div>
        </div>
      <div v-else class="title has-background-lightseagreen has-text-white has-text-centered p-2">
        <h1 class="has-text-white has-text-weight-bold">処方箋情報登録</h1>
      </div>
      <div class="form__items">
        <div class="field">
          <div class="label">
            <p>診療日 *</p>
          </div>
          <div class="control ">
            <input v-model="date" class="input" type="date" >
          </div>
          <p v-if="dateError !== null ">
            <p class="has-text-danger">{{ dateError }}</p>
          </p>
        </div>
        <div class="field">
          <div class="label">
            <p>県名 *</p>
          </div>
        </div>
          <VueMultiselect
            v-model="selectedPrefecture" :options="prefectures" @select="onSelect" track-by="name" label="name" placeholder="最初に県名を選択してください">
          </VueMultiselect>
          <div class="label pt-3">
            <p>病院名 *</p>
          </div>
          <div class="control">
            <VueMultiselect 
                v-model="selectedClinic" :options="clinics" track-by="name" label="name" placeholder="県名を選択した後に選択してください">
            </VueMultiselect>
            <p class="is-size-7">*ひらがなで見つからない時はカタカナで検索してください</p>
            <p v-if="clinicError !== null">
              <p class="has-text-danger">{{ clinicError }}</p>
            </p>
          </div>
        <div class="field">
          <div class="label pt-3">
            <p>診察料</p>
          </div>
          <div class="control">
            <input v-model="medical_fee" placeholder="数字を入力してください" class="input is-small " type="number" style="width: 50%;" min="0">
            <span>円</span>
          </div>
        </div>
        <div class="field">
          <div class="label">
            <p>処方料</p>
          </div>
          <div class="control">
            <input v-model="medicine_fee" placeholder="数字を入力してください" class="input is-small" type="number" style="width: 50%;" min="0">
            <span>円</span>
          </div>
        </div>
        <div v-if="prescriptionId" class="actions pt-3">
          <button @click="copyPrescription" class="button is-link is-fullwidth has-text-weight-bold">薬の情報を一括登録する</button>
        </div>
        <div v-else class="actions pt-3">
          <button @click="createPrescription" class="button is-link is-fullwidth has-text-weight-bold">お薬登録へ進む</button>
        </div>
        <div class="actions">
          <a :href='`/clinics/new/?pet_id=${petId}`' class="button mt-4 is-fullwidth" data-turbolinks='false'>病院名が見つからない時はこちら</a>
          <p class="is-size-7">*病院名が見つからない場合にはこちらから新しく病院情報の登録ができます。</p>
        </div>
        <div>
          <a class="button is-fullwidth mt-4 mb-4" data-turbolinks='false' 
            :href='`/pets/${petId}/medicine_notebook`'>戻る</a>
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
        dateError: null,
        clinicError: null,
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
      Axios.get(`/api/clinics/${id}`).then(
      response => {
        const responseData = response.data;
        this.clinics = responseData["clinics"]
      }
    )},
    validation: function(){
      if(!this.date){
        this.dateError = '診療日を選んでください';
      }if(!this.selectedClinic){
        this.clinicError = '病院名を選んでください';
      }
    },
    createPrescription(){
      if(this.validation()){
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
      if(this.validation()){
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