<template>
  <div class="" @click="showMenu = !showMenu">
    <span aria-hidden="true"></span>
    <span aria-hidden="true"></span>
    <span aria-hidden="true"></span>
    <transition name="fade">
      <div class="menu-bar" v-show="showMenu">
        <ul class="mt-2 ml-3 mr-3">
          <li class="pb-2 mt-2">
            <p><a href="/pets" data-turbolinks='false'>ペット一覧</a></p>
          </li>
          <li class="pb-2 mt-2">
            <p><a>ユーザー情報編集</a></p>
          </li>
          <li class="pb-2 mt-2">  
            <p><a href="/users/sign_out" data-method="delete" data-turbolinks='false'>Log out</a></p> 
          </li>
        </ul>
      </div>
    </transition> 
  </div>
</template>

<script>
import Axios from "axios";

export default {
  data() {
    return{
      showMenu: false,
    }
  },
  props: {
    petId:{type: Number, required: true},
  },
}
</script>
