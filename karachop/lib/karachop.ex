defmodule Karachop do
  @moduledoc """
    Here we implement 5 different versions of the binary search algorithm

    It works the following: [1, 3, 5, 7, 9] search 7
    First iter: [1,3] away, 7 > 5 left with [5,7,9]
    Second iter: mid check => 7 = 7

    The second one(Tropper) does the same but adds a layer of randomness to the process. After each chop, it choosed a random number in the next to search array and compares it to the searched for number.  In case these two match, we save the next loopup and end the iteration.

    The third version(Ropper) works more like version one. It seperates the list like the normal Binary Search algorithm. After seperation of the initial list, it then takes the first and last item of the list(*1 for further explanation) and compares them against the searched item. In case these two match, we save a few chops and get our answer faster.

    *1: i think that the boundaries are hard to find/just take much longer. With the same base approach but a defined search for the last / first, we could save a few iterations probably
  """

end
