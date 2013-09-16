    class UDiscoverMe.Views.TagCloud extends Backbone.View
      id = 0
      fill = d3.scale.category20() 
      draw = (words) ->
              d3.select("#tagcloud").append("svg").attr("width", 800).attr("height", 400).append("g").attr("transform", "translate(400,200)").selectAll("text").data(words).enter().append("text").style("font-size", (d) ->
                d.size + "px"
              ).style("font-family", "Impact").style("fill", (d, i) ->
                fill i
              ).attr("text-anchor", "middle").attr("transform", (d) ->
                "translate(" + [d.x+1, d.y] + ")rotate(" + d.rotate + ")"
              ).text (d) ->
                d.text
         

      initialize:->
          _.bindAll(this,"render");
          @collection.bind("reset",this.render);
          @collection.bind("change", this.render);

          console.log(@collection)

      render: ->
          # tags = ["Hello", "world", "normally", "you", "want", "more", "words", "than", "this"].map (d) ->
          #           text: d
          #           size: 10 + Math.random() * 90
          d3.select("svg").remove()
          tags = new Array()
          checker = new Array()

          for object in this.collection.models
            if(checker.indexOf(object.get("text").toLowerCase()) == -1)
              tags.push({"text":object.get("text"),"size":object.get("size") / 3 +  Math.random()*5})
              checker.push(object.get("text").toLowerCase())



          console.log(tags)    

          this.chart = d3.layout.cloud().size([800, 600]).words(tags).padding(1).rotate(->
                ~~(Math.random() * 1) * 90
              ).font("Impact").fontSize((d) ->
                d.size
              ).on("end", draw).start()
          # console.log("IN render X")
          @collection.each(@singleTag)
          this
      
      singleTag:(tag) ->
          console.log("SingleTag :" + tag.get("text").toLowerCase())
