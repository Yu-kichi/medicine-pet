<template>
  <Transition name="modal">
    <div v-if="show" class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
          <div class="modal-header">
            <slot name="header"></slot>
          </div>

          <div class="modal-body">
            <slot name="body"></slot>
          </div>

          <div class="modal-footer">
            <slot name="footer">
              <button class="button is-danger mr-5" @click="$emit('ok')">
                OK
              </button>
              <button class="button" @click="$emit('cancel')">
                Cancel
              </button>
            </slot>
          </div>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script>
  export default {
    props: {
      show: Boolean,
    }
  }
</script>
