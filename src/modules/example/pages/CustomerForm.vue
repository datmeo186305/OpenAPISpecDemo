/* eslint-disable */
<script lang="ts">
import {defineComponent} from "vue";

export default defineComponent({
  props: {
    customer: {
      type: Object,
      default: () => {
        return {
          firstName: {
            type: String
          },
          lastName: {
            type: String
          },
          email: {
            type: String
          },
          phoneNumber: {
            type: String
          }
        };
      }
    },
  },
  emits: ['submit', 'close'],
  data() {
    return {
      isModalVisible: false,
      customerDetail: {
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
      }
    };
  },
  created() {
    if (this.customer) {
      this.customerDetail = {...this.customerDetail, ...this.customer};
    }
  },
  methods: {
    submitForm() {
      console.log("this.customerDetail", this.customerDetail)
      this.$emit('submit', this.customerDetail);
    },
    dismissModal() {
      this.$emit('close')
    }
  }
})
</script>

<template>
  <div>
    <form @submit.prevent="submitForm">
      <div class="mb-3">
        <label for="firstName" class="form-label">First Name</label>
        <input type="text" class="form-control" id="firstName" v-model="customerDetail.firstName">
      </div>
      <div class="mb-3">
        <label for="lastName" class="form-label">Last Name</label>
        <input type="text" class="form-control" id="lastName" v-model="customerDetail.lastName">
      </div>
      <div class="mb-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" class="form-control" id="email" v-model="customerDetail.email">
      </div>
      <div class="mb-3">
        <label for="phoneNumber" class="form-label">Phone Number</label>
        <input type="text" class="form-control" id="phoneNumber" v-model="customerDetail.phoneNumber">
      </div>
      <div style="display: flex;align-self: center;">
        <div class="col-6">
          <button type="submit" class="btn btn-primary">OK</button>
        </div>
        <div class="col-6">
          <button type="button" class="btn btn-secondary" @click="dismissModal()">Cancel</button>
        </div>
      </div>

    </form>
  </div>
</template>
<style lang="scss">
.modal-header {
  margin-bottom: 30px;
}
form {
  margin: 0 auto;
  max-width: 500px;
  display: flex;
  flex-direction: column;
  align-items: initial;
}

.form-label {
  font-weight: bold;
  margin-bottom: 5px;
}

.form-control {
  width: 100%;
  padding: 10px;
  margin-bottom: 20px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

.btn {
  margin: 10px;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  text-align: center;
  background-color: #007bff;
  color: #fff;
}

.btn-secondary {
  background-color: #6c757d;
}

.btn i {
  margin-right: 5px;
}

.form-title {
  font-size: 2rem;
  margin-bottom: 2rem;
}

.form-label {
  font-weight: bold;
  margin-bottom: 0.5rem;
}

.form-control {
  width: 100%;
  padding: 0.5rem;
  font-size: 1rem;
  border-radius: 0.25rem;
  border: 1px solid #ced4da;
}

.form-control:focus {
  outline: none;
  box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
}

.form-control:disabled {
  background-color: #e9ecef;
  opacity: 1;
}

.form-group {
  margin-bottom: 1.5rem;
}

.btn {
  padding: 0.5rem 1rem;
  font-size: 1rem;
  font-weight: bold;
  border-radius: 0.25rem;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
}

.btn-primary {
  background-color: #007bff;
  border-color: #007bff;
  color: #fff;
}

.btn-primary:hover {
  background-color: #0069d9;
  border-color: #0062cc;
  color: #fff;
}

.btn-secondary {
  background-color: #6c757d;
  border-color: #6c757d;
  color: #fff;
}

.btn-secondary:hover {
  background-color: #5a6268;
  border-color: #545b62;
  color: #fff;
}

.mb-3 {
  display: flex;
  flex-wrap: wrap;
}
</style>
