<template>
  <div class="box has-background back-color">
    <h1 class="is-size-5 mb-4 has-text-weight-bold" >
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
      <div class="prescription-header ">
        <p class= "is-size-5 pl-4 mb-3 has-text-weight-bold">{{prescribedDate(prescription.prescription.date)}}</p>
      </div>
      <div class="columns  is-mobile pb-4 has-text-grey-darker " @click="showOnPrescription(index)" >
        <div class="column is-three-quarters-mobile">
          <a data-turbolinks='false' :href='`/pets/${petId}/prescriptions/${prescription.prescription.id}`'>
            <div class="pl-4 ">
              <p class="is-size-6 has-text-weight-bold">{{prescription.clinic_name}}</p>
              <span class="is-size-7">お薬名:</span>
              <span v-for='(medicine, index) in prescription.medicines' :key='medicine.id' class="is-size-7">
                <span>{{medicine.medicine_name}},</span>
              </span>
            </div>
          </a>
        </div>
        <a class="column mt-5" data-turbolinks='false' 
          :href='`/pets/${petId}/prescriptions/new/?prescription_id=${prescription.prescription.id}`'>+コピー</a>
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
  }
}
</script>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>