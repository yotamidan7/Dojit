module Mypaginate

  def mypagination(hash)    
    collection = {results: self.limit(hash[:per_page]).offset(hash[:per_page].to_i * hash[:page].to_i)}
    collection[:batch_count] = (self.count / hash[:per_page]) - 1
    return collection
  end
end
