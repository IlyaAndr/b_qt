# encoding: utf-8  

require 'debugger'

module InitialData
  
  def serial_array_with_missed_numbers k, n
    delete_items (1..k).to_a, n
  end
  
  private
  
  def delete_items arr, n
    rnd = Random.new
    n.times {arr.delete_at rnd.rand(0..arr.length-1)}
    arr
  end
  
end

module NumbersFinder
  
  def simple arr, k
    (1..k).to_a - arr
  end
  
  def linear arr, k
    res = []
    arr.each_with_index.find do |item, i|
      dif = item - (i != 0 ? arr[i-1] : 0)
      if dif == 3 
	res << item - 2 << item - 1
	break
      elsif dif == 2
	res << item - 1
	break if res.size == 2
      end
    end
    res << k-1 << k if res.size == 0
    res << k if res.size == 1
    res
  end
  
  def dichotomic arr, k
    res = []
    if arr[0] == 3
      res << 1 << 2 
      return res
    end
    res << 1 if arr[0] == 2
    res.concat dichotomic_solve(arr, 0, 1, k-2)
    res << k-1 << k if res.size == 0
    res << k if res.size == 1
    res
  end
  
  private 
  
  def dichotomic_solve arr, offset, i, j
    return dichotomic_decision(arr, offset, i, j) if j-i == 1
    mid = (i+j)/2
    dif = arr[mid-1] - mid - offset
    if dif == 1
      return [*dichotomic_solve(arr, offset, i, mid).compact, *dichotomic_solve(arr, offset+1, mid, j).compact]
    elsif dif == 2
       return [*dichotomic_solve(arr, offset, i, mid).compact]
    else
      return [*dichotomic_solve(arr, offset, mid, j).compact]
    end
  end
  
  def dichotomic_decision arr, offset, i, j
    res =  (arr[i-1]..arr[j-1]).to_a - [arr[i-1], arr[j-1]]
    res.empty? ? [nil] : res
  end
  
end



