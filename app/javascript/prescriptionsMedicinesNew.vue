<template>
  <div v-if='loaded === false'>
    <p>ロード中</p>
  </div>
  <div v-else class="container" >
    <div class= "card has-background-white-bis">
      <h1 class="is-size-1 has-background-white-ter mb-4">
        <p>お薬情報登録</p>
      </h1>
      <div class="form__items">
        <div class="field">
          <div class="label">
            <p>お薬名 *</p>
          </div>
          <div class="control columns">
            <div class="column is-three-fifths">
              <VueMultiselect
                v-model="selectedMedicine" :options="medicines" track-by="name" label="name" placeholder="お薬を選択してください" style="width: 50%;">
              </VueMultiselect>
              <p class="has-text-grey-light">*ひらがなで見つからない時はカタカナで検索してみましょう</p>
              <p v-if="errors.length">
              <ul>
                <li v-for="error in errors" class="has-text-danger">{{ error }}</li>
              </ul>
              </p>
            </div>  
            <div class="actions column">
              <a href="/medicines/new" class="button is-outlined" >薬の名前が見つからない時はこちらで登録できます</a>
            </div>
          </div>
        </div>
        <div class="field">
          <div class="label">
            <p>1日の使用量</p>
          </div>
        </div>
          <input v-model="dose" placeholder="数字で入力してください" class="input is-small " type="number" style="width: 20%;" min="0">
          <span>錠</span>
        <div class="field">  
          <div class="label">
            <p>総量</p>
          </div>
        </div>  
          <input v-model="total_amount" placeholder="数字で入力してください" class="input is-small" type="number" style="width: 20%;" min="0">
          <span>日分</span>
        <div class="field">
          <div class="label">
            <p>メモ</p>
          </div>
          <div class="control">
            <textarea v-model="memo"  class="textarea" ></textarea>
          </div>
        </div>
        <div class="columns">
          <div class="column is-one-third">
            <div class="actions">
              <button @click="createPrescriptionsMedicines" class="button is-link is-outlined" >お薬情報を登録する</button>
            </div>
          </div>
          <div class="column">
            <div class="actions">
              <button class="button is-primary is-outlined">続けて登録する</button>
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
    }
  },
  props: {
    petId:{type: Number, required: true},
    prescriptionId:{type: Number, required: true},
  },
  created: function() {
    this.fetchMedicines();
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
    validation: function(e){
      this.errors =[]
      if(!this.selectedMedicine){
        this.errors.push('お薬を選んでください');
      }
      //e.preventDefault();
    },
    createPrescriptionsMedicines(){
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
        Turbolinks.visit(response.data.location);
      }, (error) => {
        console.log(error, response)
      })
    }
  },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>