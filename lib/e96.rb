#!/bin/ruby
#Find the closest E96 Resistor Value

class E96
 
  R_CONST = [
    100, 102, 105, 107, 110, 113,
    115, 118, 121, 124, 127, 130,
    133, 137, 140, 143, 147, 150,
    154, 158, 162, 165, 169, 174,
    178, 182, 187, 191, 196, 200,
    205, 210, 215, 221, 226, 232,
    237, 243, 249, 255, 261, 267,
    274, 280, 287, 294, 301, 309,
    316, 324, 332, 340, 348, 357,
    365, 374, 383, 392, 402, 412,
    422, 432, 442, 453, 464, 475,
    487, 499, 511, 523, 536, 549,
    562, 576, 590, 604, 619, 634,
    649, 665, 681, 698, 715, 732,
    750, 768, 787, 806, 825, 845,
    866, 887, 909, 931, 953, 976,
  ]
 
  def initialize()
  end 

  def self.Closest(r)
    mag = magnitude_offset r
    h = sort_by_closest(r, mag)
    if not h[0].nil?
      h[0].first / mag
    elsif h[1].nil?
      h[-1].last / mag
    elsif h[-1].nil? || (r - h[-1].last) > (h[1].first - r) 
      h[1].first / mag
    else
      h[-1].last / mag
    end
  end
  
  
  def self.NextUp(r)
    mag = magnitude_offset r
    h = sort_by_closest(r, mag)
    if not h[1].nil?
      h[1].first / mag
    elsif not h[0].nil?
      h[0].first / mag
    else
      h[-1].last / mag
    end
  end


  def self.NextDown(r)
    mag = magnitude_offset r
    h = sort_by_closest(r, mag)
    if not h[-1].nil?
      h[-1].last / mag
    elsif not h[0].nil?
      h[0].first / mag
    else
      h[1].first / mag
    end
  end


  def self.List()
    puts "E96 Resistor Values:"
    (1..R_CONST.length).each do |idx|
      print "#{R_CONST[idx - 1]}   "
      if 0 == (idx % 6)
        print "\n\n"
      end
    end
  end

  
  private

  def self.magnitude_offset(r)
    return 100 if r.eql? 0
    mag = 10.0 ** (2 - Math.log10(r).floor)
  end

  def self.sort_by_closest(r, mag)
    R_CONST.sort.group_by{|c| c <=> r * mag}
  end

end
