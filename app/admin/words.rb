ActiveAdmin.register Word do
  # scope :all, :default => true
  scope :to_be_completed, :default => true
  scope :completed
  scope :thai
  scope :english
  
  form do |f|
    f.inputs "Details" do
      f.input :word
      f.input :is_done
      f.input :is_important
    end
    f.buttons
  end
  
  filter :word
  filter :meaning
  filter :examples
  
  # index do
  #   column("Word"){|word|
  #     span link_to(word.word, admin_word_path(word)), :class=>"title"
  #   }
  #   column("Meaning"){|word| word.meaning.join ", "}
  #   # column("Status"){|word| word.is_done ? status_tag("completed", :class=> "green") : status_tag("not_completed")}
  #   # column("Important"){|word| word.is_important ? status_tag("yes", :class=> "green") : status_tag("no")}
  #   column("Complete"){|word|
  #     link_to icon(:loop, :color => "#000", :width => "32px", :height => "32px"), complete_admin_word_path(word)
  #   }
  # end
  index :as => :grid, :columns => 3 do |word|
    div :for => word do
      h2 link_to(word.word, admin_word_path(word))
      div :class=>"definition" do
        div "definition:", :class => "label"
        div word.meaning.join(", "), :class => "content"
      end

      if(word.pronounciation)
        div :class=>"definition" do
          div "pronounciation:", :class => "label"
          div raw(word.pronounciation), :class => "content"
        end
      end
      
      if(word.examples.size != 0)
        div :class=>"definition" do
          div "examples:", :class => "label"
          ul :class => "content" do
            word.examples.each{ |k, v| li(span(k + ": ") + span(v.join(", "))) }
          end
        end
      end
      
      if(word.reverse_examples.size != 0)
        div :class=>"definition" do
          div "reverse examples:", :class => "label"
          ul :class => "content" do
            word.reverse_examples.each{ |k, v| li(span(k + ": ") + span(v.join(", "))) }
          end
        end
      end

      if(word.similar_words.size != 0)
        div :class=>"definition" do
          div "similar words:", :class => "label"
          ul :class => "content" do
            word.similar_words.each{ |k, v| li(span(k + ": ") + span(v.join(", "))) }
          end
        end
      end
      
    end
  end
  
  show :title => "Word Details" do
    panel "Details" do
      attributes_table_for(word) do 
        row("word"){ span word.word, :class=>"title"}
        row("meaning"){
          raw word.meaning.join(", ")
        }
        row("pronounciation"){ raw word.pronounciation}
        row("examples") do
          raw word.examples.map{|k, v| "<div><b>#{k}</b>: #{v.join(", ")}</div>"}
        end
        row("reverse_examples") do
          raw word.reverse_examples.map{|k, v| "<div><b>#{k}</b>: #{v.join(", ")}</div>"}
        end
        row("similar_words") do
          raw word.similar_words.map{|k, v| "<div><b>#{k}</b>: #{v.join(", ")}</div>"}
        end
        row("Done"){ word.is_done ? status_tag("yes", :class=> "green") : status_tag("no", :class=> "red")}
        row("Important"){ word.is_important ? status_tag("yes", :class=> "green") : status_tag("no", :class=> "red")}
      end
    end
  end
  
  action_item :only => :show do
    link_to "New Word", new_admin_word_path
  end
  
  action_item :only => :show do
    link_to "Complete", complete_admin_word_path(word)
  end
  
  
  member_action :complete do
    @word = Word.find(params[:id])
    @word.is_done = true
    @word.save
    redirect_to admin_words_path
  end

end
