<template>
  <div class="container has-background-white contents-body">
    <div class="box has-background back-color is-shadowless">
      <h1 class="page-header-title is-size-5 mb-4 has-text-weight-bold">
        <i class="fas fa-notes-medical mr-2"></i>{{`${name}のお薬手帳`}}
      </h1>
      <VueMultiselect v-model="searchTarget" :options="clinicName" @select="onSelect" @remove="offSelect"
        placeholder="病院名で絞り込み" class="mb-4">
      </VueMultiselect>
      <div v-for="(prescription, index) in showPrescriptions" :key='prescription.id' class="card mb-4 is-shadowless ">
        <a :href='`/pets/${petId}/prescriptions/${prescription.prescription.id}`'>
          <div class="prescription-header has-text-weight-bold pl-4 is-size-6">
            <p class="pt-2">{{prescribedDate(prescription.prescription.date)}}</p>
            <p class="pb-2">{{prescription.clinic_name}}</p>
          </div>
        </a>
        <div class="is-mobile pb-4 has-text-grey-darker">
          <div class="pl-4">
            <span class="is-size-7">お薬名:</span>
            <span v-for='(medicine, index) in prescription.medicines' :key='medicine.id' class="is-size-7">
              <span>{{medicine.medicine_name}},</span>
            </span>
          </div>
        </div>
      </div>
      <div v-if="petId">
        <div class="mt-6 mb-4">
          <a class="button is-fullwidth has-background-primary has-text-white has-text-weight-bold" 
          :href='`/pets/${petId}/prescriptions/new`'>新しくお薬手帳に登録する
          </a>
        </div>
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
      return {
        name: "",
        loaded: false,
        prescriptions: [],
        searchTarget: "",
        showPrescriptions: [],
        clinicName: [],
      }
    },
    components: {
      VueMultiselect,
    },
    props: {
      petId: {
        type: Number,
        required: true
      },
    },
    created: function () {
      this.fetchMedicineNotebook()
    },
    methods: {
      fetchMedicineNotebook() {
        Axios.get(`/api/medicine_notebook/index/?pet_id=${this.petId}`).then(
          response => {
            const responseData = response.data;
            this.clinicName = responseData.clinic_name
            this.name = responseData.pet.name
            this.prescriptions = responseData.prescriptions
            this.showPrescriptions = this.prescriptions
          })
      },
      onSelect(searchTarget) {
        var prescriptions = [];
        for (var i in this.prescriptions) {
          var prescription = this.prescriptions[i].clinic_name;
          if (prescription === searchTarget) {
            prescriptions.push(this.prescriptions[i]);
          }
        }
        return this.showPrescriptions = prescriptions
      },
      offSelect() {
        this.showPrescriptions = this.prescriptions
      },
      prescribedDate(date) {
        return dayjs(date).format('YYYY年MM月DD日(dd)')
      },
    }
  }
</script>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>
