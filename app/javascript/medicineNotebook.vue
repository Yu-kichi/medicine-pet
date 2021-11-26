<template>
  <div class="container has-background-white contents-body">
    <div class="box has-background back-color is-shadowless">
      <h1 class="page-header-title mb-4 has-text-weight-bold is-size-4">
        <i class="fas fa-notes-medical mr-2"></i>{{`${petName}のお薬手帳`}}
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
        <div class="is-mobile has-text-grey-darker is-size-7 ">
          <div class="pl-4">
            <table>
              <tr>
                <th class="medicine_name">お薬名</th>
                <th class="medicine_unit">単位</th>
                <th class="medicine_doze">服用回数</th>
                <th class="medicine_memo">備考</th>
              </tr>
              <tr v-for='(medicine, index) in prescription.medicines' :key='medicine.id'>
                <td>{{medicine.medicine_name}}</td>
                <td>{{medicine.medicine_unit}}</td>
                <td v-if='medicine.medicine_dose'>1日{{medicine.medicine_dose}}回</td>
                <td >{{truncate(medicine.medicine_memo)}}</td>
              </tr>
            </table>
          </div>
        </div>
      </div>
      <div v-if="petId">
        <div class="mt-6 mb-4">
          <a class="button is-primary is-fullwidth has-text-white has-text-weight-bold" 
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
        petName: "",
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
            this.petName = responseData.pet_name
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
      truncate(string) {
        const maxLength = 6
        if (string.length >= maxLength){
          return string.substr(0, maxLength) + '..';
        }else{
          return string
        }
      }
    }
  }
</script>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>
