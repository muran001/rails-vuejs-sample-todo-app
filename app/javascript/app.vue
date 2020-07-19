<template>
  <v-app id="app">
    <Header/>
    <v-main>
      <v-container fluid>
        <h1>This is app.vue</h1>
        <Task/>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import Header from "./components/Header";
import Task from "./components/Task";

export default {
  components: {
    Header,
    Task,
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
