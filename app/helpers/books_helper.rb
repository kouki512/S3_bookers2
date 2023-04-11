module BooksHelper
  def compared_to_previous_day(today,yesterday)
    unless today == 0 || yesterday == 0
      percent = today / yesterday * 100
      percent_str = percent.to_s + "%"
      return percent_str
    else
      "--"
    end
  end
end
