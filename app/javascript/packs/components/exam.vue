<template>
  <div>
    <b-jumbotron v-if="topic == 3 || topic == 4" border-variant="dark">
      <p id="text-content" v-html="content">
      </p>
    </b-jumbotron>
    <b-alert show variant="warning" v-if="topic == 6">
      <audio controls>
        <source src="horse.ogg" type="audio/ogg">
        <source src="horse.mp3" type="audio/mpeg">
      Your browser does not support the audio element.
      </audio>
    </b-alert>
    
    <b-alert show variant="primary" v-for="(question, index) in questions" :key="index">
      {{index+1}}. {{question.title}}
      <div v-for="answer in question.answers" v-if="topic != 5 && topic != 7">
        <input type="radio" v-model="answers[index].answer_id" :id="answer.id" :value="answer.id" :name="answer.question_id">
        <label :for="answer.id">{{answer.content}}</label>
      </div>
      <b-container fluid class="p-4 bg-dark" v-if="topic == 5">
        <b-row>
          <b-col v-for="answer in question.answers">
            <input type="radio" v-model="answers[index].answer_id" :id="answer.id" :value="answer.id" :name="answer.question_id">
            <b-img thumbnail :for="answer.id" fluid :src="answer.content" alt="Thumbnail" />
          </b-col>
        </b-row>
      </b-container>
      <b-form-input id="exampleInput1" v-if="topic == 7"
                      type="text"
                      v-model="answers[index].answer_id"
                      required
                      placeholder="Enter your solution">
      </b-form-input>

    </b-alert>
    <b-button size="lg" variant="success" @click="checkAnswer" :disabled="disableButton">
      Finish
    </b-button>
    {{answers}}
  </div>
</template>

<script>
  export default {
    data() {
      return {
        questions: {},
        answers: [],
        topic: {},
        content: {},
        disableButton: false,
        ids_question: []
      }
    },
    props:{
      idExam: Number
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
      fetchExamDetail(){
        return this.postData('http://localhost:3001/reading/exam_detail',
          {id: this.idExam})
          .then(json =>{
          this.questions = json.questions;
          this.topic = json.code_topic;
          this.content = json.content;
          this.questions.forEach(question => {
            this.answers.push({answer_id: ''});
            this.ids_question.push(question.id);
          });
        })
      },
      checkAnswer(){
        if(this.topic != 7)
        {
          this.postData('http://localhost:3001/reading/check_answer',
          {answers: this.answers, question_ids: this.ids_question}).then(json =>{
            console.log(json);
            swal({
              title: `Good job!You have just collected ${json.point_collect} point`,
              text: `You done ${json.number_correct} correct question`,
              icon: "success",
              button: "uk!",
            });
            json.ids_incorrect.forEach(id_incorrect =>{
              $(`label[for=${id_incorrect}]`).addClass("text-danger");
            });
            json.ids_correct.forEach(id_correct =>{
              $(`label[for=${id_correct}]`).addClass("text-success");
            });
            this.disableButton = true;
          });
        }
        else{
          let count_correct = 0;
          this.answers.forEach((question,index) => {
            const content_value = question.answer_id.toLocaleLowerCase();
            if(content_value == this.questions[index].answers[0].content.toLocaleLowerCase()){
              count_correct++;
            }
          });
          swal({
              title: `Good job!You have just collected ${count_correct*10} point`,
              text: `You done ${count_correct} correct question`,
              icon: "success",
              button: "uk!",
            });
          this.disableButton = true;
        }
      }
    },
    created() {
      this.fetchExamDetail();
    },
  }
</script>
