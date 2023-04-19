<script lang="ts" >
import axios from "axios";
import {defineComponent} from "vue";
import {Configuration, Customer, CustomerControllerApi} from "../../../../open-api-modules/customer-api-docs";
import CustomerForm from "./CustomerForm.vue";

const configuration = new Configuration({
    basePath: 'http://10.1.10.176:8080',
});
axios.defaults.baseURL = 'http://10.1.10.176:8080';

export default defineComponent({
    components: {
        CustomerForm,
    },
    data() {

        return {
            customers: [],
            customerDetail: {},
            showModal: false,
            customerApi: new CustomerControllerApi(configuration)
        }
    },
    computed: {
        modalTitle() {
            return this.customerDetail.id ? "Edit Customer" : "Create Customer";
        },
    },
    mounted() {
        this.getListCustomer();
    },
    methods: {
        getListCustomer(): void {
            this.customerApi.getAllCustomers().then((response) => {
                this.customers = response.data;
            })
            // axios.get('/api/customers')
            //     .then(response => {
            //       this.customers = response.data;
            //     })
            //     .catch(() => {
            //     });
        },
        editCustomer(customer: Customer) {
            this.customerDetail = Object.assign({}, customer);
            this.showModal = true;
        },
        deleteCustomer(id: string) {
            if (window.confirm('Are you sure you want to delete this customer?')) {

                this.customerApi.deleteCustomer(id).then(() => {
                    this.customers = this.customers.filter(customer => customer.id !== id);
                })

                // axios.delete('/api/customers/' + id)
                //     .then(() => {
                //       this.customers = this.customers.filter(customer => customer.id !== id);
                //     })
            }
        },
        submitForm(customer: Customer) {
            if (customer.id) {
                this.customerApi.updateCustomer(customer.id, customer).then(() => {
                    this.getListCustomer();
                })
                // axios.put('/api/customers/' + this.customerDetail.id, this.customerDetail)
                //     .then(() => {
                //       this.getListCustomer();
                //     })
                //     .catch(()) => {
                //     });
            } else {
                this.customerApi.createCustomer(customer).then(() => {
                    this.getListCustomer();
                })
                // axios.post('/api/customers', this.customerDetail)
                //     .then(() => {
                //       this.getListCustomer();
                //     })
                //     .catch(()) => {
                //     });
            }
            this.showModal = false;
        }
    }
})

</script>

<template>
  <div>
    <h1>Customers</h1>
    <button class="btn btn-primary" @click="showModal = true; customerDetail = {}">Add Customer</button>
    <div v-if="showModal" class="modal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ modalTitle }}</h5>
            <button type="button" class="btn-close" @click="showModal = false"></button>
          </div>
          <div class="modal-body">
            <CustomerForm :customer="customerDetail" @submit="submitForm" @close="showModal = false"></CustomerForm>
          </div>
        </div>
      </div>
    </div>
    <table class="table">
      <thead>
      <tr>
        <th>ID</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Email</th>
        <th>Phone Number</th>
        <th></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="customerItem in customers" :key="customerItem.id">
        <td>{{ customerItem.id }}</td>
        <td>{{ customerItem.firstName }}</td>
        <td>{{ customerItem.lastName }}</td>
        <td>{{ customerItem.email }}</td>
        <td>{{ customerItem.phoneNumber }}</td>
        <td>
          <button class="btn btn-primary" @click="editCustomer(customerItem)">Edit</button>
          <button class="btn btn-danger" @click="deleteCustomer(customerItem.id)">Delete</button>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<style lang="scss">
table {
  width: 100%;
  border-collapse: collapse;
}

th {
  text-align: left;
  padding: 12px;
  background-color: #f2f2f2;
}

td {
  text-align: left;
  padding: 12px;
  border-bottom: 1px solid #ddd;
}

tr:hover {
  background-color: #f5f5f5;
}

.btn {
  border: none;
  color: white;
  padding: 12px 16px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  transition-duration: 0.4s;
  cursor: pointer;
  border-radius: 4px;
}

.btn-edit {
  background-color: #4CAF50;
}

.btn-delete {
  background-color: #f44336;
}

.btn i {
  margin-right: 8px;
}

.btn:hover {
  opacity: 0.8;
}

.btn:active {
  transform: translateY(2px);
}

.modal {
  position: fixed;
  z-index: 9999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-dialog {
  margin: 5% auto;
  width: 50%;
  max-width: 700px;
}

.modal-content {
  background-color: #fff;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0px 0px 10px #888;
}

.modal-header {
  display: flex;
  justify-content: space-between;
}

.modal-title {
  margin: 0;
}

.btn-close {
  background-color: transparent;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
}

.btn-danger {
  background-color: red;
}
</style>
