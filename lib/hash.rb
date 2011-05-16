class Hash

  def map(&block)
    mapped_hash = {}
    self.each do |key, value|
      mapped_hash[key] = yield value
    end
    mapped_hash
  end

end