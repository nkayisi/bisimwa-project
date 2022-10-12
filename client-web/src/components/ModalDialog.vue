<template>
  <TransitionRoot appear :show="openDialog" as="template">
    <Dialog as="div" @close="openDialog" class="relative z-40">
      <TransitionChild as="template" enter="duration-300 ease-out" enter-from="opacity-0" enter-to="opacity-100"
        leave="duration-200 ease-in" leave-from="opacity-100" leave-to="opacity-0">
        <div class="fixed inset-0 bg-black bg-opacity-25" />
      </TransitionChild>

      <div class="fixed inset-0 overflow-y-auto">
        <div class="flex min-h-full items-center justify-center p-4 text-center">
          <TransitionChild as="template" enter="duration-300 ease-out" enter-from="opacity-0 scale-95"
            enter-to="opacity-100 scale-100" leave="duration-200 ease-in" leave-from="opacity-100 scale-100"
            leave-to="opacity-0 scale-95">
            <DialogPanel
              class="w-full max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-all">

              <DialogTitle as="h3" class="text-lg font-medium leading-6 text-gray-900">
                <slot name="title"></slot>
              </DialogTitle>

              <div class="mt-2">
                <slot name="content"></slot>
              </div>

            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script>
import { TransitionRoot, TransitionChild, Dialog, DialogPanel, DialogTitle } from '@headlessui/vue'

export default {
  name: 'ModalDialog',
  components: {
    TransitionRoot, TransitionChild, Dialog, DialogPanel, DialogTitle
  },
  props: ['openDialog']
}

</script>
