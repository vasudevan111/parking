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
    puts "Reg no is #{reg_no} and color #{color}"
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
    slot_to_remove = @parking_slots.select {|slot| slot["slot_no"] == slot_no}
    slot_to_remove["reg_no"] = nil
    slot_to_remove["color"] = nil
    puts "Slot number #{slot_no} is free"
  end
end



# Usages & Write Test Cases

p = Parking.new(7)
p.park("KA-7333 Red")
p.leave(1)