<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container" >
    <div class="box has-background-white-bis">
      <p class="is-size-3">既に登録している情報</p>
      <div v-if='clinic_name' class="is-size-5">
        <p>{{prescribedDate(prescription_date)}}</p>
        <p>{{clinic_name}}</p>
      </div>
      <div v-if='registered.length'>
        <div v-for="medicine in registered" :key='medicine.id' class="is-size-5">
          <p>{{medicine.medicine_name}}</p>
        </div>
      </div>
    </div>
    <div class= "box has-background-white-bis">
      <h1 class="is-size-3 mb-4">
        <p>お薬情報登録</p>
      </h1>
      <div class="form__items">
        <div class="field">
          <div class="label">
            <p>お薬名 *</p>
          </div>
          <div class="control columns">
            <div class="column ">
              <VueMultiselect
                v-model="selectedMedicine" :options="medicines" track-by="name" label="name" placeholder="お薬を選択してください" >
              </VueMultiselect>
              <p class="is-size-7">*ひらがなで見つからない時はカタカナで検索してみましょう</p>
              <p v-if="errors.length">
              <ul>
                <li v-for="error in errors" class="has-text-danger">{{ error }}</li>
              </ul>
              </p>
            </div>
          </div>
        </div>
        <div class="field">
          <div class="label">
            <p>1日の使用量</p>
          </div>
        </div>
          <input v-model="dose" placeholder="数字で入力してください" class="input is-small " type="number" style="width: 50%;" min="0">
          <span>錠</span>
        <div class="field">  
          <div class="label pt-3">
            <p>総量</p>
          </div>
        </div>  
          <input v-model="total_amount" placeholder="数字で入力してください" class="input is-small" type="number" style="width: 50%;" min="0">
          <span>日分</span>
        <div class="field">
          <div class="label pt-3">
            <p>メモ</p>
          </div>
          <div class="control">
            <textarea v-model="memo"  class="textarea" ></textarea>
          </div>
        </div>
        <div class="actions pt-3">
          <button @click="createPrescriptionsMedicines()" class="button is-link is-fullwidth" >お薬情報を登録する</button>
        </div>
        <div class="actions pt-4">
          <button @click="createPrescriptionsMedicines('again')" class="button is-primary  is-fullwidth">追加でお薬を登録する</button>
        </div>
        <div class="actions mt-4">
          <a :href='`/medicines/new/?prescription_id=${prescriptionId}`' class="button is-outlined is-fullwidth" >薬の名前が見つからない時はこちら</a>
          <p class="is-size-7">*薬の名前が見つからない場合にはこちらから新しくお薬情報の登録ができます。</p>
        </div>
        <div>
          <a class="button is-fullwidth mt-4 mb-4" data-turbolinks='false' 
            :href='`/pets/${petId}/medicine_notebook`' >お薬手帳に戻る</a>
        </div> 
      </div>
    </div>
  </div>  
</template>

<script>
import VueMultiselect from 'vue-multiselect'
import Axios from "axios";
import dayjs from 'dayjs';
import ja from 'dayjs/locale/ja'
dayjs.locale(ja)

export default {
  components: { VueMultiselect },
  data() {
    return{
        errors: [],
        selectedMedicine:'',
        medicines:[],
        dose: null,
        total_amount: null,
        memo:'',
        loaded: false,
        registered:[],
        clinic_name: null,
        prescription_date: "",
    }
  },
  props: {
    petId:{type: Number, required: true},
    prescriptionId:{type: Number, required: true},
  },
  created: function() {
    this.fetchMedicines();
    this.fetchPrescriptionsMedicines();
  },
  methods:{
    fetchMedicines() {
      Axios.get("/api/medicines/index.json").then(
      response => {
        const responseData = response.data;
        this.medicines = responseData["medicines"]
        this.loaded = true
      })
    },
    fetchPrescriptionsMedicines(){
      Axios.get(`/api/prescriptions_medicines/${this.prescriptionId}`).then(
      response => {
        const responseData = response.data;
        this.registered = responseData["medicines"]
        this.clinic_name = responseData["prescription_clinic"]
        this.prescription_date = responseData["prescription_date"]
      })
    },
    validation: function(e){
      this.errors =[]
      if(!this.selectedMedicine){
        this.errors.push('お薬を選んでください');
      }
      //e.preventDefault();
    },
    createPrescriptionsMedicines(again){
      if(this.validation()){
      }
      Axios.post('/api/prescriptions_medicines', {
        prescriptions_medicine: {
          medicine_id: this.selectedMedicine.id,
          prescription_id: this.prescriptionId,
          dose: this.dose,
          total_amount: this.total_amount,
          memo: this.memo,
        }
      }).then((response) => {
        if (again){
        window.location.href = `/prescriptions/${this.prescriptionId}/prescriptions_medicines/new`
        }else{
        window.location.href = response.data.location
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
<style src="vue-multiselect/dist/vue-multiselect.css"></style>