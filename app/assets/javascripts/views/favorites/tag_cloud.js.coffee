    class UDiscoverMe.Views.TagCloud extends Backbone.View
      id = 0
      fill = d3.scale.category20() 
      draw = (words) ->
              d3.select("#tagcloud").append("svg").attr("width", 300).attr("height", 300).append("g").attr("transform", "translate(150,150)").selectAll("text").data(words).enter().append("text").style("font-size", (d) ->
                d.size + "px"
              ).style("font-family", "Impact").style("fill", (d, i) ->
                fill i
              ).attr("text-anchor", "middle").attr("transform", (d) ->
                "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")"
              ).text (d) ->
                d.text
         
      defaults: {
        w: 1,
        h: 5,
      }
      initialize:->
          _.bindAll(this,"render");
          @collection.bind("reset",this.render);
          @collection.bind("change", this.render);

          console.log(@collection)

      render: ->
          tags = ["Hello", "world", "normally", "you", "want", "more", "words", "than", "this"].map (d) ->
                    text: d
                    size: 10 + Math.random() * 90
          console.log(tags)                    
          this.chart = d3.layout.cloud().size([300, 300]).words(tags).padding(5).rotate(->
                ~~(Math.random() * 2) * 90
              ).font("Impact").fontSize((d) ->
                d.size
              ).on("end", draw).start()
          # console.log("IN render X")
          @collection.each(@singleTag)
          this
      
      singleTag:(tag) ->
          console.log("SingleTag :" + tag.get("text"))
