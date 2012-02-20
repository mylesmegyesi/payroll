module InMemory
  class Transaction
    
    def self.get_bucket(bucket)
      self.ensure_bucket(bucket)
      @@buckets[bucket]
    end

    def self.reset
      @@buckets = {}
      @@id_counters = {}
    end

    def self.add(bucket, item)
      self.ensure_bucket(bucket)
      @@buckets[bucket] << item
    end

    def self.get_id(bucket)
      self.ensure_bucket(bucket)
      new_id = @@id_counters[bucket] + 1
      @@id_counters[bucket] = new_id
      new_id
    end

    private

    def self.ensure_bucket(bucket)
      self.ensure_buckets
      if @@buckets[bucket].nil?
        @@buckets[bucket] = []  
        @@id_counters[bucket] = 0
      end
    end

    def self.ensure_buckets
      self.reset if !defined?(@@buckets) 
    end

  end
end
