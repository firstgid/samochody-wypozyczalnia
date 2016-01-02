module ApplicationHelper
  def titles(full_title="")
    if(full_title.empty?)
      "Wypożyczalnia samochodów"
    else
      "Wypożyczalnia samochodów - " + full_title
    end
  end
end
