require "minitest/autorun"
require "pry"
require_relative "../lib/secret_santa/person"

class PersonTest < Minitest::Test
  def test_to_s_includes_name
    bilbo = Person.new({
      "name"  => "Bilbo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    assert bilbo.to_s =~ /Bilbo/
  end

  def test_to_s_includes_group
    bilbo = Person.new({
      "name"  => "Bilbo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    assert bilbo.to_s =~ /Bagginses/
  end

  def test_with_santa_includes_santa_to_s
    bilbo = Person.new({
      "name"  => "Bilbo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    gandalf = Person.new({
      "name"  => "Gandalf",
      "group" => "Istari",
      "phone" => "15555555555"
    })
    bilbo.santa = gandalf
    assert bilbo.with_santa.include?(gandalf.to_s)
  end

  def test_can_be_santa_of_is_true_if_people_in_different_groups
    bilbo = Person.new({
      "name"  => "Bilbo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    gandalf = Person.new({
      "name"  => "Gandalf",
      "group" => "Istari",
      "phone" => "15555555555"
    })
    assert bilbo.can_be_santa_of?(gandalf)
  end

  def test_can_be_santa_of_is_false_if_people_in_same_group
    bilbo = Person.new({
      "name"  => "Bilbo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    frodo = Person.new({
      "name"  => "Frodo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    assert !bilbo.can_be_santa_of?(frodo)
  end

  def test_can_swap_santas_with_is_false_if_person_cannot_be_santa_of_other_santa
    bilbo = Person.new({
      "name"  => "Bilbo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    frodo = Person.new({
      "name"  => "Frodo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    gandalf = Person.new({
      "name"  => "Gandalf",
      "group" => "Istari",
      "phone" => "15555555555"
    })
    aragorn = Person.new({
      "name"  => "Strider",
      "group" => "Rangers",
      "phone" => "15555555555"
    })
    bilbo.santa = gandalf
    aragorn.santa = frodo
    assert !bilbo.can_swap_santas_with?(aragorn)
  end

  def test_can_swap_santas_with_is_false_if_other_cannot_be_santa_of_persons_santa
    bilbo = Person.new({
      "name"  => "Bilbo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    frodo = Person.new({
      "name"  => "Frodo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    gandalf = Person.new({
      "name"  => "Gandalf",
      "group" => "Istari",
      "phone" => "15555555555"
    })
    aragorn = Person.new({
      "name"  => "Strider",
      "group" => "Rangers",
      "phone" => "15555555555"
    })
    gandalf.santa = bilbo
    frodo.santa = aragorn
    assert !gandalf.can_swap_santas_with?(frodo)
  end

  def test_can_swap_santas_with_is_true_if_person_and_other_can_be_santas_to_switched_santas
    bilbo = Person.new({
      "name"  => "Bilbo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    frodo = Person.new({
      "name"  => "Frodo",
      "group" => "Bagginses",
      "phone" => "15555555555"
    })
    gandalf = Person.new({
      "name"  => "Gandalf",
      "group" => "Istari",
      "phone" => "15555555555"
    })
    aragorn = Person.new({
      "name"  => "Strider",
      "group" => "Rangers",
      "phone" => "15555555555"
    })
    gandalf.santa = bilbo
    aragorn.santa = frodo
    assert gandalf.can_swap_santas_with?(aragorn)
  end
end
