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
      <VueMultiselect
        v-model="searchTarget" :options="clinicName" @select="onSelect" @remove="offSelect" placeholder="病院名で絞り込み"  class="mb-4">
      </VueMultiselect>
    <div v-for="(prescription, index) in showPrescriptions" :key='prescription.id' class="card mb-4">
      <div class="columns prescription-header is-mobile" @click="showOnPrescription(index)">
        <div class="column is-three-quarters-mobile">
          <div class="pl-4 pt-4 ">
            <p class="is-size-5">{{prescription.clinic_name}}</p>
            <p class="is-size-6">{{prescribedDate(prescription.prescription.date)}}</p>
          </div>
        </div>
        <div class="column mt-5">...</div>
      </div>
      <div v-for='(medicine, index) in prescription.medicines' :key='medicine.id' class="ml-4">
        <p>{{medicine.medicine_name}}</p>
      </div>
      <div class="ml-4 mb-4 mr-4" @click="showOnPrescription(index)">
        <div class="button mt-4 has-background-info is-fullwidth" v-show="index === clickedPrescription" >
          <a class="mb-4 mt-4 has-text-white" data-turbolinks='false' 
            :href='`/pets/${petId}/prescriptions/${prescription.prescription.id}`'>処方箋詳細</a>
        </div>
        <div class="button mt-4 has-background-primary is-fullwidth" v-show="index === clickedPrescription" >
          <a class="mb-4 mt-4 has-text-white" data-turbolinks='false'
            :href='`${prescription.new_medicine_path}`'>お薬追加登録</a>
        </div>
        <div class="button mt-4 has-background-primary is-fullwidth" v-show="index === clickedPrescription" >
          <a class="mb-4 mt-4 has-text-white" data-turbolinks='false' 
          :href='`/pets/${petId}/prescriptions/new/?prescription_id=${prescription.prescription.id}`'>コピーする </a>
        </div>
      </div>
    </div>
    <div v-if="petId">
      <div class="button mt-4 has-background-primary  is-fullwidth">
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
import VueMultiselect from 'vue-multiselect'

dayjs.locale(ja)

export default {
  data() {
    return{
      name: "",
      loaded: false,
      prescriptions: [],
      clickedPrescription: "",
      clickedMedicine: false,
      searchTarget:"",
      showPrescriptions:[],
      clinicName:[],
    }
  },
  components: {
     VueMultiselect,
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
        this.clinicName = responseData.clinic_name 
        this.name = responseData.pet.name
        this.prescriptions = responseData.prescriptions
        this.showPrescriptions = this.prescriptions 
      })
    },
    onSelect(searchTarget){
      var prescriptions = [];
        for(var i in this.prescriptions) {
            var prescription = this.prescriptions[i].clinic_name;
            if(prescription === searchTarget ) {
                prescriptions.push(this.prescriptions[i]);
            }
        }
      return this.showPrescriptions = prescriptions
    },
    offSelect(){
       this.showPrescriptions = this.prescriptions 
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
  }
}
</script>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>