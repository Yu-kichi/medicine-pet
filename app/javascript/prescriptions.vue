<template>
<div id="app">
    <VueMultiselect
      v-model="selectedKey" :options="options1" @select="onSelect" track-by="name" label="name" placeholder="最初に県名を選択してください" >
    </VueMultiselect>
    <br>
    <VueMultiselect
      v-model="selectedItem" :options="options2" track-by="name" label="name" placeholder="県名を選択した後に選択してください">
    </VueMultiselect>
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
      console.log(responseData)
      this.options2 = responseData["clinics"]
      }
    )},
  },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>