class UniqueRangesOfDates
  require 'date'

  attr_accessor :points_a
  attr_accessor :points_b

  #a, b = tablica klas Date
  def initialize(point_a = [], point_b = [])
    @points_a = point_a.clone
    @points_b = point_b.clone

    unless @points_a.size == @points_b.size
      raise TypeError, 'obie tablice musza mieć taki sam rozmiar'
    end

    unless @points_a.empty? && @points_b.empty?
      @points_a.each_index do |i|
        if @points_a[i].class != Date || @points_b[i].class != Date
          raise TypeError, 'punkty muszą być klasy Date'
        end
      end
    end
  end

  #return true + error array / false, text
  def any_errors?
    errors = []

    @points_a.each_with_index do |pa, i|
      if pa >= @points_b[i]
        errors.push "a w tablicy nr #{i} jest wieksze bądź równe b"
      else
        @points_a.each_index do |j|
          if j == i
            next
          elsif pa >= @points_a[j] && pa <= @points_b[j]
            errors.push "a[#{i}](#{pa}) jest pomiędzy "\
                        "a[#{j}](#{@points_a[j]}) - b[#{j}](#{@points_b[j]})"
            break
          elsif @points_b[i] >= @points_a[j] && @points_b[i] <= @points_b[j]
            errors.push "b[#{i}](#{@points_b[i]}) jest pomiędzy "\
                        "a[#{j}](#{@points_a[j]}) - b[#{j}](#{@points_b[j]})"
            break
          elsif pa <= @points_a[j] && @points_b[i] >= @points_b[j]
            errors.push "przedział #{i} nachodzi na przedział #{j}"
          end
        end
      end#if-else
    end

    if errors.empty?
      return false, 'nie wykryto żadnych błędów'
    else
      return true, errors
    end
  end

  #point_a = punkt a, przeksztalzony z Date -> Fixnum. Zapis do @points_a
  #point_a = punkt a, przeksztalzony z Date -> Fixnum. Zapis do @points_b
  #sprawdza czy punkt od a do b jest unikalny
  #return true/false
  def push_range(point_a, point_b)
    begin
    asize = @points_a.size
    bsize = @points_b.size
    return false if point_a >= point_b

    #sprawdza liczbe obecnych przedzialow
    if asize == 0 && bsize == 0
      push_ab point_a, point_b
      return true
    elsif asize == 1 && bsize == 1
      if point_a < @points_a[0] && point_b < @points_a[0]
        push_ab point_a, point_b
        return true
      elsif point_a > @points_b[0]
        push_ab point_a, point_b
        return true
      else
        return false
      end
    else
      #if b jest przed wszystkimi przedzialami
      #elsif a jest po wszystkich przedzialach
      if(point_b < @points_a.sort.first)
        push_ab point_a, point_b
        return true
      elsif(point_a > @points_b.sort.last)
        push_ab point_a, point_b
        return true
      else
        #sprawdza czy a oraz b sa pomiedzy a i b zapisanych przedzialow
        0.upto(asize - 1) do |i|
          if((point_a >= @points_a[i]) && (point_a <= @points_b[i]))
            return false
          elsif((point_b >= @points_a[i]) && (point_b <= @points_b[i]))
            return false
          end
        end
        #sprawdza czy a jest mniejsze od przedzialu[i].a oraz
        #sprawdza czy b jest wieksze od przedzialu[i].b
        0.upto(asize - 1) do |i|
          if((point_a < @points_a[i]) && (point_b > @points_b[i]))
            return false
          end
        end
        push_ab point_a, point_b
        return true
      end
    end
    rescue Exception => e
      return false
    end

  end#/def push_ranges


  private

  def push_ab(a, b)
    @points_a.push a
    @points_b.push b
  end
end#/Class.PrzedzialUnikat
