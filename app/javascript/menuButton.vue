<template>
  <div class="ml-4" @click="showMenu = !showMenu">
    <i class="fas fa-bars mt-5"></i>
    <transition name="fade">
      <div class="menu-bar" v-show="showMenu">
        <ul v-if="userId" class="mt-2 ml-3 mr-3">
          <li class="pb-2 mt-2">
            <p>
              <a href="/pets" data-turbolinks="false">
                <i class="fas fa-cat mr-2"></i>ペット一覧
              </a>
            </p>
          </li>
          <li class="pb-2 mt-2">
            <p>
              <a href="/users/edit" data-turbolinks="false">
                <i class="far fa-address-card mr-2"></i>ユーザー情報編集
              </a>
            </p>
          </li>
          <li class="pb-2 mt-2">
            <p>
              <a href="/users/sign_out" data-method="delete" data-turbolinks="false">
                <i class="fas fa-sign-out-alt mr-2"></i>Log out
              </a>
            </p>
          </li>
        </ul>
        <ul v-else class="mt-2 ml-3 mr-3">
          <li class="pb-2 mt-2">
            <p>
              <a href="/users/sign_in" data-turbolinks="false">
                <i class="fas fa-sign-in-alt mr-2"></i>ログイン
              </a>
            </p>
          </li>
          <li class="pb-2 mt-2">
            <p>
              <a href="/users/sign_up" data-turbolinks="false">
                <i class="far fa-thumbs-up mr-2"></i>アカウント登録
              </a>
            </p>
          </li>
        </ul>
      </div>
    </transition>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        showMenu: false,
      }
    },
    props: {
      userId: {
        type: Number,
        required: true
      },
    }
  }
</script>