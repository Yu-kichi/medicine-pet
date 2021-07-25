<template>
<div id="app">
    <VueMultiselect
      v-model="selectedKey" :options="options1" @select="onSelect" :value="value" track-by="name" label="name">
      <template slot="singleLabel" slot-scope="{ option }"><strong>{{ option.name }}</strong> is written in<strong>  {{ option.name }}</strong></template>
    </VueMultiselect>
    
    <br>
    <VueMultiselect
      v-model="selectedItem" :options="options2" >
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
        selectedKey: '',
        selectedItem:'',
        value: [],
        options1:[],
        options2:[],
        items:[],
    }
  },
  created: function() {
    this.updateContents();
  },
  methods:{
    onSelect(value) {
      //this.options2 = this.replaceChildrenOptions()
      //this.options2 = this.items[value];
    },
    updateContents() {
      Axios.get("/api/prefectures/index.json").then(
      response => {
      const responseData = response.data;
      //console.log(responseData["prefectures"][0]["name"])
      this.options1 = responseData["prefectures"]

      }
    )},
    replaceChildrenOptions(){
      var selectChildren = this.selectedKey
      if (selectChildren){
      }else{
      replaceSelectOptions(selectChildren, [])
      }
    }
  },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>