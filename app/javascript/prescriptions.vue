<template>
  <div class = "container">
    <div class= "card has-background-white-bis">
      <h1 class="is-size-1 has-background-white-ter mb-4">
        処方箋情報登録
      </h1>
      <div class="form__items">
        <div class="field">
          <div class="label">
            日付 *
          </div>
        </div>
        <div class="field">
          <div class="label">
            県名 *
          </div>
        </div>
          <VueMultiselect
              v-model="selectedKey" :options="options1" @select="onSelect" track-by="name" label="name" placeholder="最初に県名を選択してください" >
          </VueMultiselect>
          <div class="label">
            病院名 *
          </div>
          <VueMultiselect
              v-model="selectedItem" :options="options2" track-by="name" label="name" placeholder="県名を選択した後に選択してください">
          </VueMultiselect>   
        <div class="field">
          <div class="label">
            診察料
          </div>
          <div class="control">
            <input v-model="medical_fee" placeholder="" class="">
            円
          </div>
        </div>
        <div class="field">
          <div class="label">
            処方料
          </div>
          <div class="control">
            <input v-model="medicine_fee" placeholder="" class="">
            円
          </div>
        </div>
        <div class="actions">
          <button @click="createPrescription" class="actions">お薬登録へ進む</button>
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
        selectedKey: null,
        selectedItem:'',
        options1:[],
        options2:[],
        items:[],
        date: "20210722",
        medical_fee:'',
        medicine_fee: '',
    }
  },
  created: function() {
    this.updateContents();
  },
  methods:{
    updateContents() {
      Axios.get("/api/prefectures/index.json").then(
      response => {
        const responseData = response.data;
        this.options1 = responseData["prefectures"]
      }
    )},
    onSelect(prefecture){
      const id = prefecture.id
      Axios.get(`/api/clinics/index.json/?id=${id}`).then(
      response => {
        const responseData = response.data;
        //console.log(responseData)
        this.options2 = responseData["clinics"]
      }
    )},
    createPrescription(){
      //console.log(this.selectedItem.id)
      Axios.post('/api/prescriptions', {
        prescription: {
          date: this.date,
          clinic_id: this.selectedItem.id,
          pet_id: 1,
          medical_fee: this.medical_fee,
          medicine_fee: this.medicine_fee,
        }
      }).then((response) => {
        console.log(response)
        //Flash.set({ notice: response.data.notice });
        Turbolinks.visit(response.data.location);
        // self.items.unshift(response.data)
        // this.newItems = ''
        // const status = JSON.stringify(response.status)
        // if (status === '201') {
        //   const url = JSON.stringify(response.data.id)
        //   const urlRep = url.replace(/\"/g, '')
        //   const redirectURL = ('users/new?e=' + urlRep)
        //   location.href = redirectURL
      }, (error) => {
        console.log(error, response)
      })
    }
  },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>