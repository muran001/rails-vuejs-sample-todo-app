<template>
  <div>
    <!-- 新規作成部分 -->
    <v-card>
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-container>
          <v-row>
            <v-col cols="12" md="8">
              <v-text-field v-model="name" :counter="20" :rules="nameRules" label="タスク名を入力" required></v-text-field>
            </v-col>
            <v-col cols="12" md="4">
              <v-btn :disabled="!valid" color="success" class="mr-4" @click="submit">タスクを追加</v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-form>
    </v-card>
    <!-- リスト表示部分 -->
    <v-card>
      <v-toolbar flat color="primary" dark>
        <v-toolbar-title>ToDoリスト</v-toolbar-title>
      </v-toolbar>
      <v-tabs vertical>
        <v-tab>ToDo</v-tab>
        <v-tab>Done</v-tab>
        <v-tab-item>
          <v-card flat>
            <div>
              <ul class="collection">
                <li v-for="task in tasks" v-if="!task.is_done" v-bind:id="'row_task_' + task.id" class="collection-item">
                  <v-checkbox v-model="task.is_done" v-on:change="updateTask(task.id, task.is_done)" :label="task.name"></v-checkbox>
                </li>
              </ul>
            </div>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <div>
              <ul class="collection">
                <li v-for="task in tasks" v-if="task.is_done" v-bind:id="'row_task_' + task.id" class="collection-item">
                  <v-checkbox v-model="task.is_done" v-on:change="updateTask(task.id, task.is_done)" :label="task.name"></v-checkbox>
                </li>
              </ul>
            </div>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </v-card>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  name: 'Task',
  data() {
    return {
      valid: true,
      name: '',
      nameRules: [
        v => !!v || 'Name is required',
        v => (v && v.length <= 20) || 'Name must be less than 10 characters',
      ],
      tasks: [],
    }
  },
  mounted() {
    this.fetchTasks();
  },
  methods: {
    setToken(params) {
      const tags = document.getElementsByTagName("meta");
      for (let i=0; i<tags.length; i++) {
        if (tags[i].name === "csrf-token") {
          params.authenticity_token = tags[i].content;
          break;
        }
      }
      return params;
    },
    fetchTasks() {
      axios.get('/api/tasks').then((response) => {
        for(var i = 0; i < response.data.tasks.length; i++) {
          this.tasks.push(response.data.tasks[i]);
        }
      }, (error) => {
        console.log(error);
      });
    },
    updateTask(task_id, is_done) {
      var params_with_token = this.setToken({ task: { is_done: is_done }});
      axios.put('/api/tasks/' + task_id, params_with_token).then((response) => {
        console.log('updated');
      }, (error) => {
        console.log(error);
      })
    },
    submit() {
      var params_with_token = this.setToken({ task: { name: this.name }});
      axios.post('/api/tasks', params_with_token).then((response) => {
        console.log('posted');
        this.fetchTasks();
      }, (error) => {
        console.log(error);
      })
    }
  }
}
</script>
