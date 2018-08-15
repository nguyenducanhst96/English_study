<template>
  <div id="app">
    <b-card-group deck class="mb-4">
      <b-card border-variant="primary" v-for="exam in exams_first"
              :header="exam.name"
              header-bg-variant="primary"
              header-text-variant="white"
              align="center">
        <a href="#"><p class="card-text">Click to do.</p></a>
      </b-card>
    </b-card-group>
    <b-card-group deck class="mb-4">
      <b-card border-variant="primary" v-for="exam in exams_second"
              :header="exam.name"
              header-bg-variant="primary"
              header-text-variant="white"
              align="center">
        <p class="card-text">Click to do.</p>
      </b-card>
    </b-card-group>
    <b-pagination size="md" @input="fetchExams" :total-rows="count" v-model="currentPage" :per-page="per">
    </b-pagination>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      exams: {},
      currentPage: 1,
      count:1,
      per: 8,
      exams_first: {},
      exams_second: {}

    }
  },
  props:{
    codeTopic: Number
  },
  methods:{
    postData(url = ``, data = {}){
    // Default options are marked with *
    return fetch(url, {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, cors, *same-origin
      cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
      credentials: "same-origin", // include, same-origin, *omit
      headers: {
          "Content-Type": "application/json; charset=utf-8",
          // "Content-Type": "application/x-www-form-urlencoded",
      },
      redirect: "follow", // manual, *follow, error
      referrer: "no-referrer", // no-referrer, *client
      body: JSON.stringify(data), // body data type must match "Content-Type" header
    }).then(response => response.json()); // parses response to JSON
},
    fetchExams(){
      console.log(this.codeTopic);
      return this.postData('http://localhost:3000/reading/exams',
        {id: this.codeTopic, page: this.currentPage, per: this.per})
        .then(json =>{
        this.exams = json.data;
        this.count = json.count;
        this.exams_first = this.exams.slice(0,4);
        this.exams_second = this.exams.slice(4,8);
        console.log(this.code_topic);
      })
    }
  },
  created() {
    this.fetchExams();
  },
}
</script>
