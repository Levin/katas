defmodule ListNode do
  @type t :: %__MODULE__{
      val: integer,
      next: ListNode.t() | nil
  }

  defstruct val: 0, next: nil 
  
end


defmodule AddTwoNumbers do
    
  @spec add_two_numbers(l1 :: ListNode.t | nil, l2 :: ListNode.t | nil) :: ListNode.t | nil
  def add_two_numbers(l1, l2) do

    adder([], l1, l2)

  end

  def adder(list, l1, l2) when l1.next != nil and l2.next != nil do
    adder(list ++ [l1.val + l2.val], l1.next, l2.next)
  end

  def adder(list, l1, l2) do
    list ++ [l1.val + l2.val]
  end

end
