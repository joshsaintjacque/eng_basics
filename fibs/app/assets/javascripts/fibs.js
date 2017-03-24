var fibs = new Vue({
  el: '#fibs',
  data: {
    fibs: [],
    fib: {
      name: '',
      sequence_length: ''
    },
    errors: {}
  },
  mounted: function() {
    var that;
    that = this;
    $.ajax({
      url: '/fibs.json',
      success: function(response) {
        that.fibs = response;
      }
    });
  },
  methods: {
    newFib: function () {
      var that = this;
      $.ajax({
        method: 'POST',
        data: {
          fib: that.fib,
        },
        url: '/fibs.json',
        success: function(response) {
          that.errors = {}
          that.fibs.push(response);
        },
        error: function(response) {
          that.errors = response.responseJSON.errors
        }
      })
    }
  }
});

Vue.component('fib-row', {
  template: '#fib-row',
  props: {
    fib: Object
  },
  data: function () {
    return {
      editMode: false,
      errors: {}
    }
  },
  methods: {
    updateFib: function () {
      var that = this;
      $.ajax({
        method: 'PUT',
        data: {
          fib: that.fib
        },
        url: '/fibs/' + that.fib.id + '.json',
        success: function(response) {
          that.errors = {};
          that.fib = response;
          that.editMode = false;
        },
        error: function(response) {
          that.errors = response.responseJSON.errors
        }
      })
    },
    deleteFib: function () {
      var that = this;
      $.ajax({
        method: 'DELETE',
        url: '/fibs/' + that.fib.id + '.json',
        success: function(response) {
          that.$el.remove()
        }
      })
    }
  }
});