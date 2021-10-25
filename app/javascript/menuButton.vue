<template>
  <div class="ml-4" @click="showMenu = !showMenu">
    <i class="fas fa-bars mt-5"></i>
    <transition name="fade">
      <div class="menu-bar" v-show="showMenu">
        <ul v-if="userId" class="mt-2 ml-3 mr-3">
          <li class="pb-2 mt-2">
            <p>
              <a href="/pets">
                <i class="fas fa-cat mr-2"></i>ペット一覧
              </a>
            </p>
          </li>
          <li class="pb-2 mt-2">
            <p>
              <a href="/users/edit">
                <i class="far fa-address-card mr-2"></i>ユーザー情報編集
              </a>
            </p>
          </li>
          <li class="pb-2 mt-2">
            <p>
              <a href="/medicines">
                <i class="fas fa-capsules mr-2"></i>薬品リストに追加したお薬一覧
              </a>
            </p>
          </li>
          <li class="pb-2 mt-2">
            <p>
              <a href="/clinics">
                <i class="far fa-hospital mr-2"></i>病院リストに追加した病院一覧
              </a>
            </p>
          </li>
          <li class="pb-2 mt-2">
            <p>
              <a href="/users/sign_out" data-method="delete">
                <i class="fas fa-sign-out-alt mr-2"></i>ログアウト
              </a>
            </p>
          </li>
        </ul>
        <ul v-else class="mt-2 ml-3 mr-3">
          <li class="pb-2 mt-2">
            <p>
              <a href="/users/sign_in">
                <i class="fas fa-sign-in-alt mr-2"></i>ログイン
              </a>
            </p>
          </li>
          <li class="pb-2 mt-2">
            <p>
              <a href="/users/sign_up">
                <i class="far fa-thumbs-up mr-2"></i>アカウント作成
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
