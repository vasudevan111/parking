#!/usr/bin/ruby

class Parking
  def initialize(slots)
    # Creating normal object with a hash map. However using a relational database or noSql entry makes right sense.
    # Assumption is to create a simple objects without using any other Mysql Gems etc. If thats not the case am completely wrong :)
    @parking_slots = []
    slots.times do |slot|
      @parking_slots << {"color" => nil, "reg_no" => nil, "slot_no" => slot + 1}
    end
    puts "Created a parking lot with #{slots} slots"
  end

  def park(car)
    (reg_no, color) = car.chomp.split(" ")
    #puts "Reg no is #{reg_no} and color #{color}"
    free_slot = get_free_slot()
    free_slot["reg_no"] = reg_no
    free_slot["color"] = color
    puts "Allocated slot number: #{free_slot["slot_no"]}"
  end

  def get_free_slot
      @parking_slots.select {|slot| slot["reg_no"].nil?}.first
  end

  def status
    @parking_slots.each do |slot|
      puts "#{slot["slot_no"]}\t#{slot["reg_no"]}\t#{slot["color"]}\n" unless slot["reg_no"].nil?
    end
    nil
  end

  def leave(slot_no)
    slot_to_remove = @parking_slots.select {|slot| slot["slot_no"].to_i == slot_no}.first
    slot_to_remove["reg_no"] = nil
    slot_to_remove["color"] = nil
    puts "Slot number #{slot_no} is free"
  end

  def registration_numbers_for_cars_with_colour(color)
    reg_numbers = @parking_slots.select {|slot| slot["color"] == color}.collect {|slot| slot["reg_no"]}
    reg_numbers.join(",")
  end

  def slot_numbers_for_cars_with_colour(color)
    slot_numbers = @parking_slots.select {|slot| slot["color"] == color}.collect {|slot| slot["slot_no"]}
    puts slot_numbers.join(",")
  end

  def slot_number_for_registration_number(reg_no)
    slot = @parking_slots.select {|slot| slot["reg_no"] == reg_no}.first
    if slot.any?
      slot["slot_no"]
    else
      "Not Found"
    end
  end

  def status
    line = File.open("/tmp/output.tsv",'w')
    @parking_slots.each do |slot|
       line.write "#{slot["slot_no"]}\t#{slot["reg_no"]}\t#{slot["color"]}\n"
    end
    line.close
    nil
  end
end






