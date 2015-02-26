module ApplicationHelper
  def link_to_add_fields(name, f, association)
    all_fields = ""
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    ids = ""
    3.times do |i|
      fields = f.fields_for(association, new_object, child_index: (id + i)) do |builder|
        all_fields += render(association.to_s.singularize + "_fields", f: builder)
      end

      ids += ",#{id + i}"
    end
    link_to(name, '#', class: "add_fields", data: {id: ids[1..-1], fields: all_fields.gsub("\n", "")})
  end

  def cp(path)
    "current" if current_page?(path)
  end

end
