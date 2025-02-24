module ApplicationHelper
    def generate_unique_key()
        loop do
        key = SecureRandom.alphanumeric(6).gsub(/\d/, '').upcase
        return key unless REDIS.exists?(key)
        end
    end 
end
