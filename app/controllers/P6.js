var die = {
  value: 0,
  updateValue: fucntion(){

  }
}

var Die = fucntion(){
  this.value = 0;
  this.updateValue = fucntion(){
    this.value = Math.floor((Math.random()*6)+1);

  }
}

var model = {
  dice: [],
  die: function(){
    return new Die

  },

  addDie: fucntion(){
    this.dice.push(this.die())
  }
  rollDice: function (){
    for(var i=0; i < this.dice.length; i++){
      this.dice[i].updateValue();
    }
  }

}

// where you will set your event handlers jquery
var view = {
  addEventListeners: function()
  $(document).ready(function() {
    $('#roller button.add').on('click', function() {
      $('.dice').append('<div class="die">0</div>');
    });
    this.model.addDie();
  });
    // updates our view, but we need to tell our controller to update the object

    $('#roller button.roll').on('click', function() {
      $('.die').each(function(k, die) {
        var value = Math.floor((Math.random()*6)+1);
        $(die).text(value);
      });
   });
  }
}


var controller = {
  // have access to access to any variables above it that's not wrapped in a function
  model: model,
  view: view,
  addDice: fucntion(){
    // controller does not change state
    this.model.addDie()
  },
  rollDice: function(){
    this.model.rollDice()
  },
  // injecting a dependendency into view
  injectModel: function(){
    this.view.model = this.model
  }
}
